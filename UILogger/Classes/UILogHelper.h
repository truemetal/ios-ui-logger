//
//  UILogHelper.h
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/17/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILogHelper: NSObject
+ (NSString * _Nonnull) timeSinceLaunchStr;
@property (class) BOOL printToConsole;
@end

#pragma mark -

typedef NS_ENUM(NSUInteger, UILogItemType) {
    UILogItemTypeOther,
    UILogItemTypeControlAction,
    UILogItemTypeTableCellTap,
    UILogItemTypeCollectionCellTap,
    UILogItemTypeViewControllerDidAppear
};


@interface UILogItem: NSObject

@property (class, readonly) NSNotificationName _Nonnull uiLogNotification;

- (instancetype _Nonnull) initWithType:(UILogItemType)type
                                object:(NSObject * _Nonnull)object
                                 title:(NSString * _Nullable)title
                             indexPath:(NSIndexPath * _Nullable)indexPath;

@property (nonatomic) UILogItemType type;
@property (nonatomic, strong, nonnull) NSDate *timestamp;
@property (nonatomic, strong, nonnull) NSObject *object;
@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong, nullable) NSIndexPath *indexPath;

@end
