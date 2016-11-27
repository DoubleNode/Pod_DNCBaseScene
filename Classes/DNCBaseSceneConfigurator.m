//
//  DNCBaseSceneConfigurator.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

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

#pragma mark - Configuration

- (void)configure:(DNCBaseSceneViewController*)viewController
{
    // Create VIP Objects
    NSString*   className   = NSStringFromClass(self.class);
    NSString*   classRoot   = [className substringToIndex:(className.length - 12)];
    
    Class   RouterClass     = NSClassFromString([NSString stringWithFormat:@"%@Router", classRoot]);
    Class   PresenterClass  = NSClassFromString([NSString stringWithFormat:@"%@Presenter", classRoot]);
    Class   InteractorClass = NSClassFromString([NSString stringWithFormat:@"%@Interactor", classRoot]);
    
    self.interactor = [InteractorClass interactor];
    self.presenter  = [PresenterClass presenter];
    self.router     = [RouterClass router];
    
    // Connect VIP Objects
    self.interactor.output      = self.presenter;
    self.presenter.output       = viewController;
    self.router.viewController  = viewController;
    
    viewController.output   = self.interactor;
    viewController.router   = self.router;
    
    // Presenter Dependency Injection
    self.presenter.analyticsWorker  = [WKRCrash_Analytics_Worker worker];
    
    // Interactor Dependency Injection
    self.interactor.analyticsWorker = [WKRCrash_Analytics_Worker worker];
    
    // ViewController Dependency Injection
    viewController.analyticsWorker  = [WKRCrash_Analytics_Worker worker];
}

@end

