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

    [self forAllChildCoordinatorsRunBlock:
     ^(DNCCoordinator* block)
     {
         [block reset];
     }];
    
    _childCoordinators      = NSMutableDictionary.dictionary;
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
    NSAssert([childCoordinator isKindOfClass:DNCCoordinator.class], @"childCoordinator is NOT a DNCCoordinator.class!");
    NSAssert([key isKindOfClass:NSString.class], @"key is NOT a NSString.class!");

    _childCoordinators[key] = childCoordinator;
}

- (void)removeChildCoordinatorForKey:(nonnull NSString*)key
{
    NSAssert([key isKindOfClass:NSString.class], @"key is NOT a NSString.class!");

    [_childCoordinators removeObjectForKey:key];
}

- (void)forAllChildCoordinatorsRunBlock:(DNCCoordinatorChildCoordinatorBlock)block
{
    [_childCoordinators enumerateKeysAndObjectsUsingBlock:
     ^(NSString* _Nonnull key, DNCCoordinator* _Nonnull childCoordinator, BOOL* _Nonnull stop)
     {
         NSAssert([childCoordinator isKindOfClass:DNCCoordinator.class], @"childCoordinator is NOT a DNCCoordinator.class!");

         block ? block(childCoordinator) : (void)nil;
     }];
}

- (void)forSuggestedAction:(NSString*)suggestedAction
       runBlockFromActions:(const DNCCoordinatorActions*)actions
               unlessBlank:(DNCUtilitiesBlock)blankBlock
                 orNoMatch:(DNCUtilitiesBlock)noMatchBlock
{
    if (!suggestedAction.length)
    {
        blankBlock ? blankBlock() : (void)nil;
        return;
    }
    
    __block BOOL    matchFound = NO;
    
    [actions enumerateKeysAndObjectsUsingBlock:
     ^(NSString* _Nonnull key, DNCUtilitiesBlock _Nonnull block, BOOL* _Nonnull stop)
     {
         if ([suggestedAction isEqualToString:key])
         {
             matchFound = YES;
             
             block ? block() : (void)nil;
             *stop = YES;
             return;
         }
     }];
    
    if (matchFound)
    {
        return;
    }
    
    noMatchBlock ? noMatchBlock() : (void)nil;
}

@end

