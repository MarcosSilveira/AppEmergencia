//
//  DCLeftMenuViewController.h
//  Emergencia
//
//  Created by Marcos Sokolowski on 08/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface DCLeftMenuViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (nonatomic) UIImageView *image;
@property (nonatomic) UIView *imagem;

@end
