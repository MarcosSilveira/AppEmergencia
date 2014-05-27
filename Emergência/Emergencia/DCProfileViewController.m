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
@property (weak, nonatomic) IBOutlet UISwitch *doador;
@property (weak, nonatomic) IBOutlet UITextField *alergiastxt;
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
    
//  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.navigationController.navigationBar.alpha = 0.6;
    self.navigationItem.title = @"Seu perfil";
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255/255 green: 0/255 blue:0/255 alpha:1];

    _sangue=@[@"A+",@"A-",@"AB+",@"AB-",@"B+",@"B-", @"O+",@"O-"];
    
    
    self.nametxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"nome"];
    self.pesotxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"peso"];
    self.alturatxt.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"altura"];
    self.tel.text=[[NSUserDefaults standardUserDefaults] stringForKey: @"tel"];
    _doador.on = NO;
    _doador.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"doador"];
    _alergiastxt.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"alergias"];
    NSNumber *temp= [[NSUserDefaults standardUserDefaults] objectForKey: @"sangue"];
   //[self.tipo selectedRowInComponent:[temp integerValue]];
    
    [self.tipo selectRow:[temp integerValue] inComponent:0 animated:YES];
    self.navigationItem.hidesBackButton = YES;
    
    [self.scrolls setScrollEnabled:YES];
    [self.scrolls setContentSize:CGSizeMake(360, 1100)];
    
    
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
//    if(imageData!=nil){
        UIImage* image = [UIImage imageWithData:imageData];
//
        self.foto.image=image;
//       //_foto.transform = CGAffineTransformMakeRotation(M_PI_2);
//        
//        
//        
//    }
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
    
    [[NSUserDefaults standardUserDefaults] setBool:[_doador isOn] forKey:@"doador"];
    [[NSUserDefaults standardUserDefaults] setObject:self.alergiastxt.text forKey:@"alergias"];
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
    UIFont *font=[UIFont fontWithName:@"MarkerFelt-Wide" size:25.0];
   
    UIImage *base=[UIImage imageNamed:@"background"];
    
    UIImage *photo=self.foto.image;
    
    
    //Size 568
    
    
    NSString *temp=[NSString stringWithFormat:@"%@",text];
    
    NSString *tel=[NSString stringWithFormat:@"Tel. Contato: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"tel"]];
    
    CGFloat width=100;
    
    NSString *alergia=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] stringForKey: @"alergias"]];
    
   
    NSArray *splitArray =[alergia componentsSeparatedByString:@","]; //it separates the string and store it in the different different indexes.

    
    if([temp sizeWithFont:font].width>width&&[temp sizeWithFont:font].width>[tel sizeWithFont:font].width){
        
        width=[temp sizeWithFont:font].width;
    }
    if ([tel sizeWithFont:font].width>width&&[temp sizeWithFont:font].width<[tel sizeWithFont:font].width) {
        width=[tel sizeWithFont:font].width;
    }
    
    if (splitArray.count>1) {
        
        CGFloat maior=0;
        
        for (int i=0; i<splitArray.count; i+=2) {
            int aux=i+1;
            NSString *juncao;
            if(aux<splitArray.count){
                juncao=[NSString stringWithFormat:@"%@, %@",splitArray[i],splitArray[aux]];
                if(i==0){
                    juncao=[NSString stringWithFormat:@"Alergias: %@",juncao];
                    
                }
                if(maior<[juncao sizeWithFont:font].width){
                    maior=[juncao sizeWithFont:font].width;
                }
            }
           
            
        }
        
        if(width<maior){
            width=maior;
        }

    }
        width+=50;
       CGFloat height=568;
    
    if(width*2>height){
        height=width*2;
    }
    
    //Testar height
    if(splitArray.count*[temp sizeWithFont:font].height>height){
        height=splitArray.count*[temp sizeWithFont:font].height+568;
    }
    
    
    NSLog(@"Width %f altura %f",width,height);

    
    //CGRect rect = CGRectMake(0,0, width/2, [temp sizeWithFont:font].height*5+5);
    
    CGRect rect = CGRectMake(width/14,0, width*0.8, [temp sizeWithFont:font].height*10);//Foto
    
    //CGFloat height=rect.size.height+([temp sizeWithFont:font].height+2)*7;
    
    
    
    CGRect rect2 = CGRectMake(0,0, width, height);//Imagem toda
    
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
    

    temp=[NSString stringWithFormat:@"Tel. c. :%@",[[NSUserDefaults standardUserDefaults] stringForKey: @"tel"]];
    
    
    [temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*3) withFont:font];
    
    

    for (int i=0; i<splitArray.count; i+=2) {
        int aux=i+1;
        NSString *juncao;
        if(aux<splitArray.count){
            juncao=[NSString stringWithFormat:@"%@, %@",splitArray[i],splitArray[aux]];
            
        }else {
            juncao=[NSString stringWithFormat:@"%@",splitArray[i]];
        }
        
                if(i==0){
            juncao=[NSString stringWithFormat:@"Alergias: %@",juncao];
            [juncao drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*6+i) withFont:font];
        }else{
            NSLog(@"Aqui com o i %d",i);
            [juncao drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*(6+i-1)) withFont:font];

        }
    }

    
    //temp=[NSString stringWithFormat:@"Alergias: %@",[[NSUserDefaults standardUserDefaults] stringForKey: @"alergias"]];
    
    
    //[temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*6) withFont:font];
    
    BOOL aux=[[NSUserDefaults standardUserDefaults] stringForKey: @"doador"];
    if (aux) {
        temp=@"Sou doador de orgãos? Sim";
        
        
    }
    else
        temp = @"Sou doador de orgãos? Não";
    
    [temp drawAtPoint:CGPointMake(10, pos+[text sizeWithFont:font].height*5) withFont:font];
    
    
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
    UIImage* selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    if(selectedImage.imageOrientation==UIImageOrientationUp){
//        CGImageRef cgRef = selectedImage.CGImage;
//        selectedImage = [[UIImage alloc] initWithCGImage:cgRef scale:1.0 orientation:UIImageOrientationRight];
//        
//    }
    
    selectedImage = [self scaleAndRotateImage:selectedImage];
    
//    CGImageRef cgRef = selectedImage.CGImage;
//    selectedImage = [[UIImage alloc] initWithCGImage:cgRef scale:1.0 orientation:UIImageOrientationUp];
    
    
    [_foto setContentMode:UIViewContentModeScaleAspectFill];
    [_foto setImage:selectedImage];
    
     //_foto.transform = CGAffineTransformMakeRotation(M_PI_2);

//    [_foto sizeThatFits:CGSizeMake(167, 96)];
    
   
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.foto.image) forKey:@"foto"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(UIImage *)scaleAndRotateImage: (UIImage *) image
{
    int kMaxResolution = 320; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();  
    
    return imageCopy;  
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




@end

