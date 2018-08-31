//
//  DNCBaseSceneViewController.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import CRToast;
@import DNCore;
@import WebKit;

#import "DNCBaseSceneViewController.h"

@interface DNCBaseSceneViewController ()<WKNavigationDelegate>

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
    [self.configurator configure:self];
}

- (void)setSceneTitle:(NSString*)sceneTitle
{
    if ([sceneTitle isEqualToString:_sceneTitle])
    {
        return;
    }
    
    if (!_sceneBackTitle ||
        [_sceneBackTitle isEqualToString:_sceneTitle])
    {
        _sceneBackTitle = sceneTitle;
    }
    
    _sceneTitle = sceneTitle;
    if (!_sceneTitle)
    {
        return;
    }
    
    [self updateSceneTitle];
}

- (void)updateSceneTitle
{
    if (!self->_sceneTitle)
    {
        return;
    }
    
    [DNCUIThread run:
     ^()
     {
         self.title                 = self->_sceneTitle;
         self.navigationItem.title  = self->_sceneTitle;
         self.titleLabel.text       = self->_sceneTitle;
     }];
}

- (void)updateSceneBackTitle
{
    if (!self->_sceneBackTitle)
    {
        return;
    }
    
    [DNCUIThread run:
     ^()
     {
         self.navigationItem.title  = self->_sceneBackTitle;
     }];
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
    
    [self updateSceneTitle];
    [self sceneDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateSceneTitle];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self sceneDidAppear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self sceneDidDisappear];
    
    if (self.navigationController)
    {
        if ([self.navigationController.viewControllers containsObject:self])
        {
            [self sceneDidHide];
            return;
        }
    }
    
    [self sceneDidClose];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self sceneWillDisappear];
    
    [self updateSceneBackTitle];
}

#pragma mark - Scene Lifecycle

- (void)sceneDidAppear
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidAppear:DNCBaseSceneRequest.request];
}

- (void)sceneDidClose
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidClose:DNCBaseSceneRequest.request];
}

- (void)sceneDidDisappear
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidDisappear:DNCBaseSceneRequest.request];
}

- (void)sceneDidHide
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidHide:DNCBaseSceneRequest.request];
}

- (void)sceneDidLoad
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneDidLoad:DNCBaseSceneRequest.request];
}

- (void)sceneWillAppear
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneWillAppear:DNCBaseSceneRequest.request];
}

- (void)sceneWillDisappear
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self.output sceneWillDisappear:DNCBaseSceneRequest.request];
}

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartViewModel*)viewModel;
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _displayType = viewModel.displayType;
    
    switch (_displayType)
    {
        case DNCBaseSceneDisplayTypeNone:
        {
            break;
        }
            
        case DNCBaseSceneDisplayTypeModal:
        {
            [DNCUIThread run:
             ^()
             {
                 [DNCUtilities.appDelegate.rootViewController presentViewController:self
                                                                           animated:viewModel.animated
                                                                         completion:nil];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarPush:
        case DNCBaseSceneDisplayTypeNavBarPushInstant:
        {
            BOOL    animated = (viewModel.animated && (_displayType == DNCBaseSceneDisplayTypeNavBarPush));
            
            [DNCUIThread run:
             ^()
             {
                 if (!self.configurator.navigationController.viewControllers.count)
                 {
                     [self.configurator.navigationController setViewControllers:@[ self ]
                                                                       animated:animated];
                     return;
                 }
                 if (self.configurator.navigationController.viewControllers.lastObject == self)
                 {
                     return;
                 }
                 
                 id lastViewController  = self.configurator.navigationController.viewControllers.lastObject;
                 if ([lastViewController isKindOfClass:DNCBaseSceneViewController.class])
                 {
                     DNCBaseSceneViewController* baseSceneViewController = lastViewController;
                     [baseSceneViewController updateSceneBackTitle];
                 }
                 
                 [self.configurator.navigationController pushViewController:self
                                                                   animated:animated];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarRoot:
        case DNCBaseSceneDisplayTypeNavBarRootInstant:
        default:
        {
            BOOL    animated = (_displayType == DNCBaseSceneDisplayTypeNavBarRoot);
            
            [DNCUIThread run:
             ^()
             {
                 [self.configurator.navigationController setViewControllers:@[ self ]
                                                                   animated:animated];
             }];
            
            break;
        }
    }
}

- (void)endScene:(DNCBaseSceneEndViewModel*)viewModel
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _displayType = viewModel.displayType;
    
    switch (_displayType)
    {
        case DNCBaseSceneDisplayTypeNone:
        {
            break;
        }
            
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
        case DNCBaseSceneDisplayTypeNavBarPushInstant:
        {
            BOOL    animated = viewModel.animated && (_displayType == DNCBaseSceneDisplayTypeNavBarPush);
            
            [DNCUIThread run:
             ^()
             {
                 [self.configurator.navigationController popViewControllerAnimated:animated];
             }];
            break;
        }
            
        case DNCBaseSceneDisplayTypeNavBarRoot:
        case DNCBaseSceneDisplayTypeNavBarRootInstant:
        default:
        {
            //BOOL    animated = (_displayType == DNCBaseSceneDisplayTypeNavBarRoot);
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
                                           DNCBaseSceneConfirmationRequest*    request = DNCBaseSceneConfirmationRequest.request;
                                           request.selection   = viewModel.button1Code;
                                           request.userData    = viewModel.userData;
                                           [self.output doConfirmation:request];
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
                                           DNCBaseSceneConfirmationRequest*    request = DNCBaseSceneConfirmationRequest.request;
                                           request.selection   = viewModel.button2Code;
                                           request.userData    = viewModel.userData;
                                           [self.output doConfirmation:request];
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
                                           DNCBaseSceneConfirmationRequest*    request = DNCBaseSceneConfirmationRequest.request;
                                           request.selection   = viewModel.button3Code;
                                           request.userData    = viewModel.userData;
                                           [self.output doConfirmation:request];
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
                                           DNCBaseSceneConfirmationRequest*    request = DNCBaseSceneConfirmationRequest.request;
                                           request.selection   = viewModel.button4Code;
                                           request.userData    = viewModel.userData;
                                           [self.output doConfirmation:request];
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
    
    DNCBaseSceneEndViewModel*   endViewModel = DNCBaseSceneEndViewModel.viewModel;
    endViewModel.displayType    = _displayType;
    endViewModel.animated       = viewModel.animated;
    [self endScene:endViewModel];
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
    
    self.sceneTitle = viewModel.title;
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

#pragma mark - WKNavigationDelegate methods

- (void)webView:(WKWebView*)webView
didCommitNavigation:(null_unspecified WKNavigation*)navigation
{
    DNCBaseSceneWebRequest* request = DNCBaseSceneWebRequest.request;
    request.url = webView.URL;
    [self.output doWebStartNavigation:request];
}

- (void)webView:(WKWebView*)webView
didFinishNavigation:(null_unspecified WKNavigation*)navigation
{
    DNCBaseSceneWebRequest* request = DNCBaseSceneWebRequest.request;
    request.url = webView.URL;
    [self.output doWebFinishNavigation:request];
}

- (void)webView:(WKWebView*)webView
didFailNavigation:(null_unspecified WKNavigation*)navigation
      withError:(NSError*)error
{
    DNCBaseSceneWebErrorRequest*    request = DNCBaseSceneWebErrorRequest.request;
    request.url     = webView.URL;
    request.error   = error;
    [self.output doWebErrorNavigation:request];
}

#pragma mark - Actions

@end
