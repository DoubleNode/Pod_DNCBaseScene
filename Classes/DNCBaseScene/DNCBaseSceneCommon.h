//
//  DNCBaseSceneCommon.h
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

@import DNCore;
@import UIKit;

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

@protocol DNCBaseBusinessLogic;
@protocol DNCBasePresentationLogic;
@protocol DNCBaseDisplayLogic;

@protocol DNCBaseBusinessLogic

@property (strong, nonatomic) id<DNCBasePresentationLogic>  output;

@end

@protocol DNCBasePresentationLogic

@property (weak, nonatomic) id<DNCBaseDisplayLogic> output;

@end

@protocol DNCBaseDisplayLogic

@property (strong, nonatomic) id<DNCBaseBusinessLogic>  output;

@end

#endif // CLEAN_COMMON
