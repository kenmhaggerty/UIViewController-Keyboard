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
#define DEFAULT_TOOLBAR_FONT_IOS_6 [UIFont boldSystemFontOfSize:12.0]
#define DEFAULT_TOOLBAR_FONT_IOS_7 [UIFont systemFontOfSize:12.0]
#define DEFAULT_TOOLBAR_TEXT_COLOR_IOS_6 [UIColor whiteColor]
#define DEFAULT_TOOLBAR_TEXT_COLOR_IOS_7 [UIColor blackColor]
#define DEFAULT_TOOLBAR_TEXT_SHADOW_COLOR [UIColor colorWithWhite:0.0 alpha:0.66]
#define DEFAULT_TOOLBAR_COLOR_IOS_6 [UIColor colorWithRed:87.5/255.0 green:100.0/255.0 blue:112.5/255.0 alpha:1.0]
#define DEFAULT_TOOLBAR_COLOR_IOS_7 [UIColor colorWithWhite:0.9 alpha:0.33]
#define DEFAULT_TOOLBAR_HEIGHT 20.0

#define DEFAULT_SCROLLING_PADDING_HORIZONTAL 0.0
#define DEFAULT_SCROLLING_PADDING_VERTICAL 5.0

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

- (void)setKeyboardToolbar:(UIView *)keyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardToolbar), keyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)keyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardToolbar));
}

- (void)setScrollPadding:(CGSize)scrollPadding
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(scrollPadding), [NSValue valueWithCGSize:scrollPadding], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)scrollPadding
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSValue *scrollPaddingNSValue = objc_getAssociatedObject(self, @selector(scrollPadding));
    CGSize scrollPadding = [scrollPaddingNSValue CGSizeValue];
    if (!scrollPaddingNSValue)
    {
        scrollPadding = CGSizeMake(DEFAULT_SCROLLING_PADDING_HORIZONTAL, DEFAULT_SCROLLING_PADDING_VERTICAL);
        [self setScrollPadding:scrollPadding];
    }
    return scrollPadding;
}

- (void)setUseDefaultKeyboardToolbar:(BOOL)useDefaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(useDefaultKeyboardToolbar), [NSNumber numberWithBool:useDefaultKeyboardToolbar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)useDefaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    NSNumber *useDefaultKeyboardToolbarNSNumber = objc_getAssociatedObject(self, @selector(useDefaultKeyboardToolbar));
    BOOL useDefaultKeyboardToolbar = [useDefaultKeyboardToolbarNSNumber boolValue];
    if (!useDefaultKeyboardToolbarNSNumber)
    {
        useDefaultKeyboardToolbar = DEFAULT_USE_DEFAULT_TOOLBAR;
        [self setUseDefaultKeyboardToolbar:useDefaultKeyboardToolbar];
    }
    return useDefaultKeyboardToolbar;
}

- (void)setScrollViewContentInset:(UIEdgeInsets)scrollViewContentInset
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(scrollViewContentInset), [NSValue valueWithUIEdgeInsets:scrollViewContentInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)scrollViewContentInset
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [objc_getAssociatedObject(self, @selector(scrollViewContentInset)) UIEdgeInsetsValue];
}

- (void)setScrollViewScrollIndicatorInsets:(UIEdgeInsets)scrollViewScrollIndicatorInsets
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(scrollViewScrollIndicatorInsets), [NSValue valueWithUIEdgeInsets:scrollViewScrollIndicatorInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)scrollViewScrollIndicatorInsets
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return [objc_getAssociatedObject(self, @selector(scrollViewScrollIndicatorInsets)) UIEdgeInsetsValue];
}

- (void)setDefaultKeyboardToolbar:(UIView *)defaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(defaultKeyboardToolbar), defaultKeyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)defaultKeyboardToolbar
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    UIView *defaultKeyboardToolbar = objc_getAssociatedObject(self, @selector(defaultKeyboardToolbar));
    if (!defaultKeyboardToolbar)
    {
        UIToolbar *defaultKeyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, DEFAULT_TOOLBAR_HEIGHT)];
        [defaultKeyboardToolbar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
        UILabel *labelForToolbar = [[UILabel alloc] initWithFrame:defaultKeyboardToolbar.bounds];
        [labelForToolbar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [labelForToolbar setBackgroundColor:[UIColor clearColor]];
        [labelForToolbar setTextAlignment:NSTextAlignmentCenter];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
        {
            [defaultKeyboardToolbar setTintColor:DEFAULT_TOOLBAR_COLOR_IOS_6];
            [labelForToolbar setFont:DEFAULT_TOOLBAR_FONT_IOS_6];
            [labelForToolbar setTextColor:DEFAULT_TOOLBAR_TEXT_COLOR_IOS_6];
            [labelForToolbar setShadowColor:DEFAULT_TOOLBAR_TEXT_SHADOW_COLOR];
            [labelForToolbar setShadowOffset:CGSizeMake(labelForToolbar.shadowOffset.width, labelForToolbar.shadowOffset.height/2.0)];
        }
        else
        {
            [defaultKeyboardToolbar setBarTintColor:DEFAULT_TOOLBAR_COLOR_IOS_7];
            [labelForToolbar setFont:DEFAULT_TOOLBAR_FONT_IOS_7];
            [labelForToolbar setTextColor:DEFAULT_TOOLBAR_TEXT_COLOR_IOS_7];
            [defaultKeyboardToolbar setTranslucent:YES];
        }
        [labelForToolbar setText:DEFAULT_TOOLBAR_TEXT];
        [defaultKeyboardToolbar addSubview:labelForToolbar];
        [defaultKeyboardToolbar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignActiveView)]];
        [self setDefaultKeyboardToolbar:defaultKeyboardToolbar];
    }
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
    if (!tapGestureRecognizer)
    {
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignActiveView)];
        [self setTapGestureRecognizer:tapGestureRecognizer];
    }
    return tapGestureRecognizer;
}

- (void (^)(CGRect, NSTimeInterval))keyboardWillAppear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardWillAppear));
}

- (void (^)(CGRect))keyboardDidAppear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardDidAppear));
}

- (void (^)(NSTimeInterval))keyboardWillDisappear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardWillDisappear));
}

- (void (^)(void))keyboardDidDisappear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardDidDisappear));
}

- (void (^)(CGRect, NSTimeInterval))keyboardFrameWillChange
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardFrameWillChange));
}

- (void (^)(CGRect))keyboardFrameDidChange
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:@[AKD_UI] message:nil];
    
    return objc_getAssociatedObject(self, @selector(keyboardFrameDidChange));
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

- (void)scrollToView:(UIView *)view animated:(BOOL)animated
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    if (![AKGenerics view:view isEventualSubviewOfView:self.scrollView])
    {
        [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:[NSString stringWithFormat:@"%@ is not subview of %@", stringFromVariable(view), NSStringFromSelector(@selector(scrollView))]];
        return;
    }
    
    CGRect viewRect = [self.scrollView convertRect:view.frame fromView:view.superview];
    viewRect = CGRectMake(viewRect.origin.x-self.scrollPadding.width, viewRect.origin.y-self.scrollPadding.height, viewRect.size.width+2*self.scrollPadding.width, viewRect.size.height+2*self.scrollPadding.height);
    [self.scrollView scrollRectToVisible:viewRect animated:animated];
}

- (void)setKeyboardWillAppear:(void (^)(CGRect, NSTimeInterval))keyboardWillAppear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardWillAppear), keyboardWillAppear, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKeyboardDidAppear:(void (^)(CGRect))keyboardDidAppear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardDidAppear), keyboardDidAppear, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKeyboardWillDisappear:(void (^)(NSTimeInterval))keyboardWillDisappear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardWillDisappear), keyboardWillDisappear, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKeyboardDidDisappear:(void (^)(void))keyboardDidDisappear
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetter tags:@[AKD_UI] message:nil];
    
    objc_setAssociatedObject(self, @selector(keyboardDidDisappear), keyboardDidDisappear, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    
    if (self.scrollView)
    {
        [self setScrollViewContentInset:self.scrollView.contentInset];
        [self setScrollViewScrollIndicatorInsets:self.scrollView.scrollIndicatorInsets];
        CGFloat insetBottom = self.scrollView.frame.size.height-[self.scrollView.superview convertRect:frame fromCoordinateSpace:self.view].origin.y;
        [UIView animateWithDuration:animationDuration animations:^{
            [self.scrollView setContentInset:UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, insetBottom, self.scrollView.contentInset.right)];
            [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(self.scrollView.scrollIndicatorInsets.top, self.scrollView.scrollIndicatorInsets.left, insetBottom, self.scrollView.scrollIndicatorInsets.right)];
        }];
    }
    else [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:[NSString stringWithFormat:@"%@.%@ is nil", stringFromVariable(self), NSStringFromSelector(@selector(scrollView))]];
    
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    if (self.keyboardWillAppear) self.keyboardWillAppear(frame, animationDuration);
}

- (void)keyboardDidAppear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.scrollView)
    {
        [self scrollToView:[AKGenerics getFirstResponderInView:self.scrollView] animated:YES];
        [self.scrollView flashScrollIndicators];
    }
    else [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:[NSString stringWithFormat:@"%@.%@ is nil", stringFromVariable(self), NSStringFromSelector(@selector(scrollView))]];
    
    if (self.keyboardDidAppear) self.keyboardDidAppear(frame);
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
    if (self.keyboardWillDisappear) self.keyboardWillDisappear(animationDuration);
}

- (void)keyboardDidDisappear:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    if (self.keyboardDidDisappear) self.keyboardDidDisappear();
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (self.scrollView)
    {
        CGFloat insetBottom = self.scrollView.frame.size.height-[self.scrollView.superview convertRect:frame fromCoordinateSpace:self.view].origin.y;
        [UIView animateWithDuration:animationDuration animations:^{
            [self.scrollView setContentInset:UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, insetBottom, self.scrollView.contentInset.right)];
            [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(self.scrollView.scrollIndicatorInsets.top, self.scrollView.scrollIndicatorInsets.left, insetBottom, self.scrollView.scrollIndicatorInsets.right)];
        }];
    }
    else [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeNotice methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:[NSString stringWithFormat:@"%@.%@ is nil", stringFromVariable(self), NSStringFromSelector(@selector(scrollView))]];
    
    if (self.keyboardFrameWillChange) self.keyboardFrameWillChange(frame, animationDuration);
}

- (void)keyboardFrameDidChange:(NSNotification *)notification
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_NOTIFICATION_CENTER, AKD_UI] message:nil];
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.keyboardFrameDidChange) self.keyboardFrameDidChange(frame);
}

- (void)resignActiveView
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_UI] message:nil];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
