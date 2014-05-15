//
//  DCNumerosViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 12/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCNumerosViewController.h"

@implementation DCNumerosViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    
    [_op0 setImage:[UIImage imageNamed:@"ambulancia.png"] forState:UIControlStateNormal];
    [_Op1 setImage:[UIImage imageNamed:@"taxi.png"] forState:UIControlStateNormal];
}
- (IBAction)clicouOp0:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:192"]];
    
}


- (IBAction)clicouOp1:(id)sender {
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:190"]];
}

//slide menu
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}
@end
