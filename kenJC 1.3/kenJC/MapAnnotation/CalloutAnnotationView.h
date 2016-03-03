//
//  CalloutAnnotationView.h
//  CustomCalloutSample
//
//  Created by tochi on 11/05/17.
//  Copyright 2011 aguuu,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol CalloutAnnotationViewDelegate;
@interface CalloutAnnotationView : MKAnnotationView
{
 @private
    NSString *title_,*subtitle;
    UILabel *titleLabel_;
    UILabel *lblSubTitle_;
    UIButton *button_;
    UIImageView *imageview_;
    UIView *lineView_;
}
@property (nonatomic, retain) NSString *title,*subtitle;
@property (nonatomic, retain) UIImageView *imageview;
@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, assign) id<CalloutAnnotationViewDelegate> delegate;
@end

@protocol CalloutAnnotationViewDelegate
@required
- (void)calloutButtonClicked:(NSString *)title;
@end
