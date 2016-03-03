//
//  VlidationAndJsonViewController.h
//  MakeUpArtist
//
//  Created by Ashesh Shah on 21/10/13.
//  Copyright (c) 2013 Ashesh Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValidationAndJsonViewController : UIViewController<NSURLConnectionDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIActionSheet *actionsheet;
    UIDatePicker *datepikar;
}
@property(nonatomic,strong)UIActionSheet *actionsheet;
@property(nonatomic,strong) UIPickerView *pikarview;
+(NSArray *)GetParsingData:(NSDictionary *)ParsingDict GetKey:(NSString *)key GetTimeinterval:(NSTimeInterval)interval;
+(BOOL)validateEmail:(NSString *)inputText;
+(void)displayTost:(NSString *)erroemessage;
+(BOOL)validatePhone:(NSString *)candidate;
+(BOOL)GetStatus:(NSString *)statusstring;
+(NSString *)GetProfiledata:(NSString *)keyvalue;
+(NSArray *)imageupload:(UIImage *)attachedimage getsize:(CGSize )imagesize getpath:(NSString *)path getsubpath:(NSString *)subpath getimagename:(NSString *)imagename;
-(UIActionSheet *)OpenPicker:(UIView *)view;
+(NSInteger)setcontectforScroll;
+(NSString *)getweekdiffrence:(NSString*)minute;
+(NSString *)getday:(NSString *)getdate dateformat:(NSString *)getdateformat;
+(NSString *)getmonthname:(NSString *)getdate dateformat:(NSString *)getdateformat;

+(NSArray *)GetParsingDataUsingAsync:(NSDictionary *)Dict d:(void(^)(NSArray *ResponseArray)) block;
+(NSArray *)ArrayJsonData:(NSString *)ParsingText;
+(NSArray *)ArrayJsonDataAsync:(NSString *)ParsingText d:(void(^)(NSArray *ResponseArray)) block;
+(UIImage *)scaleAndRotateImage:(UIImage *)image;
+(NSArray *)GetParsingDataUsingAsync:(NSDictionary *)Dict GetKey:(NSString *)key GetTimeinterval:(NSTimeInterval)interval d:(void(^)(NSArray *ResponseArray)) block;
+(NSArray *)GetParsingData:(NSDictionary *)ParsingDict GetKey:(NSString *)key GetTimeinterval:(NSTimeInterval)interval getbase:(NSString *)baseapi;
@end
