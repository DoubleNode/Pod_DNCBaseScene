//
//  DNCVisibleViewController.h
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

@import DNCore;
@import UIKit;

@interface DNCVisibleViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView*   tapToDismissView;

@property (nonatomic, weak) UIView*   lastVisibleView;

@property (nonatomic) CGFloat visibleMargin;
@property (nonatomic) CGRect  keyboardBounds;

#if TARGET_OS_IOS
- (void)keyboardWillShow:(NSNotification*)note;
- (void)keyboardWillHide:(NSNotification*)note;
#elif TARGET_OS_OSX || TARGET_OS_TV || TARGET_OS_WATCH
#endif // TARGET_OS_IOS

- (void)tapToDismiss:(UITapGestureRecognizer*)recognizer;

@end
