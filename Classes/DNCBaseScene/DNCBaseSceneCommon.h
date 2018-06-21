//
//  DNCBaseSceneCommon.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCore/DNCUtilities.h>
#import <UIKit/UIKit.h>

#ifndef CLEAN_COMMON
#define CLEAN_COMMON 1

#define CLEAN_RETURNTOOPENER    @"opener"
#define CLEAN_RETURNTOROOT      @"root"
#define CLEAN_RETURNTOSKIP      @"skip"

typedef NS_ENUM(NSUInteger, DNCBaseSceneDisplayType)
{
    DNCBaseSceneDisplayTypeNone,
    DNCBaseSceneDisplayTypeModal,
    DNCBaseSceneDisplayTypeNavBarPush,
    DNCBaseSceneDisplayTypeNavBarPushInstant,
    DNCBaseSceneDisplayTypeNavBarRoot,
    DNCBaseSceneDisplayTypeNavBarRootInstant,

    DNCBaseSceneDisplayType_Count
};

@protocol CleanViewControllerInput

@end

@protocol CleanPresenterInput

@property (weak, nonatomic) id<CleanViewControllerInput>    output;

@end

#endif // CLEAN_COMMON
