//
//  DCViewController.m
//  Doacoes
//
//  Created by Acácio Veit Schneider on 23/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCLoginViewController.h"
#import "DCConfigs.h"
#import "DCInicialViewController.h"
#import "DCInicialViewController.h"
#import "DCAppDelegate.h"
#import "TLAlertView.h"
#import "DCNumerosViewController.h"
@interface DCLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BTEntrar;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior1;
@property (nonatomic, strong) UIPushBehavior *pushBehavior2;
@property (nonatomic, strong) UIPushBehavior *pushBehavior3;
@property (nonatomic, strong) UIPushBehavior *pushBehavior4;
@property (nonatomic, strong) UIPushBehavior *pushBehavior5;
@property (weak, nonatomic) IBOutlet UILabel *LBUsuario;
@property (weak, nonatomic) IBOutlet UILabel *LBSenha;
@property (weak, nonatomic) IBOutlet UITextField *FIELDUsuario;
@property (weak, nonatomic) IBOutlet UITextField *FIELDSenha;
@property (weak, nonatomic) IBOutlet UIButton *BTCadastro;
@property (weak, nonatomic) IBOutlet UIButton *BTAux;
@property (weak, nonatomic) IBOutlet UIButton *BTEmergencia;



@property (nonatomic) DCConfigs *conf;

@end

@implementation DCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    //    NSString *savedUserName = [[NSUserDefaults standardUserDefaults] stringForKey: @"username"];
    //    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    //


//    NSString *iden = [[NSUserDefaults standardUserDefaults] stringForKey: @"id"];
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"]){
        [self performSegueWithIdentifier:@"goToInicio" sender:self];

    }
    
    [self configuracoesIniciais];
    
    
    
    //    if(savedUserName != nil && savedPassword != nil) {
    //        [self performSegueWithIdentifier:@"goToInicio" sender:self];
    //    }
    
    // NAO PODE TER BACK BUTTON
    self.navigationItem.hidesBackButton = YES;
}

-(void)RunAnimation:(NSInteger)ID{
    if(ID==0){

        //animações da tela de login
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.BTEntrar]];

        [animator addBehavior:collisionBehavior];
        
        
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.BTEntrar] mode:UIPushBehaviorModeInstantaneous];
        pushBehavior.angle = 30.0;
        pushBehavior.magnitude = 1.0;
        
        UIPushBehavior *pushBehavior1 = [[UIPushBehavior alloc] initWithItems:@[self.BTEmergencia] mode:UIPushBehaviorModeInstantaneous];
        pushBehavior1.angle = 100.0;
        pushBehavior1.magnitude = 3.0;
        
        
        [animator addBehavior:pushBehavior1];
        [animator addBehavior:pushBehavior];
        self.pushBehavior = pushBehavior;
        self.pushBehavior1 = pushBehavior1;
        self.animator = animator;
        
        
        
        
        
        
        
        
        
        
        //chama a segue depois de 2 segundos da inicialização do método
        NSTimer * timer = [[NSTimer alloc] init];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.7
                                                  target:self
                                               selector:@selector(vaipratela)
                                                userInfo:nil
                                                 repeats:NO];
            
        }
}

-(void)vaipratela
{
    [self performSegueWithIdentifier:@"goToInicio" sender:nil];
}




-(void)viewWillAppear:(BOOL)animated
{
    _keychainPassword = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
    
    NSString *savedUserName = [_keychainPassword objectForKey:(__bridge id)kSecAttrAccount];
    NSString *savedPassword = [_keychainPassword objectForKey:(__bridge id)kSecValueData];
    
    if(![savedUserName isEqualToString:@""] && ![savedPassword isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"goToInicio" sender:self];
         self.conf.login = savedUserName;
    }
    
  
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionRepeat animations:^{
       _cruzImage.alpha = 0;
   } completion:^(BOOL finished) {
       _cruzImage.alpha = 1;
   }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"goToInicio"]) {
        DCInicialViewController *inicial = (DCInicialViewController *)segue.destinationViewController;
        inicial.coordenada = _coordenada;
        inicial.config=self.conf;
    }
    
    if ([segue.identifier isEqualToString:@"goToNumeros"]) {
        DCNumerosViewController *numeros = (DCNumerosViewController *)segue.destinationViewController;
        numeros.veioDaSegue = YES;
    }
}
- (void) configuracoesIniciais
{
    //UIColor *color = self.view.tintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0], NSForegroundColorAttributeName:[UIColor blackColor] }];
    
    self.title = @"Login";
    self.conf=[[DCConfigs alloc] init];
    
    _keychainPassword = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)logar:(UIButton *)sender {
    
    if ([self loginUsuarioComUsuario: self.login.text comSenha:self.pass.text]) {
      //  [self RunAnimation:0];
        [self vaipratela];

    } else {
        //self.oks.text=@"Erro no login";
        TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Login não efetuado" buttonTitle:@"OK"];
        [alertView show];
    }
    
    
}

-(BOOL) loginUsuarioComUsuario:(NSString *)usuario
                      comSenha:(NSString *)senha {
    
    NSString *ur=[NSString stringWithFormat:@"http://%@:8080/Emergencia/login.jsp?login=%@&senha=%@",self.conf.ip,usuario,senha];
    DCAppDelegate *tokn;
    
    ur=[ur stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *urs=[[NSURL alloc] initWithString:ur];
    NSData* data = [NSData dataWithContentsOfURL:
                    urs];
    
    //retorno
    if(data!=nil){
        
        NSError *jsonParsingError = nil;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        
        NSNumber *res=[resultado objectForKey:@"login"];
        
        NSNumber *teste=[[NSNumber alloc] initWithInt:0];
        
        //confere
        if(![res isEqualToNumber:teste]){
            
            self.conf.login = self.login.text;
            self.conf.idusuario = res;
            self.conf.token = tokn.pushId;
            //Checagem de preferencias, saber se já ta logado
            
            [_keychainPassword setObject:self.login.text forKey:(__bridge id)kSecAttrAccount];
            [_keychainPassword setObject:self.pass.text forKey:(__bridge id)kSecValueData];
            
            [[NSUserDefaults standardUserDefaults] setObject:res forKey:@"id"];
            [[NSUserDefaults standardUserDefaults] setObject:tokn.pushId forKey:@"token"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            // NSString *idUsuario = [[NSUserDefaults standardUserDefaults] stringForKey: @"id"];
            //[_keychainPassword setObject:res forKey:(__bridge id)kSecAttrCanVerify];
            //[_keychainPassword setObject:tokn.pushId forKey:(__bridge id)kSecAttrCertificateType];
            
            
            return YES;
            
        }
        
        else
        {
            return NO;
        }
        
    }else{
        //self.oks.text=@"Erro no login";
        TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Login não efetuado" buttonTitle:@"OK"];
        [alertView show];
        
        
        
        return NO;
    }
    
}


@end
