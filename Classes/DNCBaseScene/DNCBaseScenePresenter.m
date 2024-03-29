//
//  DNCBaseScenePresenter.m
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

@import BFKit;
@import DNCore;

#import "DNCBaseScenePresenter.h"

#import "DNCCoordinator.h"

@interface DNCBaseScenePresenter ()
{
    NSInteger   _spinnerCount;
}

@end

@implementation DNCBaseScenePresenter

+ (instancetype)presenter   {   return [[[self class] alloc] init]; }

#pragma mark - Lifecycle Methods

- (void)startScene:(DNCBaseSceneStartResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _spinnerCount = 0;
    
    DNCBaseSceneStartViewModel* viewModel = DNCBaseSceneStartViewModel.viewModel;
    viewModel.animated      = YES;
    viewModel.displayType   = response.displayType;
    [self.output startScene:viewModel];
}

- (void)endScene:(DNCBaseSceneEndResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    _spinnerCount = 0;
    
    DNCBaseSceneEndViewModel*   viewModel = DNCBaseSceneEndViewModel.viewModel;
    viewModel.animated      = YES;
    viewModel.displayType   = response.displayType;
    [self.output endScene:viewModel];
}

#pragma mark - Palette Colors

- (UIColor*)paletteToastTitleColor
{
    return UIColor.whiteColor;
}

- (UIColor*)paletteToastMessageColor
{
    return UIColor.whiteColor;
}

- (UIColor*)paletteToastBackgroundColor
{
    return UIColor.redColor;
}

- (UIColor*)paletteToastErrorTitleColor
{
    return UIColor.whiteColor;
}

- (UIColor*)paletteToastErrorMessageColor
{
    return UIColor.whiteColor;
}

- (UIColor*)paletteToastErrorBackgroundColor
{
    return UIColor.redColor;
}

#pragma mark - Palette Fonts

- (UIFont*)paletteToastTitleFont
{
    return [UIFont boldSystemFontOfSize:16];
}

- (UIFont*)paletteToastMessageFont
{
    return [UIFont systemFontOfSize:14];
}

- (UIFont*)paletteToastErrorTitleFont
{
    return [UIFont boldSystemFontOfSize:16];
}

- (UIFont*)paletteToastErrorMessageFont
{
    return [UIFont systemFontOfSize:14];
}

#pragma mark - Presentation logic

- (void)presentConfirmation:(DNCBaseSceneConfirmationResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneConfirmationViewModel* viewModel = DNCBaseSceneConfirmationViewModel.viewModel;
    viewModel.alertStyle    = response.alertStyle;
    viewModel.title         = response.title;
    viewModel.message       = response.message;
    
    viewModel.textField1KeyboardType    = response.textField1KeyboardType;
    viewModel.textField1Placeholder     = response.textField1Placeholder;
    viewModel.textField1TextContentType = response.textField1TextContentType;
    viewModel.textField2KeyboardType    = response.textField2KeyboardType;
    viewModel.textField2Placeholder     = response.textField2Placeholder;
    viewModel.textField2TextContentType = response.textField2TextContentType;
    
    viewModel.button1       = response.button1;
    viewModel.button1Code   = response.button1Code;
    viewModel.button1Style  = response.button1Style;
    
    viewModel.button2       = response.button2;
    viewModel.button2Code   = response.button2Code;
    viewModel.button2Style  = response.button2Style;
    
    viewModel.button3       = response.button3;
    viewModel.button3Code   = response.button3Code;
    viewModel.button3Style  = response.button3Style;
    
    viewModel.button4       = response.button4;
    viewModel.button4Code   = response.button4Code;
    viewModel.button4Style  = response.button4Style;
    
    viewModel.userData      = response.userData;
    
    [self.output displayConfirmation:viewModel];
}

- (void)presentDismiss:(DNCBaseSceneDismissResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneDismissViewModel* viewModel = [DNCBaseSceneDismissViewModel viewModel];
    viewModel.sendData  = response.sendData;
    viewModel.animated  = response.animated;
    [self.output displayDismiss:viewModel];
}

- (void)presentError:(DNCBaseSceneErrorResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    NSString*   errorMessage    = response.error.localizedDescription;
    if (response.error.localizedFailureReason.length)
    {
        if (errorMessage.length)
        {
            errorMessage = [NSString stringWithFormat:@"%@\n\n", errorMessage];
        }
        errorMessage = [NSString stringWithFormat:@"%@%@", errorMessage, response.error.localizedFailureReason];
    }
    
    [self utilityDisplayMessage:errorMessage
                      withTitle:response.title];
}

- (void)presentHud:(DNCBaseSceneHudResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneHudViewModel*   viewModel = DNCBaseSceneHudViewModel.viewModel;
    
    viewModel.show  = response.show;
    viewModel.title = response.title;
    
    [self.output displayHud:viewModel];
}

- (void)presentMessage:(DNCBaseSceneMessageResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self utilityDisplayMessage:response.message
                      withTitle:response.title];
}

- (void)presentSpinner:(DNCBaseSceneSpinnerResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    if (response.show)
    {
        _spinnerCount++;
        if (_spinnerCount > 1)
        {
            return;
        }
    }
    else
    {
        _spinnerCount--;
        if (_spinnerCount > 0)
        {
            return;
        }
        
        _spinnerCount = 0;
    }
    
    DNCBaseSceneSpinnerViewModel* viewModel = [DNCBaseSceneSpinnerViewModel viewModel];
    
    viewModel.show  = response.show;
    
    [self.output displaySpinner:viewModel];
}

- (void)presentTitle:(DNCBaseSceneTitleResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneTitleViewModel* viewModel = DNCBaseSceneTitleViewModel.viewModel;
    viewModel.title = response.title;
    [self.output displayTitle:viewModel];
}

- (void)presentToast:(DNCBaseSceneMessageResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self utilityDisplayToast:response.message
                    withTitle:response.title
               withTitleColor:self.paletteToastTitleColor
             withMessageColor:self.paletteToastMessageColor
          withBackgroundColor:self.paletteToastBackgroundColor
                withTitleFont:self.paletteToastTitleFont
              withMessageFont:self.paletteToastMessageFont];
}

- (void)presentToastError:(DNCBaseSceneErrorResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self utilityDisplayToast:response.error.localizedDescription
                    withTitle:response.title
               withTitleColor:self.paletteToastErrorTitleColor
             withMessageColor:self.paletteToastErrorMessageColor
          withBackgroundColor:self.paletteToastErrorBackgroundColor
                withTitleFont:self.paletteToastErrorTitleFont
              withMessageFont:self.paletteToastErrorMessageFont];
}

#pragma mark - Utility methods

- (void)utilityDisplayMessage:(NSString*)message
                    withTitle:(NSString*)title
{
    DNCBaseSceneMessageViewModel* viewModel = DNCBaseSceneMessageViewModel.viewModel;
    
    viewModel.title     = title;
    viewModel.message   = message;
    
    [self.output displayMessage:viewModel];
}

- (void)utilityDisplayToast:(NSString*)message
                  withTitle:(NSString*)title
             withTitleColor:(UIColor*)titleColor
           withMessageColor:(UIColor*)messageColor
        withBackgroundColor:(UIColor*)backgroundColor
              withTitleFont:(UIFont*)titleFont
            withMessageFont:(UIFont*)messageFont
{
    DNCBaseSceneToastViewModel* viewModel = [DNCBaseSceneToastViewModel viewModel];
    
    viewModel.title             = title;
    viewModel.message           = message;
    
    viewModel.titleColor        = titleColor;
    viewModel.messageColor      = messageColor;
    viewModel.backgroundColor   = backgroundColor;
    
    viewModel.titleFont         = titleFont;
    viewModel.messageFont       = messageFont;
    
    [self.output displayToast:viewModel];
}
@end
