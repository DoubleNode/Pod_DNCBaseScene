//
//  DNCBaseSceneInteractor.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCProtocols/PTCLAnalytics_Protocol.h>

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneConfigurator.h"
#import "DNCBaseSceneInteractorInterface.h"
#import "DNCBaseSceneViewControllerInterface.h"

@interface DNCBaseSceneInteractor : NSObject<DNCBaseSceneInteractorInput, DNCBaseSceneViewControllerOutput>

+ (instancetype)interactor;

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;

@property (strong, nonatomic)   id<DNCBaseSceneInteractorOutput>   output;

@property (copy, nonatomic)     NSDictionary*       receivedData;
@property (weak, nonatomic)     UIViewController*   returnTo;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

#pragma mark - Configuration

- (void)setConfigDataKey:(NSString*)key
         withValue:(id)value;
- (id)valueForConfigDataKey:(NSString*)key;

#pragma mark - Incoming Data

- (NSDictionary*)receiveAndClearData;

#pragma mark - Business logic

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request;
- (void)doDidLoad:(DNCBaseSceneRequest*)request;
- (void)doDidAppear:(DNCBaseSceneRequest*)request;

@end
