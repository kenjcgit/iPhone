//
//  NotificationListing.m
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "NotificationListing.h"
#import "NotificationListingCell.h"
#import "EventListing.h"
#import "ContactListing.h"
#import "MoreListing.h"

@interface NotificationListing ()

@end

@implementation NotificationListing
@synthesize tableview;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    ArrayNotification = [[NSMutableArray alloc]initWithObjects:@"New Event Announcement",@"Reminder",@"General Announcement",@"Adult activities",@"Youth activities",@"Mini Maccabi activities",@"Bogrim (young adults)",@"Non-community events",nil];
    
    ArrayNotification2 = [[NSMutableArray alloc]initWithObjects:@"New Event is happening at Miami beach.",@"Dont Miss the Event",@"System Shutdown",nil];
    
     [Btncount setTitle:[NSString stringWithFormat:@"%@",([[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"])?[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"]]:@"0"] forState:UIControlStateNormal];
    
//    if ([AppDelegate checkForNetworkStatus])
//    {
//        LOADINGSHOW
//        [self performSelector:@selector(ResetBadgeCountAction) withObject:nil afterDelay:0.1f];
//    }
//    else
//    {
//        LOADINGHIDE
//        NOINTERNET
//    }
}
//-(void)ResetBadgeCountAction
//{
//    NSDictionary *dict=@{@"action":@"ResetBadge",@"memId":[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]]};
//    
//    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
//    
//    if (arry.count!=0 && [[[arry objectAtIndex:0]valueForKey:@"status"]boolValue])
//    {
//        THIS.notificationcount = 0;
//        [Btncount setTitle:[NSString stringWithFormat:@"%ld",(long)THIS.notificationcount] forState:UIControlStateNormal];
//    }
//    LOADINGHIDE
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)GetNotificationListAction
{
    NSDictionary *dict=@{@"action":@"getnotifications",@"memId":[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]]};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    [ArrayNotification addObjectsFromArray:arry];
   
    [self.tableview reloadData];
    LOADINGHIDE
}
#pragma mark - Tableview Delegate Methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ArrayNotification count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotificationListingCell";
    NotificationListingCell *cell = (NotificationListingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotificationListingCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell.LblName setText:[NSString stringWithFormat:@"%@",[ArrayNotification objectAtIndex:indexPath.row]]];
    
    [cell.LblDetail setNumberOfLines:0];
    [cell.LblDetail setLineBreakMode:NSLineBreakByWordWrapping];
    
    [cell.LblName setFont:[UIFont boldSystemFontOfSize:15.0f]];

    [cell.LblDetail sizeToFit];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    NotificationSubListing *ed = [[NotificationSubListing alloc]initWithNibName:@"NotificationSubListing" bundle:nil];
    
    if (indexPath.row==0)
    {
        ed.strtype = @"New Event";
    }
    else if (indexPath.row==1)
    {
        ed.strtype = @"Event Reminder";
    }
    else if (indexPath.row==2)
    {
        ed.strtype = @"General";
    }
    else if (indexPath.row==3)
    {
        ed.strtype = @"Adult activities";
    }
    else if (indexPath.row==4)
    {
        ed.strtype = @"Youth Activities";
    }
    else if (indexPath.row==5)
    {
        ed.strtype = @"Mini Maccabi activities";
    }
    else if (indexPath.row==6)
    {
        ed.strtype = @"Bogrim";
    }
    else if (indexPath.row==7)
    {
        ed.strtype = @"Non Community Events";
    }
    
    [self.navigationController pushViewController:ed animated:YES];
}

- (IBAction)BtnContact:(id)sender
{
    NSArray *controllerArray = self.navigationController.viewControllers;
    
    for (id controller in controllerArray)
    {
        if ([controller isKindOfClass:[ContactListing class]])
        {
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
    
    ContactListing *eventobj  = [[ContactListing alloc]initWithNibName:@"ContactListing" bundle:nil];
    [self.navigationController pushViewController:eventobj animated:NO];
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
- (IBAction)BtnMore:(id)sender
{
        NSArray *controllerArray = self.navigationController.viewControllers;
    
        for (id controller in controllerArray)
        {
            if ([controller isKindOfClass:[MoreListing class]])
            {
                //do your stuff here
                [self.navigationController popToViewController:controller animated:NO];
                return;
            }
        }
        
        MoreListing *obj = [[MoreListing alloc] initWithNibName:@"MoreListing" bundle:nil];
        
        [[self navigationController] pushViewController:obj animated:NO];
}


@end
