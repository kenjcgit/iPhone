//
//  Change Profile.m
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "Change Profile.h"

@interface Change_Profile ()

@end

@implementation Change_Profile

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScrlChangeProfile setContentSize:CGSizeMake(320, 280)];

    dateformat = [[NSDateFormatter alloc] init];
    
    [datePicker setMaximumDate:[NSDate date]];
    
    profileArray  = [[NSMutableArray alloc]init];
    
    [BtnFemale setSelected:NO];
    [BtnFemale setSelected:NO];
    
    [profileArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"userarray"]];
    TxtName.text = [NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"memName"]];
    TxtEmail.text = [NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"memEmail"]];
    TxtPhone.text = [NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"memMobile"]];
    
    NSString *dateString = [[profileArray objectAtIndex:0]valueForKey:@"memDob"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"MM-dd-yyyy"];
    NSString* finalDateString = [format stringFromDate:date];
    
    TxtBDate.text = [NSString stringWithFormat:@"%@",finalDateString];
    
    ([[[profileArray objectAtIndex:0]valueForKey:@"memGender"]isEqualToString:@"Male"])?[BtnMale setSelected:YES]:[BtnFemale setSelected:YES];
}
- (IBAction)hideDatepicker:(id)sender
{
    [dateView removeFromSuperview];
    [dateformat setDateFormat:@"MM-dd-yyyy"];
    TxtBDate.text=[dateformat stringFromDate:datePicker.date];
}

-(IBAction)BtnBirthdayAction:(id)sender
{
    [self.view endEditing:YES];
    [self.view addSubview:dateView];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate=[NSDate date];
    dateView.frame = CGRectMake(0, self.view.frame.size.height-dateView.frame.size.height+20, dateView.frame.size.width, dateView.frame.size.height);
}
-(IBAction)BtnGenderAction:(id)sender
{
    if ([sender tag]==1)
    {
        if ([BtnMale isSelected])
        {
        }
        else
        {
            [BtnMale setSelected:YES];
            [BtnFemale setSelected:NO];
        }
    }
    else if ([sender tag]==2)
    {
        if ([BtnFemale isSelected])
        {
        }
        else
        {
            [BtnMale setSelected:NO];
            [BtnFemale setSelected:YES];
        }
    }
}

-(IBAction)BtnSubmitAction:(id)sender
{
    if (TxtName.text.length==0)
    {
        FIRSTNAME
    }
    else if (TxtEmail.text.length==0)
    {
        EMAIL
    }
    else if (![Global validateEmail:TxtEmail.text])
    {
        VALIDEMAIL
    }
    else if (TxtPhone.text.length==0)
    {
        PHONENUM
    }
    else if (TxtBDate.text.length==0)
    {
        [Global displayTost:@"Enter Date of Birth."];
    }
    else if(![BtnMale isSelected] && ![BtnFemale isSelected])
    {
        GENDER
    }
    else
    {
        LOADINGSHOW
        [self performSelector:@selector(SignUpJsonAction) withObject:nil afterDelay:0.1f];
    }
}
-(void)SignUpJsonAction
{
    NSString *dateString = TxtBDate.text;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd-yyyy"];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString* finalDateString = [format stringFromDate:date];
    
    NSString *strgender;
    
    if ([BtnMale isSelected])
    {
        strgender = @"Male";
    }
    else
    {
        strgender = @"Female";
    }
    
    NSString *str=[NSString stringWithFormat:@"[{\"memName\":\"%@\",\"memMobile\":\"%@\",\"memEmail\":\"%@\",\"memDob\":\"%@\",\"memGender\":\"%@\",\"memDeviceType\":\"%@\",\"memUDID\":\"%@\",\"memId\":\"%ld\"}]",TxtName.text,TxtPhone.text,TxtEmail.text,finalDateString,strgender,@"iPhone",@"ndvjojdfdsfgdfgfdfgdgdrgg",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"]];
    
    NSDictionary *dict=@{@"action":@"EditProfile",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    NSLog(@"%@",arry);
    LOADINGHIDE
    if ([[[arry objectAtIndex:0]  valueForKey:@"status"]boolValue])
    {
        [self UpdateDeviceTokenAction];
        
        [[NSUserDefaults standardUserDefaults]setInteger:[[[arry objectAtIndex:0]  valueForKey:@"memId"]integerValue] forKey:@"logincsrid"];
        
        [[NSUserDefaults standardUserDefaults]setObject:TxtEmail.text forKey:@"loginUsername"];
        
        NSLog(@"%@",[[arry objectAtIndex:0]  valueForKey:@"memId"]);
        
        [[NSUserDefaults standardUserDefaults]setObject:arry  forKey:@"userarray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userarray"]);
        
        PROFILE
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([[arry objectAtIndex:0]  valueForKey:@"status"])
    {
        [Global displayTost:[[arry objectAtIndex:0]valueForKey:@"status"]];
    }
    else
    {
        NOINTERNET
    }
}

-(void)UpdateDeviceTokenAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memId\":\"%ld\",\"memDeviceType\":\"%@\",\"memUDID\":\"%@\"}]",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"],@"iphone",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
    
    NSDictionary *dict=@{@"action":@"UpdateDeviceInfo",@"json":str};
    
    [Global GetParsingDataUsingAsync:dict d:^(NSArray *ResponseArray) {
        
        NSLog(@"%@",ResponseArray);
        if ([ResponseArray  count]!=0)
        {
            
        }
    }];
    
}


-(IBAction)BtnCancelAction:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
BACK
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
