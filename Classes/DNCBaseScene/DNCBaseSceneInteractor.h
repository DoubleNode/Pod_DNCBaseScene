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

#import "DNCBaseSceneInteractorProtocol.h"
#import "DNCBaseScenePresenterProtocol.h"

@interface DNCBaseSceneInteractor : NSObject<DNCBaseSceneInteractorProtocol>

+ (instancetype)interactor;

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;

@property (strong, nonatomic)   id<DNCBaseScenePresenterProtocol>   output;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

#pragma mark - Lifecycle Methods

- (void)startSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType;
- (BOOL)shouldEndScene;
- (void)endSceneWithIntent:(NSString*)intent
            andDataChanged:(BOOL)dataChanged;
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
