//
//  MapOverlayView.m
//  CGContextFillPathSlow
//
//  Created by Timothy Reddy on 9/28/16.
//  Copyright © 2016 Timothy Reddy. All rights reserved.
//

#import <CoreText/CoreText.h>
#import <math.h>
#import "MapOverlayRenderer.h"
#import "MapOverlay.h"

const static int kColorRefsCount = 16;
static CGColorRef colorRefs[kColorRefsCount];

@implementation MapOverlayRenderer

+(void)initialize {
    if (self == [MapOverlayRenderer class]) {
        //create random colors
        double delta = (256.0 / kColorRefsCount) / 256.0;
        for (int i = 0; i < 16; i++) {
            UIColor* color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:i * delta];
            colorRefs[i] = CGColorRetain([color CGColor]);
        }
    }
}

-(void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    NSDate* startDate = [NSDate date];
    
    MapOverlay* mapOverlay = [self overlay];
    double delta = mapRect.size.width / [mapOverlay delta];
    
    //Simulate the typical fill path count we have for each tile
    CGContextBeginPath(context);
    
    MKMapPoint origin = mapRect.origin;
    MKMapPoint max = MKMapPointMake(mapRect.origin.x + mapRect.size.width, mapRect.origin.y + mapRect.size.height);
    for (double x = origin.x; x < max.x; x += delta) {
        for (double y = origin.y; y < max.y; y += delta) {
            CGContextSetFillColorWithColor(context, colorRefs[arc4random() % kColorRefsCount]);
            CGContextMoveToPoint(context, x, y);
            CGContextAddLineToPoint(context, x, y + delta);
            CGContextAddLineToPoint(context, x + delta, y + delta);
            CGContextAddLineToPoint(context, x + delta, y);
            CGContextClosePath(context);
            CGContextFillPath(context);
        }
    }
    CGContextSetLineWidth(context, 1.0/zoomScale);
    CGContextSetStrokeColorWithColor(context, [[UIColor yellowColor] CGColor]);
    CGContextStrokeRect(context, [self rectForMapRect:mapRect]);
    
    NSDate* endDate = [NSDate date];
    dispatch_async(dispatch_get_main_queue(), ^{
        [mapOverlay accumulate:[endDate timeIntervalSince1970] - [startDate timeIntervalSince1970]];
    });
}

@end
