//
//  DNCBaseSceneConfigurator.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <PodAsset/PodAsset.h>
#import <WKRCrash_Workers/WKRCrash_Analytics_Worker.h>
#import <WKRCrash_Workers/WKRCrash_User_Worker.h>
#import <WKRCrash_Workers/WKRCrash_Validation_Worker.h>

#import "DNCBaseSceneConfigurator.h"
#import "DNCBaseSceneInteractor.h"
#import "DNCBaseScenePresenter.h"
#import "DNCBaseSceneViewController.h"

@interface DNCBaseSceneConfigurator ()
{
    DNCCoordinator*         _coordinator;
    
    DNCBaseSceneConfiguratorBlock   _coordinatorEndBlock;
}

@end

@implementation DNCBaseSceneConfigurator

#pragma mark - VIP Object Class Base Names

+ (NSString*)classBaseInteractor        {   return @"DNCBaseScene"; }
+ (NSString*)classBasePresenter         {   return @"DNCBaseScene"; }
+ (NSString*)classBaseViewController    {   return @"DNCBaseScene"; }

#pragma mark - Object lifecycle

+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate;
    static DNCBaseSceneConfigurator* instance = nil;
    dispatch_once(&predicate, ^
                  {
                      instance = [[self alloc] init];
                  });
    return instance;
}

#pragma mark - Scene factories

+ (DNCBaseSceneViewController*)viewController
{
    NSString*   classRoot   = self.classBaseViewController;
    
    NSBundle*   viewControllerBundle    = [PodAsset bundleForPod:classRoot];
    NSString*   viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", classRoot];
    Class       ViewControllerClass     = NSClassFromString(viewControllerClassName);
    
    __block DNCBaseSceneViewController* retval;
    
    [DNCUIThread run:
     ^()
     {
         retval  = [ViewControllerClass alloc];
         
         retval.configurator    = self.sharedInstance;
         retval.sceneTitle      = classRoot;
         
         retval = [retval initWithNibName:viewControllerClassName
                                   bundle:viewControllerBundle];
         NSAssert(retval, @"'%@' not found", viewControllerClassName);
     }];
    
    return retval;
}

- (instancetype)init
{
    self = super.init;
    if (self)
    {
    }
    
    return self;
}

#pragma mark - Scene lifecycle

- (DNCBaseSceneViewController*)loadSceneWithCoordinator:(DNCCoordinator*)coordinator
                                         andDisplayType:(DNCBaseSceneDisplayType)displayType
                                                thenRun:(DNCBaseSceneConfiguratorBlock)endBlock
{
    _coordinatorEndBlock    = endBlock;
    _coordinator            = coordinator;
    
    DNCBaseSceneViewController* retval = self.class.viewController;
    
    retval.coordinatorDelegate  = coordinator;
    
    return retval;
}

- (DNCBaseSceneViewController*)runSceneWithCoordinator:(DNCCoordinator*)coordinator
                                        andDisplayType:(DNCBaseSceneDisplayType)displayType
                                               thenRun:(DNCBaseSceneConfiguratorBlock)endBlock
{
    DNCBaseSceneViewController* retval = [self loadSceneWithCoordinator:coordinator
                                                         andDisplayType:displayType
                                                                thenRun:endBlock];

    [self.interactor startSceneWithDisplayType:displayType];
    
    return retval;
}

- (void)endSceneWithSuggestedAction:(NSString*)suggestedAction
                     andDataChanged:(BOOL)dataChanged
{
    _coordinatorEndBlock ? _coordinatorEndBlock(suggestedAction, dataChanged) : (void)nil;
}

#pragma mark - Configuration

- (UINavigationController*)navigationController
{
    return _coordinator.navigationController;
}

- (void)configure:(DNCBaseSceneViewController*)viewController
{
    self.viewController = viewController;
    
    // Create VIP Objects
    Class   InteractorClass = NSClassFromString([NSString stringWithFormat:@"%@Interactor", self.class.classBaseInteractor]);
    Class   PresenterClass  = NSClassFromString([NSString stringWithFormat:@"%@Presenter", self.class.classBasePresenter]);
    
    if (!self.interactor)   {   self.interactor = [InteractorClass interactor]; }   self.interactor.configurator    = self;
    if (!self.presenter)    {   self.presenter  = [PresenterClass presenter];   }   self.presenter.configurator     = self;
    
    // Connect VIP Objects
    self.interactor.output      = self.presenter;
    self.presenter.output       = viewController;
    
    viewController.output   = self.interactor;
    
    // Interactor Dependency Injection
    self.interactor.analyticsWorker = WKRCrash_Analytics_Worker.worker;
    
    // Presenter Dependency Injection
    self.presenter.analyticsWorker  = WKRCrash_Analytics_Worker.worker;
    
    // ViewController Dependency Injection
    viewController.analyticsWorker  = WKRCrash_Analytics_Worker.worker;
}

@end

