//
//  DNCBaseScenePresenterInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseScenePresenterInput

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartResponse*)response;

#pragma mark - Presentation logic

- (void)presentConfirmation:(DNCBaseSceneConfirmationResponse*)response;
- (void)presentDismiss:(DNCBaseSceneDismissResponse*)response;
- (void)presentError:(DNCBaseSceneErrorResponse*)response;
- (void)presentMessage:(DNCBaseSceneMessageResponse*)response;
- (void)presentRoot:(DNCBaseSceneResponse*)response;
- (void)presentScene:(DNCBaseSceneResponse*)response;
- (void)presentSpinner:(DNCBaseSceneSpinnerResponse*)response;
- (void)presentTitle:(DNCBaseSceneTitleResponse*)response;
- (void)presentToast:(DNCBaseSceneMessageResponse*)response;
- (void)presentToastError:(DNCBaseSceneErrorResponse*)response;

@end

@protocol DNCBaseScenePresenterOutput<CleanViewControllerInput>

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
