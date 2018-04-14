//
//  DNCBaseSceneViewController.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCProtocols/PTCLAnalytics_Protocol.h>

#import "DNCDisabledViewController.h"
#import "DNCCoordinator.h"

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneConfigurator.h"
#import "DNCBaseScenePresenterInterface.h"
#import "DNCBaseSceneViewControllerInterface.h"

@class DNCBaseSceneRouter;

@interface DNCBaseSceneViewController : DNCDisabledViewController<DNCBaseSceneViewControllerInput, DNCBaseScenePresenterOutput>

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;
@property (weak, nonatomic)   DNCCoordinator*           coordinatorDelegate;

@property (strong, nonatomic) id<DNCBaseSceneViewControllerOutput> output;

@property (weak, nonatomic) id<CleanViewControllerInput>    opener;
@property (strong, nonatomic) DNCBaseSceneRouter*           router;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

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

- (void)displayConfirmation:(DNCBaseSceneConfirmationViewModel*)viewModel;
- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displayRoot:(DNCBaseSceneViewModel*)viewModel;
- (void)displayScene:(DNCBaseSceneViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayTitle:(DNCBaseSceneTitleViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end
