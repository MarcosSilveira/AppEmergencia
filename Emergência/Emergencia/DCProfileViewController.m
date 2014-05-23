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
@property (weak, nonatomic) IBOutlet UITextField *tel;
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
    self.tel.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"tel"];
    
   
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
    
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.title = @"Seu perfil";

}

-(void)dismissKeyboard {
    [self.tel resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"foto"];
    if(imageData!=nil){
        UIImage* image = [UIImage imageWithData:imageData];
        
        self.foto.image=image;
       // _foto.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        
        
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
    [self cads];
    TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Atualizado" message:@"Atualização do perfil efetuada com sucesso" buttonTitle:@"OK"];
    [alertView show];
}

-(void)cads{
    [[NSUserDefaults standardUserDefaults] setObject:self.nametxt.text forKey:@"nome"];
    [[NSUserDefaults standardUserDefaults] setObject:self.pesotxt.text forKey:@"peso"];
    [[NSUserDefaults standardUserDefaults] setObject:self.alturatxt.text forKey:@"altura"];
    [[NSUserDefaults standardUserDefaults] setObject:self.tel.text forKey:@"tel"];
    NSInteger sele=[self.tipo selectedRowInComponent:self.tipo.tag];
    NSNumber *seles=[NSNumber numberWithInteger:sele];
    [[NSUserDefaults standardUserDefaults] setObject:seles forKey:@"sangue"];
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.foto.image) forKey:@"foto"];
    
    
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

- (IBAction)criarImagem:(id)sender {
    NSString *teste=[[NSUserDefaults standardUserDefaults] stringForKey: @"nome"];
    

    UIImage *img=[self imageFromText:teste];
    
    
    self.image.image = img;
    
    
    
   // [self.image setImage:[self imageFromText:teste]];
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    
    TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"Imagem criada" message:@"Foi gerada uma imagem com suas informações médicas e salva no seu album de fotos. Recomenda-se que você use a imagem gerada como fundo da tela bloqueada." buttonTitle:@"OK"];
    [alertView show];
}

-(UIImage *)imageFromText:(NSString *)text
{
    [self cads];
    
    // set the font type and size
    //UIFont *font = [UIFont systemFontOfSize:20.0];
    UIFont *font=[UIFont fontWithName:@"MarkerFelt-Wide" size:20.0];
   
    UIImage *base=[UIImage imageNamed:@"background.png"];
    
    UIImage *photo=self.foto.image;
    
    
    //Size 568
    
    
    NSString *temp=[NSString stringWithFormat:@"%@",text];
    
    NSString *tel=[NSString stringWithFormat:@"Tel. Contato: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"tel"]];
    
    CGFloat width=100;
    
    
    
    if([temp sizeWithFont:font].width>width&&[temp sizeWithFont:font].width>[tel sizeWithFont:font].width){
        
        width=[temp sizeWithFont:font].width;
    }
    if ([tel sizeWithFont:font].width>width&&[temp sizeWithFont:font].width<[tel sizeWithFont:font].width) {
        width=[tel sizeWithFont:font].width;
    }
    
    width+=50;
    //CGRect rect = CGRectMake(0,0, width/2, [temp sizeWithFont:font].height*5+5);
    
    CGRect rect = CGRectMake(0,0, width, [temp sizeWithFont:font].height*10);
    
    //CGFloat height=rect.size.height+([temp sizeWithFont:font].height+2)*7;
    
    CGFloat height=568;
    
    CGRect rect2 = CGRectMake(0,0, width, height);
    
    CGFloat pos=rect.size.height;

    
    CGSize size  = CGSizeMake(width, height);
    
    
    
    UIGraphicsBeginImageContext(size);
    
    [base drawInRect:rect2 blendMode:kCGBlendModeNormal alpha:1.0];
    
    [photo drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    //  [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1] setFill];
    

    
    [temp drawAtPoint:CGPointMake(10, pos) withFont:font];
    
    temp=[NSString stringWithFormat:@"peso: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"peso"]];
    
    [temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height) withFont:font];
    
    temp=[NSString stringWithFormat:@"Altura: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"altura"]];

    
    [temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*2) withFont:font];
    

    temp=[NSString stringWithFormat:@"Tel. c.:%@",[[NSUserDefaults standardUserDefaults] stringForKey: @"tel"]];
    
    
    [temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*3) withFont:font];

    
     //Sangue
    
    NSNumber *numero= [[NSUserDefaults standardUserDefaults] objectForKey: @"sangue"];
    
    
   
    
    
    temp=[NSString stringWithFormat:@"Tipo sanguíneo:  %@",[_sangue objectAtIndex:[numero integerValue] ]];
    
    
    [temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*4) withFont:font];

    
    
    // transfer image
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
-(void) buscarImagem{
    NSLog(@"Teste");
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    
     imagePicker.delegate = self;
    
    // Allow editing of image ?
    imagePicker.allowsImageEditing = NO;
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
    }
*/

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    //UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //self.foto.image=image;
    
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage* selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    
    //[_foto setContentMode:UIViewContentModeScaleAspectFill];
    [_foto setImage:selectedImage];
    
     //_foto.transform = CGAffineTransformMakeRotation(M_PI_2);

    [_foto sizeThatFits:CGSizeMake(167, 96)];
    
   
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.foto.image) forKey:@"foto"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) buscarImagem
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:NSLocalizedString(@"Cancelar", nil)
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"Tirar uma foto", nil),
                                      NSLocalizedString(@"Escolher uma foto", nil), nil];
        /*
        UIActionSheet *UIActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:NSLocalizedString(@"TAKE_PHOTO", nil),
                                        NSLocalizedString(@"CHOOSE_EXISTING", nil), nil];
         
         */
        [actionSheet showInView:self.view];
    } else {
        [self actionSheet:nil clickedButtonAtIndex:1];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 2)
        return;
    int sourceType[] = {UIImagePickerControllerSourceTypeCamera, UIImagePickerControllerSourceTypePhotoLibrary};
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType[buttonIndex];
    
    [self presentViewController:picker animated:YES completion:^{}];
}


@end