//
//  MapOverlay.h
//  CGContextFillPathSlow
//
//  Created by Timothy Reddy on 9/28/16.
//  Copyright © 2016 Timothy Reddy. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapOverlay : NSObject <MKOverlay>
@property (assign, nonatomic, readonly) double delta;

-(instancetype)initWithBoundingRect:(MKMapRect)rect delta:(double)delta;

-(void)accumulate:(NSTimeInterval)timeInterval;

-(NSString*)message;

@end
