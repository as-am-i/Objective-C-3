//
//  ContactList.h
//  Assignment3
//
//  Created by 谷井朝美 on 2018-04-19.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"


@interface ContactList : NSObject

@property NSMutableArray *contactList;

- (instancetype) init;
- (void) addContact:(Contact *)newContact;
- (void) listContact;

- (void) seedContact;

- (NSString *) showContactDetailsWithIndex:(int)index;
- (NSArray *) findContactDetailsWithTerm:(NSString *)term;

- (int) checkDuplicateEmail:(NSString *)email;
- (NSMutableDictionary *) addMultiplePhoneNumbers:(Contact *)contactToAdd andLabel:(NSString *)lavel andNumber:(NSString *)number;

@end
