//
//  DCCadastroViewController.m
//  Emergencia
//
//  Created by Acácio Veit Schneider on 23/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCCadastroViewController.h"
#import "DCConfigs.h"
#import "TLAlertView.h"


@interface DCCadastroViewController ()
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *senha;
@property (weak, nonatomic) IBOutlet UITextField *csenha;

@property (nonatomic) DCConfigs *conf;

@end

@implementation DCCadastroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configuracoesIniciais];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) configuracoesIniciais {
    
    //UIColor *color = self.view.tintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0], NSForegroundColorAttributeName: [UIColor blackColor]}];
    self.title = NSLocalizedString(@"CADASTRO_TITULO", nil);
    self.conf=[[DCConfigs alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)cadastrar:(UIButton *)sender {
    
    //Verifica senhas
    if([self.senha.text isEqual:self.csenha.text]){
        
        //JSON
        NSString *ur=[NSString stringWithFormat:@"http://%@:8080/Emergencia/cadastro.jsp?login=%@&senha=%@&email=%@",self.conf.ip,self.login.text,self.senha.text,self.email.text];
        
        ur=[ur stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *urs=[[NSURL alloc] initWithString:ur];
        NSData* data = [NSData dataWithContentsOfURL:
                        urs];
        
        //Retorno
        if(data!=nil){
            
            NSError *jsonParsingError = nil;
            NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
            
            
            NSNumber *res=[resultado objectForKey:@"cadastro"];
            
            NSNumber *teste=[[NSNumber alloc] initWithInt:1];
            
            
            if([res isEqualToNumber:teste]){
                //OK
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:NSLocalizedString(@"CADASTRO_TITULO", nil) message:NSLocalizedString(@"CADASTRO_OK", nil)  buttonTitle:@"OK"];
                [alertView show];
                [self performSegueWithIdentifier:@"cadtoInicial" sender:sender];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstRun"];
            }else{
                //ERRO
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:NSLocalizedString(@"ERRO", nil) message:NSLocalizedString(@"CADASTRO_FALHA", nil) buttonTitle:@"OK"];
                [alertView show];
            }
            
        }else{
            //ERRO
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:NSLocalizedString(@"CADASTRO_FALHA", nil)  buttonTitle:@"OK"];
            [alertView show];
        }
        
        
    }else{
        TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:NSLocalizedString(@"CADASTRO_SENHA_FALHA", nil)  buttonTitle:@"OK"];
        [alertView show];
    }
    
    
    
}


@end
