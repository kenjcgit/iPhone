//
//  AppDelegate.m
//  kenJC
//
//  Created by fiplmacmini2 on 09/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "GlobalViewController.h"
#import "LabeledActivityIndicatorView.h"

#import <AVFoundation/AVFoundation.h>
#import "AFHTTPClient.h"
#import "AFNetworking.h"

#import <AudioToolbox/AudioToolbox.h>
#import "GlobalViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize ArrayActivity,notificationcount,apsInfo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:-1];
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self DropDBToDocument];
    
    EventListing *vc=[[EventListing alloc]initWithNibName:@"EventListing" bundle:nil];
    
    [Global GetParsingDataUsingAsync:@{@"action":@"GetActivities"} GetKey:@"" GetTimeinterval:0 d:^(NSArray *ResponseArray)
     {
         ArrayActivity = [[NSMutableArray alloc]init];
         [ArrayActivity addObjectsFromArray:ResponseArray];
         NSLog(@"%@",ArrayActivity);
         
         NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
         [dict setObject:@"909" forKey:@"actTypeId"];
         [dict setObject:@"All" forKey:@"actTypeName"];
         [dict setObject:@"All" forKey:@"actInfo"];
         
         [ArrayActivity addObject:dict];
         
         FMDatabase *dataBase = [FMDatabase databaseWithPath:[THIS getDBPath]];
         [dataBase open];
         
         NSString *strSelectQuery3 = [NSString stringWithFormat:@"SELECT * FROM ActivityType"];
         
         FMResultSet *rs3 = [dataBase executeQuery:strSelectQuery3];
         
         NSMutableArray *tmpary2 = [[NSMutableArray alloc] init];
         while (rs3.next) {
             [tmpary2 addObject:[rs3 resultDict]];
         }
         
         if(tmpary2.count==0)
         {
             for (int i=0; i<[ArrayActivity count]; i++)
             {
                 NSString *strQuery = [NSString stringWithFormat:@"INSERT INTO ActivityType (actTypeId,actTypeName,actInfo) VALUES ('%ld','%@','%@')",(long)[[[ArrayActivity objectAtIndex:i]valueForKey:@"actTypeId"]integerValue],[[ArrayActivity objectAtIndex:i]valueForKey:@"actTypeName"],[[ArrayActivity objectAtIndex:i]valueForKey:@"actInfo"]];
                 
                 NSLog(@"str query %@",strQuery);
                 BOOL result = [dataBase executeUpdate:strQuery];
                 
                 NSLog(@"%d",result);
             }
         }
         [dataBase close];
     }];
    
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (localNotif)
    {
        //        NSDictionary *userInfo=[[NSDictionary alloc]init];
        //        userInfo=localNotif;
        apsInfo = [localNotif valueForKey:@"aps"];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",@"Reminder"] message:[apsInfo valueForKey:@"alert"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
        application.applicationIconBadgeNumber =application.applicationIconBadgeNumber-1;
//        counter=application.applicationIconBadgeNumber;
//        [self performSelector:@selector(resetcounterapi) withObject:nil afterDelay:0.1f];
    }


    self.Navigationcontroller = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:self.Navigationcontroller];
    [self.Navigationcontroller setNavigationBarHidden:YES];
    [self.window makeKeyAndVisible];
    
    return YES;
}
static AppDelegate *temp = nil;
+(AppDelegate*)sharedInstance
{
    if(!temp)
    {
        temp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    }
    return temp;
}

+(BOOL)checkForNetworkStatus
{
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

#define DBAdd Code
-(NSString *)getDBPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"KenJC.rdb"];
}
-(void) DropDBToDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"KenJC.rdb"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults]setInteger:application.applicationIconBadgeNumber  forKey:@"notificationcount"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Rloadmenu" object:nil userInfo:@{@"Noti":@"NP",@"Count":[NSString stringWithFormat:@"%ld",(long)application.applicationIconBadgeNumber]}];
    
    if([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        NSString *str=[NSString stringWithFormat:@"[{\"memId\":\"%ld\",\"badge\":\"%ld\"}]",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"],(long)application.applicationIconBadgeNumber];
        
        NSDictionary *dict=@{@"action":@"ResetBadge",@"json":str};
        
        [Global GetParsingDataUsingAsync:dict GetKey:@"" GetTimeinterval:0 d:^(NSArray *ResponseArray)
         {
             NSLog(@"appdelegate response=%@",[NSString stringWithFormat:@"%ld",(long)application.applicationIconBadgeNumber]);
             [[NSUserDefaults standardUserDefaults]setInteger:application.applicationIconBadgeNumber  forKey:@"notificationcount"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"Rloadmenu" object:nil userInfo:@{@"Noti":@"NP",@"Count":[NSString stringWithFormat:@"%ld",(long)application.applicationIconBadgeNumber]}];
             THIS.notificationcount = application.applicationIconBadgeNumber;
           //  application.applicationIconBadgeNumber = 0;
         }];
    }

    evtobj = [[EventListing alloc]init];
    
    [evtobj.Btncount setTitle:[NSString stringWithFormat:@"%ld",(long)application.applicationIconBadgeNumber] forState:UIControlStateNormal];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
#pragma mark Push Notification Actions:

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * tokenAsString = [[[deviceToken description]
                                 stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"tokenAsString = %@",tokenAsString);
    
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Device token" message:tokenAsString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    
    [[NSUserDefaults standardUserDefaults]setObject:tokenAsString forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    UIAlertView *alert1 = [[UIAlertView alloc]  initWithTitle:@"alert"
                                                      message:[NSString stringWithFormat:@"Error in registration. Error: %@", err]
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [alert1 show];
}

-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView *alert;
    if([otherTitle isEqualToString:@""])
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:nil,nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle,nil];
    [alert show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    apsInfo = [userInfo objectForKey:@"aps"];
    
    // application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    
    [[NSUserDefaults standardUserDefaults]setInteger:[[apsInfo objectForKey:@"badge"] integerValue]  forKey:@"notificationcount"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    if(application.applicationState == UIApplicationStateInactive||application.applicationState == UIApplicationStateBackground)
    {
        application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",@"Reminder"] message:[apsInfo valueForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:159];
        [alert show];
    }
    else
    {
    }

//    if(application.applicationState == UIApplicationStateInactive||application.applicationState == UIApplicationStateBackground)
//    {
//        application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
//    }
//    else
//    {
//        application.applicationIconBadgeNumber  = 0;
//    }
}

@end
