//
//  DCNovoHospitalViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 07/03/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCNovoHospitalViewController.h"

@interface DCNovoHospitalViewController ()
@property (weak, nonatomic) IBOutlet UITextField *FDNome;
@property (weak, nonatomic) IBOutlet UITextField *FDTelefone;
@property (weak, nonatomic) IBOutlet UITextField *FDLat;
@property (weak, nonatomic) IBOutlet UITextField *FDLong;
@property (weak, nonatomic) IBOutlet UITextField *FDEndereco;

@end

@implementation DCNovoHospitalViewController
CLLocationManager *gerenciadorLocalizacao;

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
    gerenciadorLocalizacao.delegate = self;
    [gerenciadorLocalizacao startUpdatingLocation];
    _FDNome.delegate = self;
    _FDTelefone.delegate = self;
    _FDLat.delegate = self;
    _FDLong.delegate = self;
    _FDEndereco.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    _FDLat.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    _FDLat.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    
    
}
-(bool)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ClicouEnvia:(id)sender {
    /UIColor
    if([_FDNome.text isEqualToString:@""]){
        NSLog(@"Em branco");
        _FDNome.backgroundColor = [UIColor redColor];
    }
}
- (IBAction)ClicouSobre:(id)sender {
    
    UIAlertView *sobre = [[UIAlertView alloc] initWithTitle:@"Ajude a melhorar o emergência!" message:@"Nesta tela você pode adicionar novos locais que possuam serviços de emergencia para que estes sejam adicionados ao aplicativo, todos os envios estão sujeitos a aprovação. Os campos com '*'são de preenchimento obrigatório."delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [sobre show];
}

@end
