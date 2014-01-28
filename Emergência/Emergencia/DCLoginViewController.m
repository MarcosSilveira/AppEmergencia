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

@interface DCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *pass;


@property (nonatomic) DCConfigs *conf;

@end

@implementation DCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *savedUserName = [[NSUserDefaults standardUserDefaults] stringForKey: @"username"];
    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    
    
    
    
    [self configuracoesIniciais];
    
    if(![savedUserName isEqualToString:@""] && ![savedPassword isEqualToString:@""])
    {
        // preferencias
        
        if ([self loginUsuarioComUsuario:savedUserName comSenha:savedPassword])
        {
            [self performSegueWithIdentifier:@"goToInicio" sender:self];
        } else {
            //self.oks.text=@"Erro no login";
            [[[UIAlertView alloc] initWithTitle:@"erro" message:@"Login não efetuado" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show ];
        }
        
        
    }
    
}

- (void) configuracoesIniciais {
    
    UIColor *color = self.view.tintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName: color}];
    self.title = @"Login";
    self.conf=[[DCConfigs alloc] init];
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
    
    
    
    NSURL *urs=[[NSURL alloc] initWithString:ur];
    NSData* data = [NSData dataWithContentsOfURL:
                    urs];
    
    //retorno
    if(data!=nil){
        
        NSError *jsonParsingError = nil;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        
        NSNumber *res=[resultado objectForKey:@"login"];
        
        NSNumber *teste=[[NSNumber alloc] initWithInt:1];
        
        //confere
        if([res isEqualToNumber:teste]){
            
            
            //Checagem de preferencias, saber se já ta logado
            
            NSUserDefaults *prefer = [NSUserDefaults standardUserDefaults];
            
            [prefer setObject:self.login.text forKey:@"username"];
            [prefer setObject:self.pass.text forKey:@"password"];
            
            [prefer synchronize];
            
            return YES;
            
        }else{
            
            
            return NO;
        }
        
    }else{
        //self.oks.text=@"Erro no login";
        [[[UIAlertView alloc] initWithTitle:@"erro" message:@"Login não efetuado" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show ];
        
        return NO;
    }
    
}


@end
