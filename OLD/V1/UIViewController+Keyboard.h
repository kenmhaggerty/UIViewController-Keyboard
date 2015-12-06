//
//  UIViewController+Keyboard.h
//  UIViewController+Keyboard
//
//  Created by Ken M. Haggerty on 10/9/13.
//  Copyright (c) 2015 Ken M. Haggerty All rights reserved.
//
//  For full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

#pragma mark - // NOTES (Public) //

// SUMMARY:
// This category for UIViewController manages display of an on-screen keyboard.
//
// NOTES:
// • scrollView contains scrollable contents accessible when the keyboard is displayed. If scrollView is nil, the category will not be able to adjust content automatically so that it remains visible and accessible while the keyboard is displayed.
// • activeView is a read-only convenience property that makes getting the current first responder easy.
// • keyboardToolbar allows the developer to set and store a desired custom inputAccessoryView for the first responder to use if the first responder does not already have an associated inputAccessoryView set.
// • useDefaultKeyboardToolbar allows the developer to fall back on a default "tap to dismiss" inputAccessoryView if the first responder does not have an associated inputAccessoryView and if keyboardToolbar is nil.
//
// OTHER:
// Please remember to call -[registerForKeyboardNotifications] and -[unregisterForKeyboardNotifications] in your UIViewController setup and teardown.

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

@interface UIViewController (Keyboard) <UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UISearchBarDelegate>
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIView *keyboardToolbar;
@property (nonatomic) BOOL useDefaultKeyboardToolbar;
@property (nonatomic) CGSize scrollToViewPadding;
- (void)registerForKeyboardNotifications;
- (void)unregisterForKeyboardNotifications;
- (void)scrollToView:(UIView *)view animated:(BOOL)animated;
- (UIView *)getFirstResponder;
@end