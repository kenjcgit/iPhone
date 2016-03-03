//
//  SignUp.m
//  kenJC
//
//  Created by fiplmacmini2 on 09/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "SignUp.h"
#import "GlobalViewController.h"

@interface SignUp ()

@end

@implementation SignUp

- (void)viewDidLoad
{
    [super viewDidLoad];
    dateformat = [[NSDateFormatter alloc] init];
    
    NSDate *now = [NSDate date];
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-1*24*60*60];
    NSLog(@"7 days ago: %@", sevenDaysAgo);
    
    
    [datePicker setDate:sevenDaysAgo];
    [datePicker setMaximumDate:sevenDaysAgo];
    
    [ScrlSignup setContentSize:CGSizeMake(320, 605)];
}

BACK

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BtnBirthdayAction:(id)sender
{
    [self.view endEditing:YES];
    [self.view addSubview:dateView];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *sevenDaysAgo = [[NSDate date] dateByAddingTimeInterval:-1*24*60*60];
    datePicker.maximumDate=sevenDaysAgo;
    dateView.frame = CGRectMake(0, self.view.frame.size.height-dateView.frame.size.height+20, dateView.frame.size.width, dateView.frame.size.height);
}
-(IBAction)hideDatepicker:(id)sender
{
    [dateView removeFromSuperview];
    [dateformat setDateFormat:@"MM-dd-yyyy"];
    TxtBDate.text=[dateformat stringFromDate:datePicker.date];
}
-(IBAction)BtnSignupAction:(id)sender
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
    else if (TxtPswd.text.length==0)
    {
        PASSWORD
    }
    else if (TxtCfnmPswd.text.length==0)
    {
        CONFPASSWORD
    }
    else if (![TxtPswd.text isEqualToString:TxtCfnmPswd.text])
    {
        PASSWORDMISMATCH
    }
//    else if (TxtPhone.text.length==0)
//    {
//        PHONENUM
//    }
//    else if (TxtBDate.text.length==0)
//    {
//        [Global displayTost:@"Enter Date of Birth."];
//    }
//    else if(![BtnMale isSelected] && ![BtnFemale isSelected])
//    {
//        GENDER
//    }
    else if(![BtnAccept isSelected])
    {
        [Global displayTost:@"Accept Terms and Condition."];
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
    
    NSString* finalDateString;
    
    if (TxtBDate.text.length==0)
    {
        finalDateString = @"0000-00-00";
    }
    else
    {
        finalDateString = [format stringFromDate:date];
    }
    
    NSString *strgender;
    
    if ([BtnMale isSelected])
    {
        strgender = @"Male";
    }
    else if ([BtnFemale isSelected])
    {
         strgender = @"Female";
    }
    else
    {
        strgender = @"";
    }
    
    NSString *str=[NSString stringWithFormat:@"[{\"memName\":\"%@\",\"memMobile\":\"%@\",\"memEmail\":\"%@\",\"memDob\":\"%@\",\"memGender\":\"%@\",\"memDeviceType\":\"%@\",\"memUDID\":\"%@\",\"memPassword\":\"%@\"}]",TxtName.text,(TxtPhone.text.length==0)?@"":TxtPhone.text,TxtEmail.text,finalDateString,strgender,@"iPhone",[[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"],TxtPswd.text];
    
    NSDictionary *dict=@{@"action":@"SignUp",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    NSLog(@"%@",arry);
    if ([[[arry objectAtIndex:0]  valueForKey:@"status"]boolValue])
    {
        [[NSUserDefaults standardUserDefaults]setInteger:[[[[[arry objectAtIndex:0]  valueForKey:@"memId"]objectAtIndex:0]valueForKey:@"memId"]integerValue] forKey:@"logincsrid"];
        
        [[NSUserDefaults standardUserDefaults]setObject:TxtEmail.text forKey:@"loginUsername"];
        
        [[NSUserDefaults standardUserDefaults]setObject:TxtPswd.text forKey:@"loginPassword"];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"remember"];
        
        NSLog(@"%@",[[arry objectAtIndex:0]  valueForKey:@"memId"]);
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"reloadafterlogin"];

        [[NSUserDefaults standardUserDefaults]setObject:[[arry objectAtIndex:0]valueForKey:@"memId"]   forKey:@"userarray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
          NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userarray"]);
 
        [Global displayTost:@"Registered Successfully"];

        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if([[arry objectAtIndex:0]  valueForKey:@"status"])
    {
        [Global displayTost:[[arry objectAtIndex:0]valueForKey:@"status"]];
    }
    else
    {
        NOINTERNET
    }
    LOADINGHIDE
}
-(IBAction)BtnSignupCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)BtnAcceptAction:(id)sender
{
    if ([BtnAccept isSelected])
    {
        [BtnAccept setSelected:NO];
    }
    else
    {
         [BtnAccept setSelected:YES];
    }
}
-(IBAction)BtnTermsAction:(id)sender
{
    TermsView *terms = [[TermsView alloc]initWithNibName:@"TermsView" bundle:nil];
    [self.navigationController pushViewController:terms animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
