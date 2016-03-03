//
//  EventListing.m
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "EventListing.h"
#import "EventListingCell.h"
#import "NotificationListing.h"
#import "ContactListing.h"
#import "MoreListing.h"
#import "GlobalViewController.h"


@interface EventListing ()

@end

@implementation EventListing
@synthesize tableview,Btncount;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ActivityType = [[NSMutableArray alloc]init];
    ArrayLatest = [[NSMutableArray alloc]initWithObjects:@"Upcoming",@"Completed",nil];
    ArrayImages = [[NSMutableArray alloc]initWithObjects:@"date_full_bg.png",@"date_full_bg1.png",@"date_full_bg2.png",@"date_full_bg3.png",@"date_full_bg4.png",nil];
    
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    Eventarray = [[NSMutableArray alloc]init];
    MainEventArray = [[NSMutableArray alloc]init];
    
    intPageNumber=1;
    
    [BtnLatest setTitle:[NSString stringWithFormat:@"%@",[ArrayLatest objectAtIndex:0]] forState:UIControlStateNormal];

    WallpullToRefreshManager_ = [[MNMBottomPullToRefreshManager2 alloc]initWithPullToRefreshViewHeight:40 tableView:self.tableview withClient:self Settag:0];
    
    
    if (_refreshHeaderView == nil)
    {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableview.bounds.size.height, self.view.frame.size.width, self.tableview.bounds.size.height)];
		view.delegate = self;
		[self.tableview addSubview:view];
		_refreshHeaderView = view;
	}
	
	[_refreshHeaderView refreshLastUpdatedDate];
    
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(EventListJsonAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        LOADINGHIDE
        NOINTERNET
    }
}

-(void)setNotiFication
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reloadmenu:) name:@"Rloadmenu" object:nil];
}
-(void)reloadmenu:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    NSLog (@"Successfully received test notification! %@", userInfo);
    
    [Btncount setTitle:[NSString stringWithFormat:@"%@",([[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"])?[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"]]:@"0"] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [Btncount setTitle:[NSString stringWithFormat:@"%@",([[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"])?[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"notificationcount"]]:@"0"] forState:UIControlStateNormal];
    
//    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
//    {
//        FMDatabase *dataBase = [FMDatabase databaseWithPath:[THIS getDBPath]];
//        [dataBase open];
//        
//        NSString *strSelectQuery3 = [NSString stringWithFormat:@"SELECT * FROM EventList"];
//        
//        FMResultSet *rs3 = [dataBase executeQuery:strSelectQuery3];
//        
//        Eventarray = [[NSMutableArray alloc] init];
//        MainEventArray = [[NSMutableArray alloc]init];
//        
//        while (rs3.next) {
//            [Eventarray addObject:[rs3 resultDict]];
//            [MainEventArray addObject:[rs3 resultDict]];
//        }
//        
//        if (Eventarray.count==0)
//        {
//            if ([AppDelegate checkForNetworkStatus])
//            {
//                LOADINGSHOW
//                [self performSelector:@selector(EventListJsonAction) withObject:nil afterDelay:0.1f];
//            }
//            else
//            {
//                LOADINGHIDE
//                NOINTERNET
//            }
//        }
//        else
//        {
//            [self.tableview reloadData];
//        }
//    }
//    else
//    {
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"reloadafterlogin"] || [[NSUserDefaults standardUserDefaults]boolForKey:@"reloadafterlogout"])
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"reloadafterlogin"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"reloadafterlogout"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [BtnLatest setTitle:[NSString stringWithFormat:@"%@",[ArrayLatest objectAtIndex:0]] forState:UIControlStateNormal];
        [BtnType setTitle:@"Type" forState:UIControlStateNormal];
        
        if ([AppDelegate checkForNetworkStatus])
        {
            Eventarray = [[NSMutableArray alloc]init];
            MainEventArray = [[NSMutableArray alloc]init];
            intPageNumber = 1;
            LOADINGSHOW
            [self performSelector:@selector(EventListJsonAction) withObject:nil afterDelay:0.1f];
        }
        else
        {
            LOADINGHIDE
            NOINTERNET
        }
    }
}
-(void)EventActivityTypeAction
{
    NSDictionary *dict =@{@"action":@"GetActivities"};
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    THIS.ArrayActivity = [[NSMutableArray alloc]init];
    
    [THIS.ArrayActivity addObjectsFromArray:arry];
    
    NSLog(@"%@",THIS.ArrayActivity);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:[THIS getDBPath]];
    [dataBase open];

    if(THIS.ArrayActivity.count!=0)
    {
        for (int i=0; i<[THIS.ArrayActivity count]; i++)
        {
            NSString *strQuery = [NSString stringWithFormat:@"INSERT INTO ActivityType (actTypeId,actTypeName,actInfo) VALUES ('%ld','%@','%@')",(long)[[[THIS.ArrayActivity objectAtIndex:i]valueForKey:@"actTypeId"]integerValue],[[THIS.ArrayActivity objectAtIndex:i]valueForKey:@"actTypeName"],[[THIS.ArrayActivity objectAtIndex:i]valueForKey:@"actInfo"]];
            
            NSLog(@"str query %@",strQuery);
            BOOL result = [dataBase executeUpdate:strQuery];
            
            NSLog(@"%d",result);
        }
    }
    [dataBase close];
    
    LOADINGHIDE
    
    [self OpenPicker:THIS.ArrayActivity];
    otherPicker.delegate = self;
    otherPicker.dataSource = self;
    otherPicker.tag=1;
    
    if (![BtnType.currentTitle isEqualToString:@"Type"])
    {
        NSUInteger index = [[THIS.ArrayActivity valueForKey:@"actTypeName"]indexOfObject:BtnLatest.currentTitle];
        if (index!=NSNotFound)
        {
            [otherPicker selectRow:index inComponent:0 animated:YES];
        }
    }
    else
    {
        [otherPicker selectRow:0 inComponent:0 animated:YES];
    }
    
    [otherPicker reloadAllComponents];
}
-(void)EventListJsonAction
{
    NSDictionary *dict;
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
       dict=@{@"action":@"GetEvents",@"memId":[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]],@"page":[NSString stringWithFormat:@"%d",intPageNumber],@"actTypeId":@"",@"sortType":[NSString stringWithFormat:@"%@",@"1"]};
    }
    else
    {
         dict=@{@"action":@"GetEvents",@"page":[NSString stringWithFormat:@"%d",intPageNumber],@"actTypeId":@"",@"sortType":[NSString stringWithFormat:@"%@",@"1"]};
    }
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];

    if (arry.count==0)
    {
        [Global displayTost:@"No Events Found."];
    }
    
    [Eventarray addObjectsFromArray:arry];
    
    [MainEventArray addObjectsFromArray:arry];

    NSLog(@"%@",Eventarray);
    
    colorindex = 0;
    [self.tableview reloadData];
    
    if(arry.count>=10)
    {
        [WallpullToRefreshManager_ setPullToRefreshViewVisible:TRUE];
    }else
    {
        [WallpullToRefreshManager_ setPullToRefreshViewVisible:FALSE];
    }
    
    [WallpullToRefreshManager_ tableViewReloadFinished];
    
    LOADINGHIDE
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Eventarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventListingCell";
    EventListingCell *cell = (EventListingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EventListingCell" owner:self options:nil] objectAtIndex:0];
   }
    
    [cell.LblEventName setText:[NSString stringWithFormat:@"%@",[[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtName"]]];
    
    [cell.LblEventName setNumberOfLines:0];
    [cell.LblEventName setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSString *tempstring = [[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtInfo"];
    
    tempstring = [tempstring stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    
    [cell.LblEventDetails setText:[NSString stringWithFormat:@"%@",[tempstring stripHtml]]];

    [cell.LblEventDetails setNumberOfLines:0];
    [cell.LblEventDetails setLineBreakMode:NSLineBreakByWordWrapping];
    
    [cell.LblEventDetails setTextColor:[UIColor darkGrayColor]];
    
    [cell.imgviewTime setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[ArrayImages objectAtIndex:colorindex]]]];
    
    if (colorindex==0)
    {
        colorindex++;
    }
    else if (colorindex%4==0)
    {
        colorindex = 0;
    }
    else
    {
        colorindex++;
    }
    
    [cell.LblAddress setText:[NSString stringWithFormat:@"%@",[[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtAddress"]]];
    
    [cell.imgViewCell setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@&w=%d&h=%d&zc=1",IMAGEURLSIZE,[[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtImage"],100*2,95*2]] placeholderImage:nil];
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@&w=%f&h=%f&zc=2",IMAGEURLSIZE,[[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtImage"],cell.imgViewCell.frame.size.width*2,cell.imgViewCell.frame.size.height*2]);
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [dateFormatter1 dateFromString:[[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtStartDate"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSLog(@"%@",[dateFormatter stringFromDate:now]);
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm:ss"];
    NSDate *now2 = [dateFormatter2 dateFromString:[[Eventarray objectAtIndex:indexPath.row]valueForKey:@"evtStartTime"]];
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"hh:mm a"];
    NSLog(@"%@",[dateFormatter3 stringFromDate:now2]);
    
    NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
    [dateFormatter4 setDateFormat:@"yyyy-MMMM-dd"];
    NSLog(@"%@",[dateFormatter4 stringFromDate:now]);
    
    NSArray *ary = [[dateFormatter4 stringFromDate:now] componentsSeparatedByString:@"-"];
    
    [cell.LblTime setText:[NSString stringWithFormat:@"%@\n%@",[dateFormatter stringFromDate:now],[dateFormatter3 stringFromDate:now2]]];
    
    [cell.LblDate setText:[NSString stringWithFormat:@"%@",[ary objectAtIndex:2]]];
    [cell.LblMonth setText:[NSString stringWithFormat:@"%@",[ary objectAtIndex:1]]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    EventDetails *ed = [[EventDetails alloc]initWithNibName:@"EventDetails" bundle:nil];
    ed.ArrayDetail = [Eventarray objectAtIndex:indexPath.row];
    ed.delegate=(id)self;
    ed.strname=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self.navigationController pushViewController:ed animated:YES];
}

- (IBAction)BtnNotification:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        NSArray *controllerArray = self.navigationController.viewControllers;
        
        for (id controller in controllerArray)
        {
            if ([controller isKindOfClass:[NotificationListing class]])
            {
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
    
    for (id controller in controllerArray)
    {
        if ([controller isKindOfClass:[ContactListing class]])
        {
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
    ContactListing *obj = [[ContactListing alloc] initWithNibName:@"ContactListing" bundle:nil];
    
    [[self navigationController] pushViewController:obj animated:NO];
}

- (IBAction)BtnMore:(id)sender
{
    NSArray *controllerArray = self.navigationController.viewControllers;

    for (id controller in controllerArray)
    {
        if ([controller isKindOfClass:[MoreListing class]])
        {
            [self.navigationController popToViewController:controller animated:NO];
            return;
        }
    }
    
    MoreListing *obj = [[MoreListing alloc] initWithNibName:@"MoreListing" bundle:nil];
    [[self navigationController] pushViewController:obj animated:NO];
}

-(IBAction)BtnLatestAction:(id)sender
{
    [self OpenPicker:ArrayLatest];
    otherPicker.delegate = self;
    otherPicker.dataSource = self;
    otherPicker.tag=2;
    
    if (![BtnLatest.currentTitle isEqualToString:@"Select"])
    {
        NSUInteger index = [ArrayLatest indexOfObject:BtnLatest.currentTitle];
        if (index!=NSNotFound)
        {
            [otherPicker selectRow:index inComponent:0 animated:YES];
        }
    }
    else
    {
        [otherPicker selectRow:0 inComponent:0 animated:YES];
    }
    
    [otherPicker reloadAllComponents];
}
-(IBAction)BtnTypeAction:(id)sender
{
    if (THIS.ArrayActivity.count==0)
    {
        FMDatabase *dataBase = [FMDatabase databaseWithPath:[THIS getDBPath]];
        [dataBase open];
        
        NSString *strSelectQuery3 = [NSString stringWithFormat:@"SELECT * FROM ActivityType"];
        
        FMResultSet *rs3 = [dataBase executeQuery:strSelectQuery3];
        
        THIS.ArrayActivity = [[NSMutableArray alloc] init];
        while (rs3.next) {
            [THIS.ArrayActivity addObject:[rs3 resultDict]];
        }
        
        if(THIS.ArrayActivity.count==0)
        {
            LOADINGSHOW
            [self performSelector:@selector(EventActivityTypeAction) withObject:nil afterDelay:0.1f];
        }
        else
        {
            [self OpenPicker:THIS.ArrayActivity];
            otherPicker.delegate = self;
            otherPicker.dataSource = self;
            otherPicker.tag=1;
            
            if (![BtnType.currentTitle isEqualToString:@"Type"])
            {
            NSUInteger index = [[THIS.ArrayActivity valueForKey:@"actTypeName"]indexOfObject:BtnType.currentTitle];
            if (index!=NSNotFound)
            {
                [otherPicker selectRow:index inComponent:0 animated:YES];
            }
            }
            else
            {
                [otherPicker selectRow:0 inComponent:0 animated:YES];
            }
            [otherPicker reloadAllComponents];
        }
    }
    else
    {
        [self OpenPicker:THIS.ArrayActivity];
        otherPicker.delegate = self;
        otherPicker.dataSource = self;
        otherPicker.tag=1;
        if (![BtnType.currentTitle isEqualToString:@"Type"])
        {
            NSUInteger index = [[THIS.ArrayActivity valueForKey:@"actTypeName"]indexOfObject:BtnType.currentTitle];
            if (index!=NSNotFound)
            {
                [otherPicker selectRow:index inComponent:0 animated:YES];
            }
        }
        else
        {
            [otherPicker selectRow:0 inComponent:0 animated:YES];
        }
        
       // [otherPicker selectRow:0 inComponent:0 animated:YES];
        [otherPicker reloadAllComponents];
    }
}
-(void)OpenPicker:(NSMutableArray *)Pickerarray
{
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView= NO;
    
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //[ScrlSignup setUserInteractionEnabled:NO];
    // this prevents the gesture recognizers to 'block' touches
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Hide" object:nil];
    [self.view addSubview:viewOther];
    viewOther.frame = CGRectMake(0, self.view.frame.size.height-viewOther.frame.size.height+20, viewOther.frame.size.width, viewOther.frame.size.height);
    [otherPicker reloadAllComponents];
}
-(void)hideKeyboard
{
    //Code to handle the gesture
    NSLog(@"handleTapFrom");
    [self.view removeGestureRecognizer:gestureRecognizer];
    [viewOther removeFromSuperview];
    
    if(otherPicker.tag==1)
    {
        [BtnType setTitle:[NSString stringWithFormat:@"%@",[[THIS.ArrayActivity objectAtIndex:[otherPicker selectedRowInComponent:0]]valueForKey:@"actTypeName"]] forState:UIControlStateNormal];
        activityid = [[[THIS.ArrayActivity objectAtIndex:[otherPicker selectedRowInComponent:0]]valueForKey:@"actTypeId"]integerValue];
        
            if ([AppDelegate checkForNetworkStatus])//        if ([BtnType.currentTitle isEqualToString:@"All"])
//        {
//            Eventarray = [[NSMutableArray alloc]init];
//            [Eventarray addObjectsFromArray:MainEventArray];
//            colorindex = 0;
//            [self.tableview reloadData];
//        }
//        else
//        {

            {
                LOADINGSHOW
                [self performSelector:@selector(ActivityFilterAction) withObject:nil afterDelay:0.1f];
            }
            else
            {
                LOADINGHIDE
                NOINTERNET
            }
        //}
    }
    else if (otherPicker.tag==2)
    {
        if ([BtnType.titleLabel.text isEqualToString:@"Type"] || [BtnType.titleLabel.text isEqualToString:@"All"])
        {
            [BtnLatest setTitle:[NSString stringWithFormat:@"%@",[ArrayLatest objectAtIndex:[otherPicker selectedRowInComponent:0]]] forState:UIControlStateNormal];
            
          /*  NSDate* currentDate = [NSDate date];
            NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
            //  [_formatter setLocale:[NSLocale currentLocale]];
            [_formatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *_date=[_formatter stringFromDate:currentDate];
            
            NSPredicate *predicate;
            
            if ([otherPicker selectedRowInComponent:0]==0)
            {
                predicate = [NSPredicate predicateWithFormat:@"evtStartDate >= %@", _date];
            }
            else if ([otherPicker selectedRowInComponent:0]==1)
            {
                predicate = [NSPredicate predicateWithFormat:@"evtStartDate <= %@", _date];
            }
            else
            {
                Eventarray = [[NSMutableArray alloc]init];
                [Eventarray addObjectsFromArray:MainEventArray];
                
                colorindex = 0;
                [self.tableview reloadData];
                return;
            }
            
            NSMutableArray *shortPrograms = [[NSMutableArray alloc]init];
            [shortPrograms addObjectsFromArray:[MainEventArray filteredArrayUsingPredicate:predicate]];
            NSDate* currentDate2 = [NSDate date];
            NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
            [_formatter2 setDateFormat:@"yyyy-MM-dd"];
            NSString *date2=[_formatter2 stringFromDate:currentDate2];
            
            NSUInteger index = [[shortPrograms valueForKey:@"evtStartDate"]indexOfObject:date2];
            if (index!=NSNotFound)
            {
                NSDate* currentDate2 = [NSDate date];
                NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
                [_formatter2 setDateFormat:@"HH:mm:ss"];
                
                
                NSString *time1 = [_formatter2 stringFromDate:currentDate2];
                
                NSString *time2;
                
                if ([otherPicker selectedRowInComponent:0]==0)
                {
                    time2 = [[shortPrograms objectAtIndex:index]valueForKey:@"evtStartTime"];
                }
                else if ([otherPicker selectedRowInComponent:0]==1)
                {
                    time2 = [[shortPrograms objectAtIndex:index]valueForKey:@"evtEndTime"];
                }
                
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"HH:mm:ss"];
                
                NSDate *date1= [formatter dateFromString:time1];
                NSDate *date2 = [formatter dateFromString:time2];
                
                NSComparisonResult result = [date1 compare:date2];
                if(result == NSOrderedDescending)
                {
                    NSLog(@"date1 is later than date2");
                    if ([otherPicker selectedRowInComponent:0]==0)
                    {
                        [shortPrograms removeObjectAtIndex:index];
                    }
                    else if ([otherPicker selectedRowInComponent:0]==1)
                    {
                    }
                }
                else if(result == NSOrderedAscending)
                {
                    NSLog(@"date2 is later than date1");
                    if ([otherPicker selectedRowInComponent:0]==0)
                    {
                    }
                    else if ([otherPicker selectedRowInComponent:0]==1)
                    {
                        [shortPrograms removeObjectAtIndex:index];
                    }
                    
                }
                else
                {
                    NSLog(@"date1 is equal to date2");
                }
            }
            Eventarray = [[NSMutableArray alloc]init];
            
            [Eventarray addObjectsFromArray:shortPrograms];
            
            if ([Eventarray count]==0)
            {
                [Global displayTost:@"No Events Found."];
            }
            
            colorindex = 0;
            [self.tableview reloadData];*/
            
            activityid = @"" ;
            if ([AppDelegate checkForNetworkStatus])
            {
                LOADINGSHOW
                [self performSelector:@selector(ActivityFilterAction) withObject:nil afterDelay:0.1f];
            }
            else
            {
                LOADINGHIDE
                NOINTERNET
            }

        }
        else
        {
            if ([AppDelegate checkForNetworkStatus])
            {
                LOADINGSHOW
                [self performSelector:@selector(ActivityFilterAction) withObject:nil afterDelay:0.1f];
            }
            else
            {
                LOADINGHIDE
                NOINTERNET
            }
        }
    }
}
-(IBAction)hideOtherpicker:(id)sender
{
    [viewOther removeFromSuperview];

    if(otherPicker.tag==1)
    {
        [BtnType setTitle:[NSString stringWithFormat:@"%@",[[THIS.ArrayActivity objectAtIndex:[otherPicker selectedRowInComponent:0]]valueForKey:@"actTypeName"]] forState:UIControlStateNormal];
        activityid = [[[THIS.ArrayActivity objectAtIndex:[otherPicker selectedRowInComponent:0]]valueForKey:@"actTypeId"]integerValue];
//        
//        if ([BtnType.currentTitle isEqualToString:@"All"])
//        {
//            Eventarray = [[NSMutableArray alloc]init];
//            [Eventarray addObjectsFromArray:MainEventArray];
//            colorindex = 0;
//            [self.tableview reloadData];
//        }
//        else
//        {
            if ([AppDelegate checkForNetworkStatus])
            {
                LOADINGSHOW
                [self performSelector:@selector(ActivityFilterAction) withObject:nil afterDelay:0.1f];
            }
            else
            {
                LOADINGHIDE
                NOINTERNET
            }
       // }
     }
    else if (otherPicker.tag==2)
    {
        if ([BtnType.titleLabel.text isEqualToString:@"Type"] || [BtnType.titleLabel.text isEqualToString:@"All"])
        {
        [BtnLatest setTitle:[NSString stringWithFormat:@"%@",[ArrayLatest objectAtIndex:[otherPicker selectedRowInComponent:0]]] forState:UIControlStateNormal];
        
        NSDate* currentDate = [NSDate date];
        NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
        //  [_formatter setLocale:[NSLocale currentLocale]];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *_date=[_formatter stringFromDate:currentDate];
        
        NSPredicate *predicate;
        
        if ([otherPicker selectedRowInComponent:0]==0)
        {
            predicate = [NSPredicate predicateWithFormat:@"evtStartDate >= %@", _date];
        }
        else if ([otherPicker selectedRowInComponent:0]==1)
        {
            predicate = [NSPredicate predicateWithFormat:@"evtStartDate <= %@", _date];
        }
        else
        {
            Eventarray = [[NSMutableArray alloc]init];
            [Eventarray addObjectsFromArray:MainEventArray];
            
            colorindex = 0;
            [self.tableview reloadData];
            return;
        }

        NSMutableArray *shortPrograms = [[NSMutableArray alloc]init];
        
//        if ([BtnType.titleLabel.text isEqualToString:@"Type"] || [BtnType.titleLabel.text isEqualToString:@"All"])
//        {
            [shortPrograms addObjectsFromArray:[MainEventArray filteredArrayUsingPredicate:predicate]];
//        }
//        else
//        {
//            [shortPrograms addObjectsFromArray:[Eventarray filteredArrayUsingPredicate:predicate]];
//        }
        
        
        
        NSDate* currentDate2 = [NSDate date];
        NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
        [_formatter2 setDateFormat:@"yyyy-MM-dd"];
        NSString *date2=[_formatter2 stringFromDate:currentDate2];
        
        NSUInteger index = [[shortPrograms valueForKey:@"evtStartDate"]indexOfObject:date2];
        if (index!=NSNotFound)
        {
            NSDate* currentDate2 = [NSDate date];
            NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
            [_formatter2 setDateFormat:@"HH:mm:ss"];
           
            
            NSString *time1 = [_formatter2 stringFromDate:currentDate2];
            
            NSString *time2;
            
            if ([otherPicker selectedRowInComponent:0]==0)
            {
                time2 = [[shortPrograms objectAtIndex:index]valueForKey:@"evtStartTime"];
            }
            else if ([otherPicker selectedRowInComponent:0]==1)
            {
                time2 = [[shortPrograms objectAtIndex:index]valueForKey:@"evtEndTime"];
            }
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm:ss"];
            
            NSDate *date1= [formatter dateFromString:time1];
            NSDate *date2 = [formatter dateFromString:time2];
            
            NSComparisonResult result = [date1 compare:date2];
            if(result == NSOrderedDescending)
            {
                NSLog(@"date1 is later than date2");
                if ([otherPicker selectedRowInComponent:0]==0)
                {
                    [shortPrograms removeObjectAtIndex:index];
                }
                else if ([otherPicker selectedRowInComponent:0]==1)
                {
                }
            }
            else if(result == NSOrderedAscending)
            {
                NSLog(@"date2 is later than date1");
                if ([otherPicker selectedRowInComponent:0]==0)
                {
                }
                else if ([otherPicker selectedRowInComponent:0]==1)
                {
                    [shortPrograms removeObjectAtIndex:index];
                }
                
            }
            else
            {
                NSLog(@"date1 is equal to date2");
            }
        }
        
        Eventarray = [[NSMutableArray alloc]init];
        
        [Eventarray addObjectsFromArray:shortPrograms];
        
        if ([Eventarray count]==0)
        {
            [Global displayTost:@"No Events Found."];
        }
        
        colorindex = 0;
        [self.tableview reloadData];
    }
    else
    {
        if ([AppDelegate checkForNetworkStatus])
        {
            LOADINGSHOW
            [self performSelector:@selector(ActivityFilterAction) withObject:nil afterDelay:0.1f];
        }
        else
        {
            LOADINGHIDE
            NOINTERNET
        }
    }
        
    }
}
-(void)ActivityFilterAction
{
   // Upcoming",@"Completed",@"All
    NSString *str = [[NSString alloc]init];
    
    if ([BtnLatest.titleLabel.text isEqualToString:@"Upcoming"])
    {
        str = [NSString stringWithFormat:@"%@",@"1"];
    }
    else if ([BtnLatest.titleLabel.text isEqualToString:@"Completed"])
    {
        str = [NSString stringWithFormat:@"%@",@"2"];
    }
//    else if ([BtnType.currentTitle isEqualToString:@"All"])
//    {
//        activityid = ;
//    }
    else
    {
        str = [NSString stringWithFormat:@"%@",@"3"];
    }
    
    NSDictionary *dict;
    if ([BtnType.currentTitle isEqualToString:@"All"] || [BtnType.currentTitle isEqualToString:@"Type"])
    {
        dict = @{@"action":@"GetEvents",@"actTypeId":@"",@"sortType":str};
    }
    else
    {
        dict = @{@"action":@"GetEvents",@"actTypeId":[NSString stringWithFormat:@"%ld",activityid],@"sortType":str};
    }
    
//    NSDictionary *dict = @{@"action":@"GetEvents",@"actTypeId":[NSString stringWithFormat:@"%ld",activityid],@"sortType":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    Eventarray = [[NSMutableArray alloc]init];
    
    [Eventarray addObjectsFromArray:arry];
    
    NSLog(@"%@",Eventarray);
    
    if ([Eventarray count]==0)
    {
        [Global displayTost:@"No Events Found."];
    }
    
    colorindex = 0;
    [self.tableview reloadData];
    LOADINGHIDE

    
    
    
  
//    if ([BtnLatest.titleLabel.text isEqualToString:@"Upcoming"] || [BtnLatest.titleLabel.text isEqualToString:@"Completed"])
//    {
//        NSDate* currentDate = [NSDate date];
//        NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
//        //  [_formatter setLocale:[NSLocale currentLocale]];
//        [_formatter setDateFormat:@"yyyy-MM-dd"];
//        
//        NSString *_date=[_formatter stringFromDate:currentDate];
//        
//        NSPredicate *predicate;
//        
//        if ([BtnLatest.titleLabel.text isEqualToString:@"Upcoming"])
//        {
//            predicate = [NSPredicate predicateWithFormat:@"evtStartDate >= %@", _date];
//        }
//        else if ([BtnLatest.titleLabel.text isEqualToString:@"Completed"])
//        {
//            predicate = [NSPredicate predicateWithFormat:@"evtStartDate <= %@", _date];
//        }
//        
//        NSMutableArray *shortPrograms = [[NSMutableArray alloc]init];
//        
//        [shortPrograms addObjectsFromArray:[Eventarray filteredArrayUsingPredicate:predicate]];
//        
//        
//        NSDate* currentDate2 = [NSDate date];
//        NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
//        [_formatter2 setDateFormat:@"yyyy-MM-dd"];
//        NSString *date2=[_formatter2 stringFromDate:currentDate2];
//        
//        NSUInteger index = [[shortPrograms valueForKey:@"evtStartDate"]indexOfObject:date2];
//        if (index!=NSNotFound)
//        {
//            NSDate* currentDate2 = [NSDate date];
//            NSDateFormatter *_formatter2 = [[NSDateFormatter alloc] init];
//            [_formatter2 setDateFormat:@"HH:mm:ss"];
//            
//            
//            NSString *time1 = [_formatter2 stringFromDate:currentDate2];
//            
//            NSString *time2;
//            
//            if ([BtnLatest.titleLabel.text isEqualToString:@"Upcoming"])
//            {
//                time2 = [[shortPrograms objectAtIndex:index]valueForKey:@"evtStartTime"];
//            }
//            else if ([BtnLatest.titleLabel.text isEqualToString:@"Completed"])
//            {
//                time2 = [[shortPrograms objectAtIndex:index]valueForKey:@"evtEndTime"];
//            }
//            
//            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"HH:mm:ss"];
//            
//            NSDate *date1= [formatter dateFromString:time1];
//            NSDate *date2 = [formatter dateFromString:time2];
//            
//            NSComparisonResult result = [date1 compare:date2];
//            if(result == NSOrderedDescending)
//            {
//                NSLog(@"date1 is later than date2");
//                if ([BtnLatest.titleLabel.text isEqualToString:@"Upcoming"])
//                {
//                    [shortPrograms removeObjectAtIndex:index];
//                }
//                else if ([BtnLatest.titleLabel.text isEqualToString:@"Completed"])
//                {
//                }
//            }
//            else if(result == NSOrderedAscending)
//            {
//                NSLog(@"date2 is later than date1");
//                if ([BtnLatest.titleLabel.text isEqualToString:@"Upcoming"])
//                {
//                }
//                else if ([BtnLatest.titleLabel.text isEqualToString:@"Completed"])
//                {
//                    [shortPrograms removeObjectAtIndex:index];
//                }
//                
//            }
//            else
//            {
//                NSLog(@"date1 is equal to date2");
//            }
//        }
//        Eventarray = [[NSMutableArray alloc]init];
//        
//        [Eventarray addObjectsFromArray:shortPrograms];
//       
//    }
//    
}
#pragma mark - UIPickerView Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(otherPicker.tag==1)
    {
        return [THIS.ArrayActivity count];
    }
    else if (otherPicker.tag==2)
    {
        return [ArrayLatest count];
    }
    return [THIS.ArrayActivity count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(otherPicker.tag==1)
    {
         return [[THIS.ArrayActivity objectAtIndex:row]valueForKey:@"actTypeName"];
    }
    else if (otherPicker.tag==2)
    {
         return [ArrayLatest objectAtIndex:row];
    }
    return [[THIS.ArrayActivity objectAtIndex:row]valueForKey:@"actTypeName"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(otherPicker.tag==1)
    {
        [BtnType setTitle:[NSString stringWithFormat:@"%@",[[THIS.ArrayActivity objectAtIndex:[otherPicker selectedRowInComponent:0]]valueForKey:@"actTypeName"]] forState:UIControlStateNormal];
    }
    else if (otherPicker.tag==2)
    {
        [BtnLatest setTitle:[NSString stringWithFormat:@"%@",[ArrayLatest objectAtIndex:[otherPicker selectedRowInComponent:0]]] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    NSDictionary *dict;
    
    [BtnLatest setTitle:[NSString stringWithFormat:@"%@",[ArrayLatest objectAtIndex:0]] forState:UIControlStateNormal];
    [BtnType setTitle:@"Type" forState:UIControlStateNormal];
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"])
    {
        dict=@{@"action":@"GetEvents",@"memId":[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]],@"page":[NSString stringWithFormat:@"%@",@"1"],@"actTypeId":@"",@"sortType":[NSString stringWithFormat:@"%@",@"1"]};
    }
    else
    {
         dict=@{@"action":@"GetEvents",@"page":[NSString stringWithFormat:@"%@",@"1"],@"actTypeId":@"",@"sortType":[NSString stringWithFormat:@"%@",@"1"]};
    }
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    
    [Eventarray removeAllObjects];
    [MainEventArray removeAllObjects];
    
    [Eventarray addObjectsFromArray:arry];
    [MainEventArray addObjectsFromArray:arry];
    NSLog(@"%@",Eventarray);
    colorindex = 0;
    [self.tableview reloadData];
    
    if(arry.count>=10)
    {
        [WallpullToRefreshManager_ setPullToRefreshViewVisible:TRUE];
    }else
    {
        [WallpullToRefreshManager_ setPullToRefreshViewVisible:FALSE];
    }
    
    [WallpullToRefreshManager_ tableViewReloadFinished];
    
  //  LOADINGHIDE
//
   // [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0f];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableview];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [WallpullToRefreshManager_ tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [WallpullToRefreshManager_ tableViewReleased];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	//[self reloadTableViewDataSource];
    [self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:1.0f];

	 [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0f];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
- (void)viewDidUnload {
	_refreshHeaderView=nil;
}

//- (void)dealloc {
//	
//	_refreshHeaderView = nil;
//    [super dealloc];
//}

-(void)radiurate:(NSDictionary *)UpdatedDictionary replceindex:(NSInteger)tagindex
{
    NSLog(@"Eventarray %@",Eventarray);
    NSLog(@"UpdatedDictionary %@",UpdatedDictionary);
    NSLog(@"tagindex %ld",(long)tagindex);
    
    [Eventarray replaceObjectAtIndex:tagindex withObject:UpdatedDictionary];
    
    NSUInteger index2 = [[MainEventArray valueForKey:@"evtId"]indexOfObject:[[Eventarray objectAtIndex:tagindex]valueForKey:@"evtId"]];
    
    if (index2!=NSNotFound)
    {
        [MainEventArray replaceObjectAtIndex:index2 withObject:[Eventarray objectAtIndex:tagindex]];
    }
    
    NSLog(@"Eventarray %@",Eventarray);
     NSLog(@"MainEventArray %@",MainEventArray);
}

#pragma mark  - PullToRefersh
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [WallpullToRefreshManager_ tableViewScrolled];
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [WallpullToRefreshManager_ tableViewReleased];
//}

- (void)MNMBottomPullToRefreshManagerClientReloadTableGetTag:(NSInteger)tag
{
    if([Eventarray count] != 0 && (10*intPageNumber)<=Eventarray.count)
    {
        intPageNumber = intPageNumber + 1;
        
       // [txtserchfriend resignFirstResponder];
        
        LOADINGSHOW
        [self performSelector:@selector(EventListJsonAction) withObject:nil afterDelay:0.1f];
    }
}

@end
