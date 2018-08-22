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

MKMapView* mapView;
MKMapCamera* mapCamera;
CLLocationCoordinate2D currentCenter;
bool animating = false; //animation mutex
double x = 0;

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    mapView = [[MKMapView alloc] initWithFrame:self.frame];
    [mapView setMapType:MKMapTypeSatelliteFlyover];
    mapView.delegate = self;
    [self addSubview:mapView];
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    NSString *location = @"Eiffel Tower, France";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     animating = true;
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         currentCenter = placemark.region.center;
                     }
                 }
     ];
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
    x+=0.02;
    mapCamera = nil;
    mapCamera = [[MKMapCamera alloc] init];
    [mapCamera setPitch:75];
    [mapCamera setCenterCoordinate:currentCenter];
    [mapCamera setAltitude: 400];
    [mapCamera setHeading:x];
    
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

- (void)mapView:(MKMapView *)mapView
regionDidChangeAnimated:(BOOL)animated {
    if(animated) animating = false;
}

@end
