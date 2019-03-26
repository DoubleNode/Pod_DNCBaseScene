//
//  DNCCoordinator.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;
@import UIKit;

typedef NS_ENUM(NSUInteger, DNCCoordinatorState)
{
    DNCCoordinatorStateNotStarted = 0,
    DNCCoordinatorStateStarted,
    DNCCoordinatorStateTerminated,
    
    DNCCoordinatorState_Count
};

@class DNCCoordinator;

typedef void (^DNCCoordinatorChildCoordinatorBlock)(DNCCoordinator* block);

@class DNCBaseSceneViewController;

@interface DNCCoordinator : NSObject

@property (weak, nonatomic) id _Nullable  delegate;

@property (assign, nonatomic) DNCCoordinatorState   runState;

@property (strong, nonatomic)   UINavigationController* _Nullable navigationController;

@property (strong, nonatomic)   NSArray<UIViewController*>* _Nullable   savedViewControllers;

- (nullable instancetype)initWithNavigationController:(nonnull UINavigationController*)navigationController;

- (void)start;
- (void)reset;
- (void)stop;

- (void)addChildCoordinator:(nonnull DNCCoordinator*)childCoordinator
                     forKey:(nonnull NSString*)key;
- (void)removeChildCoordinatorForKey:(nonnull NSString*)key;
- (void)forAllChildCoordinatorsRunBlock:(DNCCoordinatorChildCoordinatorBlock)block;

typedef NSDictionary<NSString*, DNCUtilitiesBlock>  DNCCoordinatorActions;

- (void)forSuggestedAction:(NSString*)suggestedAction
       runBlockFromActions:(const DNCCoordinatorActions*)actions
               unlessBlank:(DNCUtilitiesBlock)blankBlock
                 orNoMatch:(DNCUtilitiesBlock)noMatchBlock;

#pragma mark - Utility methods

- (void)utilityShouldAllowSectionStatusWithStatus:(DNCAppConstantsStatus)status
                                  andSectionTitle:(NSString*)sectionTitle
                                       andMessage:(NSString*)message
                                   andCancelBlock:(DNCUtilitiesBlock)cancelBlock
                                 andContinueBlock:(DNCUtilitiesBlock)continueBlock
                                     andBuildType:(DNCAppConstantsBuildType)buildType;

- (void)utilityShowSectionStatusMessageForSectionTitle:(NSString*)title
                                           withMessage:(NSString*)message
                                        andCancelBlock:(DNCUtilitiesBlock)cancelBlock
                                      andContinueBlock:(DNCUtilitiesBlock)continueBlock;

@end
