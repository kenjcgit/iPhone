//
//  UITextField+MycustomTextField.m
//  MakeUpArtist
//
//  Created by Ashesh Shah on 30/10/13.
//  Copyright (c) 2013 Ashesh Shah. All rights reserved.
//

#import "UITextField+MycustomTextField.h"

@implementation UITextField (MycustomTextField)

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    return CGRectInset(bounds, 8, 0);
    
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    return CGRectInset(bounds, 8, 0);
    
}
@end
