//
//  DCNovoHospitalViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 07/03/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCNovoHospitalViewController.h"
#import "DCConfigs.h"
#import "DCPosto.h"
#import "TLAlertView.h"
#import "DCConfirmaViewController.h"

@interface DCNovoHospitalViewController ()
@property (weak, nonatomic) IBOutlet UITextField *FDNome;
@property (weak, nonatomic) IBOutlet UITextField *FDTelefone;
@property (weak, nonatomic) IBOutlet UITextField *FDLat;
@property (weak, nonatomic) IBOutlet UITextField *FDLong;
@property (weak, nonatomic) IBOutlet UITextField *FDEndereco;
@property (weak, nonatomic) IBOutlet UISwitch *usoSwitch;
@property BOOL pegoualoc;


@property (nonatomic) DCConfigs *config;
@property (nonatomic) DCPosto *posto;

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
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Novo local";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.navigationController.navigationBar.alpha = 0.6;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255/255 green: 0/255 blue:0/255 alpha:1];

    
    
    gerenciadorLocalizacao = [[CLLocationManager alloc] init];
    gerenciadorLocalizacao.delegate = self;
    
    [gerenciadorLocalizacao startUpdatingLocation];
    
    self.config=[[DCConfigs alloc] init];
    
    _FDNome.delegate = self;
    _FDTelefone.delegate = self;
    _FDLat.delegate = self;
    _FDLong.delegate = self;
    _FDEndereco.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (_pegoualoc==NO) {
        
    _FDLat.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    _FDLong.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        _pegoualoc= YES;
    }
    
    
}
-(bool)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

-(void)doAdd:(UIButton *)sender{
    self.posto=[[DCPosto alloc] init];
    
    self.posto.nome=self.FDNome.text;
    self.posto.lat=[self.FDLat.text floatValue];
    self.posto.log=[self.FDLong.text floatValue];
    
    self.posto.telefone=self.FDTelefone.text;
    
    self.posto.endereco=self.FDEndereco.text;
    if (self.posto.isOk) {
        [self performSegueWithIdentifier:@"goToConfirma" sender:self];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Campos obrigatórios em branco" buttonTitle:@"OK"];
            [alertView show];
        });
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToConfirma"]) {
        DCConfirmaViewController* dccvc = (DCConfirmaViewController*)segue.destinationViewController;
        dccvc.postoaux = _posto;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ClicouEnvia:(id)sender {
    
    UIColor *cor;
    cor = [[UIColor alloc] initWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f];
    
    [self doAdd:sender];
    
    
    if([_FDNome.text isEqualToString:@""]){
        NSLog(@"Em branco");
        _FDNome.backgroundColor = cor;
    }else{
        _FDNome.backgroundColor = [UIColor whiteColor];
    }
        
            
    if([_FDTelefone.text isEqualToString:@""]){
        NSLog(@"Em branco");
        _FDTelefone.backgroundColor = cor;
   }
    else
        _FDTelefone.backgroundColor = [UIColor whiteColor];
    if([_FDLat.text isEqualToString:@""])
        _FDLat.backgroundColor = cor;
    else
        _FDLat.backgroundColor = [UIColor whiteColor];
    if ([_FDLong.text isEqualToString:@""]) {
        _FDLong.backgroundColor = cor;
    }
    else
        _FDLong.backgroundColor = [UIColor whiteColor];
    
    
}
- (IBAction)ClicouSobre:(id)sender {
    
    UIAlertView *sobre = [[UIAlertView alloc] initWithTitle:@"Ajude a melhorar o emergência!" message:@"Nesta tela você pode adicionar novos locais que possuam serviços de emergencia para que estes sejam adicionados ao aplicativo, todos os envios estão sujeitos a aprovação. Os campos com '*' são de preenchimento obrigatório."delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [sobre show];
}
- (IBAction)trocouUso:(id)sender {
    if (_usoSwitch.on==YES) {
        _FDLat.enabled = YES;
        _FDLong.enabled = YES;
    }
    else{
        _FDLong.enabled = NO;
        _FDLat.enabled = NO;
    }
}
//slideMenudelegate

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}
@end
