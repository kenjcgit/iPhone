//
//  CustomTextRegular.m
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "CustomTextRegular.h"
#import "GlobalViewController.h"

@implementation CustomTextRegular

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup {
    [self setFont:[UIFont fontWithName:FONTREGULAR size:self.font.pointSize]];
   [self setValue:[UIColor blackColor]forKeyPath:@"_placeholderLabel.textColor"];
    
}
-(void)awakeFromNib {
    [self setup];
}

@end
