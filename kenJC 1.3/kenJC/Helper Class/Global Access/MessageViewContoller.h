//
//  MessageViewContoller.h
//  HP Event
//
//  Created by fiplmacmini2 on 15/07/14.
//  Copyright (c) 2014 Ashesh Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

#define ANNOUNCE [Global displayTost:@"Sorry! No Announcements found."];
#define MAP [Global displayTost:@"Sorry! No records found."];
#define NAME [Global displayTost:@"Enter your name."];
#define EMAIL [Global displayTost:@"Enter your email."];
#define PASSWORD [Global displayTost:@"Enter your password."];
#define CONFPASSWORD [Global displayTost:@"Enter your confirm password."];
#define PASSWORDMISMATCH [Global displayTost:@"Password missmatch."];


#define VALIDEMAIL [Global displayTost:@"Please enter valid email."];
#define VALIDEPHONE [Global displayTost:@"Please enter valid phone."];

#define GENDER [Global displayTost:@"Select gender."];
#define QUERY  [Global displayTost:@"Please write your query."];
#define FIRSTNAME  [Global displayTost:@"Enter your first name."];
#define LASTNAME [Global displayTost:@"Enter your last name."];
#define COMPANYNAME [Global displayTost:@"Enter your company name."];
#define JOB  [Global displayTost:@"Enter your job title."];
#define BADD1 [Global displayTost:@"Enter your business address line1."];
#define BADD2 [Global displayTost:@"Enter your business address line2."];
#define CITY [Global displayTost:@"Enter city"];
#define ZIP [Global displayTost:@"Enter zipcode"];
#define STATE [Global displayTost:@"Enter state"];
#define COUNTRY  [Global displayTost:@"Enter country"];
#define PHONENUM [Global displayTost:@"Enter phone number"];
#define NORECORD [Global displayTost:@"Sorry! No record found."];
#define NOINTERNET [Global displayTost:@"Sorry! No Internet connection."];
#define CONNECTION [Global displayTost:@"Sorry! some webservice connection error."];
#define Feedback [Global displayTost:@"Your Feedback sent successfully."];
#define ATTENDEVENT [Global displayTost:@"You have successfully registered for the event."];
#define QUERYAbout [Global displayTost:@"Your query has been submitted successfully."];
#define FORGOT [Global displayTost:@"Password has been sent to your email id."];
#define Promate [Global displayTost:@"Thanks for promoting reference."];
#define PROFILE  [Global displayTost:@"Profile Updated Successfully"];


//change password
#define CURRENTPSWD [Global displayTost:@"Current Password is wrong."];
#define NEWPSWD [Global displayTost:@"Enter new password."];
#define REPSWD [Global displayTost:@"Re-Enter new password."];
#define MISMATCH [Global displayTost:@"new password mismatch."];
#define CHANGEPSWD [Global displayTost:@"Password changed successfully."];

//event add to calender
#define ALREADY [Global displayTost:@"Event already added to calender."];
#define ADDCALENDER [Global displayTost:@"Event added to calender successfully."];
#define PASTDATE [Global displayTost:@"Cannot Add Past Event To calender."];

@interface MessageViewContoller : UIViewController

@end
