//
//  DCConfirmaViewController.h
//  Emergencia
//
//  Created by Marcos Sokolowski on 23/04/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "DCPosto.h"

@interface DCConfirmaViewController : UIViewController<MKMapViewDelegate>
@property  DCPosto *postoaux;

@end
