//
//  DNCBaseSceneConfigurator.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNCBaseSceneInteractor;
@class DNCBaseScenePresenter;
@class DNCBaseSceneRouter;

@class DNCBaseSceneViewController;

@interface DNCBaseSceneConfigurator : NSObject

@property (strong, nonatomic)   DNCBaseSceneInteractor* interactor;
@property (strong, nonatomic)   DNCBaseScenePresenter*  presenter;
@property (strong, nonatomic)   DNCBaseSceneRouter*     router;

#pragma mark - VIP Object Class Base Names

+ (NSString*)classBaseInteractor;
+ (NSString*)classBasePresenter;
+ (NSString*)classBaseRouter;
+ (NSString*)classBaseViewController;

#pragma mark - Object lifecycle

+ (instancetype)sharedInstance;

#pragma mark - Scene factories

+ (DNCBaseSceneViewController*)viewController;

#pragma mark - Configuration

- (void)configure:(DNCBaseSceneViewController*)viewController;

@end
