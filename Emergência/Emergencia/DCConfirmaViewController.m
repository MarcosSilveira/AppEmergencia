//
//  DCConfirmaViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 23/04/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCConfirmaViewController.h"
#import "DCPosto.h"

@interface DCConfirmaViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *TipoMapa;
@property (weak, nonatomic) IBOutlet MKMapView *Map1;


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
    
    MKCoordinateRegion regiao = MKCoordinateRegionMake(newLocation.coordinate, zoom);
    
    [_Map1 setRegion:regiao animated:YES];
}
- (IBAction)clicouConfirma:(id)sender {
    
    
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
