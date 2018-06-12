//
//  DNCBaseSceneConfigurator.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNCBaseSceneCommon.h"

@class DNCCoordinator;

@class DNCBaseSceneInteractor;
@class DNCBaseScenePresenter;
@class DNCBaseSceneRouter;

@class DNCBaseSceneViewController;

typedef void (^DNCBaseSceneConfiguratorBlock)(NSString* suggestedAction, BOOL dataChanged);

@interface DNCBaseSceneConfigurator : NSObject

@property (strong, nonatomic)   DNCBaseSceneInteractor*     interactor;
@property (strong, nonatomic)   DNCBaseScenePresenter*      presenter;
@property (strong, nonatomic)   DNCBaseSceneRouter*         router;
@property (strong, nonatomic)   DNCBaseSceneViewController* viewController;

#pragma mark - VIP Object Class Base Names

+ (NSString*)classBaseInteractor;
+ (NSString*)classBasePresenter;
+ (NSString*)classBaseRouter;
+ (NSString*)classBaseViewController;

#pragma mark - Object lifecycle

+ (instancetype)sharedInstance;

#pragma mark - Scene factories

+ (DNCBaseSceneViewController*)viewController;

#pragma mark - Lifecycle Methods

- (DNCBaseSceneViewController*)loadSceneWithCoordinator:(DNCCoordinator*)coordinator
                                         andDisplayType:(DNCBaseSceneDisplayType)displayType
                                                thenRun:(DNCBaseSceneConfiguratorBlock)endBlock;
- (DNCBaseSceneViewController*)runSceneWithCoordinator:(DNCCoordinator*)coordinator
                                        andDisplayType:(DNCBaseSceneDisplayType)displayType
                                               thenRun:(DNCBaseSceneConfiguratorBlock)endBlock;

- (void)endSceneWithSuggestedAction:(NSString*)suggestedAction
                     andDataChanged:(BOOL)dataChanged;

#pragma mark - Configuration

- (UINavigationController*)navigationController;

- (void)setValue:(id)value
      forDataKey:(NSString*)key;
- (id)valueForDataKey:(NSString*)key;

- (void)configure:(DNCBaseSceneViewController*)viewController;

@end
