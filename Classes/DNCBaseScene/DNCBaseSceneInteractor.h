//
//  DNCBaseSceneInteractor.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCProtocols;

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneConfigurator.h"

#import "DNCBaseSceneBusinessLogic.h"
#import "DNCBaseScenePresentationLogic.h"

@class DNCBaseSceneInitializationObject;
@class DNCBaseSceneResultsObject;

@interface DNCBaseSceneInteractor : NSObject<DNCBaseSceneBusinessLogic>

+ (instancetype)interactor;

@property (strong, nonatomic) DNCBaseSceneConfigurator*         configurator;
@property (strong, nonatomic) DNCBaseSceneInitializationObject* initializationObject;

@property (strong, nonatomic)   id<DNCBaseScenePresentationLogic>   output;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

#pragma mark - Lifecycle Methods

// *******************************
// ** Deprecated Methods
- (void)startSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType DEPRECATED_MSG_ATTRIBUTE("Use -startSceneWithDisplayType:andInitializationObject:");

- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged DEPRECATED_MSG_ATTRIBUTE("Use -endSceneWithResultsObject:andIntent:andDataChanged:");
// **
// *******************************

- (void)startSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType
          andInitializationObject:(DNCBaseSceneInitializationObject*)initializationObject;

- (BOOL)shouldEndScene;

- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged
          andResultsObject:(DNCBaseSceneResultsObject*)resultsObject;

- (void)removeSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType;

#pragma mark - Scene Lifecycle

- (void)sceneDidAppear:(DNCBaseSceneRequest*)request;
- (void)sceneDidClose:(DNCBaseSceneRequest*)request;
- (void)sceneDidDisappear:(DNCBaseSceneRequest*)request;
- (void)sceneDidHide:(DNCBaseSceneRequest*)request;
- (void)sceneDidLoad:(DNCBaseSceneRequest*)request;
- (void)sceneWillAppear:(DNCBaseSceneRequest*)request;
- (void)sceneWillDisappear:(DNCBaseSceneRequest*)request;

#pragma mark - Business Logic

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;
- (void)doErrorOccurred:(DNCBaseSceneErrorRequest*)request;
- (void)doWebStartNavigation:(DNCBaseSceneWebRequest*)request;
- (void)doWebFinishNavigation:(DNCBaseSceneWebRequest*)request;
- (void)doWebErrorNavigation:(DNCBaseSceneWebErrorRequest*)request;

@end
