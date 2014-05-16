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
#import "KeychainItemWrapper.h"

@interface DCEmergenciaViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtRaio;
@property (strong, nonatomic) NSMutableArray *emergencias;
@property (weak, nonatomic) IBOutlet UIPickerView *pickers;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic,strong) UIView *viewNotification, *viewAux;
@property KeychainItemWrapper *keychainPassword;

@end

@implementation DCEmergenciaViewController


float lat;
float longi;

- (void)viewDidLoad
{
  [super viewDidLoad];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"]){
        [self performSegueWithIdentifier:@"goToMapas" sender:self];
    
    }
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"background.png"]]];

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
    
    _keychainPassword = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
    
}
-(void)handleNotification{
    NSLog(@"Recebeu notificação");
    
    
    
//    _viewAux = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 100)];
    _viewNotification = [[UIView alloc] initWithFrame:CGRectMake(0,64, 320, 100)];
    UIColor *branco = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1.0];
    _viewAux.backgroundColor =branco;
    NSString *nome = [[NSUserDefaults standardUserDefaults] stringForKey:@"nome2"];
   NSString *emergencia = [[NSUserDefaults standardUserDefaults] stringForKey:@"emergencia2"];
    NSString *mensagem = [NSString stringWithFormat:@"O seu amigo %@ relatou um", nome];
    NSString *mensagem2 =[NSString stringWithFormat:@"problema %@",emergencia];
    UILabel *labelteste2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 25)];
    UILabel *labelteste = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,300, 25)];

    labelteste.text = mensagem;
    labelteste.textColor = [UIColor whiteColor];
    labelteste2.text = mensagem2;
    labelteste2.textColor = [UIColor whiteColor];
    [_viewNotification addSubview:labelteste];
    [_viewNotification addSubview:labelteste2];
   
    UIColor *vermelho = [[UIColor alloc] initWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f];
    _viewNotification.backgroundColor = vermelho;
    

    UITapGestureRecognizer *toque = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tocouNaNotification)];
    [_viewNotification addGestureRecognizer:toque];
//    [self.view addSubview:_viewAux];
    [self.view addSubview:_viewNotification];
}
-(void)tocouNaNotification{
      NSLog(@"Toque");

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pushOn"];
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
    
    NSString *savedUserName = [_keychainPassword objectForKey:(__bridge id)kSecAttrAccount];
    NSLog(@"Solocitando");
    
    //self.pickers
    
    //Montar a mensagem
    NSString *msm=[[NSString alloc]init];
    
    
    
    NSInteger sele=[self.pickers selectedRowInComponent:self.pickers.tag];
    
    DCEmergencia *emer=self.emergencias[sele];
    
    msm=[msm stringByAppendingFormat:@"o usuario:%@ está solicitando sua ajuda, com uma ermergência: %@",savedUserName,emer.nome];
    
    //NSLog(@"%@",msm);
    
    
    //NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/alertar.jsp?mensagem=%@&idusu=%@&lat=%@&log=%@&lohin=%@&tipo=%@",self.configs.ip,@"testando o push",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    
    
    //COlocar a posiçao atual
    NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/alertar.jsp?mensagem=%@&idusu=%@&lat=%f&log=%f&login=%@&tipo=%@",self.configs.ip,msm,savedUserName,lat,longi,savedUserName,emer.nome];
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
            //Colocar Alert
            [[[UIAlertView alloc] initWithTitle:@"Enviado" message:@"Mensagens enviadas com sucesso" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
            
            //TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Enviado" message:@"Mensagens enviadas com sucesso" buttonTitle:@"OK"];
            //[alertView show];
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
-(void)viewWillDisappear:(BOOL)animated{
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"pushOn"];
}



@end