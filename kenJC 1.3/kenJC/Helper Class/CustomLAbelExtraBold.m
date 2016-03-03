//
//  CustomLAbelExtraBold.m
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "CustomLAbelExtraBold.h"
#import "GlobalViewController.h"

@implementation CustomLAbelExtraBold

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setup {
    // [self setFont:[UIFont fontWithName:@"ProximaNova-Regular" size:self.font.pointSize]];
    [self setFont:[UIFont fontWithName:FONTEXTRABOLD size:self.font.pointSize]];
    
}
-(void)awakeFromNib {
    [self setup];
}

@end
