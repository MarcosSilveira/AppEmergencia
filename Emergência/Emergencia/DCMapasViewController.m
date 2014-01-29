//
//  DCMapasViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 29/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCMapasViewController.h"

@interface DCMapasViewController ()

@end

@implementation DCMapasViewController{
    
    CLLocationManager *gerenciadorLocalizacao;
    MKPointAnnotation *ondeEstouAnotacao;
    MKPointAnnotation *saoLucasPucrs;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [gerenciadorLocalizacao startUpdatingLocation];
    [self OndeEstouAction:NULL];
    
}

- (IBAction)OndeEstouAction:(UIBarButtonItem *)sender {
    if ([CLLocationManager locationServicesEnabled])
    {
        //estou verificando se ja existe um location manager alocado
        if (gerenciadorLocalizacao == nil)
        {
            //caso nao exista eu crio um
            gerenciadorLocalizacao = [[CLLocationManager alloc] init];
            //objetos da classe CLLocationManager entregam as informacoes sobre a localizacao desejada por delegate
            gerenciadorLocalizacao.delegate = self;
        }
        //solicitando que o locationManager inicie o trabalho de monitorar a localizacao e chamar os metodos delegate nesta classe que foi protocolocada com  CLLocationManagerDelegate (.h)
        
        [gerenciadorLocalizacao startUpdatingLocation];
        
        
    }
    
}
//desenho do raio de busca de locais próximos
- (void)drawRangeRings: (CLLocationCoordinate2D) where {
    // first, I clear out any previous overlays:
    [_Map1 removeOverlays: [_Map1 overlays]];
    float range =1000; //[self.rangeCalc currentRange] / 1609.3;//MILES_PER_METER;
    MKCircle* innerCircle = [MKCircle circleWithCenterCoordinate: where radius: range];
    innerCircle.title = @"Safe Range";
    
    [_Map1 addOverlay: innerCircle];
}

//desenhando e colorindo o raio
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay{
    
    MKCircleRenderer *circleR = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
    circleR.fillColor = [UIColor blueColor];
    circleR.alpha = 0.2;
    
    return circleR;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //centralizar o mapa nesta nova localizacao do usuario
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.001,0.001);
    
    MKCoordinateRegion regiao = MKCoordinateRegionMake(newLocation.coordinate, zoom);
    
    
    [self drawRangeRings:newLocation.coordinate];
    
    
    
    //adicionar uma marcacao no mapa
    //criando o pino
    ondeEstouAnotacao = [[MKPointAnnotation alloc] init];
    saoLucasPucrs = [[MKPointAnnotation alloc] init];
    //ao alterar alguma informacao que deve ser exibida
    ondeEstouAnotacao.title = @"Minha localizacao";
    saoLucasPucrs.title = @"Hospital São Lucas";
    // UIView *view = [[UIView alloc] init];
    //view. = @"teste";
    //  saoLucasPucrs.leftCalloutAccessoryView = view;
    
    //onde o pino sera adicionado
    ondeEstouAnotacao.coordinate = newLocation.coordinate;
    CLLocationCoordinate2D saoLucasCoorde =CLLocationCoordinate2DMake(-30.056085,-51.174413);
    saoLucasPucrs.coordinate = (saoLucasCoorde);
    _cr = [[CLCircularRegion alloc] initWithCenter:ondeEstouAnotacao.coordinate
                                            radius:1000
                                        identifier:@"teste"];
    
    
    //busca por informacoes acerca de uma localizacao
    //CLGeocoder ->fazer a codificacao de uma localizacao trazendo informacoes relevantes
    CLGeocoder *meuCodificadorMapas = [[CLGeocoder alloc] init];
    
    //metodo do clgocoder onde passamos uma cllocation e recebemos suas info pelo bloco completionhandler
    [meuCodificadorMapas reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //precisamos garantir que so temos um placemark
        if (placemarks.count == 1)
        {
            //criando um novo placdemark que vai conter  as informacoes do unico placemark contido no vetor de resposta, indice 0
            //ajustar o anotation
            CLPlacemark *infoLocalAtual = [[CLPlacemark alloc] initWithPlacemark:[placemarks objectAtIndex:0]];
            
            ondeEstouAnotacao.title = infoLocalAtual.thoroughfare;
            ondeEstouAnotacao.subtitle = infoLocalAtual.administrativeArea;
            _cr = [[CLCircularRegion alloc] init];
            
            
            //adiciona o pino no mapa
            [_Map1 addAnnotation:ondeEstouAnotacao];
            [_Map1 addAnnotation: saoLucasPucrs];
            _Map1.showsPointsOfInterest = YES;
            
        }
        else
        {
            //tratar situacao onde temos mais de um placemark
            //exemplo:exibir uma lista para o usuario para que ele escolha a informacao
        }
    }];
    
    
    [_Map1 setRegion:regiao animated:YES];
    
    
    //parando a leitura do GPS
    [gerenciadorLocalizacao stopUpdatingLocation];
    
}
//liga ou desliga o modo "me siga"
- (IBAction)follow:(id)sender {
    if(_Map1.userTrackingMode == NO)
        _Map1.userTrackingMode = YES;
    
    else
        _Map1.userTrackingMode = NO;
}

//definição do tipo de mapa exibido
- (IBAction)TipoMapaAcao:(id)sender {
    if (_TipoMapa.selectedSegmentIndex == 0)
    {
        _Map1.mapType = MKMapTypeStandard;
    }
    else if (_TipoMapa.selectedSegmentIndex == 1)
    {
        _Map1.mapType = MKMapTypeHybrid;
    }
    else if (_TipoMapa.selectedSegmentIndex == 2)
    {
        _Map1.mapType = MKMapTypeSatellite;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
