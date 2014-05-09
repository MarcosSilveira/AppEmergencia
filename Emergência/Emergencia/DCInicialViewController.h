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
#import "SlideNavigationContorllerAnimator.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "DCLeftMenuViewController.h"
@interface DCInicialViewController : UIViewController<UITableViewDelegate,SlideNavigationControllerDelegate>

@property NSMutableArray *listaContatos;
@property (nonatomic)CLLocationCoordinate2D coordenada;
@property (nonatomic)UITableViewController *esquerda;
@property (nonatomic)DCLeftMenuViewController *left;
@property (nonatomic) DCConfigs *config;

- (IBAction)btLogOut;
-(void)handleNotification;

@end
