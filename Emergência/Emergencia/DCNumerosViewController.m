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
    if (_veioDaSegue){}
    
    else{
        self.navigationItem.hidesBackButton = YES;
        _veioDaSegue = NO;
    }
    
    [_op0 setImage:[UIImage imageNamed:@"ambulancia.png"] forState:UIControlStateNormal];
    [_op1 setImage:[UIImage imageNamed:@"taxi.png"] forState:UIControlStateNormal];
    [_op2 setImage:[UIImage imageNamed:@"taxi.png"] forState:UIControlStateNormal];
    [_op3 setImage:[UIImage imageNamed:@"taxi.png"] forState:UIControlStateNormal];
    [_op4 setImage:[UIImage imageNamed:@"taxi.png"] forState:UIControlStateNormal];
    [_op5 setImage:[UIImage imageNamed:@"taxi.png"] forState:UIControlStateNormal];
}
- (IBAction)clicouOp0:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:192"]];
}
- (IBAction)clicouOp1:(id)sender {
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:190"]];
}
- (IBAction)clicouOp2:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:193"]];
}

- (IBAction)clicouOp3:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:194"]];
}

- (IBAction)clicouOp4:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:191"]];
}

- (IBAction)clicouOp5:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:199"]];
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
