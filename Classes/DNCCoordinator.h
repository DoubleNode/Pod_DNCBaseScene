//
//  DNCCoordinator.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DNCCoordinatorState)
{
    DNCCoordinatorStateNotStarted = 0,
    DNCCoordinatorStateStarted,
    DNCCoordinatorStateTerminated,

    DNCCoordinatorState_Count
};

@class DNCBaseSceneViewController;

@interface DNCCoordinator : NSObject

@property (weak, nonatomic) id _Nullable  delegate;

@property (assign, nonatomic) DNCCoordinatorState   runState;

@property (strong, nonatomic)   UINavigationController* _Nullable navigationController;

- (nullable instancetype)initWithNavigationController:(nonnull UINavigationController*)navigationController;

- (void)addChildCoordinator:(nonnull DNCCoordinator*)childCoordinator
                     forKey:(nonnull NSString*)key;
- (void)removeChildCoordinatorForKey:(nonnull NSString*)key;

- (void)start;
- (void)reset;
- (void)stop;

@end
