//
//  main.m
//  Assignment3
//
//  Created by 谷井朝美 on 2018-04-19.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputCollector.h"
#import "Contact.h"
#import "ContactList.h"
#import "Input.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // ContactList instance
        ContactList *contactList = [[ContactList alloc] init];
        
        // Seed some fake data in
        [contactList seedContact];
        
        // Input instance
        Input *input = [Input new];
        
        // menu
        NSString *user_input = @"";
        while ([user_input isNotEqualTo:@"quit"]) {
            [InputCollector printToPrompt:@"What would you like to do next?"];
            [InputCollector printToPrompt:@"new - Create a new contact"];
            [InputCollector printToPrompt:@"list - List all contacts"];
            [InputCollector printToPrompt:@"show id - show the contact with the id"];
            [InputCollector printToPrompt:@"find term - show the contact with the term"];
            [InputCollector printToPrompt:@"history - show the last 3 commands"];
            [InputCollector printToPrompt:@"quit - Exit Application"];
            user_input = [InputCollector inputForPrompt:@"> "];
            
            if ([user_input isEqualToString:@"new"]) {
                [[input commands] addObject:user_input];
                NSString *user_email = [InputCollector inputForPrompt:@"Type your email:  "];
                
                /* Bonus 3: Prevent duplicate entries */
                int error = [contactList checkDuplicateEmail:user_email];
                if (error == 0) {
                    NSString *user_fullname = [InputCollector inputForPrompt:@"Type your full name: "];
                    
                    Contact *contact = [[Contact alloc] init];
                    contact.name = user_fullname;
                    contact.email = user_email;
                    
                    /* Bonus 4: Multiple phone numbers */
                    [InputCollector printToPrompt:@"You can add as many phone numbers as you need.\n(eg: \"Mobile\" : \"444-555-3123\")"];
                    int flag = 0;
                    while (flag != 1) {
                        NSString *user_phone_label = [InputCollector inputForPrompt:@"Type the lavel for number:  "];
                        NSString *user_phone_number = [InputCollector inputForPrompt:@"Type your phone number:  "];
                        if (![user_phone_label isEqualToString:@"" ]&& ![user_phone_number isEqualToString:@""]) {
                            contact.phoneNumbers = [contactList addMultiplePhoneNumbers:contact andLabel:user_phone_label andNumber:user_phone_number];
                        } else {
                            [InputCollector printToPrompt:@"Error: Label or Phone number is not found and cannot be added to contact"];
                        }
                        flag = 1; // stop adding
                        
                        NSString *doneForPhone = [InputCollector inputForPrompt:@"Add more? (y/n)"];
                        if ([doneForPhone isEqualToString:@"y"] || [doneForPhone isEqualToString:@"yes"]) {
                            flag = 0; // continue adding
                        }
                    }
                    [contactList addContact:contact];
                } else {
                    [InputCollector printToPrompt:@"Error: Contact with the email already exists and cannot be created"];
                }
            } else if ([user_input isEqualToString:@"list"]) {
                [[input commands] addObject:user_input];
                [contactList listContact];
            } else if ([user_input containsString:@"show"]) {
                [[input commands] addObject:user_input];
                /* Bonus 1: Contact details (show command) */
                // example: show 01
                NSString *value = [user_input substringFromIndex:5];
                int number = [value intValue];
                [InputCollector printToPrompt:[contactList showContactDetailsWithIndex:number]];
            } else if ([user_input containsString:@"find"]) {
                [[input commands] addObject:user_input];
                /* Bonus 2: Implement Contact search (find command) */
                NSString *value = [user_input substringFromIndex:5];
                NSArray *array = [contactList findContactDetailsWithTerm:value];
                
                // check if some contacts found
                if ([array count] == 0) {
                    [InputCollector printToPrompt:@"Error: not found"];
                } else {
                    // printing all the contacts cantaining the term
                    for (Contact *temp in array) {
                        [InputCollector printToPrompt:[temp name]];
                    }
                }
            } else if ([user_input isEqualToString:@"history"]) {
                /* Bonus 5: History */
                [[input commands] addObject:user_input];
                [InputCollector printToPrompt:@"Showing last 3 commands(at most) you entered"];
                [input showLastThreeCommands];
            } else if ([user_input isEqualToString:@"quit"]) {
                // nothing
            } else {
                [[input commands] addObject:user_input];
                NSString *result = [NSString stringWithFormat:@"Error: command not found: %@", user_input];
                [InputCollector printToPrompt:result];
            }
        }

        

    }
    return 0;
}
