//
//  DNCBaseSceneRouter.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCBaseSceneRouter.h"
#import "DNCBaseSceneViewController.h"

@interface DNCBaseSceneRouter ()
{
    NSDictionary*   _sendingData;
    NSDictionary*   _previousSendingData;
}

@end

@implementation DNCBaseSceneRouter

+ (instancetype)router   {   return [[[self class] alloc] init]; }

#pragma mark - ViewController Class Names

//- (NSString*)classSceneAvatar   {   return @"DNCOnboardingAvatar";      }

#pragma mark - Routing

//- (void)routeToSceneAvatar  {   [self popScene:self.peekSceneAvatar];       }
- (void)routeToRoot
{
    [((UIViewController*)self.viewController).navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Peeking

//- (UIViewController*)peekSceneAvatar    {   return [self utilityPeekScene:self.classSceneAvatar];  }

#pragma mark - Popping

- (void)popScene:(DNCBaseSceneViewController*)viewController
{
    [self popScene:viewController
          animated:YES];
}

- (void)popScene:(DNCBaseSceneViewController*)viewController
        animated:(BOOL)animated
{
    NSAssert(viewController, @"UIViewController not found");
 
    viewController.opener = self.viewController;
    
    [self assignDataToViewController:viewController];

    [self.viewController.navigationController pushViewController:viewController
                                                        animated:animated];
}

#pragma mark - Navigation

- (void)dismiss:(BOOL)animated
{
    [self dismiss:animated
           forced:NO];
}

- (void)dismiss:(BOOL)animated
         forced:(BOOL)forced
{
    id<CleanViewControllerInput>    openerViewController    = self.viewController.opener;
    id<CleanRouterOutput>           openerOutput            = openerViewController.output;
    
    [self assignDataToViewController:openerViewController];
    
    id  returnTo    = openerOutput.returnTo;
    
    if (![self.viewController.navigationController.childViewControllers containsObject:self.viewController])
    {
        // Not in NavController
        [self.viewController dismissViewControllerAnimated:animated
                                                completion:nil];
        return;
    }
    
    if (forced || !returnTo)
    {
        // nil returnTo
        [self.viewController.navigationController popViewControllerAnimated:animated];
        return;
    }
    
    if ([returnTo isKindOfClass:[NSString class]])
    {
        if ([returnTo isEqualToString:CLEAN_RETURNTOROOT])
        {
            // returnTo CLEAN_RETURNTOROOT
            [self.viewController.navigationController popToRootViewControllerAnimated:animated];
            return;
        }
        else if ([returnTo isEqualToString:CLEAN_RETURNTOSKIP])
        {
            // skip CLEAN_RETURNTOSKIP -- Do Nothing
            return;
        }
        else if ([returnTo isEqualToString:CLEAN_RETURNTOOPENER])
        {
            returnTo    = openerViewController;
        }
    }
    
    [self assignPreviousDataToViewController:returnTo];
    
    [self.viewController.navigationController popToViewController:returnTo
                                                         animated:animated];
}

#pragma mark - Communication

- (void)assignDataToViewController:(id<CleanViewControllerInput>)viewController
{
    id<CleanRouterOutput>   viewControllerOutput    = viewController.output;
    
    _previousSendingData    = _sendingData;
    
    if (!_sendingData)
    {
        // Set nil if sendingData isn't already set
        [self passDataToNextViewController:@{ }];
    }
    
    viewControllerOutput.receivedData   = _sendingData;
    
    // Clear sendingData to make sure it's not reused
    _sendingData    = nil;
}

- (void)assignPreviousDataToViewController:(id<CleanViewControllerInput>)viewController
{
    _sendingData    = _previousSendingData;
    
    [self assignDataToViewController:viewController];
}

- (void)passDataToNextViewController:(NSDictionary*)dataDictionary
{
    NSMutableDictionary*    data    = [NSMutableDictionary dictionaryWithDictionary:dataDictionary];
    
    data[@"from"] = NSStringFromClass([self.viewController class]);
    
    _sendingData = data;
}

#pragma mark - Utility

- (UIViewController*)utilityPeekScene:(NSString*)classBaseName
{
    NSString*   configuratorClassName   = [NSString stringWithFormat:@"%@Configurator", classBaseName];
    Class       ConfiguratorClass       = NSClassFromString(configuratorClassName);
    
    return [ConfiguratorClass viewController];
}

@end
