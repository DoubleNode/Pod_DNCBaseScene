//
//  DNCBaseSceneInteractor.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneInteractor.h"

@interface DNCBaseSceneInteractor ()
{
    DNCBaseSceneDisplayType _displayType;
    
    BOOL    _sceneEnded;
}

@end

@implementation DNCBaseSceneInteractor

+ (instancetype)interactor   {   return [self.class.alloc init];    }

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
    
    _displayType    = displayType;
    
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

- (void)endSceneWithSuggestedAction:(NSString*)suggestedAction
                     andDataChanged:(BOOL)dataChanged
{
    [self endSceneConditionally:NO
            withSuggestedAction:suggestedAction
                 andDataChanged:dataChanged];
}

- (void)endSceneConditionally:(BOOL)conditionally
          withSuggestedAction:(NSString*)suggestedAction
               andDataChanged:(BOOL)dataChanged
{
    if (!self.shouldEndScene)
    {
        if (conditionally)
        {
            return;
        }
    }
    
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.configurator endSceneWithSuggestedAction:suggestedAction
                                    andDataChanged:dataChanged];
}

- (void)removeSceneWithDisplayType:(DNCBaseSceneDisplayType)displayType
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneEndResponse*    response = DNCBaseSceneEndResponse.response;
    response.displayType    = displayType;
    [self.output endScene:response];
}

#pragma mark - Scene Lifecycle

- (void)sceneDidAppear:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _sceneEnded = NO;
}

- (void)sceneDidClose:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self endSceneConditionally:YES
            withSuggestedAction:@""
                 andDataChanged:NO];
}

- (void)sceneDidDisappear:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneDidHide:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneDidLoad:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneWillAppear:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)sceneWillDisappear:(DNCBaseSceneRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

#pragma mark - Business Logic

- (void)doConfirmation:(DNCBaseSceneConfirmationRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)doErrorOccurred:(DNCBaseSceneErrorRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];

    DNCBaseSceneErrorResponse*  response = DNCBaseSceneErrorResponse.response;
    response.title  = request.title;
    response.error  = request.error;
    [self.output presentError:response];
}

- (void)doWebStartNavigation:(DNCBaseSceneWebRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)doWebFinishNavigation:(DNCBaseSceneWebRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
}

- (void)doWebErrorNavigation:(DNCBaseSceneWebErrorRequest*)request
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneErrorResponse*  response = DNCBaseSceneErrorResponse.response;
    response.title  = @"Web Error";
    response.error  = request.error;
    [self.output presentError:response];
}

@end
