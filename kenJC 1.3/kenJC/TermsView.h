//
//  TermsView.h
//  kenJC
//
//  Created by Apple on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface TermsView : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UIWebView *WebTerms;
}
-(IBAction)BtnBackAction:(id)sender;
@end
