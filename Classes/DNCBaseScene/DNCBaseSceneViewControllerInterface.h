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

#pragma mark - Display logic

- (void)displayConfirmation:(DNCBaseSceneConfirmationViewModel*)viewModel;
- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displayRoot:(DNCBaseSceneViewModel*)viewModel;
- (void)displayScene:(DNCBaseSceneViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayTitle:(DNCBaseSceneTitleViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end

@protocol DNCBaseSceneViewControllerOutput<CleanRouterOutput>

#pragma mark - Scene Lifecycle

- (void)sceneDidLoad:(DNCBaseSceneRequest*)request;
- (void)sceneDidAppear:(DNCBaseSceneRequest*)request;
- (void)sceneDidDisappear:(DNCBaseSceneRequest*)request;

#pragma mark - Event Actions

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;

@end
