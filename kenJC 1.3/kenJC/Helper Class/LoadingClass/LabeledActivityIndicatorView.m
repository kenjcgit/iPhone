#import "LabeledActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


#define Size	80

@implementation LabeledActivityIndicatorView

@synthesize controller;

-(LabeledActivityIndicatorView *) initWithController:(UIViewController *)ctrl andText:(NSString *)text;
{
    
  self = [super initWithFrame:CGRectMake(0, 0, Size, Size)];
	
	if (self) {
		self.controller = ctrl;
		shown = NO;
		
        if(SYSVERSION<7.0)
		self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, CurrenscreenHeight/ 2);
        else
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    
		self.clipsToBounds = YES;
		self.backgroundColor = [UIColor colorWithWhite: 0.3 alpha: 1.0];
		if ([self.layer respondsToSelector: @selector(setCornerRadius:)]) [self.layer setCornerRadius: 10];
		self.alpha = 0.7;
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Size, Size/2)];
    label.text = text;
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize: [UIFont smallSystemFontSize]];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
		activity.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + Size/5);
		
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    
    [self addSubview: label];
    [self addSubview: activity];
    
        }
	
	return self;
}

-(void) show
{
	if (!shown) {
		shown = YES;
		[self.controller.view addSubview:self];
	}
}

-(void) hide
{
	if (shown) {
		shown = NO;
		[self removeFromSuperview];
	}
}

/*
 -(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
 {
 [self hide];
 }
 */


@end
