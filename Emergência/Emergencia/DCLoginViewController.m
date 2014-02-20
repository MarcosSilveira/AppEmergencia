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
@interface DCLoginViewController ()



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
    
    [self configuracoesIniciais];
    
    //    if(savedUserName != nil && savedPassword != nil) {
    //        [self performSegueWithIdentifier:@"goToInicio" sender:self];
    //    }
    
    // NAO PODE TER BACK BUTTON
    self.navigationItem.hidesBackButton = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *savedUserName = [_keychainPassword objectForKey:(__bridge id)kSecAttrAccount];
    NSString *savedPassword = [_keychainPassword objectForKey:(__bridge id)kSecValueData];
    
    if(![savedUserName isEqualToString:@""] && ![savedPassword isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"goToInicio" sender:self];
         self.conf.login = savedUserName;
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"goToInicio"]) {
        DCInicialViewController *inicial = (DCInicialViewController *)segue.destinationViewController;
        inicial.coordenada = _coordenada;
        inicial.config=self.conf;
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
        [self performSegueWithIdentifier:@"goToInicio" sender:sender];
    } else {
        //self.oks.text=@"Erro no login";
        [[[UIAlertView alloc] initWithTitle:@"erro" message:@"Login não efetuado" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show ];
    }
    
}

-(BOOL) loginUsuarioComUsuario:(NSString *)usuario
                      comSenha:(NSString *)senha {
    
    NSString *ur=[NSString stringWithFormat:@"http://%@:8080/Emergencia/login.jsp?login=%@&senha=%@",self.conf.ip,usuario,senha];
    DCAppDelegate *tokn;
    
    
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
        [[[UIAlertView alloc] initWithTitle:@"erro" message:@"Login não efetuado" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show ];
        
        return NO;
    }
    
}


@end
