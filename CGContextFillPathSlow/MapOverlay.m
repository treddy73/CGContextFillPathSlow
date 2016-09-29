//
//  MapOverlay.m
//  CGContextFillPathSlow
//
//  Created by Timothy Reddy on 9/28/16.
//  Copyright © 2016 Timothy Reddy. All rights reserved.
//

#import "MapOverlay.h"

@interface MapOverlay () {
    NSTimeInterval _accumulatedTimeInterval;
    int _accumulatedCount;
}
@end

@implementation MapOverlay
@synthesize boundingMapRect = _boundingMapRect;
@synthesize coordinate = _coordinate;

-(instancetype)initWithBoundingRect:(MKMapRect)rect delta:(double)delta {
    self = [super init];
    if (self) {
        _boundingMapRect = rect;
        _delta = delta;
    }
    return self;
}

-(void)accumulate:(NSTimeInterval)timeInterval {
    _accumulatedTimeInterval += timeInterval;
    _accumulatedCount++;
}

-(NSString *)message {
    NSTimeInterval average = _accumulatedTimeInterval / _accumulatedCount;
    return [NSString stringWithFormat:@"  count:%d\n  averageTimeInterval:%.3f", _accumulatedCount, average];
}

@end
