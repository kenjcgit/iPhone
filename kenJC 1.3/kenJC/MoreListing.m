//
//  MoreListing.m
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "MoreListing.h"
#import "EventListing.h"
#import "NotificationListing.h"
#import "ContactListing.h"
#import "NotificationSetting.h"
#import "ChangePassword.h"
#import "Change Profile.h"


@interface MoreListing ()

@end

@implementation MoreListing

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Btncount setTitle:[NSString stringWithFormat:@"%ld",(long)THIS.notificationcount] forState:UIControlStateNormal];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [Btncount setTitle:[NSString stringWithFormat:@"%@",([[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"])?[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"]]:@"0"] forState:UIControlStateNormal];
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        [btnlogout setHidden:NO];
        [imglogoutbg setHidden:NO];
        [lbllogout setHidden:NO];
    }
    else
    {
        [btnlogout setHidden:YES];
        [imglogoutbg setHidden:YES];
        [lbllogout setHidden:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BtnNotificationSetng:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        NotificationSetting *obj = [[NotificationSetting alloc] initWithNibName:@"NotificationSetting" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
    else
    {
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
}

- (IBAction)BtnChangeProfl:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        Change_Profile *obj = [[Change_Profile alloc] initWithNibName:@"Change Profile" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
    else
    {
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
}

- (IBAction)BtnChangePasswrd:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        ChangePassword *obj = [[ChangePassword alloc] initWithNibName:@"ChangePassword" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
    else
    {
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:YES];
    }
}

- (IBAction)BtnLogout:(id)sender
{
    [self UpdateDeviceTokenAction];
    
    ilogin  = [[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"logincsrid"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginUsername"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginPassword"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userarray"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"reloadafterlogout"];

    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [Global displayTost:@"Logout Successfully."];

    ViewController *ViewObj = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:ViewObj animated:YES];
}
-(void)UpdateDeviceTokenAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memId\":\"%ld\",\"memDeviceType\":\"%@\",\"memUDID\":\"%@\"}]",ilogin,@"iphone",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
    
    NSDictionary *dict=@{@"action":@"UpdateDeviceInfo",@"json":str};
    
    [Global GetParsingDataUsingAsync:dict d:^(NSArray *ResponseArray) {
        
        NSLog(@"%@",ResponseArray);
        if ([ResponseArray  count]!=0)
        {
            
        }
    }];
    
}

- (IBAction)BtnEvent:(id)sender
{
    NSArray *controllerArray = self.navigationController.viewControllers;
    //will get all the controllers added to UINavigationController.
    
    for (id controller in controllerArray)
    {
        // iterate through the array and check for your controller
        if ([controller isKindOfClass:[EventListing class]])
        {
            //do your stuff here
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
    
    EventListing *eventobj  = [[EventListing alloc]initWithNibName:@"EventListing" bundle:nil];
    [self.navigationController pushViewController:eventobj animated:NO];
}

- (IBAction)BtnNotification:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        NSArray *controllerArray = self.navigationController.viewControllers;
        //will get all the controllers added to UINavigationController.
        
        for (id controller in controllerArray)
        {
            // iterate through the array and check for your controller
            if ([controller isKindOfClass:[NotificationListing class]])
            {
                //do your stuff here
                [self.navigationController popToViewController:controller animated:NO];
                return;
            }
        }
        
        NotificationListing *obj = [[NotificationListing alloc] initWithNibName:@"NotificationListing" bundle:nil];
        [[self navigationController] pushViewController:obj animated:NO];
    }
    else
    {
        ViewController *obj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [[self navigationController] pushViewController:obj animated:YES];
    }
}

- (IBAction)BtnContact:(id)sender
{
    NSArray *controllerArray = self.navigationController.viewControllers;
    //will get all the controllers added to UINavigationController.
    
    for (id controller in controllerArray)
    {
        // iterate through the array and check for your controller
        if ([controller isKindOfClass:[ContactListing class]])
        {
            //do your stuff here
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
   
    ContactListing *obj = [[ContactListing alloc] initWithNibName:@"ContactListing" bundle:nil];
    
    [[self navigationController] pushViewController:obj animated:NO];
}

-(IBAction)BtnBusReservationAction:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://kenjc.org/bus-registration-s/"]]];
}
-(IBAction)BtnCalenderAction:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://kenjc.org/calendar/"]]];
}

@end
