//
//  ScrollViewContainer.m
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "ScrollViewContainer.h"

@implementation ScrollViewContainer

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return _scrollView;
    }
    return view;
}


@end
