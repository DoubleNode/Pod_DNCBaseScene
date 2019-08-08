//
//  DNCBaseSceneConfigurator.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneCommon.h"

@class DNCCoordinator;

@class DNCBaseSceneInitializationObject;
@class DNCBaseSceneResultsObject;

@class DNCBaseSceneInteractor;
@class DNCBaseScenePresenter;
@class DNCBaseSceneViewController;

typedef void (^DNCBaseSceneConfiguratorBlock)(NSString* intent, BOOL dataChanged, DNCBaseSceneResultsObject* resultsObject);

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

// *******************************
// ** Deprecated Methods
- (DNCBaseSceneViewController*)loadSceneWithCoordinator:(DNCCoordinator*)coordinator
                                         andDisplayType:(DNCBaseSceneDisplayType)displayType
                                                thenRun:(DNCBaseSceneConfiguratorBlock)endBlock DEPRECATED_MSG_ATTRIBUTE("Use -loadSceneWithCoordinator:andDisplayType:andInitializationObject:thenRun:");

- (DNCBaseSceneViewController*)runSceneWithCoordinator:(DNCCoordinator*)coordinator
                                        andDisplayType:(DNCBaseSceneDisplayType)displayType
                                               thenRun:(DNCBaseSceneConfiguratorBlock)endBlock DEPRECATED_MSG_ATTRIBUTE("Use -runSceneWithCoordinator:andDisplayType:andInitializationObject:thenRun:");

- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged DEPRECATED_MSG_ATTRIBUTE("Use -endSceneWithResultsObject:andIntent:andDataChanged:");
// **
// *******************************

- (DNCBaseSceneViewController*)loadSceneWithCoordinator:(DNCCoordinator*)coordinator
                                         andDisplayType:(DNCBaseSceneDisplayType)displayType
                                andInitializationObject:(DNCBaseSceneInitializationObject*)initializationObject
                                                thenRun:(DNCBaseSceneConfiguratorBlock)endBlock;

- (DNCBaseSceneViewController*)runSceneWithCoordinator:(DNCCoordinator*)coordinator
                                        andDisplayType:(DNCBaseSceneDisplayType)displayType
                               andInitializationObject:(DNCBaseSceneInitializationObject*)initializationObject
                                               thenRun:(DNCBaseSceneConfiguratorBlock)endBlock;

- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged
          andResultsObject:(DNCBaseSceneResultsObject*)resultsObject;

- (void)removeSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType;

#pragma mark - Configuration

- (UINavigationController*)navigationController;

- (void)configure:(DNCBaseSceneViewController*)viewController;

@end
