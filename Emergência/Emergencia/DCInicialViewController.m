//
//  DCInicialViewController.m
//  Emergencia
//
//  Created by Acácio Veit Schneider on 23/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCInicialViewController.h"
#import "DCLoginViewController.h"
#import "DCEmergenciaViewController.h"
#import "DCConfigs.h"
#import "KeychainItemWrapper.h"
#include <arpa/inet.h>
#import "Reachability.h"


@interface DCInicialViewController ()



@end

@implementation DCInicialViewController

//DCReachability *connectionTest;
UIAlertView *nconnection;
BOOL connectionOK = YES;
UIImageView *auxi;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.navigationController.navigationBar.alpha = 0.6;
    self.navigationItem.title = @"Salve.Me!";
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255/255 green: 0/255 blue:0/255 alpha:1];


    if([[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"]){
        [self performSegueWithIdentifier:@"goToEmergencia" sender:nil];

    }

    [self configuracoesIniciais];
    [self testeDeConeccao];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"firstRun"]) {
        [self firstRun];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstRun"];
    }
    
    

//    _userLogado.text = self.config.login;
    
    
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification) name:@"MyNotification" object:nil];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MyNotification" object:nil];
}
-(void)firstRun{
    UIImage *imgggg = [UIImage imageNamed:@"first_run.png"];
 //   imgggg.size = [CGSizeMake(imgggg.size.height/2, imgggg.size.width/2)];
    auxi = [[UIImageView alloc] initWithImage:imgggg];
    auxi.alpha = 0.6;
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView *splashView = [[UIView alloc] initWithFrame:frame];
    splashView.backgroundColor = [[UIColor alloc] initWithPatternImage:imgggg];
    [[self view] addSubview:auxi];
    [self.view bringSubviewToFront: auxi];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(removeMenu)
                                   userInfo:nil
                                    repeats:YES];
    
}

-(void) removeMenu{
    if([[SlideNavigationController sharedInstance] isMenuOpen]){
        [auxi removeFromSuperview];
    }
}
-(void)handleNotification{
    NSLog(@"Recebeu notificacao");
    
    
    UIView *viewNotification, *viewAux;
    viewAux = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 100)];
    viewNotification = [[UIView alloc] initWithFrame:CGRectMake(0,64, 320, 100)];
    UIColor *branco = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1.0];
    viewAux.backgroundColor =branco;
    
    UILabel *labelteste = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 25)];
    labelteste.text = @"Testando label na view aux";
    labelteste.textColor = [UIColor whiteColor];
    [viewNotification addSubview:labelteste];
    
    UIColor *vermelho = [[UIColor alloc] initWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f];
    viewNotification.backgroundColor = vermelho;
    
    
    UITapGestureRecognizer *toque = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tocouNaNotification)];
    [viewNotification addGestureRecognizer:toque];
    [self.view addSubview:viewAux];
    [self.view addSubview:viewNotification];
}

-(void)tocouNaNotification{
    NSLog(@"Toque");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pushOn"];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}


-(void) testeDeConeccao {
    NSString *server = [[NSString alloc] init];
    DCConfigs *config=[[DCConfigs alloc] init];
    server = [server stringByAppendingFormat:@"http://%@:8080/Emergencia/", config.ip];
    
    
    
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    //    connectionTest = [DCReachability reachabilityWithHostName:server];
    //    [connectionTest startNotifier];
    //
    //    NetworkStatus remoteHostStatus = [connectionTest currentReachabilityStatus];
    //    if(remoteHostStatus == NotReachable) {
    //
    //        nconnection = [[UIAlertView alloc] initWithTitle:@"Sem conexão" message:@"Não foi possível conectar aos servidores no momento. Verifique sua conexão com a internet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [nconnection show];
    //    }
    //    else
    //        connectionOK = YES;
    //
    //
    //
    
    //     struct sockaddr_in ipAddress;
    //    ipAddress.sin_len = sizeof(ipAddress);
    //    ipAddress.sin_family = AF_INET;
    //    ipAddress.sin_port = htons(8080);
    //    inet_pton(AF_INET, "192.168.2.2", &ipAddress.sin_addr);
    //
    //    Reachability* reach = [Reachability reachabilityWithAddress:ipAddress];
    //
    //    // Set the blocks
    //    reach.reachableBlock = ^(Reachability*reach)
    //    {
    //        NSLog(@"REACHABLE!");
    //    };
    //
    //    reach.unreachableBlock = ^(Reachability*reach)
    //    {
    //        NSLog(@"UNREACHABLE!");
    //    };
    //
    //    // Start the notifier, which will cause the reachability object to retain itself!
    //    [reach startNotifier];
    //}
}
//- (void) handleNetworkChange:(NSNotification *)notice
//{
//
//    NetworkStatus remoteHostStatus = [connectionTest currentReachabilityStatus];
//
//    if(remoteHostStatus == NotReachable) {NSLog(@"no");}
//    else if (remoteHostStatus == ReachableViaWiFi) {NSLog(@"wifi"); connectionOK = YES; }
//    else if (remoteHostStatus == ReachableViaWWAN) {NSLog(@"cell"); connectionOK = YES; }
//}

- (void) configuracoesIniciais {
    
    //UIColor *color = self.view.tintColor;
    self.navigationItem.hidesBackButton = YES;
    
    
    //Esconde o bota de voltar
    //TODO: Verificar se o usuário está logado?
    
    
    
    
    if(self.coordenada.latitude!=0 && self.coordenada.longitude !=0)
        [self performSegueWithIdentifier:@"goToEmergencia" sender:self];
    //configuraTableView do menu lateral esquerdo

    
    
}


- (IBAction)clicouEmergencia:(id)sender {
    [self performSegueWithIdentifier:@"goToEmergencia" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToEmergencia"] && self.coordenada.latitude!=0 && self.coordenada.longitude!=0) {
        DCEmergenciaViewController *emergencia = (DCEmergenciaViewController *)segue.destinationViewController;
        emergencia.coordenada = _coordenada;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btLogOut
{
    
    KeychainItemWrapper *keyPref = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
    
    [keyPref resetKeychainItem];
    
    /*DCLoginViewController *logon;
     
     logon.login.text = nil;
     
     logon.pass.text = nil;
     
     [[NSUserDefaults standardUserDefaults] setObject:logon.login.text forKey:@"username"];
     [[NSUserDefaults standardUserDefaults] setObject:logon.login.text forKey:@"password"];
     
     [[NSUserDefaults standardUserDefaults]synchronize];*/
    
}

//slideMenudelegate

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"pushOn"];
}

@end
