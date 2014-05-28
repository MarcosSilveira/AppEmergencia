//
//  DCAjudaTableViewController.h
//  Emergencia
//
//  Created by Marcos Sokolowski on 28/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface DCAjudaTableViewController : UITableViewController<SlideNavigationControllerDelegate>
@property (nonatomic) UIImageView *image;
@property (nonatomic) UIView *imagem;

@end
