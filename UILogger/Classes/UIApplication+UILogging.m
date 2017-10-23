//
//  UIApplication+UILogging.m
//  UI Logging
//
//  Created by Bogdan Pashchenko on 2/16/17.
//  Copyright © 2017 Bogdan Pashchenko. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>

#import "UILogHelper.h"

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
    NSString *targetName = NSStringFromClass([target class]);
    NSString *selectorName = NSStringFromSelector(action);
    
    NSString *textInfo = nil;
    UILogItemType type = UILogItemTypeOther;
    
    if ([sender isKindOfClass:[UIButton class]]) {
        textInfo = [sender titleForState:UIControlStateNormal];
        type = UILogItemTypeControlAction;
    }
    if ([sender isKindOfClass:[UIBarItem class]]) {
        textInfo = [sender title];
        type = UILogItemTypeControlAction;
    }
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        textInfo = [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]];
        type = UILogItemTypeControlAction;
    }
    
    if (textInfo != nil) textInfo = [NSString stringWithFormat:@" (%@)", textInfo];
    else textInfo = @"";
    
    id vc = [self nextResponder];
    while(vc != nil) {
        if ([vc isKindOfClass:[UIViewController class]]) break;
        vc = [vc nextResponder];
    }
    NSString *vcClass = vc != nil? NSStringFromClass([vc class]) : nil;
    if (vcClass) vcClass = [NSString stringWithFormat:@" (%@)", vcClass];
    else vcClass = @"";
    
    if (UILogHelper.printToConsole) {
        NSString *log = [NSString stringWithFormat:@"%@ %@%@%@ calling [%@ %@]", [UILogHelper timeSinceLaunchStr], NSStringFromClass([sender class]), textInfo, vcClass, targetName, selectorName];
        printf("UI Log: %s\n", [log UTF8String]);
    }
    
    UILogItem *logItem = [[UILogItem alloc] initWithType:type object:sender title:textInfo indexPath:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:UILogItem.uiLogNotification object:logItem];
    
    return [self xxx_sendAction:action to:target from:sender forEvent:event];
}

@end
