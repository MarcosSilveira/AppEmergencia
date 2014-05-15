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
@property (weak, nonatomic) IBOutlet UIButton *Op1;
@property (weak, nonatomic) IBOutlet UIButton *op0;

@end
