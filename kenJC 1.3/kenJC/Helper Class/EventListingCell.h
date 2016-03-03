//
//  EventListingCell.h
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventListingCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *imgViewCell;
@property (retain, nonatomic) IBOutlet UILabel *LblEventName;
@property (retain, nonatomic) IBOutlet UILabel *LblEventDetails;
@property (retain, nonatomic) IBOutlet UILabel *LblAddress;

@property (retain, nonatomic) IBOutlet UIImageView *imgviewTime;
@property (retain, nonatomic) IBOutlet UILabel *LblTime;

//@property (retain, nonatomic) IBOutlet UIImageView *imgviewDate;
@property (retain, nonatomic) IBOutlet UILabel *LblDate;
@property (retain, nonatomic) IBOutlet UILabel *LblMonth;
@property(retain, nonatomic) IBOutlet UIButton *btnLocation;


@end
