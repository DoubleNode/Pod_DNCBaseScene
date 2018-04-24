//
//  DNCBaseSceneViewController+Routing.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneViewController.h"

@interface DNCBaseSceneViewController (Routing)

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

#pragma mark - Navigation

- (void)whenDismissedRun:(DNCUtilitiesBlock)block;
- (void)dismiss:(BOOL)animated;
- (void)dismiss:(BOOL)animated forced:(BOOL)forced;

#pragma mark - Communication

- (void)passDataToNextViewController:(NSDictionary*)dataDictionary;

#pragma mark - Utility

- (DNCBaseSceneViewController*)utilityPeekScene:(NSString*)classBaseName;

@end
