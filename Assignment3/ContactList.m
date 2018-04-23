//
//  ContactList.m
//  Assignment3
//
//  Created by 谷井朝美 on 2018-04-19.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

#import "ContactList.h"
#import "Contact.h"
#import "InputCollector.h"


@implementation ContactList

- (instancetype) init{
    self = [super init];
    if (self) {
        _contactList = [NSMutableArray array];
    }
    return self;
}

- (void) addContact:(Contact *)newContact{
    [[self contactList] addObject:newContact];
}

- (void) listContact{
    NSString *result;
    
    NSUInteger number_of_contactList = [[self contactList] count];
    int end = (int) number_of_contactList;
    
    for (int index = 0; index < end; index++) {
        result = [NSString stringWithFormat:@"%02d: %@", index, [[[self contactList] objectAtIndex:index] name]];
        [InputCollector printToPrompt:result]; // it is required to implement the printing code here
    }
}

- (void) seedContact{
    Contact *contact1 = [[Contact alloc] init];
    contact1.name = @"John Doe";
    contact1.email = @"whoami@email.com";
    contact1.phoneNumbers = [NSMutableDictionary new];
    [contact1.phoneNumbers setObject:@"444-555-3123" forKey:@"Mobile"];
    [self addContact:contact1];
    
    Contact *contact2 = [[Contact alloc] init];
    contact2.name = @"Jane Doe";
    contact2.email = @"whoamitoo@email.com";
    contact2.phoneNumbers = [NSMutableDictionary new];
    [contact2.phoneNumbers setObject:@"999-112-3678" forKey:@"Mobile"];
    [contact2.phoneNumbers setObject:@"251-888-4471" forKey:@"Work"];
    [self addContact:contact2];
}

- (NSString *) showContactDetailsWithIndex:(int)index{
    NSString *result;
    Contact *contactAtIndex = [[self contactList] objectAtIndex:index];
    if (contactAtIndex) {
        NSString *user_phone_as_string = @"";
        for (NSString *key in [contactAtIndex phoneNumbers]) {
            user_phone_as_string = [user_phone_as_string stringByAppendingString:[NSString stringWithFormat:@"%@: %@\n", key, [[contactAtIndex phoneNumbers] valueForKey:key]]];
        }
        result = [NSString stringWithFormat:@"showing %02d:\nname: %@\nemail: %@\n%@", index, [contactAtIndex name], [contactAtIndex email], user_phone_as_string];
    } else {
        result = @"not found";
    }
    return result;
}

- (NSArray *) findContactDetailsWithTerm:(NSString *)term{
    NSPredicate *predicate;
    // create a NSArray and assign all the contacts in contactList to the NSArray
    NSArray *tempContactList =  [self.contactList mutableCopy];
    
    // declare a condition to check
    predicate = [NSPredicate predicateWithFormat:@"(name contains[cd] %@) OR (email contains[cd] %@)", term, term];
    
    // update tempContactList with the array already filtered
    tempContactList = [NSMutableArray arrayWithArray:[tempContactList filteredArrayUsingPredicate:predicate]];
    return tempContactList;
    
    // tips
    // filterUsingPredicate cheanges the NSMutableArray([tempContactList contactList]) itself and returns void
    // [[tempContactList contactList] filterUsingPredicate:predicate];
}

- (int) checkDuplicateEmail:(NSString *)email{
    int error = 0;
    
    NSUInteger number_of_contactList = [[self contactList] count];
    int end = (int) number_of_contactList;
    for (int index = 0; index < end; index++) {
        if ([email isEqualToString:[[[self contactList] objectAtIndex:index] email]]) {
            error = 1;
            break;
        }
    }
    return error;
}

- (NSMutableDictionary *) addMultiplePhoneNumbers:(Contact *)contactToAdd andLabel:(NSString *)lavel andNumber:(NSString *)number{
    NSMutableDictionary *phoneNumbers = [NSMutableDictionary new];
    [phoneNumbers setObject:number forKey:lavel];
    return phoneNumbers;
}


@end
