//
//  DCDetalhesHospitalTableViewController.h
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 15/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPosto.h"

@interface DCDetalhesHospitalTableViewController : UITableViewController

@property (strong, nonatomic) DCPosto *postos;
@property (strong, nonatomic) NSMutableArray *detalhePosto;

@end
