//
//  DNCVisibleViewController.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <DNCore/UIView+DNCPending.h>

@interface DNCVisibleViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UIView*   lastVisibleView;

@property (nonatomic) CGFloat visibleMargin;
@property (nonatomic) CGRect  keyboardBounds;

#if TARGET_OS_IOS
- (void)keyboardWillShow:(NSNotification*)note;
- (void)keyboardWillHide:(NSNotification*)note;
#elif TARGET_OS_OSX || TARGET_OS_TV || TARGET_OS_WATCH
#endif // TARGET_OS_IOS

@end