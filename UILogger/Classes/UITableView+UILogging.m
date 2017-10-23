//
//  UITableView+UILogging.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/16/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>

#import "UILogHelper.h"


@implementation UITableView (UILogging)

+ (void)load {
    Class class = [self class];
    
    SEL originalSelector = NSSelectorFromString(@"_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:");
    SEL swizzledSelector = @selector(swizzle_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void) swizzle_selectRowAtIndexPath:(NSIndexPath *)indexPath
                             animated:(BOOL) animated
                       scrollPosition:(unsigned int)scrollPosition
                       notifyDelegate:(BOOL)notifyDelegate
{
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if (cell != nil) {
        NSString *cellClass = NSStringFromClass([cell class]);
        NSString *indexPathStr = [NSString stringWithFormat:@"%zd, %zd", [indexPath section], [indexPath item]];
        
        id vc = [self nextResponder];
        while(vc != nil) {
            if ([vc isKindOfClass:[UIViewController class]]) break;
            vc = [vc nextResponder];
        }
        NSString *vcClass = vc != nil? NSStringFromClass([vc class]) : nil;
        
        NSString *tableText = cell.textLabel.text;
        if (tableText != nil) tableText = [NSString stringWithFormat:@": %@", tableText];
        else tableText = @"";
        
        if (UILogHelper.printToConsole) {
            NSString *log = [NSString stringWithFormat:@"%@ Did select table cell (%@%@) %@ selected", [UILogHelper timeSinceLaunchStr], indexPathStr, tableText, cellClass];
            if (vcClass != nil)
                log = [log stringByAppendingFormat:@" from %@", vcClass];
            
            printf("UI Log: %s\n", [log UTF8String]);
        }
        
        UILogItem *logItem = [[UILogItem alloc] initWithType:UILogItemTypeTableCellTap object:cell title:tableText indexPath:indexPath];
        [[NSNotificationCenter defaultCenter] postNotificationName:UILogItem.uiLogNotification object:logItem];
    }
    
    [self swizzle_selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition notifyDelegate:notifyDelegate];
}

@end
