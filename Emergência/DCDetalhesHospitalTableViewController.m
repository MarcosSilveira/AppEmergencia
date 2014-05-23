//
//  DCDetalhesHospitalTableViewController.m
//  Emergencia
//
//  Created by Joao Pedro da Costa Nunes on 15/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCDetalhesHospitalTableViewController.h"

@interface DCDetalhesHospitalTableViewController ()

@end

@implementation DCDetalhesHospitalTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundView = backgroundView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdent = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdent];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdent];
    }
    UILabel *lblEndereco = (UILabel *)[cell viewWithTag:1];
    //UIButton *btAceita = (UIButton *) [cell viewWithTag:1];
    
    lblEndereco.lineBreakMode = YES;
    lblEndereco.lineBreakMode = NSLineBreakByCharWrapping;
    lblEndereco.text = _postos.endereco;
    lblEndereco.textColor = [UIColor whiteColor];
    lblEndereco.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);

    //[btAceita setImage:[UIImage imageNamed:@"hospital.png"] forState:UIControlStateNormal];
    //[btAceita addTarget:self action:@selector(aceitarHospital) forControlEvents:UIControlEventTouchUpInside];
    
    cell.tag = indexPath.row;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void) aceitarHospital {
    NSLog(@"FUNCIONOU");
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.5, 400, 20)];
    
    lblHeader.text = _postos.nome;
    lblHeader.lineBreakMode = YES;
    lblHeader.lineBreakMode = NSLineBreakByCharWrapping;
    lblHeader.textColor = [UIColor colorWithRed:(107/255.0) green:0 blue:(2/255.0) alpha:1];
    lblHeader.font = [UIFont boldSystemFontOfSize:1.0f];
    [lblHeader setFont:[UIFont systemFontOfSize:13.0f]];
    
    headerView.backgroundColor = [UIColor whiteColor];
    [lblHeader setBackgroundColor: [UIColor clearColor]];
    
    [headerView addSubview:lblHeader];
    
    return headerView;
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
