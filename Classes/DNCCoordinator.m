//
//  DNCCoordinator.m
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

#import "DNCCoordinator.h"

#import "DNCBaseSceneViewController.h"

@interface DNCCoordinator()
{
    NSMutableDictionary<NSString*, DNCCoordinator*>*    _childCoordinators;
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
         self.savedViewControllers   = self.navigationController.viewControllers;
     }];
    
}

- (void)reset
{
    self.runState   = DNCCoordinatorStateNotStarted;
    
    self.savedViewControllers = nil;
    
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
         [self.navigationController setViewControllers:self.savedViewControllers
                                              animated:YES];
     }];
    
    self.savedViewControllers = nil;
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

- (void)forIntent:(NSString*)intent
       runActions:(const DNCCoordinatorActions*)actions
      unlessBlank:(DNCUtilitiesBlock)blankBlock
        orNoMatch:(DNCUtilitiesBlock)noMatchBlock
{
    if (!intent.length)
    {
        blankBlock ? blankBlock() : (void)nil;
        return;
    }
    
    __block BOOL    matchFound = NO;
    
    [actions enumerateKeysAndObjectsUsingBlock:
     ^(NSString* _Nonnull key, DNCUtilitiesBlock _Nonnull block, BOOL* _Nonnull stop)
     {
         if ([intent isEqualToString:key])
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

#pragma mark - Utility methods

- (void)utilityShouldAllowSectionStatusWithStatus:(DNCAppConstantsStatus)status
                                  andSectionTitle:(NSString*)sectionTitle
                                       andMessage:(NSString*)message
                                   andCancelBlock:(DNCUtilitiesBlock)cancelBlock
                                 andContinueBlock:(DNCUtilitiesBlock)continueBlock
                                     andBuildType:(DNCAppConstantsBuildType)buildType
{
    switch (status)
    {
        case DNCAppConstantsStatusYellow:
        {
            if (!message.length)
            {
                message = [NSString stringWithFormat:NSLocalizedString(@"We apologize, but our %@ is currently experiencing occasional issues.  We are working quickly to find and correct the problem.\n\nYou can continue, or check back later.", nil), sectionTitle];
            }
            [self utilityShowSectionStatusMessageForSectionTitle:sectionTitle
                                                     withMessage:message
                                                  andCancelBlock:cancelBlock
                                                andContinueBlock:continueBlock];
            break;
        }
        case DNCAppConstantsStatusRed:
        {
            if (!message.length)
            {
                message = [NSString stringWithFormat:NSLocalizedString(@"We apologize, but our %@ is temporarily down.  We are working quickly to find and correct the problem.\n\nPlease check back later.", nil), sectionTitle];
            }
            

            DNCUtilitiesBlock   actualContinueBlock = ((buildType == DNCAppConstantsBuildTypeDEV) ? continueBlock : nil);
            
            [self utilityShowSectionStatusMessageForSectionTitle:sectionTitle
                                                     withMessage:message
                                                  andCancelBlock:cancelBlock
                                                andContinueBlock:actualContinueBlock];
            break;
        }
            
        case DNCAppConstantsStatusGreen:
        case DNCAppConstantsStatusUnknown:
        default:
        {
            continueBlock ? continueBlock() : (void)nil;
            break;
        }
    }
}

- (void)utilityShowSectionStatusMessageForSectionTitle:(NSString*)title
                                           withMessage:(NSString*)message
                                        andCancelBlock:(DNCUtilitiesBlock)cancelBlock
                                      andContinueBlock:(DNCUtilitiesBlock)continueBlock
{
    if (!title)
    {
        continueBlock ? continueBlock() : (cancelBlock ? cancelBlock() : (void)nil);
        return;
    }
    
    [DNCUIThread run:
     ^()
     {
         UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
         
         if (continueBlock)
         {
             UIAlertAction* okayAction = [UIAlertAction actionWithTitle:@"Continue"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:
                                          ^(UIAlertAction* _Nonnull action)
                                          {
                                              continueBlock ? continueBlock() : (void)nil;
                                          }];
             [alertController addAction:okayAction];
         }
         
         UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleCancel
                                                              handler:
                                        ^(UIAlertAction* _Nonnull action)
                                        {
                                            cancelBlock ? cancelBlock() : (void)nil;
                                        }];
         
         [alertController addAction:cancelAction];
         
         [DNCUtilities.appDelegate.rootViewController presentViewController:alertController
                                                                   animated:YES
                                                                 completion:nil];
     }];
}

@end

