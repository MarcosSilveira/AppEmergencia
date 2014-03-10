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

@interface DCNovoHospitalViewController ()
@property (weak, nonatomic) IBOutlet UITextField *FDNome;
@property (weak, nonatomic) IBOutlet UITextField *FDTelefone;
@property (weak, nonatomic) IBOutlet UITextField *FDLat;
@property (weak, nonatomic) IBOutlet UITextField *FDLong;
@property (weak, nonatomic) IBOutlet UITextField *FDEndereco;


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
    
    _FDLat.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    _FDLong.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    
    
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
    

    if(self.posto.isOk){
        NSString *urlServidor =[NSString stringWithFormat: @"http://%@:8080/Emergencia/cadastrarUnidade.jsp?lat=%f&log=%f&nome=%@&tel=%@&endereco=%@",self.config.ip,self.posto.lat,self.posto.log,self.posto.nome,self.posto.telefone,self.posto.endereco];
        
        urlServidor=[urlServidor stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *urs=[[NSURL alloc] initWithString:urlServidor];
        NSData* data = [NSData dataWithContentsOfURL:
                        urs];
        
        if(data!=nil){
            
            NSError *jsonParsingError = nil;
            NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            
            NSNumber *res=[resultado objectForKey:@"cadastro"];
            
            NSNumber *teste=[[NSNumber alloc] initWithInt:1];
            
            
            if([res isEqualToNumber:teste]){
                //OK
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Ok" message:@"Cadastro efetuado com sucesso" buttonTitle:@"OK"];
                [alertView show];
                //[self performSegueWithIdentifier:@"cadtoInicial" sender:sender];
            }else{
                //ERRO
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Cadastro não efetuado" buttonTitle:@"OK"];
                [alertView show];
            }
            
        }else{
            //ERRO
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Cadastro não efetuado" buttonTitle:@"OK"];
            [alertView show];
        }

    }else{
        TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Campos em Branco" buttonTitle:@"OK"];
        [alertView show];
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
    if([_FDNome.text isEqualToString:@""]){
        NSLog(@"Em branco");
        _FDNome.backgroundColor = cor;
    
    }
}
- (IBAction)ClicouSobre:(id)sender {
    
    UIAlertView *sobre = [[UIAlertView alloc] initWithTitle:@"Ajude a melhorar o emergência!" message:@"Nesta tela você pode adicionar novos locais que possuam serviços de emergencia para que estes sejam adicionados ao aplicativo, todos os envios estão sujeitos a aprovação. Os campos com '*'são de preenchimento obrigatório."delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [sobre show];
}

@end
