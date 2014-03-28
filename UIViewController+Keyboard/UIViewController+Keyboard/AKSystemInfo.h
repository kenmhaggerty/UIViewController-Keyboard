//
//  AKSystemInfo.h
//  UIViewController+Keyboard
//
//  Created by Ken M. Haggerty on 11/11/13.
//  Copyright (c) 2013 Ken M. Haggerty All rights reserved.
//
//  For full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <Foundation/Foundation.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

@interface AKSystemInfo : NSObject
+ (float)iOSVersion;
+ (CGSize)screenSize;
+ (BOOL)isRetina;
@end