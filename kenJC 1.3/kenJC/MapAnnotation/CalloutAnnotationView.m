//
//  CalloutAnnotationView.m
//  CustomCalloutSample
//
//  Created by tochi on 11/05/17.
//  Copyright 2011 aguuu,Inc. All rights reserved.
//

#import "CalloutAnnotationView.h"
#import "CalloutAnnotation.h"

@implementation CalloutAnnotationView
@synthesize title=title_;
@synthesize subtitle=subtitle_;
@synthesize imageview=imageview_;
@synthesize delegate=delegate_;
@synthesize lineView=lineView_;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
  
  if (self) {
      
      self.frame = CGRectMake(0.0f, 0.0f, 210.0f, 200.0f);
      self.backgroundColor = [UIColor clearColor];
    
      imageview_ = [[UIImageView alloc] initWithFrame:CGRectMake(27.0f,40.0f, 145.0f, 50.0)];
      imageview_.contentMode = UIViewContentModeScaleToFill;
     // [imageview_ setBackgroundColor:[UIColor greenColor]];
      [self addSubview:imageview_];
      
      titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 42.0f, 132.0f, 15.0f)];
      titleLabel_.textColor       = [UIColor blackColor];
      titleLabel_.textAlignment   = UITextAlignmentLeft;
      titleLabel_.backgroundColor = [UIColor clearColor];
      titleLabel_.numberOfLines=1;
      titleLabel_.font=[UIFont fontWithName:@"Verdana-Bold" size:11];
      [self addSubview:titleLabel_];
      
      
      CGSize expectedLabelSize = [reuseIdentifier sizeWithFont:titleLabel_.font constrainedToSize:titleLabel_.frame.size lineBreakMode:NSLineBreakByCharWrapping];
      
//      UIView *viewUnderline=[[UIView alloc] init];
//      viewUnderline.frame=CGRectMake(35.0f,55.0f,   expectedLabelSize.width, 1);
//      viewUnderline.backgroundColor=[UIColor whiteColor];
//      [self addSubview:viewUnderline];
      
      
      
      lblSubTitle_ = [[UILabel alloc] initWithFrame:CGRectMake(35.0f,55.0f,152.0,30)];
      lblSubTitle_.textColor     = [UIColor blackColor];
      lblSubTitle_.textAlignment = UITextAlignmentLeft;
      lblSubTitle_.backgroundColor = [UIColor clearColor];
      lblSubTitle_.numberOfLines = 3;
      lblSubTitle_.font = [UIFont fontWithName:@"Verdana" size:9];
      [self addSubview:lblSubTitle_];
      

      
      button_ = [UIButton buttonWithType:UIButtonTypeCustom];
      button_.frame = CGRectMake(35.0f,40.0f,  expectedLabelSize.width, 18.0f);
      //[button_ setTitle:@"Go to store" forState:UIControlStateNormal];
      [button_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      button_.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      button_.backgroundColor = [UIColor clearColor];
      //[self setValue:[UIFont fontWithName:@"Verdana" size:10] forKeyPath:@"button_.font"];
     // button_.titleLabel.font = [UIFont fontWithName:@"Verdana" size:10];
      [button_ addTarget:self action:@selector(calloutButtonClicked) forControlEvents:UIControlEventTouchDown];
      [self addSubview:button_];
  }
  
  return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    titleLabel_.text = self.title;
    lblSubTitle_.text = self.subtitle;
}

#pragma mark - Button clicked
- (void)calloutButtonClicked
{
    CalloutAnnotation *annotation = self.annotation;
    [delegate_ calloutButtonClicked:(NSString *)annotation.title];
}

@end
