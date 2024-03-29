//
//  DNCBaseSceneModels.m
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

#import "DNCBaseSceneModels.h"

//
// InitializationObject Models
//
#pragma mark - InitializationObject Models

@implementation __DNCBaseSceneInitializationObject

+ (instancetype)initializationObject    {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneInitializationObject
@end

//
// ResultsObject Models
//
#pragma mark - ResultsObject Models

@implementation __DNCBaseSceneResultsObject

+ (instancetype)resultsObject   {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneResultsObject
@end

//
// DataObject Models
//
#pragma mark - DataObject Models

@implementation __DNCBaseSceneDataObject

+ (instancetype)dataObject  {   return [[self.class alloc] init]; }

@end

@implementation DNCBaseSceneDataObject
@end

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

@implementation DNCBaseSceneWebRequest
@end

@implementation DNCBaseSceneWebErrorRequest
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

@implementation DNCBaseSceneEndResponse
@end

@implementation DNCBaseSceneConfirmationResponse
@end

@implementation DNCBaseSceneDismissResponse
@end

@implementation DNCBaseSceneErrorResponse
@end

@implementation DNCBaseSceneHudResponse
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

@implementation DNCBaseSceneEndViewModel
@end

@implementation DNCBaseSceneConfirmationViewModel
@end

@implementation DNCBaseSceneDismissViewModel
@end

@implementation DNCBaseSceneHudViewModel
@end

@implementation DNCBaseSceneMessageViewModel
@end

@implementation DNCBaseSceneSpinnerViewModel
@end

@implementation DNCBaseSceneTitleViewModel
@end

@implementation DNCBaseSceneToastViewModel
@end
