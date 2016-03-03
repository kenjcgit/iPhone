//
//  TermsView.m
//  kenJC
//
//  Created by Apple on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "TermsView.h"

@interface TermsView ()

@end

@implementation TermsView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WebTerms.opaque = NO;
    [WebTerms setBackgroundColor:[UIColor clearColor]];
    
    WebTerms.scrollView.delegate = self;
    
    if ([AppDelegate checkForNetworkStatus])
    {
        LOADINGSHOW
        [self performSelector:@selector(GetWebImageAction) withObject:nil afterDelay:0.1f];
    }
    else
    {
        NOINTERNET
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)GetWebImageAction
{
    [WebTerms loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",CMSTERMS]]]];
}
#pragma mark - Webview delegate methods

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webview finished loading");
    if(!webView.isLoading){ //This ensures whether the webview has finished loading..
        LOADINGHIDE
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webview started loading");
}
-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSString *urlString = url.absoluteString;
    
    NSLog(@"urlstring is %@", urlString);
    
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error is %@", [error localizedDescription]);
}
-(IBAction)BtnBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
