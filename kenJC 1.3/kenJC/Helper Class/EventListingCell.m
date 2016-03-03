//
//  EventListingCell.m
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.

#import "EventListingCell.h"

@implementation EventListingCell
@synthesize LblEventName,LblEventDetails,LblAddress,btnLocation;

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
