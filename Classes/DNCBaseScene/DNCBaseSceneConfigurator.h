//
//  DNCBaseSceneConfigurator.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneCommon.h"

@class DNCCoordinator;

@class DNCBaseSceneInteractor;
@class DNCBaseScenePresenter;

@class DNCBaseSceneViewController;

typedef void (^DNCBaseSceneConfiguratorBlock)(NSString* suggestedAction, BOOL dataChanged);

@interface DNCBaseSceneConfigurator : NSObject

@property (strong, nonatomic)   DNCBaseSceneInteractor*     interactor;
@property (strong, nonatomic)   DNCBaseScenePresenter*      presenter;
@property (strong, nonatomic)   DNCBaseSceneViewController* viewController;

#pragma mark - VIP Object Class Base Names

+ (NSString*)classBaseInteractor;
+ (NSString*)classBasePresenter;
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

- (void)removeSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType;

#pragma mark - Configuration

- (UINavigationController*)navigationController;

- (void)configure:(DNCBaseSceneViewController*)viewController;

@end
