//
//  UILogHelper.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/17/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

#import "UILogHelper.h"

static NSDate *_launchTime;
static BOOL _printToConsole = true;

@implementation UILogHelper

+ (void)load {
    _launchTime = [NSDate new];
}

+ (NSString *) timeSinceLaunchStr {
    return [NSString stringWithFormat:@"%.3fs", [[NSDate new] timeIntervalSinceDate:_launchTime]];
}

+ (BOOL)printToConsole { return _printToConsole; }
+ (void)setPrintToConsole:(BOOL)printToConsole { _printToConsole = printToConsole; }

@end

#pragma mark -

@implementation UILogItem
@synthesize timestamp, object, title, indexPath;

+ (NSNotificationName) uiLogNotification { return @"uiLogNotification"; }

- (instancetype _Nonnull) initWithType:(UILogItemType)type
                                object:(NSObject * _Nonnull)object
                                 title:(NSString * _Nullable)title
                             indexPath:(NSIndexPath * _Nullable)indexPath
{
    self = [super init];
    self.type = type;
    self.timestamp = [NSDate new];
    self.object = object;
    self.title = title;
    self.indexPath = indexPath;
    return self;
}

@end
