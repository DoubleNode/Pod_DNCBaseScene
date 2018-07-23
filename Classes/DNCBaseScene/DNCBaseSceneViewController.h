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

@interface DNCBaseSceneViewController : DNCDisabledViewController<DNCBaseSceneViewControllerInput, DNCBaseScenePresenterOutput>

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;
@property (strong, nonatomic) DNCCoordinator*           coordinatorDelegate;
@property (assign, nonatomic) DNCBaseSceneDisplayType   displayType;
@property (strong, nonatomic) NSString*                 sceneTitle;

@property (strong, nonatomic) id<DNCBaseSceneViewControllerOutput> output;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

@property (strong, nonatomic) IBOutlet UILabel* titleLabel;

#pragma mark - Palette Colors

- (UIColor*)paletteAccessoryBackgroundColor;
- (UIColor*)paletteErrorTextColor;
- (UIColor*)palettePrimaryTextColor;

#pragma mark - Object settings

- (void)configure;

#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString*)nibNameOrNil
               bundle:(NSBundle*)nibBundleOrNil;

#pragma mark - Scene Lifecycle

- (void)sceneDidAppear;
- (void)sceneDidClose;
- (void)sceneDidDisappear;
- (void)sceneDidHide;
- (void)sceneDidLoad;
- (void)sceneWillAppear;
- (void)sceneWillDisappear;

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartViewModel*)viewModel;
- (void)endScene:(DNCBaseSceneEndViewModel*)viewModel;

#pragma mark - Display logic

- (void)displayConfirmation:(DNCBaseSceneConfirmationViewModel*)viewModel;
- (void)displayDismiss:(DNCBaseSceneDismissViewModel*)viewModel;
- (void)displayMessage:(DNCBaseSceneMessageViewModel*)viewModel;
- (void)displaySpinner:(DNCBaseSceneSpinnerViewModel*)viewModel;
- (void)displayTitle:(DNCBaseSceneTitleViewModel*)viewModel;
- (void)displayToast:(DNCBaseSceneToastViewModel*)viewModel;

@end
