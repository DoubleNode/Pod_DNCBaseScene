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
    
    DNCBaseSceneViewController* retval  = [ViewControllerClass alloc];
    
    retval.configurator = self.sharedInstance;
    
    retval = [retval initWithNibName:viewControllerClassName
                              bundle:viewControllerBundle];
    NSAssert(retval, @"'%@' not found", viewControllerClassName);
    
    return retval;
}

#pragma mark - Configuration

- (void)configure:(DNCBaseSceneViewController*)viewController
{
    // Create VIP Objects
    Class   InteractorClass = NSClassFromString([NSString stringWithFormat:@"%@Interactor", self.class.classBaseInteractor]);
    Class   PresenterClass  = NSClassFromString([NSString stringWithFormat:@"%@Presenter", self.class.classBasePresenter]);
    Class   RouterClass     = NSClassFromString([NSString stringWithFormat:@"%@Router", self.class.classBaseRouter]);
    
    self.interactor = [InteractorClass interactor];
    self.presenter  = [PresenterClass presenter];
    self.router     = [RouterClass router];
    
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

