//
//  DCAjudaTableViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 28/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCAjudaTableViewController.h"
#import "DCDetalhesAjudaViewController.h"

@interface DCAjudaTableViewController ()
@property  NSInteger selectedCell;

@end

@implementation DCAjudaTableViewController

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
    self.navigationItem.hidesBackButton = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row)
    {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"AJUDA_CELULAS_TITULO_1", nil);
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
			
		case 1:
			cell.textLabel.text = NSLocalizedString(@"AJUDA_CELULAS_TITULO_2", nil);
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
			
		case 2:
			cell.textLabel.text = NSLocalizedString(@"AJUDA_CELULAS_TITULO_3", nil);
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row)
	{
		case 0:
            _selectedCell = 0;
            [self performSegueWithIdentifier:@"goToDetalheAjuda" sender:nil];
            
			break;
			
		case 1:
            _selectedCell = 1;
            [self performSegueWithIdentifier:@"goToDetalheAjuda" sender:nil];
            
			break;
			
		case 2:
            _selectedCell = 2;
            [self performSegueWithIdentifier:@"goToDetalheAjuda" sender:nil];
            
			break;
    }
    return;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DCDetalhesAjudaViewController *ADV = (DCDetalhesAjudaViewController *)segue.destinationViewController;
//    ADV.texto_auxiliar= @"TESTE";
    if (_selectedCell==0)
        ADV.texto_auxiliar = NSLocalizedString(@"AJUDA_TEXTO_1", nil);
    
    else if (_selectedCell==1)
        ADV.texto_auxiliar = NSLocalizedString(@"AJUDA_TEXTO_2", nil);
    
    else if(_selectedCell==2)
        ADV.texto_auxiliar = NSLocalizedString(@"AJUDA_TEXTO_3", nil);

    
    

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

//slideMenudelegate

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


@end
