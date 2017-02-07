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

@end

@implementation DNCBaseSceneInteractor

+ (instancetype)interactor   {   return [[[self class] alloc] init]; }

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    
    return self;
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

#pragma mark - Business logic

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request
{
    
}

- (void)doDidLoad:(DNCBaseSceneRequest*)request
{
}

- (void)doDidAppear:(DNCBaseSceneRequest*)request
{
}

@end
