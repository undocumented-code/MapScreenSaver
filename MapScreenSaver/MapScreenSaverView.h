//
//  MapScreenSaverView.h
//  MapScreenSaver
//
//  Created by Tucker Osman on 8/21/18.
//  Copyright © 2018 Tucker Osman. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <ScreenSaver/ScreenSaver.h>

typedef enum {
    fadeIn,
    fadeOut,
    noFade
} FadeState;

@interface MapScreenSaverView : ScreenSaverView

@end
