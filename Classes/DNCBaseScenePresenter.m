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

- (UIColor*)palettePrimaryTextColor
{
    return [UIColor hexString:@"353131"];
}

- (UIColor*)paletteSecondaryBackgroundColor
{
    return [UIColor hexString:@"E6D98E"];
}

#pragma mark - Presentation logic

- (void)presentDismiss:(DNCBaseSceneResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    DNCBaseSceneDismissViewModel* viewModel = [DNCBaseSceneDismissViewModel viewModel];
    viewModel.animated  = YES;
    [self.output displayDismiss:viewModel];
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
               withTitleColor:self.palettePrimaryTextColor
             withMessageColor:self.palettePrimaryTextColor
          withBackgroundColor:self.paletteSecondaryBackgroundColor];
}

- (void)presentToastError:(DNCBaseSceneMessageResponse*)response
{
    [self.analyticsWorker doTrack:NS_PRETTY_FUNCTION];
    
    [self utilityDisplayToast:response.message
                    withTitle:response.title
               withTitleColor:[UIColor whiteColor]
             withMessageColor:[UIColor whiteColor]
          withBackgroundColor:[UIColor redColor]];
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
{
    DNCBaseSceneToastViewModel* viewModel = [DNCBaseSceneToastViewModel viewModel];
    
    viewModel.title             = title;
    viewModel.message           = message;
    
    viewModel.titleColor        = titleColor;
    viewModel.messageColor      = messageColor;
    viewModel.backgroundColor   = backgroundColor;
    
    [self.output displayToast:viewModel];
}
@end
