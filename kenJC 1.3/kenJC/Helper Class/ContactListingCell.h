//
//  ContactListingCell.h
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactListingCell : UITableViewCell

@property (retain, nonatomic)IBOutlet UIButton *BtnPhone,*BtnEmail;
@property (retain, nonatomic)IBOutlet UILabel *LblPhone,*LblEmal,*LblContact;
@end
