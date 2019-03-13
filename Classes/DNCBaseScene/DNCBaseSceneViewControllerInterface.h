//
//  DNCBaseSceneViewControllerInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseSceneViewControllerInput<CleanViewControllerInput>

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartViewModel*)viewModel;
- (void)endScene:(DNCBaseSceneEndViewModel*)viewModel;

#pragma mark - Display logic

- (void)displayConfirmation:(DNCBaseSceneConfirmationViewModel*)viewModel;
- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayHud:(DNCBaseSceneHudViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayTitle:(DNCBaseSceneTitleViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end

@protocol DNCBaseSceneViewControllerOutput

#pragma mark - Scene Lifecycle

- (void)sceneDidAppear:(DNCBaseSceneRequest*)request;
- (void)sceneDidClose:(DNCBaseSceneRequest*)request;
- (void)sceneDidDisappear:(DNCBaseSceneRequest*)request;
- (void)sceneDidHide:(DNCBaseSceneRequest*)request;
- (void)sceneDidLoad:(DNCBaseSceneRequest*)request;
- (void)sceneWillAppear:(DNCBaseSceneRequest*)request;
- (void)sceneWillDisappear:(DNCBaseSceneRequest*)request;

#pragma mark - Event Actions

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;
- (void)doErrorOccurred:(DNCBaseSceneErrorRequest*)request;
- (void)doWebStartNavigation:(DNCBaseSceneWebRequest*)request;
- (void)doWebFinishNavigation:(DNCBaseSceneWebRequest*)request;
- (void)doWebErrorNavigation:(DNCBaseSceneWebErrorRequest*)request;

@end
