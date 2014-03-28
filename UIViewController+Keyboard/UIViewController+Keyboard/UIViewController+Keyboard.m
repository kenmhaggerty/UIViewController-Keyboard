//
//  UIViewController+Keyboard.m
//  UIViewController+Keyboard
//
//  Created by Ken M. Haggerty on 10/9/13.
//  Copyright (c) 2013 Ken M. Haggerty All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "UIViewController+Keyboard.h"
#import "AKSystemInfo.h"
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

static char scrollViewKey;
static char keyboardToolbarKey;
static char useDefaultKeyboardToolbarKey;
static char scrollToViewPaddingKey;
static char scrollViewContentInsetKey;
static char scrollViewScrollIndicatorInsetsKey;
static char defaultKeyboardToolbarKey;
static char tapGestureRecognizerKey;

@interface UIViewController () <UIScrollViewDelegate>
//@property (nonatomic, retain, readwrite) UIView *activeView;
@end

@implementation UIViewController (Keyboard)

#pragma mark - // SETTERS AND GETTERS //

- (void)setScrollView:(UIScrollView *)scrollView
{
    [scrollView setClipsToBounds:NO];
    objc_setAssociatedObject(self, &scrollViewKey, scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)scrollView
{
	return objc_getAssociatedObject(self, &scrollViewKey);
}

- (void)setKeyboardToolbar:(UIView *)keyboardToolbar
{
    objc_setAssociatedObject(self, &keyboardToolbarKey, keyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)keyboardToolbar
{
	return objc_getAssociatedObject(self, &keyboardToolbarKey);
}

- (void)setUseDefaultKeyboardToolbar:(BOOL)useDefaultKeyboardToolbar
{
    objc_setAssociatedObject(self, &useDefaultKeyboardToolbar, [NSNumber numberWithBool:useDefaultKeyboardToolbar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)useDefaultKeyboardToolbar
{
    NSNumber *useDefaultKeyboardToolbarNSNumber = objc_getAssociatedObject(self, &useDefaultKeyboardToolbarKey);
    BOOL useDefaultKeyboardToolbar = [useDefaultKeyboardToolbarNSNumber boolValue];
    if (!useDefaultKeyboardToolbarNSNumber)
    {
        useDefaultKeyboardToolbar = DEFAULT_USE_DEFAULT_TOOLBAR;
        [self setUseDefaultKeyboardToolbar:useDefaultKeyboardToolbar];
    }
	return useDefaultKeyboardToolbar;
}

- (void)setScrollToViewPadding:(CGSize)scrollToViewPadding
{
    objc_setAssociatedObject(self, &scrollToViewPaddingKey, [NSValue valueWithCGSize:scrollToViewPadding], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)scrollToViewPadding
{
    NSValue *scrollToViewPaddingNSValue = objc_getAssociatedObject(self, &scrollToViewPaddingKey);
    CGSize scrollToViewPadding = [scrollToViewPaddingNSValue CGSizeValue];
    if (!scrollToViewPaddingNSValue)
    {
        scrollToViewPadding = CGSizeMake(DEFAULT_SCROLLING_PADDING_HORIZONTAL, DEFAULT_SCROLLING_PADDING_VERTICAL);
        [self setScrollToViewPadding:scrollToViewPadding];
    }
	return scrollToViewPadding;
}

- (void)setScrollViewContentInset:(UIEdgeInsets)scrollViewContentInset
{
    objc_setAssociatedObject(self, &scrollViewContentInsetKey, [NSValue valueWithUIEdgeInsets:scrollViewContentInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)scrollViewContentInset
{
	return [objc_getAssociatedObject(self, &scrollViewContentInsetKey) UIEdgeInsetsValue];
}

- (void)setScrollViewScrollIndicatorInsets:(UIEdgeInsets)scrollViewScrollIndicatorInsets
{
    objc_setAssociatedObject(self, &scrollViewScrollIndicatorInsetsKey, [NSValue valueWithUIEdgeInsets:scrollViewScrollIndicatorInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)scrollViewScrollIndicatorInsets
{
	return [objc_getAssociatedObject(self, &scrollViewScrollIndicatorInsetsKey) UIEdgeInsetsValue];
}

- (void)setDefaultKeyboardToolbar:(UIView *)defaultKeyboardToolbar
{
    objc_setAssociatedObject(self, &defaultKeyboardToolbarKey, defaultKeyboardToolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)defaultKeyboardToolbar
{
    UIView *defaultKeyboardToolbar = objc_getAssociatedObject(self, &defaultKeyboardToolbarKey);
    if (!defaultKeyboardToolbar)
    {
        UIToolbar *defaultKeyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, DEFAULT_TOOLBAR_HEIGHT)];
        [defaultKeyboardToolbar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
        UILabel *labelForToolbar = [[UILabel alloc] initWithFrame:defaultKeyboardToolbar.bounds];
        [labelForToolbar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [labelForToolbar setBackgroundColor:[UIColor clearColor]];
        [labelForToolbar setTextAlignment:NSTextAlignmentCenter];
        if ([AKSystemInfo iOSVersion] < 7.0)
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
	objc_setAssociatedObject(self, &tapGestureRecognizerKey, tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = objc_getAssociatedObject(self, &tapGestureRecognizerKey);
    if (!tapGestureRecognizer)
    {
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignActiveView)];
        [self setTapGestureRecognizer:tapGestureRecognizer];
    }
    return tapGestureRecognizer;
}

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidDisappear:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)scrollToView:(UIView *)view animated:(BOOL)animated
{
    if ([self view:view isSubviewSomewhereOfView:self.scrollView])
    {
        CGRect viewFrameWithPadding = CGRectMake(view.frame.origin.x-self.scrollToViewPadding.width, view.frame.origin.y-self.scrollToViewPadding.height, view.frame.size.width+2*self.scrollToViewPadding.width, view.frame.size.height+2*self.scrollToViewPadding.height);
        [self.scrollView scrollRectToVisible:[self.scrollView convertRect:viewFrameWithPadding fromView:view.superview] animated:animated];
    }
}

- (UIView *)getFirstResponder
{
    UIView *firstResponder;
    NSMutableArray *subviews = [[NSMutableArray alloc] initWithObjects:self.view, nil];
    do {
        UIView *subview = [subviews firstObject];
        if (subview.isFirstResponder) firstResponder = subview;
        else [subviews addObjectsFromArray:subview.subviews];
        [subviews removeObject:subview];
    } while ((!firstResponder) && (subviews.count));
    return firstResponder;
}

#pragma mark - // DELEGATED METHODS (UITextFieldDelegate) //

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.useDefaultKeyboardToolbar)
    {
        self.defaultKeyboardToolbar; // this is bad code but necessary to work, needs fix
        [textField performSelector:@selector(setInputAccessoryView:) withObject:self.defaultKeyboardToolbar];
    }
    else if (self.keyboardToolbar)
    {
        self.keyboardToolbar; // this is bad code but necessary to work, needs fix
        [textField performSelector:@selector(setInputAccessoryView:) withObject:self.keyboardToolbar];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollToView:textField animated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark - // DELEGATED METHODS (UITextViewDelegate) //

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.useDefaultKeyboardToolbar)
    {
        self.defaultKeyboardToolbar; // this is bad code but necessary to work, needs fix
        [textView performSelector:@selector(setInputAccessoryView:) withObject:self.defaultKeyboardToolbar];
    }
    else if (self.keyboardToolbar)
    {
        self.keyboardToolbar; // this is bad code but necessary to work, needs fix
        [textView performSelector:@selector(setInputAccessoryView:) withObject:self.keyboardToolbar];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self scrollToView:textView animated:YES];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

#pragma mark - // DELEGATED METHODS (UISearchBarDelegate) //

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (self.useDefaultKeyboardToolbar)
    {
        self.defaultKeyboardToolbar; // this is bad code but necessary to work, needs fix
        [searchBar performSelector:@selector(setInputAccessoryView:) withObject:self.defaultKeyboardToolbar];
    }
    else if (self.keyboardToolbar)
    {
        self.keyboardToolbar; // this is bad code but necessary to work, needs fix
        [searchBar performSelector:@selector(setInputAccessoryView:) withObject:self.keyboardToolbar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self scrollToView:searchBar animated:YES];
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - // DELEGATED METHODS (UIScrollViewDelegate) //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

- (void)keyboardWillAppear:(NSNotification *)notification
{
    // keyboard will appear
}

- (void)keyboardDidAppear:(NSNotification *)notification
{
    if (self.scrollView)
    {
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGRect insetFrame = CGRectZero;
        CGFloat oversize = 0.0;
        if (UIEdgeInsetsEqualToEdgeInsets(self.scrollViewContentInset, UIEdgeInsetsZero))
        {
            [self setScrollViewContentInset:self.scrollView.contentInset];
            insetFrame = [self.view convertRect:CGRectMake(2*self.scrollView.contentInset.left+self.scrollView.contentOffset.x, 2*self.scrollView.contentInset.top+self.scrollView.contentOffset.y, self.scrollView.frame.size.width-self.scrollView.contentInset.left-self.scrollView.contentInset.right, self.scrollView.frame.size.height-self.scrollView.contentInset.top-self.scrollView.contentInset.bottom) fromView:self.scrollView];
            oversize = (insetFrame.origin.y+insetFrame.size.height)-(self.view.bounds.size.height-keyboardSize.height+self.scrollView.contentInset.top);
            if (oversize > 0.0)
            {
                [self.scrollView setContentInset:UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom+oversize, self.scrollView.contentInset.right)];
            }
        }
        if (UIEdgeInsetsEqualToEdgeInsets(self.scrollViewScrollIndicatorInsets, UIEdgeInsetsZero))
        {
            [self setScrollViewScrollIndicatorInsets:self.scrollView.scrollIndicatorInsets];
            insetFrame = [self.view convertRect:CGRectMake(2*self.scrollView.scrollIndicatorInsets.left+self.scrollView.contentOffset.x, 2*self.scrollView.scrollIndicatorInsets.top+self.scrollView.contentOffset.y, self.scrollView.frame.size.width-self.scrollView.scrollIndicatorInsets.left-self.scrollView.scrollIndicatorInsets.right, self.scrollView.frame.size.height-self.scrollView.scrollIndicatorInsets.top-self.scrollView.scrollIndicatorInsets.bottom) fromView:self.scrollView];
            oversize = (insetFrame.origin.y+insetFrame.size.height)-(self.view.bounds.size.height-keyboardSize.height+self.scrollView.contentInset.top);
            if (oversize > 0.0)
            {
                [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(self.scrollView.scrollIndicatorInsets.top, self.scrollView.scrollIndicatorInsets.left, self.scrollView.scrollIndicatorInsets.bottom+oversize, self.scrollView.scrollIndicatorInsets.right)];
            }
        }
        [self scrollToView:[self getFirstResponder] animated:YES];
    }
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    if (self.scrollView)
    {
        NSTimeInterval animationDuration = 0.0;
        [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
        [UIView animateWithDuration:animationDuration animations:^{
            [self.scrollView setContentInset:self.scrollViewContentInset];
        } completion:^(BOOL finished){
            [self setScrollViewContentInset:UIEdgeInsetsZero];
        }];
        [UIView animateWithDuration:animationDuration animations:^{
            [self.scrollView setScrollIndicatorInsets:self.scrollViewScrollIndicatorInsets];
        } completion:^(BOOL finished){
            [self setScrollViewScrollIndicatorInsets:UIEdgeInsetsZero];
        }];
    }
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
}

- (void)keyboardDidDisappear:(NSNotification *)notification
{
    // keyboard did disappear
}

- (void)resignActiveView
{
    UIView *activeView = [self getFirstResponder];
    if (activeView)
    {
        [activeView performSelector:@selector(resignFirstResponder)];
    }
}

- (BOOL)view:(UIView *)view isSubviewSomewhereOfView:(UIView *)parentView
{
    NSMutableOrderedSet *setOfSubviews = [[NSMutableOrderedSet alloc] initWithArray:parentView.subviews];
    UIView *subview;
    while (setOfSubviews.count > 0)
    {
        subview = [setOfSubviews firstObject];
        if ([subview isEqual:view]) return YES;
        else if (subview.subviews.count > 0) [setOfSubviews addObjectsFromArray:subview.subviews];
        [setOfSubviews removeObject:subview];
    }
    return NO;
}

@end