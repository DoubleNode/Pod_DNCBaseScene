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

@protocol DNCBaseSceneConfiguratorProtocol

@property (strong, nonatomic)   DNCBaseSceneInteractor* interactor;
@property (strong, nonatomic)   DNCBaseScenePresenter*  presenter;
@property (strong, nonatomic)   DNCBaseSceneRouter*     router;

- (void)configure:(DNCBaseSceneViewController*)viewController;

@end

@interface DNCBaseSceneConfigurator : NSObject<DNCBaseSceneConfiguratorProtocol>

@property (strong, nonatomic)   DNCBaseSceneInteractor* interactor;
@property (strong, nonatomic)   DNCBaseScenePresenter*  presenter;
@property (strong, nonatomic)   DNCBaseSceneRouter*     router;

+ (instancetype)sharedInstance;

@end
