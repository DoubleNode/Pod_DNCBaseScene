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

typedef void (^DNCCoordinatorChildCoordinatorBlock)(DNCCoordinator* _Nonnull block);

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
- (void)forAllChildCoordinatorsRunBlock:(nullable DNCCoordinatorChildCoordinatorBlock)block;

typedef NSDictionary<NSString*, DNCUtilitiesBlock>  DNCCoordinatorActions;

- (void)forSuggestedAction:(nullable NSString*)suggestedAction
       runBlockFromActions:(nullable const DNCCoordinatorActions*)actions
               unlessBlank:(nullable DNCUtilitiesBlock)blankBlock
                 orNoMatch:(nullable DNCUtilitiesBlock)noMatchBlock;

#pragma mark - Utility methods

- (void)utilityShouldAllowSectionStatusWithStatus:(DNCAppConstantsStatus)status
                                  andSectionTitle:(nullable NSString*)sectionTitle
                                       andMessage:(nullable NSString*)message
                                   andCancelBlock:(nullable DNCUtilitiesBlock)cancelBlock
                                 andContinueBlock:(nullable DNCUtilitiesBlock)continueBlock
                                     andBuildType:(DNCAppConstantsBuildType)buildType;

- (void)utilityShowSectionStatusMessageForSectionTitle:(nullable NSString*)title
                                           withMessage:(nullable NSString*)message
                                        andCancelBlock:(nullable DNCUtilitiesBlock)cancelBlock
                                      andContinueBlock:(nullable DNCUtilitiesBlock)continueBlock;

@end
