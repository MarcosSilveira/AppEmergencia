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
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Sucesso" message:@"Contato adicionato com sucesso (em Aprovação)" buttonTitle:@"OK"];
                [alertView show];
                [self.previousViewController.contacts addObject: contato];
                [self.navigationController popViewControllerAnimated:YES];
                    });
            } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Não foi possível adicionar o contato. Tente novamente mais tarde." buttonTitle:@"OK"];
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
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Sucesso" message:@"Contato editado com sucesso" buttonTitle:@"OK"];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
                });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Erro" message:@"Não foi possível editar o contato. Tente novamente mais tarde." buttonTitle:@"OK"];
            [alertView show];
                });
        }
              });
    }
}




@end
