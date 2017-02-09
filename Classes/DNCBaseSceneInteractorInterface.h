//
//  DNCBaseSceneInteractorInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

@protocol DNCBaseSceneInteractorInput

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;
- (void)doDidLoad:(DNCBaseSceneRequest*)request;
- (void)doDidAppear:(DNCBaseSceneRequest*)request;

@end

@protocol DNCBaseSceneInteractorOutput

- (void)presentConfirmation:(DNCBaseSceneConfirmationResponse*)response;
- (void)presentDismiss:(DNCBaseSceneDismissResponse*)response;
- (void)presentError:(DNCBaseSceneErrorResponse*)response;
- (void)presentMessage:(DNCBaseSceneMessageResponse*)response;
- (void)presentSpinner:(DNCBaseSceneSpinnerResponse*)response;
- (void)presentTitle:(DNCBaseSceneTitleResponse*)response;
- (void)presentToast:(DNCBaseSceneMessageResponse*)response;
- (void)presentToastError:(DNCBaseSceneErrorResponse*)response;

@end
