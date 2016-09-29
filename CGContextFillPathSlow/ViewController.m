//
//  ViewController.m
//  CGContextFillPathSlow
//
//  Created by Timothy Reddy on 9/28/16.
//  Copyright © 2016 Timothy Reddy. All rights reserved.
//

#import "ViewController.h"
#import "MapOverlay.h"
#import "MapOverlayRenderer.h"

@interface ViewController () {
    MapOverlay* _mapOverlay;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void)refreshLabel;
@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    _mapOverlay = [[MapOverlay alloc] initWithBoundingRect:MKMapRectWorld delta:40.0];
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.599496, -89.476341), MKCoordinateSpanMake(1, 1))];
    [_mapView addOverlay:_mapOverlay];
    [self refreshLabel];
}

#pragma mark MKOverlayRenderer delegate methods

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MapOverlay class]]) {
        return [[MapOverlayRenderer alloc] initWithOverlay:overlay];
    }
    return nil;
}

#pragma mark Private Methods

-(void)refreshLabel {
    [_label setText:[_mapOverlay message]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshLabel];
    });
}

@end
