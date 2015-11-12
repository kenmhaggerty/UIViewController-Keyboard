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
@property (nonatomic, strong) UIView *keyboardToolbar;
@property (nonatomic) CGSize scrollPadding;
@property (nonatomic) BOOL useDefaultKeyboardToolbar;
- (void)addObserversToKeyboard;
- (void)removeObserversFromKeyboard;
- (void)scrollToView:(UIView *)view animated:(BOOL)animated;

- (void)setKeyboardWillAppear:(void (^)(CGRect, NSTimeInterval))keyboardWillAppear;
- (void)setKeyboardDidAppear:(void (^)(CGRect))keyboardDidAppear;
- (void)setKeyboardWillDisappear:(void (^)(NSTimeInterval))keyboardWillDisappear;
- (void)setKeyboardDidDisappear:(void (^)(void))keyboardDidDisappear;
- (void)setKeyboardFrameWillChange:(void (^)(CGRect, NSTimeInterval))keyboardFrameDidChange;
- (void)setKeyboardFrameDidChange:(void (^)(CGRect))keyboardFrameDidChange;

@end