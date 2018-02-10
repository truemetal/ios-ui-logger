//
//  UILoggerLaunchTimeHolder.m
//  UILogger
//
//  Created by Dan Pashchenko on 2/10/18.
//

#import "UILoggerLaunchTimeHolder.h"

static NSDate *_launchTime;

@implementation UILoggerLaunchTimeHolder
+ (void)load {
    _launchTime = [NSDate new];
}

+ (NSDate *)launchTime { return _launchTime; }

+ (NSString *)appUptime { return [NSString stringWithFormat:@"%.3fs", [[NSDate date] timeIntervalSinceDate:self.launchTime]]; }

@end
