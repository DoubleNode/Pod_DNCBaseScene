//
//  DNCBaseSceneModels.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneModels.h"

//
// Request Models
//
#pragma mark - Request Models

@implementation __DNCBaseSceneRequest

+ (instancetype)request     {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneRequest
@end

@implementation DNCBaseSceneErrorRequest
@end

@implementation DNCBaseSceneConfirmationRequest
@end

//
// Response Models
//
#pragma mark - Response Models

@implementation __DNCBaseSceneResponse

+ (instancetype)response    {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneResponse
@end

@implementation DNCBaseSceneStartResponse
@end

@implementation DNCBaseSceneConfirmationResponse
@end

@implementation DNCBaseSceneDismissResponse
@end

@implementation DNCBaseSceneErrorResponse
@end

@implementation DNCBaseSceneMessageResponse
@end

@implementation DNCBaseSceneSpinnerResponse
@end

@implementation DNCBaseSceneTitleResponse
@end

//
// ViewModel Models
//
#pragma mark - ViewModel Models

@implementation __DNCBaseSceneViewModel

+ (instancetype)viewModel   {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneViewModel
@end

@implementation DNCBaseSceneStartViewModel
@end

@implementation DNCBaseSceneConfirmationViewModel
@end

@implementation DNCBaseSceneDismissViewModel
@end

@implementation DNCBaseSceneMessageViewModel
@end

@implementation DNCBaseSceneSpinnerViewModel
@end

@implementation DNCBaseSceneTitleViewModel
@end

@implementation DNCBaseSceneToastViewModel
@end
