//
//  DCDetalhesAjudaViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 28/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCDetalhesAjudaViewController.h"

@interface DCDetalhesAjudaViewController ()

@end

@implementation DCDetalhesAjudaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textoAjuda.text = _texto_auxiliar;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
