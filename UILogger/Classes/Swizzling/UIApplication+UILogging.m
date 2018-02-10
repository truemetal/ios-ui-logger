//
//  UIApplication+UILogging.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/16/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>
#import <UILogger/UILogger-Swift.h>

@implementation UIApplication (UILogging)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(sendAction:to:from:forEvent:);
        SEL swizzledSelector = @selector(xxx_sendAction:to:from:forEvent:);
        
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

- (BOOL)xxx_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    UILogItem *logItem = [[UIControlActionLogItem alloc] initWithSender:sender target:target selector:action];
    [UILogger postLogItemWithLogItem:logItem];
    return [self xxx_sendAction:action to:target from:sender forEvent:event];
}

@end
