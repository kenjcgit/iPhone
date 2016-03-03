//
//  NSDictionary+NullReplacement.h
//  MakeUpArtist
//
//  Created by Ashesh Shah on 24/10/13.
//  Copyright (c) 2013 Ashesh Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;
- (NSDictionary *)Replacespecialcharacter;
@end
