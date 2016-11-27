//
//  DNCBaseSceneViewController.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDisabledViewController/DNCDisabledViewController.h>
#import <DNCProtocols/PTCLAnalytics_Protocol.h>

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneConfigurator.h"
#import "DNCBaseScenePresenterInterface.h"
#import "DNCBaseSceneViewControllerInterface.h"

@class DNCBaseSceneRouter;

@interface DNCBaseSceneViewController : DNCDisabledViewController<CleanViewControllerInput, DNCBaseSceneViewControllerInput, DNCBaseScenePresenterOutput>

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;

@property (strong, nonatomic) id<CleanRouterOutput, DNCBaseSceneViewControllerOutput> output;

@property (weak, nonatomic) id<CleanViewControllerInput>    opener;
@property (strong, nonatomic) DNCBaseSceneRouter*           router;

#pragma mark - Palette Colors

- (UIColor*)paletteAccessoryBackgroundColor;
- (UIColor*)paletteErrorTextColor;
- (UIColor*)palettePrimaryTextColor;

#pragma mark - Object settings

- (void)configure;

#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString*)nibNameOrNil
               bundle:(NSBundle*)nibBundleOrNil;

#pragma mark - Display logic

- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end
