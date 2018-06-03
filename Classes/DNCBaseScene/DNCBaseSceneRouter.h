//
//  DNCBaseSceneRouter.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneRouterInterface.h"

#import "DNCBaseSceneConfigurator.h"

@class DNCBaseSceneViewController;

@interface DNCBaseSceneRouter : NSObject<DNCBaseSceneRouterInput>

+ (instancetype)router;

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;

@property (weak, nonatomic) DNCBaseSceneViewController* viewController;

#pragma mark - Configuration

- (void)setConfigDataKey:(NSString*)key
               withValue:(id)value;
- (id)valueForConfigDataKey:(NSString*)key;

#pragma mark - ViewController Class Names

//- (NSString*)classSceneAvatar;

#pragma mark - Routing

//- (void)routeToSceneAvatar;
- (void)routeToRoot;
- (void)routeToScene:(NSString*)scene;

#pragma mark - Peeking

//- (UIViewController*)peekSceneAvatar;

#pragma mark - Popping

- (void)popScene:(DNCBaseSceneViewController*)viewController;
- (void)popScene:(DNCBaseSceneViewController*)viewController animated:(BOOL)animated;

#pragma mark - Navigation

- (void)whenDismissedRun:(DNCUtilitiesBlock)block;
- (void)runDismissBlock;

- (void)dismiss:(BOOL)animated;
- (void)dismiss:(BOOL)animated forced:(BOOL)forced;

#pragma mark - Communication

- (void)passDataToNextViewController:(NSDictionary*)dataDictionary;

#pragma mark - Utility

- (void)utilityCallToCoordinator:(NSString*)selectorString;
- (DNCBaseSceneViewController*)utilityPeekScene:(NSString*)classBaseName;

@end
