//
//  DNCBaseScenePresenter.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCProtocols/PTCLAnalytics_Protocol.h>

#import "DNCBaseSceneCommon.h"
#import "DNCBaseSceneInteractorInterface.h"
#import "DNCBaseScenePresenterInterface.h"

@interface DNCBaseScenePresenter : NSObject<CleanPresenterInput, DNCBaseScenePresenterInput, DNCBaseSceneInteractorOutput>

+ (instancetype)presenter;

@property (weak, nonatomic) id<CleanViewControllerInput, DNCBaseScenePresenterOutput> output;

@property (strong, nonatomic)   id<PTCLAnalytics_Protocol>  analyticsWorker;

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

- (void)presentDismiss:(DNCBaseSceneDismissResponse*)response;
- (void)presentError:(DNCBaseSceneErrorResponse*)response;
- (void)presentMessage:(DNCBaseSceneMessageResponse*)response;
- (void)presentSpinner:(DNCBaseSceneSpinnerResponse*)response;
- (void)presentToast:(DNCBaseSceneMessageResponse*)response;
- (void)presentToastError:(DNCBaseSceneErrorResponse*)response;

@end
