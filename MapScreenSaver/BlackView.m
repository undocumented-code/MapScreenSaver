//
//  BlackView.m
//  MapScreenSaver
//
//  Created by Tucker Osman on 8/22/18.
//  Copyright © 2018 Tucker Osman. All rights reserved.
//

#import "BlackView.h"

@implementation BlackView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor blackColor] set];
    [NSBezierPath fillRect:dirtyRect];
}

@end
