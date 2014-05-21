//
//  DCAppDelegate.m
//  Doacoes
//
//  Created by Acácio Veit Schneider on 23/01/14.
//  Copyright (c) 2014 Acácio Veit Schneider. All rights reserved.
//

#import "DCAppDelegate.h"
#import "DCLoginViewController.h"
#import "DCConfigs.h"
#import "DCMapasViewController.h"
#import "DCInicialViewController.h"
#import "SlideNavigationContorllerAnimator.h"
#import "DCLeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import <unistd.h>


@implementation DCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    self.window.tintColor = [UIColor colorWithRed:(107/255.0) green:0 blue:(2/255.0) alpha:1];
    
    
    
    if(launchOptions != nil)
    {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if(userInfo != nil)
        {
            float latitude = [[userInfo objectForKey:@"lat"] floatValue];
            float longitude =[[userInfo objectForKey:@"log"]floatValue];
            MKPointAnnotation *amigo;
            amigo.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            
            UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
//            [navController popToRootViewControllerAnimated:NO];
            
            
            DCLoginViewController *dcvc = (DCLoginViewController *)navController.viewControllers[0];
            dcvc.coordenada = CLLocationCoordinate2DMake(latitude, longitude);
        }
    }
    else
    {
        
    }
    
    
//---------SlideMenu-------------
    DCLeftMenuViewController *left;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
    
    left = [mainStoryboard instantiateViewControllerWithIdentifier: @"leftMenu"];
    
    
    //    _left = [[DCLeftMenuViewController alloc]init];
    id <SlideNavigationContorllerAnimator> revealAnimator;
    revealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc]init];
    [[SlideNavigationController sharedInstance] enableSwipeGesture];
    [SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
    [SlideNavigationController sharedInstance].leftMenu = left;
    [SlideNavigationController sharedInstance].landscapeSlideOffset = 120;
    // Override point for customization after application launch.
    
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("myQueue",
                                  NULL);
    dispatch_async(queue, ^{
        [self vincular];
    }
                   );

    
    return YES;
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    float latitude = [[userInfo objectForKey:@"lat"] floatValue];
    float longitude =[[userInfo objectForKey:@"log"]floatValue];
    NSString *nome = [userInfo objectForKey:@"login"];
    NSString *emergencia = [userInfo objectForKey:@"tipo"];
    MKPointAnnotation *amigo;
    amigo.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    
    if(application.applicationState == UIApplicationStateInactive)
    {
        UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
        [navController popToRootViewControllerAnimated:NO];
        
        
        DCLoginViewController *dcvc = (DCLoginViewController *)navController.viewControllers[0];
        dcvc.coordenada = CLLocationCoordinate2DMake(latitude, longitude);
    }
    if(application.applicationState == UIApplicationStateActive){
//        BOOL push = YES;
        NSNumber *latitude2 = [[NSNumber alloc] initWithFloat:latitude];
        NSNumber *longitude2 = [[NSNumber alloc] initWithFloat:longitude];
//        NSNumber *push2 = [[NSNumber alloc] initWithBool:push];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self];
        [[NSUserDefaults standardUserDefaults] setObject:longitude2 forKey:@"log"];
        [[NSUserDefaults standardUserDefaults] setObject:latitude2 forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pushOnToMap"];
        [[NSUserDefaults standardUserDefaults] setObject:nome forKey:@"nome2"];
        [[NSUserDefaults standardUserDefaults] setObject:emergencia forKey:@"emergencia2"];
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    
    _pushId = [[[[newDeviceToken description]
                 stringByReplacingOccurrencesOfString:@"<" withString:@""]
                stringByReplacingOccurrencesOfString:@">" withString:@""]
               stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", _pushId);
    
    [[NSUserDefaults standardUserDefaults]setObject:_pushId forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //chamar WS passando usuario e token
//    NSString *savedUserName = [[NSUserDefaults standardUserDefaults] stringForKey: @"username"];
//    NSString *savedToken = [[NSUserDefaults standardUserDefaults]stringForKey:@"token"];
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"falhou");
    NSLog(@"%@",[error localizedDescription]);
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self scheduleLocal];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  //  [self scheduleLocal];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"pushOn"];
}

-(void)scheduleLocal{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    if([eventArray count]==0){
        UILocalNotification *localNotif = [[UILocalNotification alloc]init];
        
        NSDate *today = [NSDate dateWithTimeIntervalSinceNow:604800];
//        NSDate *today = [NSDate dateWithTimeIntervalSinceNow:20];
        localNotif.fireDate = today;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        localNotif.alertBody = NSLocalizedString(@"Lembre-se de registrar novos locais!", nil);
        localNotif.alertAction = NSLocalizedString(@"abrir", nil);
        
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];

    }
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    application.applicationIconBadgeNumber = 0;

}

-(void)vincular{
    NSString *savedUserName = self.config.login;
    NSString *savedToken = [[NSUserDefaults standardUserDefaults]stringForKey:@"token"];
    
    if(savedUserName!=nil){
        
        //DCConfigs *config=[[DCConfigs alloc] init];
        
        
        NSString *ur = [NSString stringWithFormat:@"http://%@:8080/Emergencia/vincular.jsp?login=%@&token=%@",self.config.ip,savedUserName,savedToken];
        NSLog(@"URL: %@",ur);
                    
            
            NSURL *urs = [[NSURL alloc] initWithString:ur];
            NSData* data = [NSData dataWithContentsOfURL:urs];
            if (data != nil) {
                
                NSError *jsonParsingError = nil;
                NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
                
                //OBjeto Array
                
                NSNumber *res = [resultado objectForKey:@"vincular"];
                NSNumber *teste=[[NSNumber alloc] initWithInt:1];
                
                
                if([res isEqualToNumber:teste]){
                    NSLog(@"Cadastro ok");
                }
            }
        
    }
    
}


@end
