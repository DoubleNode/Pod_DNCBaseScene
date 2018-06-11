//
//  DNCBaseSceneCommon.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCore/DNCUtilities.h>
#import <UIKit/UIKit.h>

#ifndef CLEAN_ROUTER_OUTPUT
#define CLEAN_ROUTER_OUTPUT 1

#define CLEAN_RETURNTOOPENER    @"opener"
#define CLEAN_RETURNTOROOT      @"root"
#define CLEAN_RETURNTOSKIP      @"skip"

typedef NS_ENUM(NSUInteger, DNCBaseSceneDisplayType)
{
    DNCBaseSceneDisplayType_None,
    DNCBaseSceneDisplayTypeModal,
    DNCBaseSceneDisplayTypeNavBarPush,
    DNCBaseSceneDisplayTypeNavBarRoot,

    DNCBaseSceneDisplayType_Count
};

@protocol CleanRouterOutput

@property (copy, nonatomic) NSDictionary*       receivedData;
@property (weak, nonatomic) UIViewController*   returnTo;

@end

@protocol CleanViewControllerInput

@property (strong, nonatomic)   id<CleanRouterOutput>           output;
@property (weak, nonatomic)     id<CleanViewControllerInput>    opener;

@end

@protocol CleanPresenterInput

@property (weak, nonatomic) id<CleanViewControllerInput>    output;

@end

#endif // CLEAN_ROUTER_OUTPUT
