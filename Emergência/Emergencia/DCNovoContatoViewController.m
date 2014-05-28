//
//  DCNovoContatoViewController.m
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 05/02/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCNovoContatoViewController.h"
#import "DCContatos.h"
#import "DCConfigs.h"
#import "DCContatosViewController.h"
#import "TLAlertView.h"

@interface DCNovoContatoViewController ()

@property (nonatomic) DCConfigs *conf;


@end

@implementation DCNovoContatoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.navigationController.navigationBar.alpha = 0.6;
    self.navigationItem.title = NSLocalizedString(@"NOVO_CONTATO_TITULO", nil);
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255/255 green: 0/255 blue:0/255 alpha:1];

    self.conf = [[DCConfigs alloc] init];
    
    if (self.contato != nil) {
        
        self.txtNome.text = self.contato.nome;
        self.txtTelefone.text = self.contato.telefone;
        self.txtUser.text = self.contato.usuario;
        
        self.txtUser.enabled = NO;
    }
    
}

//LIMITA O TAMANHO DO TEXTFIELD
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
  if (![textField isEqual:self.txtTelefone]) {
    return YES;
  }
  
  if (range.location > 13) {
    return NO;
  }
  
  return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txtNome resignFirstResponder];
    [_txtTelefone resignFirstResponder];
    [_txtUser resignFirstResponder];
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)salvarContat {
    
    DCContatos *contato;
    
    //ADICIONA UM CONTATO NOVO
    if (self.contato == nil) {
        contato = [[DCContatos alloc]init];
        
        contato.nome = self.txtNome.text;
        contato.telefone = self.txtTelefone.text;
        contato.usuario = self.txtUser.text;
        
        dispatch_queue_t queue;
        
        queue = dispatch_queue_create("myQueue",
                                      NULL);
        dispatch_async(queue, ^{
            if ([contato salvarComIPServidor: self.conf.ip]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:NSLocalizedString(@"NOVO_CONTATO_ADICIONAR_OK_TITULO", nil) message:NSLocalizedString(@"NOVO_CONTATO_ADICIONAR_OK_MENSAGEM", nil) buttonTitle:@"OK"];
                [alertView show];
                [self.previousViewController.contacts addObject: contato];
                [self.navigationController popViewControllerAnimated:YES];
                    });
            } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:NSLocalizedString(@"ERRO", nil) message:NSLocalizedString(@"NOVO_CONTATO_ADICIONAR_FALHA_MENSAGEM", nil) buttonTitle:@"OK"];
                [alertView show];
                  });
            }
        });
        
        
    } else { //EDITA UM CONTATO JA EXISTENTE
        
        contato = self.contato;
        contato.nome = self.txtNome.text;
        contato.telefone = self.txtTelefone.text;
        
        dispatch_queue_t queue;
        
        queue = dispatch_queue_create("myQueue",
                                      NULL);
        dispatch_async(queue, ^{
        
        if ([contato editarComIPServidor: self.conf.ip]) {
            dispatch_async(dispatch_get_main_queue(), ^{
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:NSLocalizedString(@"NOVO_CONTATO_MODIFICAR_OK_TITULO", nil) message:NSLocalizedString(@"NOVO_CONTATO_MODIFICAR_OK_MENSAGEM", nil) buttonTitle:@"OK"];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
                });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:NSLocalizedString(@"ERRO", nil) message:NSLocalizedString(@"NOVO_CONTATO_MODIFICAR_FALHA_MENSAGEM", nil) buttonTitle:@"OK"];
            [alertView show];
                });
        }
              });
    }
}




@end
