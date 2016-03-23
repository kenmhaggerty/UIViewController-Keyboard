//
//  UIViewController+Keyboard.m
//  UIViewController+Keyboard
//
//  Created by Ken M. Haggerty on 9/1/15.
//  Copyright (c) 2015 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "UIViewController+Keyboard.h"
#import "AKDebugger.h"
#import "AKGenerics.h"
#import <objc/runtime.h>

#pragma mark - // DEFINITIONS (Private) //

#define DEFAULT_USE_DEFAULT_TOOLBAR YES
#define DEFAULT_TOOLBAR_TEXT @"Tap To Dismiss Keyboard"
#define DEFAULT_TOOLBAR_HEIGHT 20.0f

// iOS 6 //

#define DEFAULT_TOOLBAR_COLOR_IOS_6 [UIColor colorWithRed:87.5f/255.0f green:100.0f/255.0f blue:112.5f/255.0f alpha:1.0f]
#define DEFAULT_TOOLBAR_FONT_IOS_6 [UIFont boldSystemFontOfSize:12.0f]
#define DEFAULT_TOOLBAR_TEXT_COLOR_IOS_6 [UIColor whiteColor]
#define DEFAULT_TOOLBAR_TEXT_SHADOW_COLOR [UIColor colorWithWhite:0.0f alpha:0.66f]

// iOS 7 //

#define DEFAULT_TOOLBAR_COLOR_IOS_7 [UIColor colorWithWhite:0.9 alpha:0.33]
#define DEFAULT_TOOLBAR_FONT_IOS_7 [UIFont systemFontOfSize:12.0]
#define DEFAULT_TOOLBAR_TEXT_COLOR_IOS_7 [UIColor blackColor]

@implementation UIViewController (Keyboard)

#pragma mark - // SETTERS AND GETTERS //

- (void)setScrollView:(UIScrollView *)scrollView {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(scrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)scrollView {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(scrollView));
}

- (void)setKeyboardToolbar:(UIView *)keyboardToolbar {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardToolbar), keyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)keyboardToolbar {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    if (self.useDefaultKeyboardToolbar) {
        return self.defaultKeyboardToolbar;
    }
    
    return objc_getAssociatedObject(self, @selector(keyboardToolbar));
}

- (void)setUseDefaultKeyboardToolbar:(BOOL)useDefaultKeyboardToolbar {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(useDefaultKeyboardToolbar), [NSNumber numberWithBool:useDefaultKeyboardToolbar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)useDefaultKeyboardToolbar {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSNumber *useDefaultKeyboardToolbar = objc_getAssociatedObject(self, @selector(useDefaultKeyboardToolbar));
    if (useDefaultKeyboardToolbar) {
        return useDefaultKeyboardToolbar.boolValue;
    }
    
    [self setUseDefaultKeyboardToolbar:DEFAULT_USE_DEFAULT_TOOLBAR];
    return self.useDefaultKeyboardToolbar;
}

- (void)setKeyboardIsVisible:(BOOL)keyboardIsVisible {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardIsVisible), [NSNumber numberWithBool:keyboardIsVisible], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)keyboardIsVisible {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSNumber *keyboardIsVisible = objc_getAssociatedObject(self, @selector(keyboardIsVisible));
    if (keyboardIsVisible) {
        return keyboardIsVisible.boolValue;
    }
    
    [self setKeyboardIsVisible:NO];
    return self.keyboardIsVisible;
}

- (void)setDefaultKeyboardToolbar:(UIToolbar *)defaultKeyboardToolbar {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(defaultKeyboardToolbar), defaultKeyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIToolbar *)defaultKeyboardToolbar {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    UIToolbar *defaultKeyboardToolbar = objc_getAssociatedObject(self, @selector(defaultKeyboardToolbar));
    if (defaultKeyboardToolbar) return defaultKeyboardToolbar;
    
    defaultKeyboardToolbar = [UIToolbar new];
    [defaultKeyboardToolbar addConstraint:[NSLayoutConstraint constraintWithItem:defaultKeyboardToolbar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:DEFAULT_TOOLBAR_HEIGHT]];
    [defaultKeyboardToolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [defaultKeyboardToolbar setBackgroundColor:[UIColor clearColor]];
    UILabel *labelForToolbar = [UILabel new];
    [labelForToolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [labelForToolbar setText:DEFAULT_TOOLBAR_TEXT];
    [labelForToolbar setBackgroundColor:[UIColor clearColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
        [defaultKeyboardToolbar setTintColor:DEFAULT_TOOLBAR_COLOR_IOS_6];
        [labelForToolbar setFont:DEFAULT_TOOLBAR_FONT_IOS_6];
        [labelForToolbar setTextColor:DEFAULT_TOOLBAR_TEXT_COLOR_IOS_6];
        [labelForToolbar setShadowColor:DEFAULT_TOOLBAR_TEXT_SHADOW_COLOR];
        [labelForToolbar setShadowOffset:CGSizeMake(labelForToolbar.shadowOffset.width, labelForToolbar.shadowOffset.height/2.0)];
    }
    else {
        [defaultKeyboardToolbar setTintColor:DEFAULT_TOOLBAR_COLOR_IOS_7];
        [defaultKeyboardToolbar setTranslucent:YES];
        [labelForToolbar setFont:DEFAULT_TOOLBAR_FONT_IOS_7];
        [labelForToolbar setTextColor:DEFAULT_TOOLBAR_TEXT_COLOR_IOS_7];
    }
    [defaultKeyboardToolbar addSubview:labelForToolbar];
    [defaultKeyboardToolbar addConstraint:[NSLayoutConstraint constraintWithItem:labelForToolbar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:defaultKeyboardToolbar attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [defaultKeyboardToolbar addConstraint:[NSLayoutConstraint constraintWithItem:labelForToolbar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:defaultKeyboardToolbar attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [defaultKeyboardToolbar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignActiveView)]];
    [self setDefaultKeyboardToolbar:defaultKeyboardToolbar];
    return defaultKeyboardToolbar;
}

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(tapGestureRecognizer), tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    UITapGestureRecognizer *tapGestureRecognizer = objc_getAssociatedObject(self, @selector(tapGestureRecognizer));
    if (tapGestureRecognizer) return tapGestureRecognizer;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignActiveView)];
    [self setTapGestureRecognizer:tapGestureRecognizer];
    return tapGestureRecognizer;
}

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS (Setup) //

- (void)addObserversToKeyboard {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidDisappear:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [self addObserversForFirstResponder];
}

- (void)removeObserversFromKeyboard {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [self removeObserversForFirstResponder];
}

#pragma mark - // PUBLIC METHODS (Other) //

- (void)adjustForStatusBarHeight:(CGFloat)statusBarHeight {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    if (!self.scrollView) {
        return;
    }
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y+self.scrollView.contentInset.top-statusBarHeight);
    self.scrollView.contentInset = UIEdgeInsetsMake(statusBarHeight, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right);
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(statusBarHeight, self.scrollView.scrollIndicatorInsets.left, self.scrollView.scrollIndicatorInsets.bottom, self.scrollView.scrollIndicatorInsets.right);
}

#pragma mark - // CATEGORY METHODS //

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS (Observers) //

- (void)addObserversForFirstResponder {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:@[AKD_NOTIFICATION_CENTER] message:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidBecomeFirstResponder:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidBecomeFirstResponder:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidResignFirstResponder:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidResignFirstResponder:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)removeObserversForFirstResponder {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:@[AKD_NOTIFICATION_CENTER] message:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
}

#pragma mark - // PRIVATE METHODS (Responders) //

- (void)keyboardWillAppear:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    if (self.keyboardIsVisible) {
        return;
    }
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    if (self.scrollView) {
        [self.scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:animationDuration animations:^{
            [self.scrollView layoutIfNeeded];
        }];
    }
    
    if ([self respondsToSelector:@selector(keyboardWillAppearWithFrame:animationDuration:)]) {
        [self keyboardWillAppearWithFrame:frame animationDuration:animationDuration];
    }
}

- (void)keyboardDidAppear:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    if (self.keyboardIsVisible) {
        return;
    }
    
    self.keyboardIsVisible = YES;
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.scrollView) {
        [self.scrollView flashScrollIndicators];
    }
    
    if ([self respondsToSelector:@selector(keyboardDidAppearWithFrame:)]) {
        [self keyboardDidAppearWithFrame:frame];
    }
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    if (!self.keyboardIsVisible) {
        return;
    }
    
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
    if (self.scrollView) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.scrollView.contentOffset = CGPointMake(fminf(self.scrollView.contentOffset.x, self.scrollView.contentSize.width-self.scrollView.frame.size.width), fminf(self.scrollView.contentOffset.y, self.scrollView.contentSize.height-self.scrollView.frame.size.height));
        }];
    }
    
    if ([self respondsToSelector:@selector(keyboardWillDisappearWithAnimationDuration:)]) {
        [self keyboardWillDisappearWithAnimationDuration:animationDuration];
    }
}

- (void)keyboardDidDisappear:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    if (!self.keyboardIsVisible) {
        return;
    }
    
    self.keyboardIsVisible = NO;
    
    if ([self respondsToSelector:@selector(keyboardDidDisappear)]) {
        [self keyboardDidDisappear];
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (self.scrollView && ![self isKindOfClass:[UITableViewController class]]) {
        CGFloat delta = self.scrollView.frame.origin.y+self.scrollView.frame.size.height-frame.origin.y;
        [UIView animateWithDuration:animationDuration animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, delta, self.scrollView.contentInset.right);
            self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollView.scrollIndicatorInsets.top, self.scrollView.scrollIndicatorInsets.left, delta, self.scrollView.scrollIndicatorInsets.right);
        }];
    }
    
    if ([self respondsToSelector:@selector(keyboardFrameWillChangeWithFrame:animationDuration:)]) {
        [self keyboardFrameWillChangeWithFrame:frame animationDuration:animationDuration];
    }
}

- (void)keyboardFrameDidChange:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if ([self respondsToSelector:@selector(keyboardFrameDidChangeWithFrame:)]) {
        [self keyboardFrameDidChangeWithFrame:frame];
    }
}

- (void)viewDidBecomeFirstResponder:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    UIView *firstResponder = notification.object;
    if (![AKGenerics view:firstResponder isEventualSubviewOfView:self.view]) {
        return;
    }
    
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)firstResponder;
        if (!textField.inputAccessoryView) {
            textField.inputAccessoryView = self.keyboardToolbar;
            [textField reloadInputViews];
        }
    }
    else if ([firstResponder isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)firstResponder;
        if (!textView.inputAccessoryView) {
            textView.inputAccessoryView = self.keyboardToolbar;
            [textView reloadInputViews];
        }
    }
    
    if ([AKGenerics view:firstResponder isEventualSubviewOfView:self.scrollView]) {
        [AKGenerics scrollToView:firstResponder inScrollView:self.scrollView animated:YES];
    }
}

- (void)viewDidResignFirstResponder:(NSNotification *)notification {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    UIView *firstResponder = notification.object;
    if (![AKGenerics view:firstResponder isEventualSubviewOfView:self.view]) {
        return;
    }
    
    //
}

#pragma mark - // PRIVATE METHODS (Other) //

- (void)resignActiveView {
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
