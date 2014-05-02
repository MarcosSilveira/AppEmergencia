//
//  DCConfirmaViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 23/04/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCConfirmaViewController.h"
#import "DCPosto.h"
#import "DCConfigs.h"
#import "TLAlertView.h"

@interface DCConfirmaViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *TipoMapa;
@property (weak, nonatomic) IBOutlet MKMapView *Map1;

@property (nonatomic) DCConfigs *config;


@end

@implementation DCConfirmaViewController{
    MKPointAnnotation *novoLocal;
    CLLocationManager *gerenciadorLocalizacao;
}


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
    // Do any additional setup after loading the view.
    gerenciadorLocalizacao = [[CLLocationManager alloc]init];
    gerenciadorLocalizacao.delegate = self;
    [gerenciadorLocalizacao startUpdatingLocation];
    novoLocal = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordAux;
    coordAux = CLLocationCoordinate2DMake(_postoaux.lat, _postoaux.log);
    novoLocal.coordinate = coordAux;
    novoLocal.title = _postoaux.nome;
    
    _Map1.showsPointsOfInterest = YES;
    
    
    
    [_Map1 addAnnotation:novoLocal];
    self.config=[[DCConfigs alloc] init];
    
    
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:_Map1];
    CLLocationCoordinate2D coordAux;
    coordAux = CLLocationCoordinate2DMake(location.x, location.y);
    novoLocal.coordinate = coordAux;
    [_Map1 addAnnotation:novoLocal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clicouTipoDeMapa:(id)sender {
    
    if (_TipoMapa.selectedSegmentIndex == 0) {
        _Map1.mapType = MKMapTypeStandard;
    } else if (_TipoMapa.selectedSegmentIndex == 1) {
        _Map1.mapType = MKMapTypeHybrid;
    } else if (_TipoMapa.selectedSegmentIndex == 2) {
        _Map1.mapType = MKMapTypeSatellite;
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.015,0.015);
    
    MKCoordinateRegion regiao = MKCoordinateRegionMake(novoLocal.coordinate, zoom);
    
    [_Map1 setRegion:regiao animated:YES];
}
- (IBAction)clicouConfirma:(id)sender {
    DCPosto *posto = _postoaux;
    
    if(posto.isOk){

        NSString *urlServidor =[NSString stringWithFormat: @"http://%@:8080/Emergencia/cadastrarUnidade.jsp?lat=%f&log=%f&nome=%@&tel=%@&endereco=%@",self.config.ip,posto.lat,posto.log,posto.nome,posto.telefone,posto.endereco];
        
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Ok" message:@"Cadastro efetuado com sucesso" buttonTitle:@"OK"];
                    [alertView show];
                }
                               );
                
                //[self performSegueWithIdentifier:@"cadtoInicial" sender:sender];
            }else{
                //ERRO
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Cadastro não efetuado" buttonTitle:@"OK"];
                    [alertView show];
                });
            }
            
        }else{
            //ERRO
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Cadastro não efetuado" buttonTitle:@"OK"];
                [alertView show];
            } );
            
        }
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Campos em Branco" buttonTitle:@"OK"];
            [alertView show];
        });
    
    }
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
