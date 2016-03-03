//
//  ViewController.m
//  kenJC
//
//  Created by fiplmacmini2 on 09/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "ViewController.h"
#import "SignUp.h"
#import "ForgotPassword.h"
#import "EventListing.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"first";
    //
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"logincsrid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [ScrlLogin setContentSize:CGSizeMake(320, 494)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(BOOL) emailValidation:(NSString *)emailTxt
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailTxt];
}

- (IBAction)SignInClickAction:(id)sender
{
    if (self.txtEmail.text.length==0)
    {
        EMAIL
    }
    else if (![Global validateEmail:self.txtEmail.text])
    {
        VALIDEMAIL
    }
    else if (self.txtPass.text.length==0)
    {
        PASSWORD
    }
    else
    {
        LOADINGSHOW
        [self performSelector:@selector(LoginJsonAction) withObject:nil afterDelay:0.1f];
    }
}
-(void)LoginJsonAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memEmail\":\"%@\",\"memPassword\":\"%@\"}]",self.txtEmail.text,self.txtPass.text];
    
    NSDictionary *dict=@{@"action":@"Login",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    NSLog(@"%@",arry);
    
    LOADINGHIDE
    
    if ([BtnAutoLogion isSelected])
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"AutoLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"AutoLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
    if ([[[arry objectAtIndex:0] valueForKey:@"memId"]integerValue]!=0)
    {
        [[NSUserDefaults standardUserDefaults]setInteger:[[[arry objectAtIndex:0] valueForKey:@"memId"]integerValue] forKey:@"logincsrid"];
        
        [[NSUserDefaults standardUserDefaults]setObject:self.txtEmail.text forKey:@"loginUsername"];
        
        [[NSUserDefaults standardUserDefaults]setObject:self.txtPass.text forKey:@"loginPassword"];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"remember"];
        
        NSLog(@"%@",[[arry objectAtIndex:0]  valueForKey:@"memId"]);
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"reloadafterlogin"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arry forKey:@"userarray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userarray"]);
        
        [Global displayTost:@"Login Successfully"];
        
        [self UpdateDeviceTokenAction];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [Global displayTost:[[arry objectAtIndex:0] valueForKey:@"status"]];
    }

}

-(void)UpdateDeviceTokenAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memId\":\"%ld\",\"memDeviceType\":\"%@\",\"memUDID\":\"%@\"}]",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"],@"iphone",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
    
    NSDictionary *dict=@{@"action":@"UpdateDeviceInfo",@"json":str};
    
    [Global GetParsingDataUsingAsync:dict d:^(NSArray *ResponseArray) {
        
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",dict] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alert show];
        NSLog(@"%@",ResponseArray);
        if ([ResponseArray  count]!=0)
        {
            
        }
    }];

}
- (IBAction)AutoLoginClickAction:(id)sender
{
    if ([BtnAutoLogion isSelected])
    {
        [BtnAutoLogion setSelected:NO];
    }
    else
    {
        [BtnAutoLogion setSelected:YES];
    }
}

- (IBAction)ForgotPassClickAction:(id)sender {
    
    ForgotPassword *forobj = [[ForgotPassword alloc] initWithNibName:@"ForgotPassword" bundle:nil];
    
    [[self navigationController] pushViewController:forobj animated:YES];
}

- (IBAction)SignUpClickAction:(id)sender
{
    SignUp *obj = [[SignUp alloc] initWithNibName:@"SignUp" bundle:nil];
    [[self navigationController] pushViewController:obj animated:YES];
}

- (IBAction)cancelClickAction:(id)sender
{
  //  [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSUInteger numberOfViewControllersOnStack = [self.navigationController.viewControllers count];
    UIViewController *parentViewController = self.navigationController.viewControllers[numberOfViewControllersOnStack - 2];
    Class parentVCClass = [parentViewController class];
    NSString *className = NSStringFromClass(parentVCClass);
    
    if ([className isEqualToString:@"MoreListing"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
