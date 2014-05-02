//
//  DCInicialViewController.h
//  Emergencia
//
//  Created by Acácio Veit Schneider on 23/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCMapasViewController.h"
#import "DCConfigs.h"
@interface DCInicialViewController : UIViewController

@property NSMutableArray *listaContatos;
@property (nonatomic)CLLocationCoordinate2D coordenada;

@property (nonatomic) DCConfigs *config;

- (IBAction)btLogOut;
-(void)handleNotification;

@end
