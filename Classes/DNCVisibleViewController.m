//
//  DNCVisibleViewController.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCVisibleViewController.h"

@interface DNCVisibleViewController ()<UITextFieldDelegate, UITextViewDelegate>
{
    BOOL    _keyboardShowing;
}

@property (nonatomic) CGFloat   visibleOffset;

@end

@implementation DNCVisibleViewController

#pragma mark - Object settings

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - Object lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.tapToDismissView)
    {
        UITapGestureRecognizer* tapRecognizer = [UITapGestureRecognizer.alloc initWithTarget:self
                                                                                      action:@selector(tapToDismiss:)];
        tapRecognizer.cancelsTouchesInView  = NO;
        
        [self.tapToDismissView addGestureRecognizer:tapRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
#if TARGET_OS_IOS
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
#elif TARGET_OS_OSX || TARGET_OS_TV || TARGET_OS_WATCH
#endif // TARGET_OS_IOS
    
    self.visibleMargin = 10.0f;
}

- (void)setLastVisibleView:(UIView*)lastVisibleView
{
    if (!_lastVisibleView)
    {
        self.keyboardBounds = CGRectZero;
    }
    
    _lastVisibleView = lastVisibleView;
    
#if TARGET_OS_IOS
    NSNumber*   duration    = @(0.2f);
    NSNumber*   curve       = @(UIViewAnimationCurveEaseInOut);
    
    if (_keyboardShowing)
    {
        [self animateView:self.keyboardBounds
             withDuration:duration
                 andCurve:curve];
    }
#elif TARGET_OS_OSX || TARGET_OS_TV || TARGET_OS_WATCH
#endif // TARGET_OS_IOS
}

#if TARGET_OS_IOS

#pragma mark - NotificationCenter Keyboard callbacks

- (void)animateView:(CGRect)keyboardBounds
       withDuration:(NSNumber*)duration
           andCurve:(NSNumber*)curve
{
    if (!self.view.isVisible)
    {
        return;
    }
    
    CGRect  lastVisibleBounds   = [self.lastVisibleView.superview convertRect:self.lastVisibleView.frame
                                                                       toView:self.view];
    CGRect  frame               = self.view.frame;
    CGFloat visibleHeight       = frame.size.height - keyboardBounds.size.height;
    CGFloat lastVisiblePointY   = lastVisibleBounds.origin.y + lastVisibleBounds.size.height + 14.0f;
    
    if (self.visibleOffset != 0.0f)
    {
        frame.origin.y += self.visibleOffset;
        self.visibleOffset = 0;
    }
    
    if (self.lastVisibleView && (self.visibleOffset == 0.0f) && (visibleHeight < (lastVisiblePointY + self.visibleMargin)))
    {
        self.visibleOffset = lastVisiblePointY - visibleHeight + self.visibleMargin;
        frame.origin.y -= self.visibleOffset;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration.doubleValue];
    [UIView setAnimationCurve:curve.intValue];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
    
    self.keyboardBounds  = keyboardBounds;
}

- (void)keyboardWillShow:(NSNotification*)note
{
    if (_keyboardShowing || !self.lastVisibleView)
    {
        return;
    }
    
    _keyboardShowing    = YES;
    
    CGRect keyboardBounds;
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    NSNumber*   duration    = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber*   curve       = note.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [self animateView:keyboardBounds
         withDuration:duration
             andCurve:curve];
}

- (void)keyboardWillHide:(NSNotification*)note
{
    if (!_keyboardShowing || !self.lastVisibleView)
    {
        return;
    }
    
    _keyboardShowing    = NO;
    
    NSNumber*   duration    = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber*   curve       = note.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect  frame = self.view.frame;
    frame.origin.y += self.visibleOffset;
    self.visibleOffset = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration.doubleValue];
    [UIView setAnimationCurve:curve.intValue];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
    
    self.keyboardBounds  = CGRectZero;
}

#elif TARGET_OS_OSX || TARGET_OS_TV || TARGET_OS_WATCH
#endif // TARGET_OS_IOS

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    self.lastVisibleView    = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView*)textView
{
    self.lastVisibleView    = textView;
}

#pragma mark - Gesture Recognizer methods

- (void)tapToDismiss:(UITapGestureRecognizer*)recognizer
{
    [self.lastVisibleView resignFirstResponder];
}

@end
