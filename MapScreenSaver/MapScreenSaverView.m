//
//  MapScreenSaverView.m
//  MapScreenSaver
//
//  Created by Tucker Osman on 8/21/18.
//  Copyright © 2018 Tucker Osman. All rights reserved.
//

#import "MapScreenSaverView.h"
#import "BlackView.h"
#import <MapKit/MapKit.h>

@implementation MapScreenSaverView

MKMapView* mapView; //the map
MKMapCamera* mapCamera; //how we look at it
CLLocationCoordinate2D currentCenter; //center of map
FadeState fadeState = noFade; //fade animator state
double heading = 0; //direction of camera
BlackView * blackView;

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    
    mapView = [[MKMapView alloc] initWithFrame:frame];
    [mapView setMapType:MKMapTypeSatelliteFlyover];
    
    blackView = [[BlackView alloc] initWithFrame:self.frame];
    blackView.alphaValue = 1;
    
    [self addSubview:mapView];
    [mapView addSubview:blackView];
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    NSString *location = @"Eiffel Tower, France";
    [self setCenterTo:location];
    [NSTimer  scheduledTimerWithTimeInterval:15.0
              repeats:YES
              block:^(NSTimer* timer){
                  fadeState = fadeOut;
              }];
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
    switch (fadeState) {
        case fadeOut:
            if (blackView.alphaValue >= 1) {
                fadeState = noFade;
                [self nextLandmark];
            } else {
                blackView.alphaValue += 0.05;
            }
            break;
        case fadeIn:
            if (blackView.alphaValue <= 0) {
                fadeState = noFade;
            }
            else{
                blackView.alphaValue -= 0.05;
            }
            break;
        case noFade:
            break;
    }
    heading += 0.02;
    mapCamera = nil;
    mapCamera = [[MKMapCamera alloc] init];
    [mapCamera setPitch:75];
    [mapCamera setCenterCoordinate:currentCenter];
    [mapCamera setAltitude:400];
    [mapCamera setHeading:heading];
    
    [mapView setCamera:mapCamera animated:NO];
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

- (void) nextLandmark
{
    [self setCenterTo:@"350 5th Ave, New York, NY 10118"];
}

- (void)setCenterTo:(NSString*)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location completionHandler:^(NSArray* placemarks, NSError* error){
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
            currentCenter = placemark.region.center;
        }
        fadeState = fadeIn;
    }];
}

@end
