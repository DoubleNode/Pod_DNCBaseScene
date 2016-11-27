//
//  DNCBaseSceneViewControllerInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseSceneViewControllerInput

- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end

@protocol DNCBaseSceneViewControllerOutput

- (void)doDidLoad:(DNCBaseSceneRequest*)request;
- (void)doDidAppear:(DNCBaseSceneRequest*)request;

@end
