//
//  ChangePassword.m
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "ChangePassword.h"

@interface ChangePassword ()

@end

@implementation ChangePassword

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScrlChange setContentSize:CGSizeMake(320, 400)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)BtnSubmitAction:(id)sender
{
    if (TxtCurrentPswd.text.length==0)
    {
        PASSWORD
    }
    else if (![TxtCurrentPswd.text isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPassword"]])
    {
        CURRENTPSWD
    }
    else if (TxtNewPswd.text.length==0)
    {
        NEWPSWD
    }
    else if (TxtRePswd.text.length==0)
    {
        REPSWD
    }
    else if (![TxtNewPswd.text isEqualToString:TxtRePswd.text])
    {
        MISMATCH
    }
    else
    {
        LOADINGSHOW
        [self performSelector:@selector(ChangePswdAction) withObject:nil afterDelay:0.1f];
    }
}
-(void)ChangePswdAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memId\":\"%ld\",\"memPassword\":\"%@\"}]",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"logincsrid"],TxtNewPswd.text];
    
    NSDictionary *dict=@{@"action":@"ChangePassword",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    NSLog(@"%@",arry);

    LOADINGHIDE
    
    if ([[[arry objectAtIndex:0]  valueForKey:@"status"]isEqualToString:@"Successfully updated"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:TxtNewPswd.text forKey:@"loginPassword"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        CHANGEPSWD
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [Global displayTost:[[arry objectAtIndex:0]  valueForKey:@"status"]];
    }
}
-(IBAction)BtnCancelAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
