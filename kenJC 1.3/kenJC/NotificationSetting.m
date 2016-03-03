//
//  NotificationSetting.m
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "NotificationSetting.h"

@interface NotificationSetting ()

@end

@implementation NotificationSetting

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    ArrayUser = [[NSMutableArray alloc]init];
    [ArrayUser addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"userarray"]];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memActivityReminderPush"]isEqualToString:@"Yes"])?[BtnActivity setOn:YES]:[BtnActivity setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memEventReminderPush"]isEqualToString:@"Yes"])?[BtnEventReminder setOn:YES]:[BtnEventReminder setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memGeneralPush"]isEqualToString:@"Yes"])?[BtnGeneral setOn:YES]:[BtnGeneral setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memNewEventPush"]isEqualToString:@"Yes"])?[BtnNewEvent setOn:YES]:[BtnNewEvent setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memPush"]isEqualToString:@"Yes"])?[BtnMuteAll setOn:YES]:[BtnMuteAll setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memAdultActivities"]isEqualToString:@"Yes"])?[BtnAdultActivities setOn:YES]:[BtnAdultActivities setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memYouthActivities"]isEqualToString:@"Yes"])?[BtnYouthActivities setOn:YES]:[BtnYouthActivities setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memMiniMaccabiActivities"]isEqualToString:@"Yes"])?[BtnMiniMaccabiActivities setOn:YES]:[BtnMiniMaccabiActivities setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memBogrim"]isEqualToString:@"Yes"])?[BtnBogrim setOn:YES]:[BtnBogrim setOn:NO];
    
    ([[[ArrayUser objectAtIndex:0]valueForKey:@"memNonCommunityEvents"]isEqualToString:@"Yes"])?[BtnNonCommunity setOn:YES]:[BtnNonCommunity setOn:NO];

}

BACK

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)NewEventAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)GeneralAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)ActivityReminderAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)EventReminderAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)MuteAllAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)AdultActivitiesAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)YouthActivitiesAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)MiniMaccabiActivitiesAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)BogrimAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
- (IBAction)NonCommunityAction:(id)sender
{
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(NotificationSettingJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}
-(void)NotificationSettingJsonAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memNewEventPush\":\"%@\",\"memGeneralPush\":\"%@\",\"memActivityReminderPush\":\"%@\",\"memEventReminderPush\":\"%@\",\"memPush\":\"%@\",\"memAdultActivities\":\"%@\",\"memYouthActivities\":\"%@\",\"memMiniMaccabiActivities\":\"%@\",\"memBogrim\":\"%@\",\"memNonCommunityEvents\":\"%@\",\"memId\":\"%ld\"}]",([BtnNewEvent isOn])?@"Yes":@"No",([BtnGeneral isOn])?@"Yes":@"No",([BtnActivity isOn])?@"Yes":@"No",([BtnEventReminder isOn])?@"Yes":@"No",([BtnMuteAll isOn])?@"Yes":@"No",([BtnAdultActivities isOn])?@"Yes":@"No",([BtnYouthActivities isOn])?@"Yes":@"No",([BtnMiniMaccabiActivities isOn])?@"Yes":@"No",([BtnBogrim isOn])?@"Yes":@"No",([BtnNonCommunity isOn])?@"Yes":@"No",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]];
    
    NSDictionary *dict=@{@"action":@"EditNotificationSettings",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    NSLog(@"%@",arry);
    if ([[[arry objectAtIndex:0] valueForKey:@"status"]boolValue])
    {
        [[NSUserDefaults standardUserDefaults]setObject:arry  forKey:@"userarray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [Global displayTost:@"Successfully updated."];
    }
    LOADINGHIDE
}


@end
