//
//  UITableView+UILogging.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/16/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>
#import <UILogger/UILogger-Swift.h>


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
    UILogItem *logItem = [[UITableOrCollectionViewSelectedCellLogItem alloc] initWithTableView:self indexPath:indexPath];
    if (logItem != nil) [UILogger postLogItemWithLogItem:logItem];
    [self swizzle_selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition notifyDelegate:notifyDelegate];
}

@end
