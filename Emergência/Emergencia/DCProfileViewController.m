//
//  DCProfileViewController.m
//  Emergencia
//
//  Created by Henrique Manfroi da Silveira on 12/05/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCProfileViewController.h"
#import "TLAlertView.h"

@interface DCProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nametxt;
@property (weak, nonatomic) IBOutlet UITextField *pesotxt;
@property (weak, nonatomic) IBOutlet UITextField *alturatxt;
@property (weak, nonatomic) IBOutlet UIPickerView *tipo;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolls;
@property (weak, nonatomic) IBOutlet UIImageView *foto;
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
    
   
    NSNumber *temp= [[NSUserDefaults standardUserDefaults] objectForKey: @"sangue"];
   //[self.tipo selectedRowInComponent:[temp integerValue]];
    [self.tipo selectRow:[temp integerValue] inComponent:0 animated:YES];
    self.navigationItem.hidesBackButton = YES;
    
    [self.scrolls setScrollEnabled:YES];
    [self.scrolls setContentSize:CGSizeMake(360, 900)];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(buscarImagem)];
    [self.foto addGestureRecognizer:singleTap];
    [self.foto setMultipleTouchEnabled:YES];
    [self.foto setUserInteractionEnabled:YES];
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"foto"];
    if(imageData!=nil){
        UIImage* image = [UIImage imageWithData:imageData];
        //self.foto.image=image;
    }
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
    NSInteger sele=[self.tipo selectedRowInComponent:self.tipo.tag];
    NSNumber *seles=[NSNumber numberWithInteger:sele];
        [[NSUserDefaults standardUserDefaults] setObject:seles forKey:@"sangue"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Atualizado" message:@"Atualização do perfil ok" buttonTitle:@"OK"];
    [alertView show];
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

- (IBAction)criarImagem:(id)sender {
    NSString *teste=[[NSUserDefaults standardUserDefaults] stringForKey: @"nome"];
    UIImage *img=[self imageFromText:teste];
    [self.image setImage:[self imageFromText:teste]];
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
}

-(UIImage *)imageFromText:(NSString *)text
{
    // set the font type and size
    //UIFont *font = [UIFont systemFontOfSize:20.0];
    UIFont *font=[UIFont fontWithName:@"Futura-MediumItalic" size:12.0];
   
    UIImage *base=[UIImage imageNamed:@"background.png"];
    
    UIImage *photo=self.foto.image;
    
    
    
    NSString *temp=[NSString stringWithFormat:@"nome: %@",text];
    
    CGSize size  = CGSizeMake([temp sizeWithFont:font].width, [temp sizeWithFont:font].height*4+5+photo.size.height/10);
    
    CGRect rect = CGRectMake(0,0, [temp sizeWithFont:font].width, [temp sizeWithFont:font].height*4+5);
    
    CGRect rect2 = CGRectMake(0,0, [temp sizeWithFont:font].width, [temp sizeWithFont:font].height*4+5+photo.size.height/10);
    
    UIGraphicsBeginImageContext(size);
    
    [base drawInRect:rect2 blendMode:kCGBlendModeNormal alpha:1.0];
    
    [photo drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    //  [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1] setFill];
    

    CGFloat pos=photo.size.height/10+5;
    
    [temp drawAtPoint:CGPointMake(0.0, pos) withFont:font];
    
    temp=[NSString stringWithFormat:@"peso: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"peso"]];
    
    [temp drawAtPoint:CGPointMake(0, pos+[text sizeWithFont:font].height) withFont:font];
    
    temp=[NSString stringWithFormat:@"Altura: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"altura"]];

    
    [temp drawAtPoint:CGPointMake(0, pos+[text sizeWithFont:font].height*2) withFont:font];
    
  //  [base drawAtPoint:CGPointMake(0, 0)];
    
    NSNumber *numero= [[NSUserDefaults standardUserDefaults] objectForKey: @"sangue"];
    
    
    //Draw image?
    
    
    temp=[NSString stringWithFormat:@"Tipo sanguíneo:  %@",[_sangue objectAtIndex:[numero integerValue] ]];
    
    
    [temp drawAtPoint:CGPointMake(0, pos+[text sizeWithFont:font].height*3) withFont:font];

    /*
    
    self.pesotxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"peso"];
    self.alturatxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"altura"];
    
    
    NSNumber *tempo= [[NSUserDefaults standardUserDefaults] objectForKey: @"sangue"];
    //[self.tipo selectedRowInComponent:[temp integerValue]];
    [self.tipo selectRow:[temp integerValue] inComponent:0 animated:YES];
    */
    // transfer image
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void) buscarImagem{
    NSLog(@"Teste");
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    
     imagePicker.delegate = self;
    
    // Allow editing of image ?
    imagePicker.allowsImageEditing = NO;
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
    /*
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
    //[picker release];
     
     */
}
/*
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.foto = image;
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}
*/

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.foto.image=image;
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.foto.image) forKey:@"foto"];

    [[NSUserDefaults standardUserDefaults] synchronize];
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
