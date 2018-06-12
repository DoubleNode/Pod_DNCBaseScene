//
//  DNCBaseSceneInteractor.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDataObjects/DAOUser.h>

#import "DNCBaseSceneInteractor.h"

@interface DNCBaseSceneInteractor ()
{
    BOOL    _sceneEnded;
}

@end

@implementation DNCBaseSceneInteractor

+ (instancetype)interactor   {   return [[[self class] alloc] init]; }

- (id)init
{
    self = [super init];
    if (self)
    {
        _sceneEnded = NO;
    }
    
    return self;
}

#pragma mark - Lifecycle Methods

- (void)startSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneStartResponse*  response = DNCBaseSceneStartResponse.response;
    response.displayType    = displayType;
    [self.output startScene:response];
}

- (BOOL)shouldEndScene
{
    BOOL    shouldEndSceneFlag = !_sceneEnded;
    
    _sceneEnded = YES;
    
    return shouldEndSceneFlag;
}

- (void)endScene
{
    if (!self.shouldEndScene)
    {
        return;
    }
    
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.configurator endScene];
}

#pragma mark - Configuration

- (void)setValue:(id)value
forConfigDataKey:(NSString*)key
{
    [self.configurator setValue:value
                     forDataKey:key];
}

- (id)valueForConfigDataKey:(NSString*)key
{
    return [self.configurator valueForDataKey:key];
}

#pragma mark - CleanRouterOutput protocol

- (UIViewController*)returnTo
{
    return _returnTo;
}

#pragma mark - Incoming Data

- (NSDictionary*)receiveAndClearData
{
    NSDictionary*   retval  = self.receivedData;
    
    self.receivedData   = nil;
    
    return retval;
}

#pragma mark - Scene Lifecycle

- (void)sceneDidLoad:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneDidAppear:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _sceneEnded = NO;
}

- (void)sceneDidDisappear:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneDidHide:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneDidClose:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

#pragma mark - Business Logic

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

@end
