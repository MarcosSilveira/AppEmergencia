//
//  ViewController.h
//  LocationTest
//
//  Created by Marcos Sokolowski on 23/01/14.
//  Copyright (c) 2014 Marcos Sokolowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *Map1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TIpo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TipoMapa;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *OndeEstou;
-(void)registerRegionWithCircularOverlay:(MKCircle*) overlay andIdentifier:(NSString*)identifier;
@property (strong, nonatomic)CLCircularRegion *cr;
@end
