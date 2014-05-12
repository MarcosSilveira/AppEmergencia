//
//  DCMapasViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 29/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
// Teste - Marcos

#import "DCMapasViewController.h"
#import "DCConfigs.h"
#import "DCPosto.h"
#import "TLAlertView.h"

@interface DCMapasViewController ()

@property (nonatomic) DCConfigs *conf;
@property (weak, nonatomic) IBOutlet UILabel *LBLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *AILoading;
@property (nonatomic)UIView *aviso;
@end

@implementation DCMapasViewController{
  
  CLLocationManager *gerenciadorLocalizacao;
  MKPointAnnotation *ondeEstouAnotacao;
  MKPointAnnotation *pontoaux;
    MFMessageComposeViewController *mensagem;
    CLAuthorizationStatus *teste;
    MKPointAnnotation *amigo;
    NSMutableArray *locaisAux2;
    NSMutableArray *locaisValidar;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [gerenciadorLocalizacao startUpdatingLocation];
  [self OndeEstouAction:NULL];
  self.conf=[[DCConfigs alloc] init];
  pontoaux = [[MKPointAnnotation alloc] init];
    _AILoading.hidesWhenStopped = YES;
    _LBLoading.hidden = YES;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"]) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults] objectForKey:@"lat"] doubleValue], [[[NSUserDefaults standardUserDefaults] objectForKey:@"log"]doubleValue]);
        self.coordenada = coord;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"pushOn"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"log"];
    }
  if (self.raio == 0) {
    self.raio = 1;
  }
    if(self.raio > 150){
        self.raio = 150;
        TLAlertView *alerta = [[TLAlertView alloc]initWithTitle:@"Tamanho máximo do raio" message:@"O tamanho máximo do raio de busca é 150Km, o raio exibido será deste tamanho." buttonTitle:@"OK"];
        alerta.show;
    }
  
  self.raio = self.raio * 1000;
   
    if(self.coordenada.latitude !=0 && self.coordenada.longitude !=0){
        
        amigo = [[MKPointAnnotation alloc] init];
        amigo.coordinate = self.coordenada;
        amigo.title = @"Amigo";
        amigo.subtitle = @"Localização do pedido de ajuda";
        [_Map1 addAnnotation:amigo];
    }
    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"]){
        BOOL push = NO;
        NSNumber *push2 = [[NSNumber alloc] initWithBool:push];
        amigo = [[MKPointAnnotation alloc] init];
        NSNumber *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
        NSNumber *longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"log"];
        
        amigo.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
        amigo.title = @"Amigo";
        amigo.subtitle = @"Localização do pedido de ajuda";
        [_Map1 addAnnotation:amigo];
        [[NSUserDefaults standardUserDefaults] setObject:push2 forKey:@"pushOn"];
        
    }
    
    _aviso = [[UIView alloc]initWithFrame:CGRectMake(_LBLoading.frame.origin.x,_LBLoading.frame.origin.y-50, 180, 80)];
    UIColor *cor = [[UIColor alloc]initWithRed:0.2 green:0.45 blue:0.9 alpha:0.7];
    _aviso.backgroundColor = cor;
    _aviso.layer.cornerRadius = 15;
    _aviso.layer.masksToBounds = YES;
    _aviso.hidden = YES;
    
    
    
    
}



-(NSMutableArray *) buscar:(CLLocation*) loc{
   NSNumber *prio = @1;
    float lats, longi, raio;
     lats =loc.coordinate.latitude;
    longi =loc.coordinate.longitude;
    raio = self.raio;
    
    
  NSMutableArray *locais = [[NSMutableArray alloc] init];
  
  NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/novaBusca.jsp?lat=%f&log=%f&tipo='lol'&prioridade=%@&raio=%f",self.conf.ip,lats,longi,prio,self.raio];
  
  
  
  NSURL *urs = [[NSURL alloc] initWithString:ur];
  NSData* data = [NSData dataWithContentsOfURL:urs];
  
  //retorno
  if (data != nil) {
    
    NSError *jsonParsingError = nil;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
    
    //OBjeto Array
    
    NSArray *res = [resultado objectForKey:@"Locais"];
    
    NSDictionary *objo;
    for (int i = 0; i < res.count; i++) {
      
      DCPosto *posto = [[DCPosto alloc] init];
      objo = [res objectAtIndex:i];
      
      posto.lat = [[objo objectForKey:@"latitude"] floatValue];
      posto.log = [[objo objectForKey:@"longitude"] floatValue];
      posto.nome = [objo objectForKey:@"nome"];
      posto.endereco = [objo objectForKey:@"endereco"];
        posto.validar=NO;
      
      [locais addObject:posto];
    }
  }
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:locais waitUntilDone:NO];
    if (data != nil) {
        
    
        
    
    
    [_AILoading stopAnimating];
        _LBLoading.hidden = YES;
        _aviso.hidden = YES;}
    
  return locais;
}

-(NSMutableArray *) buscarValidar:(CLLocation*) loc{
    NSNumber *prio = @1;
    float lats, longi, raio;
    lats =loc.coordinate.latitude;
    longi =loc.coordinate.longitude;
    raio = self.raio;
    
    
    NSMutableArray *locais = [[NSMutableArray alloc] init];
    
    NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/hospitaisValidar.jsp?lat=%f&log=%f&tipo='lol'&prioridade=%@&raio=%f",self.conf.ip,lats,longi,prio,self.raio];
    
    
    
    NSURL *urs = [[NSURL alloc] initWithString:ur];
    NSData* data = [NSData dataWithContentsOfURL:urs];
    
    //retorno
    if (data != nil) {
        
        NSError *jsonParsingError = nil;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        //OBjeto Array
        
        NSArray *res = [resultado objectForKey:@"Locais"];
        
        NSDictionary *objo;
        for (int i = 0; i < res.count; i++) {
            
            DCPosto *posto = [[DCPosto alloc] init];
            objo = [res objectAtIndex:i];
            
            posto.lat = [[objo objectForKey:@"latitude"] floatValue];
            posto.log = [[objo objectForKey:@"longitude"] floatValue];
            posto.nome = [objo objectForKey:@"nome"];
            posto.endereco = [objo objectForKey:@"endereco"];
            
            posto.cod=[objo objectForKey:@"idlocaisAprovar"];
            posto.validar=YES;
            
            [locaisValidar addObject:posto];
        }
    }
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:locais waitUntilDone:NO];
    [_AILoading stopAnimating];
    _LBLoading.hidden = YES;
    
    return locais;
}





-(void)updateUI:(NSMutableArray *)locaisAux
{
    locaisAux2 = locaisAux;

    
    NSMutableArray *postos = locaisAux2;
    for (int i  = 0; i < postos.count; i++) {
        
        pontoaux = [[MKPointAnnotation alloc] init];
        DCPosto *postoaux = postos[i];
        
        pontoaux.title = postoaux.nome;
        CLLocationCoordinate2D coordenada = CLLocationCoordinate2DMake(postoaux.lat, postoaux.log);
        pontoaux.coordinate = coordenada;
        pontoaux.subtitle = postoaux.endereco;
        [_Map1 addAnnotation:pontoaux];
    }

    
}




- (IBAction)OndeEstouAction:(UIBarButtonItem *)sender {

    
  
  if ([CLLocationManager locationServicesEnabled]) {
    //estou verificando se ja existe um location manager alocado
    if (gerenciadorLocalizacao == nil) {
      
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
  
  float range = self.raio; //[self.rangeCalc currentRange] / 1609.3;//MILES_PER_METER;
  MKCircle* innerCircle = [MKCircle circleWithCenterCoordinate: where radius: range];
  innerCircle.title = @"Safe Range";
  
  [_Map1 addOverlay: innerCircle];
}

//desenhando e colorindo o raio
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
  
  MKCircleRenderer *circleR = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
  circleR.fillColor = [UIColor blueColor];
  circleR.alpha = 0.2;
  
  return circleR;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
  
  //centralizar o mapa nesta nova localizacao do usuario
  MKCoordinateSpan zoom = MKCoordinateSpanMake(0.015,0.015);
  
  MKCoordinateRegion regiao = MKCoordinateRegionMake(newLocation.coordinate, zoom);
//    [self performSelectorInBackground:@selector(buscar:newLocation.coordinate.latitude withlongitude:newLocation.coordinate.longitude withraioMeters:raio withPriority:@1) withObject:nil];
    [_AILoading startAnimating];
    _LBLoading.hidden = NO;
    [self.view addSubview:_aviso];
    _aviso.hidden = NO;
    
    [self performSelectorInBackground:@selector(buscar:) withObject:newLocation];
    [self performSelectorInBackground:@selector(buscarValidar:) withObject:newLocation];

    NSMutableArray *postos = locaisAux2;
  for (int i  = 0; i < postos.count; i++) {
    
    pontoaux = [[MKPointAnnotation alloc] init];
    DCPosto *postoaux = postos[i];
    
    pontoaux.title = postoaux.nome;
    CLLocationCoordinate2D coordenada = CLLocationCoordinate2DMake(postoaux.lat, postoaux.log);
    pontoaux.coordinate = coordenada;
    pontoaux.subtitle = postoaux.endereco;
    [_Map1 addAnnotation:pontoaux];
  }
  
  [self drawRangeRings:newLocation.coordinate];
  
 
    //busca por informacoes acerca de uma localizacao
  //CLGeocoder ->fazer a codificacao de uma localizacao trazendo informacoes relevantes
  CLGeocoder *meuCodificadorMapas = [[CLGeocoder alloc] init];
  
  //metodo do clgocoder onde passamos uma cllocation e recebemos suas info pelo bloco completionhandler
  [meuCodificadorMapas reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
    //precisamos garantir que so temos um placemark
    if (placemarks.count == 1) {
      
      //criando um novo placdemark que vai conter  as informacoes do unico placemark contido no vetor de resposta, indice 0
      //ajustar o anotation
      CLPlacemark *infoLocalAtual = [[CLPlacemark alloc] initWithPlacemark:[placemarks objectAtIndex:0]];
      
      ondeEstouAnotacao.title = infoLocalAtual.thoroughfare;
      ondeEstouAnotacao.subtitle = infoLocalAtual.administrativeArea;
      _cr = [[CLCircularRegion alloc] init];
      
      //adiciona o pino no mapa
      _Map1.showsPointsOfInterest = YES;
    }
    //TODO: tratar situacao onde temos mais de um placemark
    //exemplo:exibir uma lista para o usuario para que ele escolha a informacao
  }];
  
  
  [_Map1 setRegion:regiao animated:YES];
  
  //parando a leitura do GPS
  [gerenciadorLocalizacao stopUpdatingLocation];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
    CLLocationCoordinate2D coordAux = [annotation coordinate];
    if(coordAux.latitude == amigo.coordinate.latitude && coordAux.longitude == amigo.coordinate.longitude){
        MKPinAnnotationView *amigoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"amigo"];
        amigoView.image = [UIImage imageNamed:@"you-make-me-hurt.png"];
        amigoView.canShowCallout = YES;
        
        UIButton *btEsquerdaAmigo = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        btEsquerdaAmigo.backgroundColor = [UIColor redColor];
        [btEsquerdaAmigo setImage:[UIImage imageNamed:@"home_ico_dica_carro.png"] forState:UIControlStateNormal];
        [btEsquerdaAmigo addTarget:self action:@selector(clickLeftBt) forControlEvents:UIControlEventTouchUpInside];
        btEsquerdaAmigo.layer.cornerRadius = 15;
        
        amigoView.leftCalloutAccessoryView = btEsquerdaAmigo;
        
        amigoView.annotation = annotation;
        
        return amigoView;
    }
    else
    {
        NSString *strPinReuseIdentifier = @"pin";
        
        MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:strPinReuseIdentifier];
        
        if (pin == nil) {
            
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:strPinReuseIdentifier];
            
            UIButton *btEsquerda = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            btEsquerda.backgroundColor = [UIColor redColor];
            [btEsquerda setImage:[UIImage imageNamed:@"home_ico_dica_carro.png"] forState:UIControlStateNormal];
            [btEsquerda addTarget:self action:@selector(clickLeftBt) forControlEvents:UIControlEventTouchUpInside];
            btEsquerda.layer.cornerRadius = 15;
            pin.leftCalloutAccessoryView = btEsquerda;
            pin.canShowCallout = YES;
            pin.image = [UIImage imageNamed:@"teste.png"];
        }
        
        pin.annotation = annotation;
        
        return pin;
    }

  
}

-(void)clickLeftBt {
  
  NSLog(@"CLICOU ESQUERDA");
  
  //create MKMapItem out of coordinates
  MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:pontoaux.coordinate addressDictionary:nil];
  MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
  
  if ([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)]) {
    
    //using iOS6 native maps app
    [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
  }
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
  
  if (_TipoMapa.selectedSegmentIndex == 0) {
    _Map1.mapType = MKMapTypeStandard;
  } else if (_TipoMapa.selectedSegmentIndex == 1) {
    _Map1.mapType = MKMapTypeHybrid;
  } else if (_TipoMapa.selectedSegmentIndex == 2) {
    _Map1.mapType = MKMapTypeSatellite;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
