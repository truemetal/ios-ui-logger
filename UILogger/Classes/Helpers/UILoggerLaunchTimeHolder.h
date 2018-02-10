//
//  UILoggerLaunchTimeHolder.h
//  UILogger
//
//  Created by Dan Pashchenko on 2/10/18.
//

#import <Foundation/Foundation.h>

@interface UILoggerLaunchTimeHolder : NSObject
+ (NSDate * _Nonnull) launchTime;
+ (NSString * _Nonnull) appUptime;
@end
