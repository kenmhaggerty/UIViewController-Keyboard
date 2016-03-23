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

- (void)setScrollView:(UIScrollView *)scrollView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(scrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)scrollView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(scrollView));
}

- (void)setVisibleView:(UIView *)visibleView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(visibleView), visibleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)visibleView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    UIView *visibleView = objc_getAssociatedObject(self, @selector(visibleView));
    if (visibleView) return visibleView;
    
    visibleView = [UIView new];
    [visibleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [visibleView setUserInteractionEnabled:NO];
    [visibleView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:visibleView];
    [self.view sendSubviewToBack:visibleView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:visibleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:visibleView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:visibleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:visibleView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    [self setConstraintVisibleViewBottom:bottomConstraint];
    [self.view addConstraint:bottomConstraint];
    [self.view layoutSubviews];
    
    [self setVisibleView:visibleView];
    return visibleView;
}

- (void)setConstraintVisibleViewBottom:(NSLayoutConstraint *)constraintVisibleViewBottom
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(constraintVisibleViewBottom), constraintVisibleViewBottom, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)constraintVisibleViewBottom
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(constraintVisibleViewBottom));
}

- (void)setUseDefaultKeyboardToolbar:(BOOL)useDefaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(useDefaultKeyboardToolbar), [NSNumber numberWithBool:useDefaultKeyboardToolbar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)useDefaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSNumber *useDefaultKeyboardToolbar = objc_getAssociatedObject(self, @selector(useDefaultKeyboardToolbar));
    if (useDefaultKeyboardToolbar) return useDefaultKeyboardToolbar.boolValue;
    
    [self setUseDefaultKeyboardToolbar:DEFAULT_USE_DEFAULT_TOOLBAR];
    return self.useDefaultKeyboardToolbar;
}

- (UIView *)customKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(customKeyboardToolbar));
}

- (void)setDefaultKeyboardToolbar:(UIToolbar *)defaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(defaultKeyboardToolbar), defaultKeyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIToolbar *)defaultKeyboardToolbar
{
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
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
    {
        [defaultKeyboardToolbar setTintColor:DEFAULT_TOOLBAR_COLOR_IOS_6];
        [labelForToolbar setFont:DEFAULT_TOOLBAR_FONT_IOS_6];
        [labelForToolbar setTextColor:DEFAULT_TOOLBAR_TEXT_COLOR_IOS_6];
        [labelForToolbar setShadowColor:DEFAULT_TOOLBAR_TEXT_SHADOW_COLOR];
        [labelForToolbar setShadowOffset:CGSizeMake(labelForToolbar.shadowOffset.width, labelForToolbar.shadowOffset.height/2.0)];
    }
    else
    {
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

- (void)setTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(tapGestureRecognizer), tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    UITapGestureRecognizer *tapGestureRecognizer = objc_getAssociatedObject(self, @selector(tapGestureRecognizer));
    if (tapGestureRecognizer) return tapGestureRecognizer;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignActiveView)];
    [self setTapGestureRecognizer:tapGestureRecognizer];
    return tapGestureRecognizer;
}

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

- (void)addObserversToKeyboard
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidDisappear:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)removeObserversFromKeyboard
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)setCustomKeyboardToolbar:(UIView *)customKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(customKeyboardToolbar), customKeyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)keyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    UIView *keyboardToolbar = self.customKeyboardToolbar;
    if (!keyboardToolbar) keyboardToolbar = self.defaultKeyboardToolbar;
    return keyboardToolbar;
}

- (void)updateInsets
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:@[AKD_UI] message:nil];
    
    CGRect rect = [self.scrollView.superview convertRect:self.visibleView.frame fromView:self.visibleView.superview];
    UIEdgeInsets insets = UIEdgeInsetsMake(rect.origin.y-self.scrollView.frame.origin.y, rect.origin.x-self.scrollView.frame.origin.x, (self.scrollView.frame.origin.y+self.scrollView.frame.size.height)-(rect.origin.y+rect.size.height), (self.scrollView.frame.origin.x+self.scrollView.frame.size.width)-(rect.origin.x+rect.size.width));
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+self.scrollView.contentInset.left-insets.left, self.scrollView.contentOffset.y+self.scrollView.contentInset.top-insets.top)];
    
    [self.scrollView setContentInset:insets];
    [self.scrollView setScrollIndicatorInsets:insets];
}





- (void)setKeyboardFrameWillChange:(void (^)(CGRect, NSTimeInterval))keyboardFrameWillChange
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardFrameWillChange), keyboardFrameWillChange, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKeyboardFrameDidChange:(void (^)(CGRect))keyboardFrameDidChange
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardFrameDidChange), keyboardFrameDidChange, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - // CATEGORY METHODS //

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

- (void)keyboardWillAppear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    if ([self respondsToSelector:@selector(keyboardWillAppearWithFrame:animationDuration:)]) {
        [self keyboardWillAppearWithFrame:frame animationDuration:animationDuration];
    }
}

- (void)keyboardDidAppear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.scrollView)
    {
        [self.scrollView flashScrollIndicators];
    }
    else [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:[NSString stringWithFormat:@"%@.%@ is nil", stringFromVariable(self), NSStringFromSelector(@selector(scrollView))]];
    
    if ([self respondsToSelector:@selector(keyboardDidAppearWithFrame:)]) {
        [self keyboardDidAppearWithFrame:frame];
    }
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
    [self.constraintVisibleViewBottom setConstant:0.0f];
    [self.view layoutSubviews];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
        [self updateInsets];
    }];
    
    if ([self respondsToSelector:@selector(keyboardWillDisappearWithAnimationDuration:)]) {
        [self keyboardWillDisappearWithAnimationDuration:animationDuration];
    }
}

- (void)keyboardDidDisappear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    if ([self respondsToSelector:@selector(keyboardDidDisappear)]) {
        [self keyboardDidDisappear];
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.constraintVisibleViewBottom setConstant:frame.size.height];
    [self.view layoutSubviews];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
        [self updateInsets];
    }];
    
    if ([self respondsToSelector:@selector(keyboardFrameWillChangeWithFrame:animationDuration:)]) {
        [self keyboardFrameWillChangeWithFrame:frame animationDuration:animationDuration];
    }
}

- (void)keyboardFrameDidChange:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if ([self respondsToSelector:@selector(keyboardFrameDidChangeWithFrame:)]) {
        [self keyboardFrameDidChangeWithFrame:frame];
    }
}

- (void)resignActiveView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
