//
//  UIViewController+UILogging.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/16/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>

#import "UILogHelper.h"


@implementation UIViewController (UILogging)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(xxx_viewDidAppear:);
        
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
    });
}

#pragma mark - Method Swizzling

- (void)xxx_viewDidAppear:(BOOL)animated {
    NSString *title1 = self.title;
    NSString *title2 = self.navigationItem.title;
    NSString *title;
    
    if (title1 != nil && title2 != nil) {
        if ([title1 isEqualToString:title2]) title = title1;
        else title = [NSString stringWithFormat:@"%@ / %@", title1, title2];
    }
    else {
        if (title1 != nil) title = title1;
        if (title2 != nil) title = title2;
    }
    
    if (title != nil) title = [NSString stringWithFormat:@" (%@)", title];
    else title = @"";
    
    if (UILogHelper.printToConsole) {
        NSString *log = [NSString stringWithFormat:@"%@ viewDidAppear for %@%@", [UILogHelper timeSinceLaunchStr], NSStringFromClass([self class]), title];
        printf("UI Log: %s\n", [log UTF8String]);
    }
    
    UILogItem *logItem = [[UILogItem alloc] initWithType:UILogItemTypeViewControllerDidAppear object:self title:title indexPath:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:UILogItem.uiLogNotification object:logItem];
    
    [self xxx_viewDidAppear:animated];
}

@end
