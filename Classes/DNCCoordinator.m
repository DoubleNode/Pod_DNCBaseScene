//
//  DNCCoordinator.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCCoordinator.h"

#import "DNCBaseSceneViewController.h"

@interface DNCCoordinator()
{
    NSMutableDictionary<NSString*, DNCCoordinator*>*    _childCoordinators;
    
    NSArray<UIViewController*>* _savedViewControllers;
}

@end

@implementation DNCCoordinator

- (nullable instancetype)initWithNavigationController:(nonnull UINavigationController*)navigationController
{
    self = super.init;
    if (self)
    {
        _childCoordinators      = NSMutableDictionary.dictionary;
        _navigationController   = navigationController;
    }
    
    return self;
}

- (void)start
{
    switch (self.runState)
    {
        case DNCCoordinatorStateNotStarted:
        {
            self.runState   = DNCCoordinatorStateStarted;
            break;
        }

        case DNCCoordinatorStateStarted:
        case DNCCoordinatorStateTerminated:
        {
            [self reset];
            break;
        }

        default:
        {
            NSAssert(NO, @"%@ : Coordinator in invalid state and cannot be restarted", NSStringFromClass(self.class));
            break;
        }
    }
    
    [DNCUIThread run:
     ^()
     {
         self->_savedViewControllers   = self.navigationController.viewControllers;
     }];
    
}

- (void)reset
{
    self.runState   = DNCCoordinatorStateNotStarted;
    
    _savedViewControllers = nil;
}

- (void)stop
{
    self.runState   = DNCCoordinatorStateNotStarted;

    [DNCUIThread run:
     ^()
     {
         [self.navigationController setViewControllers:self->_savedViewControllers
                                              animated:YES];
     }];

    _savedViewControllers = nil;
}

- (void)addChildCoordinator:(nonnull DNCCoordinator*)childCoordinator
                     forKey:(nonnull NSString*)key
{
    _childCoordinators[key] = childCoordinator;
}

- (void)removeChildCoordinatorForKey:(nonnull NSString*)key
{
    [_childCoordinators removeObjectForKey:key];
}

@end

