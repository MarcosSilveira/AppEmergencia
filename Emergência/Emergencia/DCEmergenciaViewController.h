//
//  DCEmergenciaViewController.h
//  Emergencia
//
//  Created by Acácio Veit Schneider on 24/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCConfigs.h"
#import "DCMapasViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface DCEmergenciaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *countryNames;
@property (strong, nonatomic) NSArray *exchangeRates;
@property (strong,nonatomic) DCConfigs *configs;
@property (nonatomic) CLLocationCoordinate2D coordenada;

@property CLLocationManager *gerenciadorLocalizacao;
-(void)handleNotification;
@end
