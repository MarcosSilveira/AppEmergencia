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
#import "SlideNavigationController.h"

@interface DCInicialViewController : UIViewController<UITableViewDelegate,SlideNavigationControllerDelegate>

@property NSMutableArray *listaContatos;
@property (nonatomic)CLLocationCoordinate2D coordenada;
@property (nonatomic)UITableViewController *esquerda;
@property (nonatomic) DCConfigs *config;


- (IBAction)btLogOut;
-(void)handleNotification;

@end
