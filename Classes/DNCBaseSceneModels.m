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

//
// Response Models
//
#pragma mark - Response Models

@implementation __DNCBaseSceneResponse

+ (instancetype)response    {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneResponse
@end

@implementation DNCBaseSceneDismissResponse
@end

@implementation DNCBaseSceneErrorResponse
@end

@implementation DNCBaseSceneMessageResponse
@end

@implementation DNCBaseSceneSpinnerResponse
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

@implementation DNCBaseSceneDismissViewModel
@end

@implementation DNCBaseSceneMessageViewModel
@end

@implementation DNCBaseSceneSpinnerViewModel
@end

@implementation DNCBaseSceneToastViewModel
@end
