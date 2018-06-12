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

@property (weak, nonatomic) IBOutlet UILabel*   titleLabel;

@end

@implementation DNCBaseSceneViewController

#pragma mark - Configuration

- (void)setValue:(id)value
forConfigDataKey:(NSString*)key
{
    [self.configurator setValue:value
                     forDataKey:key];
}

- (id)valueForConfigDataKey:(NSString*)key
{
    return [self.configurator valueForDataKey:key];
}

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
    
    [self sceneDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self sceneDidAppear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self sceneDidDisappear];
    
    [self runDismissBlock];
}

#pragma mark - Scene Lifecycle

- (void)sceneDidLoad
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidLoad:DNCBaseSceneRequest.request];
}

- (void)sceneDidAppear
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidAppear:DNCBaseSceneRequest.request];
}

- (void)sceneDidDisappear
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidDisappear:DNCBaseSceneRequest.request];
}

#pragma mark - Event Handling

- (void)doConfirmation:(NSString*)selection
          withUserData:(id)userData
{
    DNCBaseSceneConfirmationRequest*    request = DNCBaseSceneConfirmationRequest.request;
    request.selection   = selection;
    request.userData    = userData;
    [self.output doConfirmation:request];
}

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _displayType = viewModel.displayType;
    
    switch (_displayType)
    {
        case DNCBaseSceneDisplayTypeModal:
        {
            [DNCUIThread run:
             ^()
             {
                 [DNCUtilities.appDelegate.rootViewController presentViewController:self
                                                                           animated:YES
                                                                         completion:nil];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarPush:
        {
            [DNCUIThread run:
             ^()
             {
                 if (!self.configurator.navigationController.viewControllers.count)
                 {
                     [self.configurator.navigationController setViewControllers:@[ self ]
                                                                       animated:YES];
                     return;
                 }
                 if (self.configurator.navigationController.viewControllers.lastObject == self)
                 {
                     return;
                 }
                 
                 [self.configurator.navigationController pushViewController:self
                                                                   animated:YES];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarRoot:
        default:
        {
            [DNCUIThread run:
             ^()
             {
                 [self.configurator.navigationController setViewControllers:@[ self ]
                                                                   animated:YES];
             }];
            
            break;
        }
    }
}

#pragma mark - Display logic

- (void)displayConfirmation:(DNCBaseSceneConfirmationViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         UIAlertController* alertController = [UIAlertController alertControllerWithTitle:viewModel.title
                                                                                  message:viewModel.message
                                                                           preferredStyle:viewModel.alertStyle];
         
         if (viewModel.button1.length)
         {
             UIAlertAction* button1 = [UIAlertAction actionWithTitle:viewModel.button1
                                                               style:viewModel.button1Style
                                                             handler:
                                       ^(UIAlertAction *action)
                                       {
                                           [self doConfirmation:viewModel.button1Code
                                                   withUserData:viewModel.userData];
                                       }];
             [alertController addAction:button1];
         }
         
         if (viewModel.button2.length)
         {
             UIAlertAction* button2 = [UIAlertAction actionWithTitle:viewModel.button2
                                                               style:viewModel.button2Style
                                                             handler:
                                       ^(UIAlertAction *action)
                                       {
                                           [self doConfirmation:viewModel.button2Code
                                                   withUserData:viewModel.userData];
                                       }];
             [alertController addAction:button2];
         }
         
         if (viewModel.button3.length)
         {
             UIAlertAction* button3 = [UIAlertAction actionWithTitle:viewModel.button3
                                                               style:viewModel.button3Style
                                                             handler:
                                       ^(UIAlertAction *action)
                                       {
                                           [self doConfirmation:viewModel.button3Code
                                                   withUserData:viewModel.userData];
                                       }];
             [alertController addAction:button3];
         }
         
         if (viewModel.button4.length)
         {
             UIAlertAction* button4 = [UIAlertAction actionWithTitle:viewModel.button4
                                                               style:viewModel.button4Style
                                                             handler:
                                       ^(UIAlertAction *action)
                                       {
                                           [self doConfirmation:viewModel.button4Code
                                                   withUserData:viewModel.userData];
                                       }];
             [alertController addAction:button4];
         }

         [self presentViewController:alertController
                            animated:YES
                          completion:nil];
     }];
}

- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         [self passDataToNextViewController:viewModel.sendData];
         
         //[self dismiss:viewModel.animated];
     }];
    
    switch (_displayType)
    {
        case DNCBaseSceneDisplayTypeModal:
        {
            [DNCUIThread run:
             ^()
             {
                 [self dismissViewControllerAnimated:viewModel.animated
                                          completion:nil];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarPush:
        {
            [DNCUIThread run:
             ^()
             {
                 [self.configurator.navigationController popViewControllerAnimated:YES];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarRoot:
        default:
        {
            break;
        }
    }
}

- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
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

- (void)displayRoot:(DNCBaseSceneViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         [self routeToRoot];
     }];
}

- (void)displayScene:(DNCBaseSceneViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         [self routeToScene:viewModel.scene];
     }];
}

- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         [super displaySpinner:viewModel.show];
     }];
}

- (void)displayTitle:(DNCBaseSceneTitleViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         self.title             = viewModel.title;
         self.titleLabel.text   = viewModel.title;
     }];
}

- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [DNCUIThread run:
     ^()
     {
         NSArray*   responders  = @[ [CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeAll
                                                                                     automaticallyDismiss:YES
                                                                                                    block:nil] ];
         
         NSDictionary*  options = @{
                                    kCRToastNotificationTypeKey         : @(CRToastTypeNavigationBar),
                                    kCRToastInteractionRespondersKey    : responders,
                                    kCRToastTimeIntervalKey             : @(6.0f),
                                    kCRToastTextKey                     : viewModel.title,
                                    kCRToastTextAlignmentKey            : @(NSTextAlignmentCenter),
                                    kCRToastTextColorKey                : viewModel.titleColor,
                                    kCRToastFontKey                     : viewModel.titleFont,
                                    kCRToastSubtitleTextKey             : viewModel.message,
                                    kCRToastSubtitleTextColorKey        : viewModel.messageColor,
                                    kCRToastSubtitleFontKey             : viewModel.messageFont,
                                    kCRToastBackgroundColorKey          : viewModel.backgroundColor,
                                    kCRToastAnimationInTypeKey          : @(CRToastAnimationTypeGravity),
                                    kCRToastAnimationOutTypeKey         : @(CRToastAnimationTypeGravity),
                                    kCRToastAnimationInDirectionKey     : @(CRToastAnimationDirectionTop),
                                    kCRToastAnimationOutDirectionKey    : @(CRToastAnimationDirectionTop)
                                    };
         
         [CRToastManager showNotificationWithOptions:options
                                     completionBlock:nil];
     }];
}

#pragma mark - Actions

@end
