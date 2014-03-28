//
//  AKSystemInfo.m
//  UIViewController+Keyboard
//
//  Created by Ken M. Haggerty on 11/11/13.
//  Copyright (c) 2013 Ken M. Haggerty All rights reserved.
//
//  For full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "AKSystemInfo.h"

#pragma mark - // DEFINITIONS (Private) //

@implementation AKSystemInfo

#pragma mark - // SETTERS AND GETTERS //

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

+ (float)iOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)isRetina
{
    if ([UIScreen mainScreen].scale > 1.0) return YES;
    else return NO;
}

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

@end