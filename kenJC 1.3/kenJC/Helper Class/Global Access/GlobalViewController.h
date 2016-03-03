//
//  [GlobalViewController.h
//  MakeUpArtist
//
//  Created by Ashesh Shah on 21/10/13.
//  Copyright (c) 2013 Ashesh Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "LabeledActivityIndicatorView.h"
#import "NSArray+ReplaceNull.h"
#import "AppDelegate.h"
#import "ValidationAndJsonViewController.h"
//#import "MNMBottomPullToRefreshManager.h"
#import "NSDate+SSToolkitAdditions.h"
#import "EGOCache.h"
#import <QuartzCore/QuartzCore.h>
//#import "MWPhotoBrowser.h"
//#import "MNMPullToRefreshManager.h"
#import "iToast.h"
#import "AMTextFieldNumberPad.h"
#import "MessageViewContoller.h"
#import "Reachability.h"

#import "UIImageView+AFNetworking.h"

#import "NSObject+NSString_stripHtml.h"

#import "FMDatabase.h"

#import "SignUp.h"
#import "ViewController.h"
#import "TermsView.h"
#import "EventListing.h"
#import "MoreListing.h"
#import "Change Profile.h"
#import "ChangePassword.h"
#import "NotificationListing.h"
#import "ContactListing.h"
#import "NotificationSetting.h"
#import "EventDetails.h"
#import "EventMapView.h"
#import "NotificationSubListing.h"
//#import "MNMPullToRefreshManager.h"

//#import "MNMBottomPullToRefreshManager.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>


#define THIS [AppDelegate sharedInstance]


/*(http://108.175.160.244/mygarage/timthumb.php?src=images/Listing/IMAGE_08-05-2014-8_48_37.PNG&w=100&h=100&zc=2*/

#define  LOADINGSHOW     LabeledActivityIndicatorView *aiv = [[LabeledActivityIndicatorView alloc]initWithController:self andText:@"Loading..."];[aiv show];aiv.tag = 10000;

#define  LOADINGHIDE     [[self.view viewWithTag:10000] removeFromSuperview];




/*
#define BASEAPI @"http://108.175.160.244/mygarage/json.php?"
#define CMSBASEAPI @"http://108.175.160.244/mygarage/"
#define IMAGEURL @"http://108.175.160.244/mygarage/images"
#define IMAGEURLSIZE @"http://108.175.160.244/mygarage/timthumb.php?src=images"
#define IMAGECOVERFLOW @"http://108.175.160.244/mygarage/admin/images/photogallery"
#define IMAGECOVERFLOWSIZE @"http://108.175.160.244/mygarage/timthumb.php?src=admin/images/photogallery"
 */
//kenjc.org/mobile/app/json.php

#define BASEAPI @"http://kenjc.org/mobile/app/json.php?"

#define CMSBASEAPI @"http://kenjc.org/mobile/app/json.php?"

#define CMSTERMS @"http://kenjc.org/mobile/app/cmsdetail.php?pagename=terms"

#define IMAGEURL @"http://kenjc.org/mobile/app/uploads/events/"
#define ACTIVITYTYPE @"http://kenjc.org/mobile/app/uploads"
#define IMAGEURLSIZE @"http://kenjc.org/mobile/app/timthumb.php?src=uploads/events/"

#define IMAGECOVERFLOW @"http://app.mygaragemobileapp.com/admin/images/photogallery"
#define IMAGECOVERFLOWSIZE @"http://app.mygaragemobileapp.com/timthumb.php?src=admin/images/photogallery"
#define ADVIMAGE @"/tbladvertisements/advertisementHorrImage/"

#define YOUTUBEIMGURL @"http://img.youtube.com/vi/" 

//#define kPayPalClientId @"AQnPHRC5e8IF24AZKM8LtdJD2XwzhRBLXbsco6CMUeDSfXSleRMw5bhS_Jpw"//Sandbox

#define kPayPalClientId @"AbsJAxAo0r5VyjRYFqjD6pdrpxKqVmMeJOlgVOLcmiEg7x1DgbveNA93BOPc"//Sandbox

#define kPayPalReceiverEmail @"test.mailaccounts@gmail.com"


#define Rotatory self.rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyleRotating;self.rotaryKnob.scalingFactor = 1.5f;self.rotaryKnob.maximumValue =100;self.rotaryKnob.minimumValue =0;self.rotaryKnob.value =0;self.rotaryKnob.defaultValue = self.rotaryKnob.value;self.rotaryKnob.resetsToDefault = YES;self.rotaryKnob.backgroundColor = [UIColor clearColor];[self.rotaryKnob setKnobImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];self.rotaryKnob.knobImageCenter = CGPointMake(92.0f,92.0f);[self.rotaryKnob addTarget:self action:@selector(rotaryKnobDidChange) forControlEvents:UIControlEventValueChanged];[self.circularSlider setValue:0.0];


#define SYSVERSION [[[UIDevice currentDevice]systemVersion] floatValue]

#define CurrenscreenHeight  [UIScreen mainScreen].bounds.size.height

#define BACK  -(IBAction)Backtoview:(id)sender{[self.navigationController popViewControllerAnimated:YES];}

#define ONLYBACK [self.navigationController popViewControllerAnimated:YES];

#define Global ValidationAndJsonViewController

#define  THIS [AppDelegate sharedInstance]

//For Mavigation bar

#define NAVDISPLAY [self.navigationController setNavigationBarHidden:NO];

#define NAVHIDE [self.navigationController setNavigationBarHidden:YES];

// FBAPPID

//old fbappid 754646847905613

#define			FBAPPID				@"850173861677646"

// For custom color
#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define  PLACEHOLDERKEY         @"_placeholderLabel.textColor"
#define  PLACEHOLDERFONTKEY     @"_placeholderLabel.font"

#define  FONTREGULAR                    @"OpenSans"
#define  FONTBOLD                       @"OpenSans-Bold"
#define  FONTBOLDITALIC                 @"OpenSans-BoldItalic"
#define  FONTEXTRABOLD                  @"OpenSans-ExtraBold"
#define  FONTEXTRABOLDITALIC            @"OpenSans-ExtraBoldItalic"
#define  FONTSEMIBOLD                   @"OpenSans-SemiBold"
#define  FONTSEMIBOLDITALIC             @"OpenSans-SemiBoldItalic"
#define  FONTITALIC                     @"OpenSans-Italic"
#define  FONTLIGHT                      @"OpenSans-Light"
#define  FONTLIGHTITALIC                @"OpenSans-LightItalic"


@interface GlobalViewController : UIViewController
@end
