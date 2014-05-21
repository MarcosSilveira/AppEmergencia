//
//  DCLeftMenuViewController.m
//  Emergencia
//
//  Created by Marcos Sokolowski on 08/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCLeftMenuViewController.h"
#import "KeychainItemWrapper.h"

@implementation DCLeftMenuViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	
    
	self.tableView.separatorColor = [UIColor lightGrayColor];
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];

	self.tableView.backgroundView = imageView;
	
	self.view.layer.borderWidth = .6;
	self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
	
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Home";
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ambulancia2.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
			
		case 1:
			cell.textLabel.text = @"Perfil";
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clipboard.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
			
		case 2:
			cell.textLabel.text = @"Amigos";
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contato.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
			
		case 3:
			cell.textLabel.text = @"Adicionar local";
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hospital.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
            
        case 4:
			cell.textLabel.text = @"Números de emergência";
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
    
			break;
            
        case 5:
			cell.textLabel.text = @"Sair da conta";
            _imagem = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 5, 5)];
            _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"power.png"]];
            [_imagem addSubview:_image];
            [cell addSubview:_imagem];
			break;
	}
	
	cell.backgroundColor = [UIColor clearColor];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	
	UIViewController *vc ;
	
	switch (indexPath.row)
	{
		case 0:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InicialViewController"];
			break;
			
		case 1:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
			break;
			
		case 2:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ContatosViewController"];
			break;
            
        case 3:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"NovoLocalViewController"];
			break;
            
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NumerosViewController"];
            break;
			
		case 5:
			[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
            
            //KeychainItemWrapper *keyPref = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
            //[keyPref resetKeychainItem];
            KeychainItemWrapper *keychainPassword = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
            
            NSString *savedUserName = [keychainPassword objectForKey:(__bridge id)kSecAttrAccount];
            NSString *savedPassword = [keychainPassword objectForKey:(__bridge id)kSecValueData];
            
            [keychainPassword setObject:@"" forKey:(__bridge id)kSecAttrAccount];
            [keychainPassword setObject:@"" forKey:(__bridge id)kSecValueData];
            
            savedUserName = [keychainPassword objectForKey:(__bridge id)kSecAttrAccount];
            savedPassword = [keychainPassword objectForKey:(__bridge id)kSecValueData];
            
            
			[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
			return;
			break;
	}
	
	[[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
}

@end


