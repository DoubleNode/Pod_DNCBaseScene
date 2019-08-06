//
//  DNCBaseScenePresenter.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCProtocols;

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneConfigurator.h"

#import "DNCBaseScenePresentationLogic.h"
#import "DNCBaseSceneDisplayLogic.h"

@interface DNCBaseScenePresenter : NSObject<DNCBaseScenePresentationLogic>

+ (instancetype)presenter;

@property (strong, nonatomic) DNCBaseSceneConfigurator* configurator;

@property (weak, nonatomic) id<DNCBaseSceneDisplayLogic> output;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartResponse*)response;
- (void)endScene:(DNCBaseSceneEndResponse*)response;

#pragma mark - Palette Colors

- (UIColor*)paletteToastTitleColor;
- (UIColor*)paletteToastMessageColor;
- (UIColor*)paletteToastBackgroundColor;
- (UIColor*)paletteToastErrorTitleColor;
- (UIColor*)paletteToastErrorMessageColor;
- (UIColor*)paletteToastErrorBackgroundColor;

#pragma mark - Palette Fonts

- (UIFont*)paletteToastTitleFont;
- (UIFont*)paletteToastMessageFont;
- (UIFont*)paletteToastErrorTitleFont;
- (UIFont*)paletteToastErrorMessageFont;

#pragma mark - Presentation logic

- (void)presentConfirmation:(DNCBaseSceneConfirmationResponse*)response;
- (void)presentDismiss:(DNCBaseSceneDismissResponse*)response;
- (void)presentError:(DNCBaseSceneErrorResponse*)response;
- (void)presentHud:(DNCBaseSceneHudResponse*)response;
- (void)presentMessage:(DNCBaseSceneMessageResponse*)response;
- (void)presentSpinner:(DNCBaseSceneSpinnerResponse*)response;
- (void)presentTitle:(DNCBaseSceneTitleResponse*)response;
- (void)presentToast:(DNCBaseSceneMessageResponse*)response;
- (void)presentToastError:(DNCBaseSceneErrorResponse*)response;

@end
