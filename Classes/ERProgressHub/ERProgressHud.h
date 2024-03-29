//
//  ERProgressHud.h
//  PhotoBlend
//
//  Created by Mahmudul Hasan on 5/29/17.
//  Copyright © 2017 Mahmudul Hasan. All rights reserved.
//
//  ERProgressHud is released under the MIT license. See LICENSE for details.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ERProgressHud : NSObject
{
    UIView*     container;
    UIView*     subContainer;
    UILabel*    textLabel;
    
    UIActivityIndicatorView*    activityIndicatorView;
    UIVisualEffectView*         blurEffectView;
}

+ (ERProgressHud*)sharedInstance;

- (void)show;
- (void)showWithBlurView;
- (void)hide;
- (BOOL)isShowing;

- (void)showWithTitle:(NSString*)title;
- (void)showDarkBackgroundViewWithTitle:(NSString*)title;
- (void)showBlurViewWithTitle:(NSString*)title;
- (void)updateProgressTitle:(NSString*)title;

@end
