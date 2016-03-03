//
//  CustomButtonRegular.m
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "CustomButtonRegular.h"
#import "GlobalViewController.h"

@implementation CustomButtonRegular

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup {
     self.titleLabel.font=[UIFont fontWithName:FONTREGULAR size:self.titleLabel.font.pointSize];
}
-(void)awakeFromNib {
    [self setup];
}

@end
