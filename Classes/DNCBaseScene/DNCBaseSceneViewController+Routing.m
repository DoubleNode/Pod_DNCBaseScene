//
//  DNCBaseSceneViewController+Routing.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneViewController+Routing.h"
#import "DNCBaseSceneRouter.h"

@implementation DNCBaseSceneViewController (Routing)

#pragma mark - ViewController Class Names

//- (NSString*)classSceneAvatar   {   return self.baseRouter.classSceneAvatar;    }

#pragma mark - Routing

//- (void)routeToSceneAvatar  {   [self.baseRouter routeToSceneAvatar];   }
- (void)routeToRoot                     {   [self.router routeToRoot];          }
- (void)routeToScene:(NSString*)scene   {   [self.router routeToScene:scene];   }

#pragma mark - Peeking

//- (UIViewController*)peekSceneAvatar  {   return self.baseRouter.peekSceneAvatar;     }

#pragma mark - Popping

- (void)popScene:(DNCBaseSceneViewController*)viewController
{
    return [self.router popScene:viewController];
}

#pragma mark - Navigation

- (void)whenDismissedRun:(DNCUtilitiesBlock)block
{
    [self.router whenDismissedRun:block];
}

- (void)runDismissBlock
{
    [self.router runDismissBlock];
}

- (void)dismiss:(BOOL)animated
{
    [self.router dismiss:animated];
}

- (void)dismiss:(BOOL)animated
         forced:(BOOL)forced
{
    [self.router dismiss:animated
                  forced:forced];
}

#pragma mark - Communication

- (void)passDataToNextViewController:(NSDictionary*)dataDictionary
{
    [self.router passDataToNextViewController:dataDictionary];
}

#pragma mark - Utility

- (DNCBaseSceneViewController*)utilityPeekScene:(NSString*)classBaseName
{
    return [self.router utilityPeekScene:classBaseName];
}

@end
