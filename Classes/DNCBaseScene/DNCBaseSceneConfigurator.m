//
//  DNCBaseSceneConfigurator.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import PodAsset;
@import WKRCrash_Workers;

#import "DNCBaseSceneConfigurator.h"
#import "DNCBaseSceneInteractor.h"
#import "DNCBaseScenePresenter.h"
#import "DNCBaseSceneViewController.h"

#import "DNCCoordinator.h"

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
    
    NSString*   viewControllerClassName = [NSString stringWithFormat:@"%@ViewController", classRoot];
    Class       ViewControllerClass     = NSClassFromString(viewControllerClassName);
    NSBundle*   viewControllerBundle    = [PodAsset bundleForPod:classRoot];
    if (!viewControllerBundle)
    {
        viewControllerBundle    = [NSBundle bundleForClass:ViewControllerClass];
    }

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

// *******************************
// ** Deprecated Methods
- (DNCBaseSceneViewController*)loadSceneWithCoordinator:(DNCCoordinator*)coordinator
                                         andDisplayType:(DNCBaseSceneDisplayType)displayType
                                                thenRun:(DNCBaseSceneConfiguratorBlock)endBlock
{
    return [self loadSceneWithCoordinator:coordinator
                           andDisplayType:displayType
                  andInitializationObject:nil
                                  thenRun:endBlock];
}

- (DNCBaseSceneViewController*)runSceneWithCoordinator:(DNCCoordinator*)coordinator
                                        andDisplayType:(DNCBaseSceneDisplayType)displayType
                                               thenRun:(DNCBaseSceneConfiguratorBlock)endBlock
{
    return [self runSceneWithCoordinator:coordinator
                          andDisplayType:displayType
                 andInitializationObject:nil
                                 thenRun:endBlock];
}

- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged
{
    [self endSceneWithIntent:intent
              andDataChanged:dataChanged
            andResultsObject:nil];
}
// **
// *******************************

- (DNCBaseSceneViewController*)loadSceneWithCoordinator:(DNCCoordinator*)coordinator
                                         andDisplayType:(DNCBaseSceneDisplayType)displayType
                                andInitializationObject:(DNCBaseSceneInitializationObject*)initializationObject
                                                thenRun:(DNCBaseSceneConfiguratorBlock)endBlock
{
    _coordinatorEndBlock    = endBlock;
    _coordinator            = coordinator;
    
    DNCBaseSceneViewController* viewController = self.class.viewController;
    
    viewController.coordinatorDelegate  = coordinator;
    
    return viewController;
}

- (DNCBaseSceneViewController*)runSceneWithCoordinator:(DNCCoordinator*)coordinator
                                        andDisplayType:(DNCBaseSceneDisplayType)displayType
                               andInitializationObject:(DNCBaseSceneInitializationObject*)initializationObject
                                               thenRun:(DNCBaseSceneConfiguratorBlock)endBlock
{
    DNCBaseSceneViewController* viewController = [self loadSceneWithCoordinator:coordinator
                                                                 andDisplayType:displayType
                                                        andInitializationObject:initializationObject
                                                                        thenRun:endBlock];

    [self.interactor startSceneWithDisplayType:displayType
                       andInitializationObject:initializationObject];
    
    return viewController;
}

- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged
          andResultsObject:(DNCBaseSceneResultsObject*)resultsObject
{
    _coordinatorEndBlock ? _coordinatorEndBlock(intent, dataChanged, resultsObject) : (void)nil;
}

- (void)removeSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType
{
    [self.interactor removeSceneWithDisplayType:displayType];
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

