//
//  DCDetalhesHospitalTableViewController.m
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 15/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCDetalhesHospitalTableViewController.h"
#import "DCConfigs.h"

@interface DCDetalhesHospitalTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkBT;

@property DCConfigs *config;

@end

@implementation DCDetalhesHospitalTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
//    self.tableView.backgroundView = backgroundView;
    _config=[[DCConfigs alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)aceitarHospital:(id)sender {
    UIButton *aux = sender;
    
    NSLog(@"Teste");
    aux.hidden = YES;
    
    NSString *urlServidor = @"http://%@:8080/Emergencia/validarLocal.jsp?id=%@&usuario=%@";
    
    //ID DO USUARIO QUE ESTA LOGADO NO APP
    NSString *idUsuario = [[NSUserDefaults standardUserDefaults] stringForKey: @"id"];
    
    NSString *urlAdicionarContato = [NSString stringWithFormat: urlServidor, _config.ip,_postos.cod,idUsuario];
    
    urlAdicionarContato=[urlAdicionarContato stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *urlRequest = [[NSURL alloc] initWithString: urlAdicionarContato];
    NSData *data = [NSData dataWithContentsOfURL: urlRequest];
    
    NSLog(@"%@",urlRequest);
    if (data != nil) {
        
        NSError *jsonParsingError = nil;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        NSNumber *idUsuario = [resultado objectForKey:@"adicionar"];
        NSNumber *testeUsuario = [[NSNumber alloc] initWithInt:0];
        
        if ([idUsuario isEqualToNumber:testeUsuario]) {
            //ERRO
        }
        
        NSLog(@"Foi");
       //OK
    }
    

}
- (IBAction)negarHospital:(id)sender {
    UIButton *aux = sender;
    aux.hidden = YES;
    
    
    NSString *urlServidor = @"http://%@:8080/Emergencia/deletarValidar.jsp?id=%@&usuario=%@";
    
    //ID DO USUARIO QUE ESTA LOGADO NO APP
    NSString *idUsuario = [[NSUserDefaults standardUserDefaults] stringForKey: @"id"];
    
    NSString *urlAdicionarContato = [NSString stringWithFormat: urlServidor, _config.ip,_postos.cod,idUsuario];
    
    urlAdicionarContato=[urlAdicionarContato stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *urlRequest = [[NSURL alloc] initWithString: urlAdicionarContato];
    NSData *data = [NSData dataWithContentsOfURL: urlRequest];
    
    NSLog(@"%@",urlRequest);
    if (data != nil) {
        
        NSError *jsonParsingError = nil;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        
        NSNumber *idUsuario = [resultado objectForKey:@"adicionar"];
        NSNumber *testeUsuario = [[NSNumber alloc] initWithInt:0];
        
        if ([idUsuario isEqualToNumber:testeUsuario]) {
            //ERRO
        }
        
        NSLog(@"Foi");
        //OK
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdent;
    
    if (indexPath.section == 0){
        tableIdent = @"Cell4";
    } else if (indexPath.section == 1){
        tableIdent = @"Cell5";
    } else if(indexPath.section == 2) {
        tableIdent = @"Cell6";
    } else {
        tableIdent = @"Cell7";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdent];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdent];
    }
    
    UIButton *checkBT = (UIButton *)[cell viewWithTag:10];
    UIButton *cancelBT = (UIButton *)[cell viewWithTag:20];
    
    if (_postos.validar) {
        checkBT.hidden = NO;
        cancelBT.hidden = NO;
    }
    else {
        checkBT.hidden = YES;
        cancelBT.hidden = YES;
    }
    
    if (indexPath.section == 0) {
        
        UILabel *lblEndereco = (UILabel *)[cell viewWithTag:1];
    
        lblEndereco.lineBreakMode = YES;
        lblEndereco.lineBreakMode = NSLineBreakByCharWrapping;
        lblEndereco.text = _postos.endereco;
        lblEndereco.textColor = [UIColor whiteColor];
        
    }
    
    else if (indexPath.section == 1 && ([_postos.site isKindOfClass: [NSNull class]])) {
        
        UILabel *lblSite = (UILabel *) [cell viewWithTag:2];
        
        lblSite.lineBreakMode = YES;
        lblSite.lineBreakMode = NSLineBreakByCharWrapping;
        lblSite.text = @"Nenhum site disponível";
        lblSite.textColor = [UIColor whiteColor];
    }
    
    else if (indexPath.section == 1 && (![_postos.site isKindOfClass: [NSNull class]])) {
        
        UILabel *lblSite = (UILabel *) [cell viewWithTag:2];
        
        lblSite.lineBreakMode = YES;
        lblSite.lineBreakMode = NSLineBreakByCharWrapping;
        lblSite.text = _postos.site;
        lblSite.textColor = [UIColor whiteColor];
    }
    
    else if (indexPath.section == 2 && (_postos.telefone == nil || [_postos.telefone isEqualToString:@"Não se aplica"])) {
       
        UILabel *lblTelefone = (UILabel *) [cell viewWithTag:3];
        
        lblTelefone.lineBreakMode = YES;
        lblTelefone.lineBreakMode = NSLineBreakByCharWrapping;
        lblTelefone.text = @"Nenhum telefone disponível";
        lblTelefone.textColor = [UIColor whiteColor];
        
    }
    
    else if (indexPath.section == 2 && (!(_postos.telefone == nil) || ![_postos.telefone isEqualToString:@"Não se aplica"])) {
        
        UILabel *lblTelefone = (UILabel *) [cell viewWithTag:3];
        
        lblTelefone.lineBreakMode = YES;
        lblTelefone.lineBreakMode = NSLineBreakByCharWrapping;
        lblTelefone.text = _postos.telefone;
        lblTelefone.textColor = [UIColor whiteColor];
    }
    
    else if(indexPath.section == 3 && ([_postos.especi isKindOfClass: [NSNull class]])) {
        
        UILabel *lblEspeci = (UILabel *) [cell viewWithTag:4];
        
        lblEspeci.lineBreakMode = YES;
        lblEspeci.lineBreakMode = NSLineBreakByCharWrapping;
        lblEspeci.text = @"Nenhuma especialidade especial";
        lblEspeci.textColor = [UIColor whiteColor];
    }
    
     else {
     UILabel *lblEspeci = (UILabel *) [cell viewWithTag:4];
     lblEspeci.lineBreakMode = YES;
     lblEspeci.lineBreakMode = NSLineBreakByCharWrapping;
     lblEspeci.text = _postos.especi;
     lblEspeci.textColor = [UIColor whiteColor];
     }
    
    cell.tag = indexPath.row;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.5, 400, 20)];
    
    if (section == 0) {
        
        lblHeader.text = _postos.nome;
        lblHeader.lineBreakMode = YES;
        lblHeader.lineBreakMode = NSLineBreakByCharWrapping;
        lblHeader.textColor = [UIColor colorWithRed:(107/255.0) green:0 blue:(2/255.0) alpha:1];
        lblHeader.font = [UIFont boldSystemFontOfSize:1.0f];
        [lblHeader setFont:[UIFont systemFontOfSize:13.0f]];
        
        headerView.backgroundColor = [UIColor whiteColor];
        [lblHeader setBackgroundColor: [UIColor clearColor]];
        
        [headerView addSubview:lblHeader];
        
    }
    else if (section == 1){
        
        lblHeader.text = @"Site";
        lblHeader.lineBreakMode = YES;
        lblHeader.lineBreakMode = NSLineBreakByCharWrapping;
        lblHeader.textColor = [UIColor colorWithRed:(107/255.0) green:0 blue:(2/255.0) alpha:1];
        lblHeader.font = [UIFont boldSystemFontOfSize:1.0f];
        [lblHeader setFont:[UIFont systemFontOfSize:13.0f]];
        
        headerView.backgroundColor = [UIColor whiteColor];
        [lblHeader setBackgroundColor: [UIColor clearColor]];
        
        [headerView addSubview:lblHeader];
        
    }
    
    else if(section == 2) {
        lblHeader.text = @"Telefone";
        lblHeader.lineBreakMode = YES;
        lblHeader.lineBreakMode = NSLineBreakByCharWrapping;
        lblHeader.textColor = [UIColor colorWithRed:(107/255.0) green:0 blue:(2/255.0) alpha:1];
        lblHeader.font = [UIFont boldSystemFontOfSize:1.0f];
        [lblHeader setFont:[UIFont systemFontOfSize:13.0f]];
        
        headerView.backgroundColor = [UIColor whiteColor];
        [lblHeader setBackgroundColor: [UIColor clearColor]];
        
        [headerView addSubview:lblHeader];
    }
    
    else {
        lblHeader.text = @"Especialidade";
        lblHeader.lineBreakMode = YES;
        lblHeader.lineBreakMode = NSLineBreakByCharWrapping;
        lblHeader.textColor = [UIColor colorWithRed:(107/255.0) green:0 blue:(2/255.0) alpha:1];
        lblHeader.font = [UIFont boldSystemFontOfSize:1.0f];
        [lblHeader setFont:[UIFont systemFontOfSize:13.0f]];
        
        headerView.backgroundColor = [UIColor whiteColor];
        [lblHeader setBackgroundColor: [UIColor clearColor]];
        
        [headerView addSubview:lblHeader];
    }
    
    return  headerView;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
