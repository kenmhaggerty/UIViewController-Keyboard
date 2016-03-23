//
//  UIViewController+Keyboard.h
//  UIViewController+Keyboard
//
//  Created by Ken M. Haggerty on 9/1/15.
//  Copyright (c) 2015 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>

#pragma mark - // PROTOCOLS //

@protocol UIKeyboardDelegate <NSObject>
@optional
- (void)keyboardWillAppearWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
- (void)keyboardDidAppearWithFrame:(CGRect)frame;
- (void)keyboardWillDisappearWithAnimationDuration:(NSTimeInterval)animationDuration;
- (void)keyboardDidDisappear;
- (void)keyboardFrameWillChangeWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
- (void)keyboardFrameDidChangeWithFrame:(CGRect)frame;
@end

#pragma mark - // DEFINITIONS (Public) //

@interface UIViewController (Keyboard) <UIKeyboardDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *visibleView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *constraintVisibleViewBottom;
@property (nonatomic) BOOL useDefaultKeyboardToolbar;

// SETUP //

- (void)addObserversToKeyboard;
- (void)removeObserversFromKeyboard;

// SETTERS //

- (void)setCustomKeyboardToolbar:(UIView *)customKeyboardToolbar;

// GETTERS //

- (UIView *)keyboardToolbar;

// OTHER //

- (void)updateInsets;

@end
