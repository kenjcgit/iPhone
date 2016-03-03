//
//  VlidationAndJsonViewController.m
//  MakeUpArtist
//
//  Created by Ashesh Shah on 21/10/13.
//  Copyright (c) 2013 Ashesh Shah. All rights reserved.
//



#import "ValidationAndJsonViewController.h"
#import "iToast.h"
#import "EGOCache.h"
#import "NSDictionary+NullReplacement.h"
#import "GlobalViewController.h"

@interface ValidationAndJsonViewController ()

@end

@implementation ValidationAndJsonViewController
@synthesize pikarview,actionsheet;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(NSArray *)GetParsingDataUsingAsync:(NSDictionary *)Dict GetKey:(NSString *)key GetTimeinterval:(NSTimeInterval)interval d:(void(^)(NSArray *ResponseArray)) block
{
    
    __block NSArray *jsonArray;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEAPI]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:BASEAPI
                                                      parameters:Dict];
    [request setTimeoutInterval:240];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *err;
        jsonArray = [NSJSONSerialization JSONObjectWithData:[operation responseData] options: NSJSONReadingMutableContainers error: &err];
        jsonArray=[jsonArray arrayByReplacingNullsWithBlanks];
        NSLog(@"Response: %@", jsonArray);
        if([key length]>0)
            [[EGOCache globalCache] setObject:jsonArray forKey:key withTimeoutInterval:interval];
        block(jsonArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error");
        block(nil); //or any other error message..
    }];
    
    [operation start];
    // [operation waitUntilFinished];
    
    return jsonArray;
    
}


+(NSArray *)GetParsingDataUsingAsync:(NSDictionary *)Dict d:(void(^)(NSArray *ResponseArray)) block
{
    
    __block NSArray *jsonArray;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEAPI]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:BASEAPI
                                                      parameters:Dict];
    [request setTimeoutInterval:240];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *err;
        jsonArray = [NSJSONSerialization JSONObjectWithData:[operation responseData] options: NSJSONReadingMutableContainers error: &err];
        jsonArray=[jsonArray arrayByReplacingNullsWithBlanks];
        NSLog(@"Response: %@", jsonArray);
        block(jsonArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error");
        block(nil); //or any other error message..
    }];
    
    [operation start];
   // [operation waitUntilFinished];
    
    return jsonArray;
    
}
+(NSArray *)GetParsingData:(NSDictionary *)ParsingDict GetKey:(NSString *)key GetTimeinterval:(NSTimeInterval)interval
{
    NSLog(@"%@",ParsingDict);
    ParsingDict=[ParsingDict Replacespecialcharacter];
    
    __block NSArray *jsonArray;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEAPI]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:BASEAPI
                                                      parameters:ParsingDict];
    
    
    [request setTimeoutInterval:240];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
    [operation waitUntilFinished];
    
    NSError *err;
    
    if (operation.responseData.length==0)
    {
        NOINTERNET
    }
    else
    {
        jsonArray = [NSJSONSerialization JSONObjectWithData:[operation responseData] options: NSJSONReadingMutableContainers error: &err];
        jsonArray=[jsonArray arrayByReplacingNullsWithBlanks];
        NSLog(@"Response: %@", jsonArray);
        
        if([key length]>0)
            [[EGOCache globalCache] setData:[operation responseData] forKey:key withTimeoutInterval:interval];
        
        NSLog(@"saving cache %@",@"Test");
        
        
        return jsonArray;
        
    }
    return nil;
}
+(NSArray *)GetParsingData:(NSDictionary *)ParsingDict GetKey:(NSString *)key GetTimeinterval:(NSTimeInterval)interval getbase:(NSString *)baseapi
{
    NSLog(@"%@",ParsingDict);
    
    __block NSArray *jsonArray;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEAPI]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:baseapi
                                                      parameters:ParsingDict];
    
    
    [request setTimeoutInterval:240];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
    [operation waitUntilFinished];
    
    NSError *err;
    jsonArray = [NSJSONSerialization JSONObjectWithData:[operation responseData] options: NSJSONReadingMutableContainers error: &err];
    jsonArray=[jsonArray arrayByReplacingNullsWithBlanks];
    NSLog(@"Response: %@", jsonArray);
    
    if([key length]>0)
        [[EGOCache globalCache] setData:[operation responseData] forKey:key withTimeoutInterval:interval];
    
    NSLog(@"saving cache %@",@"Test");
    
    
    return jsonArray;
}
+(void)displayTost:(NSString*)erroemessage
{
    iToast  *iT = [iToast makeText:erroemessage];
    [iT setGravity:iToastGravityCenter];
    [iT show];
}
+(BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                return TRUE;
            }
            /*else {
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             }*/
            
        }
    }
    return FALSE;
}
+ (BOOL) validatePhone: (NSString *) candidate {
    NSString *phoneRegex = @"^+(?:[0-9] ?){6,14}[0-9]$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:candidate];
}
+(NSString *)GetProfiledata:(NSString *)keyvalue
{
    return[[[NSUserDefaults standardUserDefaults]valueForKey:@"Userdata"] valueForKey:keyvalue];
}
+(BOOL)GetStatus:(NSString *)statusstring
{
    if([statusstring isEqualToString:@"true"])
        return TRUE;
    else
        return FALSE;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIActionSheet *)OpenPicker:(UIView *)view;
{
//    UIToolbar *toolBar;
//    
//    
//    menu = [[UIActionSheet alloc] initWithTitle:@"Time"
//                                       delegate:self
//                              cancelButtonTitle:nil
//                         destructiveButtonTitle:nil
//                              otherButtonTitles:nil];
//    
//    menu.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
//    
//    toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    toolBar.barStyle = UIBarStyleBlackTranslucent;
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(hidePicker)];
//    
//    pikarview = [[UIPickerView alloc] init];
//    [pikarview setShowsSelectionIndicator:YES];
//    pikarview.delegate = self;
//    pikarview.dataSource = self;
//    
//    
// 
//    
//    UIBarButtonItem *space = [[UIBarButtonItem alloc]init];
//    space.enabled = NO;
//    
//    
//    [toolBar setItems:[NSArray arrayWithObjects:space,doneButton,nil]];
//    [menu addSubview:toolBar];
//    
//    [menu showInView:view];
//    
//    space.width = 240;
//    
//    pikarview.frame = CGRectMake(0,44, 320,216);
//    
//    [menu addSubview:pikarview];
//    
//    if(SYSVERSION>=7.0)
//        [menu setBounds:CGRectMake(0,0,320, 500)];
//    else
//        [menu setBounds:CGRectMake(0,0,320, 476)];
//    
    
       //menu.tag=3;
    //[pikarview reloadAllComponents];
    
    
//    actionsheet.frame=CGRectMake(0,200,320,260);
//    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    
//    actionsheet = [[UIActionSheet alloc] initWithTitle:@"Date"
//                                              delegate:self
//                                     cancelButtonTitle:nil
//                                destructiveButtonTitle:nil
//                                     otherButtonTitles:nil];
//    
//    actionsheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
//    
//    toolBar.barStyle = UIBarStyleBlackTranslucent;
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(hidePicker)];
//    
//    datepikar = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
//    datepikar.datePickerMode = UIDatePickerModeDate;
//    
//    datepikar.hidden = NO;
//    
//    datepikar.minimumDate=[NSDate date];
//    
//    
//    UIBarButtonItem *space = [[UIBarButtonItem alloc]init];
//    space.enabled = NO;
//    
//    [toolBar setItems:[NSArray arrayWithObjects:space,doneButton,nil]];
//    [actionsheet addSubview:toolBar];
//    [actionsheet showInView:[[UIApplication sharedApplication] keyWindow]];
//    
//    space.width = 240;
//    datepikar.frame = CGRectMake(0,44, 320,216);
//    [actionsheet addSubview:datepikar];
//    if(SYSVERSION>=7.0)
//        [actionsheet setBounds:CGRectMake(0,0,320, 476)];
//    else
//        [actionsheet setBounds:CGRectMake(0,0,320, 476)];
    
    
    actionsheet = [[UIActionSheet alloc] initWithTitle:nil
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:nil];
    [actionsheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    datepikar = [[UIDatePicker alloc] initWithFrame:pickerFrame];
   
    [actionsheet addSubview:datepikar];
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    closeButton.tag = 100;
    [closeButton addTarget:self action:@selector(hidePicker) forControlEvents:UIControlEventValueChanged];
    [actionsheet addSubview:closeButton];
//    [actionsheet showInView:[[UIApplication sharedApplication] keyWindow]];
//    [actionsheet setBounds:CGRectMake(0, 0, 320, 485)];

    return actionsheet;
}

-(void)hidePicker
{
    [actionsheet dismissWithClickedButtonIndex:0 animated:YES];
   
}
#pragma mark UIPickerView Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   if(row==0 || row==1)
       return @"1";
    else
    return nil;
}
+(NSInteger)setcontectforScroll
{
    if(SYSVERSION>=7.0)
        return 0;
    else
        return 50;
}
+(NSString *)getweekdiffrence:(NSString*)date9
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@""];
    NSDate *date5 = [dateFormatter dateFromString:date9];
    double time = [[NSDate date] timeIntervalSinceDate:date5];
    NSLog(@"Time Duration==>%.2f",time);
    // The time interval
    NSTimeInterval theTimeInterval = time;
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    NSLog(@"Conversion: %dseconds  %dmin %dhours %ddays %dmoths %dYears",[conversionInfo second],[conversionInfo minute], [conversionInfo hour], [conversionInfo day], [conversionInfo month],[conversionInfo year]);
    
    if ([conversionInfo minute] <1) {
        return @"Menos de 1 min";
    }else if ([conversionInfo minute]  == 1){
        return [NSString stringWithFormat:@"1 hour ago"];
    }else if (([conversionInfo minute] >1) && ([conversionInfo hour] <1)){
        return [NSString stringWithFormat:@"Hace %d mins", [conversionInfo minute]];
    }else if ([conversionInfo hour]  == 1){
        return [NSString stringWithFormat:@"Hace 1 hora"];
    }else if (([conversionInfo hour] >1) && ([conversionInfo day] <1)){
        return [NSString stringWithFormat:@"Hace %d horas", [conversionInfo hour]];
    }else if ([conversionInfo day]  == 1){
        return [NSString stringWithFormat:@"Hace 1 día"];
    }else if (([conversionInfo day] >1) && ([conversionInfo week] <1)){
        return [NSString stringWithFormat:@"Hace %d días", [conversionInfo day]];
    }else if ([conversionInfo week]  >= 1){
        return [NSString stringWithFormat:@"Hace %d días", [conversionInfo day]];
    }else if ([conversionInfo month]  == 1){
        return [NSString stringWithFormat:@"Hace 1 mes"];
    }else if (([conversionInfo month] >1) && ([conversionInfo year] <1)){
        return [NSString stringWithFormat:@"Hace %d meses", [conversionInfo month]];
    }else
        return nil;
    
}
+(NSString *)getday:(NSString *)getdate dateformat:(NSString *)getdateformat
{
    NSString *strDate=[NSString stringWithFormat:@"%@",getdate];
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:getdateformat];
    NSDate *date=[df dateFromString:strDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    components.day = [[[strDate componentsSeparatedByString:@"-"] objectAtIndex:2] integerValue];
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    
    [df setDateFormat:@"EEEE"];
    NSString *strdayname=[df stringFromDate:firstDayOfMonth];
    return strdayname;
}
+(NSString *)getmonthname:(NSString *)getdate dateformat:(NSString *)getdateformat
{
     NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:getdateformat];
     NSDate *date = [df dateFromString:getdate];
    [df setDateFormat:@"MMMM dd, yyyy"];
   
    NSString *dateString = [df stringFromDate:date];
    return dateString;
}


+(void)handleError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
	if (error != nil)
	{
        if ([[error localizedDescription] isEqual:@"The Internet Connection Appears To Be Offline."]) {
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Game Center" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlertView show];
			//[errorAlertView release];
        }
	}
}
+(NSArray *)imageupload:(UIImage *)attachedimage getsize:(CGSize )imagesize getpath:(NSString *)path getsubpath:(NSString *)subpath getimagename:(NSString *)imagename
{
    NSString *str_time;
    if([imagename length]==0)
    {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"ddMMyyyyhhmmss"];
        NSString* str_timedate = [formatter stringFromDate:date];
        str_time = [NSString stringWithFormat:@"IMAGE_%@.PNG",str_timedate];
        str_time=[str_time stringByReplacingOccurrencesOfString:@":" withString:@"_"];
        
    }else
    {
        str_time=imagename;
    }
   // NSError *err=nil;
    
    
    NSLog(@"%f,%f",attachedimage.size.width,attachedimage.size.height);
    UIImage *newImage = [self scaleAndRotateImage:attachedimage];
    NSLog(@"%f,%f",newImage.size.width,newImage.size.height);
    
    newImage=[Global scaleAndRotateImage:newImage];
    
   /* NSData *passingimagedata = UIImageJPEGRepresentation(newImage, 1.0);
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@action=imageUpload",BASEAPI]]];
    [request setPostValue:path forKey:@"imagePath"];
    if([subpath length]>0)
        [request setPostValue:subpath forKey:@"subimagePath"];
    [request setFile:passingimagedata withFileName:str_time andContentType:@"image/jpeg" forKey:@"imageField"];
    [request setError:err];
    [request startSynchronous];
    NSData *response = [request responseData];
    
    if(!err)
    {
        NSString *resultString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
        resultArray=[resultArray arrayByReplacingNullsWithBlanks];
        NSLog(@"Response: %@", resultArray);
        
        if([[resultArray objectAtIndex:0]valueForKey:@"Status"])
        {
            return resultArray;
        }
    }*/
    return nil;
}

+(UIImage *)scaleAndRotateImage:(UIImage *)image
{
    
    static int kMaxResolution = 1450;
    
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
     return imageCopy;
}
+(NSArray *)ArrayJsonData:(NSString *)ParsingText
{
    NSLog(@"requestString = %@",ParsingText);
    NSData *requestData = [NSData dataWithBytes:[ParsingText UTF8String] length: [ParsingText length]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",BASEAPI]]];
    
    request.timeoutInterval=240.0;
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: requestData];
    
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&err ];
    
    if(!err)
    {
        NSString *resultString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
     
        
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
        resultArray=[resultArray arrayByReplacingNullsWithBlanks];
        NSLog(@"Response: %@", resultArray);
        
        if(resultArray.count>0)
            return resultArray;
        else
            [Global displayTost:@"No record found"];
    }
    
    return nil;
}
+(NSArray *)ArrayJsonDataAsync:(NSString *)ParsingText d:(void(^)(NSArray *ResponseArray)) block
{
    NSLog(@"requestString = %@",ParsingText);
    NSData *requestData = [NSData dataWithBytes:[ParsingText UTF8String] length: [ParsingText length]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",BASEAPI]]];
    
    request.timeoutInterval=240.0;
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if ([data length] >0 && error == nil)
         {
              
             NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
             
          
             
             NSError *err = nil;
             
             NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
             resultArray=[resultArray arrayByReplacingNullsWithBlanks];
             NSLog(@"Response: %@", resultArray);
            
           block(resultArray);
             
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];
   
    return nil;
}


@end
