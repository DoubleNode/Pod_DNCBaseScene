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
    _savedViewControllers   = self.navigationController.viewControllers;
}

- (void)reset
{
    
}

- (void)stop
{
    [self.navigationController setViewControllers:_savedViewControllers
                                         animated:YES];
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

#pragma mark - Utility methods

- (void)utilityPresentViewControllerOnNavigationController:(nonnull DNCBaseSceneViewController*)viewController
{
    [self utilityPresentViewControllerOnNavigationController:viewController
                                                 forceAsRoot:NO];
}

- (void)utilityPresentViewControllerOnNavigationController:(nonnull DNCBaseSceneViewController*)viewController
                                               forceAsRoot:(BOOL)forceAsRoot

{
    viewController.coordinatorDelegate  = self;
    
    if (forceAsRoot ||
        !self.navigationController.viewControllers.count)
    {
        [DNCUIThread run:
         ^()
         {
             [self.navigationController setViewControllers:@[ viewController ]
                                                  animated:YES];
         }];
        return;
    }
    
    [DNCUIThread run:
     ^()
     {
         if ([self.navigationController.viewControllers.lastObject isKindOfClass:viewController.class])
         {
             return;
         }
         
         [self.navigationController pushViewController:viewController
                                              animated:YES];
     }];
}

@end

