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
#import "DNCBaseSceneRouter.h"
#import "DNCBaseSceneViewController.h"

@interface DNCBaseSceneConfigurator ()
{
    NSMutableDictionary*    _data;
    DNCCoordinator*         _coordinator;
    
    DNCBaseSceneConfiguratorBlock   _coordinatorEndBlock;
}

@end

@implementation DNCBaseSceneConfigurator

#pragma mark - VIP Object Class Base Names

+ (NSString*)classBaseInteractor        {   return @"DNCBaseScene"; }
+ (NSString*)classBasePresenter         {   return @"DNCBaseScene"; }
+ (NSString*)classBaseRouter            {   return @"DNCBaseScene"; }
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
         
         retval.configurator = self.sharedInstance;
         
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
        _data   = NSMutableDictionary.dictionary;
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

- (void)endScene
{
    _coordinatorEndBlock ? _coordinatorEndBlock() : (void)nil;
}

#pragma mark - Configuration

- (UINavigationController*)navigationController
{
    return _coordinator.navigationController;
}

- (void)setValue:(id)value
      forDataKey:(NSString*)key
{
    if (!key.length)
    {
        return;
    }
    
    if (!value || [value isKindOfClass:NSNull.class])
    {
        [_data removeObjectForKey:key];
        return;
    }
    
    _data[key] = value;
}

- (id)valueForDataKey:(NSString*)key
{
    if (!key.length)
    {
        return nil;
    }
    
    return _data[key];
}

- (void)configure:(DNCBaseSceneViewController*)viewController
{
    self.viewController = viewController;
    
    // Create VIP Objects
    Class   InteractorClass = NSClassFromString([NSString stringWithFormat:@"%@Interactor", self.class.classBaseInteractor]);
    Class   PresenterClass  = NSClassFromString([NSString stringWithFormat:@"%@Presenter", self.class.classBasePresenter]);
    Class   RouterClass     = NSClassFromString([NSString stringWithFormat:@"%@Router", self.class.classBaseRouter]);
    
    if (!self.interactor)   {   self.interactor = [InteractorClass interactor]; }   self.interactor.configurator    = self;
    if (!self.presenter)    {   self.presenter  = [PresenterClass presenter];   }   self.presenter.configurator     = self;
    if (!self.router)       {   self.router     = [RouterClass router];         }   self.router.configurator        = self;
    
    // Connect VIP Objects
    self.interactor.output      = self.presenter;
    self.interactor.returnTo    = viewController;
    self.presenter.output       = viewController;
    self.router.viewController  = viewController;
    
    viewController.output   = self.interactor;
    viewController.router   = self.router;
    
    // Interactor Dependency Injection
    self.interactor.analyticsWorker = WKRCrash_Analytics_Worker.worker;
    
    // Presenter Dependency Injection
    self.presenter.analyticsWorker  = WKRCrash_Analytics_Worker.worker;
    
    // ViewController Dependency Injection
    viewController.analyticsWorker  = WKRCrash_Analytics_Worker.worker;
}

@end

