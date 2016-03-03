//
//  AppDelegate.h
//  kenJC
//
//  Created by fiplmacmini2 on 09/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"
#import "EventListing.h"

@class EventListing;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    EventListing *evtobj;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic)UINavigationController *Navigationcontroller;
@property(nonatomic,retain)NSMutableArray *ArrayActivity;
@property(nonatomic,assign)NSInteger notificationcount;
@property(nonatomic,strong)NSDictionary *apsInfo;
+(BOOL)checkForNetworkStatus;
+(AppDelegate*)sharedInstance;
-(NSString *)getDBPath;
@end

