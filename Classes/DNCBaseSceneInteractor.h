//
//  DNCBaseSceneInteractor.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCProtocols/PTCLAnalytics_Protocol.h>

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneInteractorInterface.h"
#import "DNCBaseSceneViewControllerInterface.h"

@interface DNCBaseSceneInteractor : NSObject<CleanRouterOutput, DNCBaseSceneInteractorInput, DNCBaseSceneViewControllerOutput>

+ (instancetype)interactor;

@property (strong, nonatomic)   id<CleanPresenterInput, DNCBaseSceneInteractorOutput>   output;

@property (copy, nonatomic)     NSDictionary*       receivedData;
@property (weak, nonatomic)     UIViewController*   returnTo;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

- (NSDictionary*)receiveAndClearData;

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;
- (void)doDidLoad:(DNCBaseSceneRequest*)request;
- (void)doDidAppear:(DNCBaseSceneRequest*)request;

@end
