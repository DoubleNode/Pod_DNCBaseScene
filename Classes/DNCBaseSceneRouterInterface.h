//
//  DNCBaseSceneRouterInterface.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneCommon.h"

@class DNCBaseSceneViewController;

@protocol DNCBaseSceneRouterInput

#pragma mark - ViewController Class Names

//- (NSString*)classSceneAvatar;

#pragma mark - Routing

//- (void)routeToSceneAvatar;

#pragma mark - Peeking

//- (UIViewController*)peekSceneAvatar;

#pragma mark - Popping

- (void)popScene:(DNCBaseSceneViewController*)viewController;

#pragma mark - Navigation

- (void)dismiss:(BOOL)animated;

#pragma mark - Communication

- (void)passDataToNextViewController:(NSDictionary*)dataDictionary;

#pragma mark - Utility

- (DNCBaseSceneViewController*)utilityPeekScene:(NSString*)classBaseName;

@end
