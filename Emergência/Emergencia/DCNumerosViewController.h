//
//  DCNumerosViewController.h
//  Emergencia
//
//  Created by Marcos Sokolowski on 12/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface DCNumerosViewController : UIViewController<SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *op1;
@property (weak, nonatomic) IBOutlet UIButton *op0;
@property (weak, nonatomic) IBOutlet UIButton *op3;
@property (weak, nonatomic) IBOutlet UIButton *op2;
@property (weak, nonatomic) IBOutlet UIButton *op4;
@property (weak, nonatomic) IBOutlet UIButton *op5;

@end
