//
//  DCEmergenciaViewController.m
//  Emergencia
//
//  Created by Acácio Veit Schneider on 24/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCEmergenciaViewController.h"
#import "DCMapasViewController.h"
#import "DCEmergencia.h"
#import "DCMapasViewController.h"
#import "TLAlertView.h"


@interface DCEmergenciaViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtRaio;
@property (strong, nonatomic) NSMutableArray *emergencias;
@property (weak, nonatomic) IBOutlet UIPickerView *pickers;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;


@end

@implementation DCEmergenciaViewController


float lat;
float longi;

- (void)viewDidLoad
{
  [super viewDidLoad];
//    if([[NSUserDefaults standardUserDefaults] objectForKey:@"pushOn"]){
//        [self performSegueWithIdentifier:@"goToMapas" sender:self];
//    
//    }

    //recebeu notificacao enquanto aberta
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification) name:@"MyNotification" object:nil];
    
    
    
    _gerenciadorLocalizacao = [[CLLocationManager alloc] init];
    _gerenciadorLocalizacao.delegate = self;
    
    
  [_gerenciadorLocalizacao startUpdatingLocation];
  [self configuracoesIniciais];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  
  [self.view addGestureRecognizer:tap];

    _configs = [[DCConfigs alloc] init];
    
//    [self handleNotification];
    
    
}
-(void)handleNotification{
    NSLog(@"Recebeu notificacao");
//    
//    
//    UIView *viewNotification, *viewAux;
//    viewAux = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 100)];
//    viewNotification = [[UIView alloc] initWithFrame:CGRectMake(0,64, 320, 100)];
//    UIColor *branco = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1.0];
//    viewAux.backgroundColor =branco;
//    
//    UILabel *labelteste = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 25)];
//    labelteste.text = @"Testando label na view aux";
//    labelteste.textColor = [UIColor whiteColor];
//    [viewNotification addSubview:labelteste];
//   
//    UIColor *vermelho = [[UIColor alloc] initWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f];
//    viewNotification.backgroundColor = vermelho;
//    
////    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:viewNotification];
////    self.animator = animator;
////    
////    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:viewNotification snapToPoint:CGPointMake(10.0f, 10.0f)];
////    [self.animator addBehavior:snapBehavior];
//    UITapGestureRecognizer *toque = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tocouNaNotification)];
//    [viewNotification addGestureRecognizer:toque];
//    [self.view addSubview:viewAux];
//    [self.view addSubview:viewNotification];
}
-(void)tocouNaNotification{
    NSLog(@"Toque");
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    lat = newLocation.coordinate.latitude;
    longi = newLocation.coordinate.longitude;
    
    
}



-(void)dismissKeyboard {
  [self.txtRaio resignFirstResponder];
}

- (void) configuracoesIniciais {
  
 // UIColor *color = self.view.tintColor;
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0], NSForegroundColorAttributeName: [UIColor blackColor]}];
  self.title = @"Emergência";
  
  [self configurarEmergencias];
    if(self.coordenada.latitude!=0 && self.coordenada.longitude !=0)
        [self performSegueWithIdentifier:@"goToMapas" sender:self];

}



- (void) configurarEmergencias {
  
  self.emergencias = [[NSMutableArray alloc] init];
  
  DCEmergencia *emergencia = [[DCEmergencia alloc] initComNome:@"Respiratório" ComPrioridade:1];
  [self.emergencias addObject:emergencia];
  
  emergencia = [[DCEmergencia alloc] initComNome:@"Cardíaco" ComPrioridade:2];
  [self.emergencias addObject:emergencia];
  
  emergencia = [[DCEmergencia alloc] initComNome:@"Neurológico" ComPrioridade:3];
  [self.emergencias addObject:emergencia];
  
  emergencia = [[DCEmergencia alloc] initComNome:@"Muscular" ComPrioridade:4];
  [self.emergencias addObject:emergencia];
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
  
  //VERIFICA SE CONTEM ALGUM CARACTER QUE NAO SEJA NUMERO OU O CARACTER '.'
  NSError *error = NULL;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([^0-9\\.])" options:NSRegularExpressionCaseInsensitive error:&error];
  
  NSUInteger numberOfMatches = [regex numberOfMatchesInString: self.txtRaio.text
                                                      options:0
                                                        range:NSMakeRange(0, [self.txtRaio.text length])];
  
  if (numberOfMatches > 0) {
    
      TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Valor do raio incompatível" buttonTitle:@"OK"];
      [alertView show];
    return NO;
  }
  return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  DCMapasViewController *viewController = (DCMapasViewController *) segue.destinationViewController;
  
  float raio = [self.txtRaio.text floatValue];
  [viewController setRaio: raio];
   
    if ([segue.identifier isEqualToString:@"goToMapas"]) {
        DCMapasViewController  *mapas = (DCMapasViewController *)segue.destinationViewController;
        mapas.coordenada = _coordenada;
    }
    
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return _emergencias.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
  
  return ((DCEmergencia *) [self.emergencias objectAtIndex:row]).nome;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
  label.textColor = self.view.tintColor;
  label.textAlignment = NSTextAlignmentCenter;
  label.text = ((DCEmergencia *) [self.emergencias objectAtIndex:row]).nome;
  return label;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void) enviar{
    
    NSString *savedUserName = [[NSUserDefaults standardUserDefaults] stringForKey: @"username"];
    NSLog(@"Solocitando");
    
    //self.pickers
    
    //Montar a mensagem
    NSString *msm=[[NSString alloc]init];
    
    
    
    NSInteger sele=[self.pickers selectedRowInComponent:self.pickers.tag];
    
    DCEmergencia *emer=self.emergencias[sele];
    
    msm=[msm stringByAppendingFormat:@"o usuario:%@ está solicitando sua ajuda, com uma ermergência: %@",savedUserName,emer.nome];
    
    //NSLog(@"%@",msm);
    
    
    //NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/alertar.jsp?mensagem=%@&idusu=%@&lat=%@&log=%@",self.configs.ip,@"testando o push",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    
    
    //COlocar a posiçao atual
    NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/alertar.jsp?mensagem=%@&idusu=%@&lat=%f&log=%f",self.configs.ip,msm,savedUserName,lat,longi];
    NSLog(@"%@",[ur stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    NSURL *urs = [[NSURL alloc] initWithString:[ur stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    NSData* data = [NSData dataWithContentsOfURL:urs];
    
    
    //retorno
    if(data!=nil){
        
        NSLog(@"Aqui");
        
        NSError *jsonParsingError = nil;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        
        NSNumber *res=[resultado objectForKey:@"enviado"];
        
        NSNumber *teste=[[NSNumber alloc] initWithInt:0];
        
        //confere
        if(![res isEqualToNumber:teste]){
//            //Colocar Alert
//            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Enviado" message:@"Mensagens enviadas com sucesso" buttonTitle:@"OK"];
//            [alertView show];
        }
    }

}
- (IBAction)Solicitar:(id)sender {
    //Thread
//    NSThread *background;
//    background = [[NSThread alloc] initWithTarget:self selector:@selector(enviar) object:nil];
//    [background start];
//    
    [self performSelectorInBackground:@selector(enviar) withObject:nil];
    //[self enviar];
    
}

-(void)dealloc
{
    _gerenciadorLocalizacao.delegate = nil;
}



@end