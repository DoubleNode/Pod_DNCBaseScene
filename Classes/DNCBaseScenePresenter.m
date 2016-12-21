//
//  DNCBaseScenePresenter.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <BFKit/UIColor+BFKit.h>
#import <DNCore/NSDate+DNCPrettyDate.h>

#import "DNCBaseScenePresenter.h"

@interface DNCBaseScenePresenter ()
{
    NSInteger   _spinnerCount;
}

@end

@implementation DNCBaseScenePresenter

+ (instancetype)presenter   {   return [[[self class] alloc] init]; }

#pragma mark - Palette Colors

- (UIColor*)paletteToastTitleColor
{
    return [UIColor hexString:@"353131"];
}

- (UIColor*)paletteToastMessageColor
{
    return [UIColor hexString:@"353131"];
}

- (UIColor*)paletteToastBackgroundColor
{
    return [UIColor hexString:@"E6D98E"];
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
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
}

- (UIFont*)paletteToastMessageFont
{
    return [UIFont fontWithName:@"ProximaNova-Regular" size:14];
}

- (UIFont*)paletteToastErrorTitleFont
{
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
}

- (UIFont*)paletteToastErrorMessageFont
{
    return [UIFont fontWithName:@"ProximaNova-Regular" size:14];
}

#pragma mark - Presentation logic

- (void)presentDismiss:(DNCBaseSceneResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneDismissViewModel* viewModel = [DNCBaseSceneDismissViewModel viewModel];
    viewModel.animated  = YES;
    [self.output displayDismiss:viewModel];
}

- (void)presentError:(DNCBaseSceneErrorResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self utilityDisplayMessage:response.error.localizedDescription
                      withTitle:response.title];
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
