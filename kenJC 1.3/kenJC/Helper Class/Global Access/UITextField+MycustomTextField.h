//
//  UITextField+MycustomTextField.h
//  MakeUpArtist
//
//  Created by Ashesh Shah on 30/10/13.
//  Copyright (c) 2013 Ashesh Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycustomTextField:UITextField

- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end
