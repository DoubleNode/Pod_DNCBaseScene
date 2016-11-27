//
//  DNCBaseScenePresenterInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseScenePresenterInput

- (void)presentDismiss:(DNCBaseSceneDismissResponse*)response;
- (void)presentMessage:(DNCBaseSceneMessageResponse*)response;
- (void)presentSpinner:(DNCBaseSceneSpinnerResponse*)response;
- (void)presentToast:(DNCBaseSceneMessageResponse*)response;
- (void)presentToastError:(DNCBaseSceneMessageResponse*)response;

@end

@protocol DNCBaseScenePresenterOutput

- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end
