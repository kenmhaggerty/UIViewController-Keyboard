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

#pragma mark - // DEFINITIONS (Public) //

@interface UIViewController (Keyboard)
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
