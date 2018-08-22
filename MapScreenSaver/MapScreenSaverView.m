//
//  MapScreenSaverView.m
//  MapScreenSaver
//
//  Created by Tucker Osman on 8/21/18.
//  Copyright © 2018 Tucker Osman. All rights reserved.
//

#import "MapScreenSaverView.h"
#import <MapKit/MapKit.h>

@implementation MapScreenSaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.frame];
    [self addSubview:mapView];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
