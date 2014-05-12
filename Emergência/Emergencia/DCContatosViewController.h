//
//  DCContatosViewController.h
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 04/02/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationContorllerAnimator.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "DCLeftMenuViewController.h"

@interface DCContatosViewController : UITableViewController <UIAlertViewDelegate, UISearchBarDelegate,SlideNavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *contacts;
@property (nonatomic)DCLeftMenuViewController *left;

@end

