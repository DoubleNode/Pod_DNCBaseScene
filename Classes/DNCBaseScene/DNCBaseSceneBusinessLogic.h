//
//  DNCBaseSceneBusinessLogic.h
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseSceneBusinessLogic<DNCBaseBusinessLogic>

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
