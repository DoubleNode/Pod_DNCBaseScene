//
//  DNCBaseSceneViewControllerInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseSceneViewControllerInput<CleanViewControllerInput>

- (void)displayConfirmation:(DNCBaseSceneConfirmationViewModel*)viewModel;
- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displayRoot:(DNCBaseSceneViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayTitle:(DNCBaseSceneTitleViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end

@protocol DNCBaseSceneViewControllerOutput<CleanRouterOutput>

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;
- (void)doDidLoad:(DNCBaseSceneRequest*)request;
- (void)doDidAppear:(DNCBaseSceneRequest*)request;

@end
