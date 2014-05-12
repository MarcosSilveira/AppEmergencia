//
//  DCProfileViewController.m
//  Emergencia
//
//  Created by Henrique Manfroi da Silveira on 12/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCProfileViewController.h"

@interface DCProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nametxt;
@property (weak, nonatomic) IBOutlet UITextField *pesotxt;
@property (weak, nonatomic) IBOutlet UITextField *alturatxt;
@property (weak, nonatomic) IBOutlet UIPickerView *tipo;
@property NSArray *sangue;

@end

@implementation DCProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sangue=@[@"A+",@"A-",@"AB+",@"AB-",@"B+",@"B-", @"O+",@"O-"];
    
    
    self.nametxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"nome"];
    self.pesotxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"peso"];
    self.alturatxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"altura"];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _sangue.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return ((NSString *) [self.sangue objectAtIndex:row]);
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textColor = self.view.tintColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.text =  ((NSString *) [self.sangue objectAtIndex:row]);
    return label;
}

- (IBAction)cadastrar:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.nametxt.text forKey:@"nome"];
    [[NSUserDefaults standardUserDefaults] setObject:self.pesotxt.text forKey:@"peso"];
    [[NSUserDefaults standardUserDefaults] setObject:self.alturatxt.text forKey:@"altura"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(bool)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
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
