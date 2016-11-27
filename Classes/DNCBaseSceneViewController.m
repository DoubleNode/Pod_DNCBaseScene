//
//  DNCBaseSceneViewController.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <CRToast/CRToast.h>
#import <DNCore/DNCUtilities.h>

#import "DNCBaseSceneViewController.h"
#import "DNCBaseSceneViewController+Routing.h"

@interface DNCBaseSceneViewController ()

@end

@implementation DNCBaseSceneViewController

#pragma mark - Palette Colors

- (UIColor*)paletteAccessoryBackgroundColor
{
    return UIColor.grayColor;
}

- (UIColor*)paletteErrorTextColor
{
    return UIColor.redColor;
}

- (UIColor*)palettePrimaryTextColor
{
    return UIColor.blueColor;
}

#pragma mark - Object settings

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)configure
{
    if (!self.configurator)
    {
        NSString*   className   = NSStringFromClass(self.class);
        NSString*   classRoot   = [className substringToIndex:(className.length - 14)];
        
        Class   ConfigClass     = NSClassFromString([NSString stringWithFormat:@"%@Configurator", classRoot]);
        self.configurator       = [ConfigClass sharedInstance];
    }
    
    [self.configurator configure:self];
}

#pragma mark - Object lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self configure];
}

- (id)initWithNibName:(NSString*)nibNameOrNil
               bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
        [self configure];
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self doDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self doDidAppear];
}

#pragma mark - Event handling

- (void)doDidLoad
{
    DNCBaseSceneRequest*    request = DNCBaseSceneRequest.request;
    [self.output doDidLoad:request];
}

- (void)doDidAppear
{
    DNCBaseSceneRequest*    request = DNCBaseSceneRequest.request;
    [self.output doDidAppear:request];
}

#pragma mark - Display logic

- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel
{
    [DNCUtilities runOnMainThreadWithoutDeadlocking:
     ^()
     {
         [self dismiss:viewModel.animated];
     }];
}

- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel
{
    [DNCUtilities runOnMainThreadWithoutDeadlocking:
     ^()
     {
         UIAlertController* alertController = [UIAlertController alertControllerWithTitle:viewModel.title
                                                                                  message:viewModel.message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil];
         [alertController addAction:ok];
         
         [self presentViewController:alertController
                            animated:YES
                          completion:nil];
     }];
}

- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel
{
    [DNCUtilities runOnMainThreadWithoutDeadlocking:
     ^()
     {
         [super displaySpinner:viewModel.show];
     }];
}

- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUtilities runOnMainThreadWithoutDeadlocking:
     ^()
     {
         NSArray*   responders  = @[ [CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                     automaticallyDismiss:YES
                                                                                                    block:nil] ];
         
         NSDictionary*  options = @{
                                    kCRToastNotificationTypeKey         : @(CRToastTypeNavigationBar),
                                    kCRToastInteractionRespondersKey    : responders,
                                    kCRToastTimeIntervalKey             : @(10.0f),
                                    kCRToastTextKey                     : viewModel.title,
                                    kCRToastTextAlignmentKey            : @(NSTextAlignmentCenter),
                                    kCRToastTextColorKey                : viewModel.titleColor,
                                    kCRToastFontKey                     : [UIFont fontWithName:@"ProximaNova-Semibold" size:16],
                                    kCRToastSubtitleTextKey             : viewModel.message,
                                    kCRToastSubtitleTextColorKey        : viewModel.messageColor,
                                    kCRToastSubtitleFontKey             : [UIFont fontWithName:@"ProximaNova-Regular" size:14],
                                    kCRToastBackgroundColorKey          : viewModel.backgroundColor,
                                    kCRToastAnimationInTypeKey          : @(CRToastAnimationTypeGravity),
                                    kCRToastAnimationOutTypeKey         : @(CRToastAnimationTypeGravity),
                                    kCRToastAnimationInDirectionKey     : @(CRToastAnimationDirectionLeft),
                                    kCRToastAnimationOutDirectionKey    : @(CRToastAnimationDirectionRight)
                                    };
         
         [CRToastManager showNotificationWithOptions:options
                                     completionBlock:nil];
     }];
}

#pragma mark - Actions

@end
