//
//  EventDetails.h
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "GlobalViewController.h"
@protocol radiuselecteddata <NSObject>
-(void)radiurate:(NSDictionary *)UpdatedDictionary replceindex:(NSInteger)tagindex;
@end


@interface EventDetails : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    IBOutlet UILabel *LblEventName,*LblTag,*LblDate,*LblAddress;
    IBOutlet UITextView *TxtDetails;
    IBOutlet UIImageView *ImgEvent;
    IBOutlet UIScrollView *ScrlEventDetail;
    BOOL isregistered,ismaybe;
    NSString *StrBtnSelected;
    IBOutlet UIButton *Btn1,*Btn2;
    IBOutlet UIView *ViewBottom;
    BOOL pastevent;
    BOOL already;
    
    IBOutlet UIView *ViewSub,*ViewMain;
}
-(IBAction)BtnYesAction:(id)sender;
-(IBAction)BtnMayBeAction:(id)sender;
-(IBAction)BtnBtnMapAction:(id)sender;
-(IBAction)BtnAddToCalenderAction:(id)sender;

-(IBAction)BtnBackAction:(id)sender;

-(IBAction)BtnOpenShareViewAction:(id)sender;
-(IBAction)BtnCancelAction:(id)sender;

@property(nonatomic,retain)NSMutableDictionary *ArrayDetail;

@property(nonatomic,strong)NSString *strname;
@property(nonatomic,weak)id<radiuselecteddata> delegate;

@end
