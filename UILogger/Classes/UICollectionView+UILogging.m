//
//  UICollectionView+UILogging.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/16/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>

#import "UILogHelper.h"

@implementation UICollectionView (UILogging)

+ (void)load {
    Class class = [self class];
    
    SEL originalSelector = NSSelectorFromString(@"_selectItemAtIndexPath:animated:scrollPosition:notifyDelegate:");
    SEL swizzledSelector = @selector(swizzle_selectItemAtIndexPath:animated:scrollPosition:notifyDelegate:);
    
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

- (void) swizzle_selectItemAtIndexPath:(NSIndexPath *)indexPath
                              animated:(BOOL) animated
                        scrollPosition:(unsigned int)scrollPosition
                        notifyDelegate:(BOOL)notifyDelegate {
    id cell = [self cellForItemAtIndexPath:indexPath];
    if (cell != nil) {
        NSString *cellClass = NSStringFromClass([cell class]);
        NSString *indexPathStr = [NSString stringWithFormat:@"%zd, %zd", [indexPath section], [indexPath item]];
        
        id vc = [self nextResponder];
        while(vc != nil) {
            if ([vc isKindOfClass:[UIViewController class]]) break;
            vc = [vc nextResponder];
        }
        NSString *vcClass = vc != nil? NSStringFromClass([vc class]) : nil;
        
        if (UILogHelper.printToConsole) {
            NSString *log = [NSString stringWithFormat:@"%@ Did select collection cell (%@) %@ selected", [UILogHelper timeSinceLaunchStr], indexPathStr, cellClass];
            if (vcClass != nil)
                log = [log stringByAppendingFormat:@" from %@", vcClass];
            
            printf("UI Log: %s\n", [log UTF8String]);
        }
        
        UILogItem *logItem = [[UILogItem alloc] initWithType:UILogItemTypeCollectionCellTap object:cell title:nil indexPath:indexPath];
        [[NSNotificationCenter defaultCenter] postNotificationName:UILogItem.uiLogNotification object:logItem];
    }
    
    [self swizzle_selectItemAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition notifyDelegate:notifyDelegate];
}

@end
