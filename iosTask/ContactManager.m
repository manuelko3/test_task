//
//  ContactManager.m
//  iosTask
//
//  Created by Yevgeni on 07.01.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

#import "ContactManager.h"
#import "Contact.h"

@implementation ContactManager

+ (id)sharedManager {
    static ContactManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        
    });
    return sharedManager;
}

- (void)requestAccess:(void (^)(NSMutableArray *contacts))retrievedContacts {
    CNContactStore* contactStore = [[CNContactStore alloc]init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts
                           completionHandler:^(BOOL granted, NSError * _Nullable error) {
                               if(granted == YES){
                                   [self retrieveContacts:^(NSMutableArray *contactsToRetrieve) {
                                       retrievedContacts(contactsToRetrieve);
                                   }];
                               }
                           }];
}

- (void)retrieveContacts:(void (^)(NSMutableArray *contacts))retrievedData {
    
    NSMutableArray *contacts = [[NSMutableArray alloc]init];
    
    CNContactFetchRequest* contactsFetchRequest = [[CNContactFetchRequest alloc]initWithKeysToFetch:[@[CNContactGivenNameKey,
                                                                                                       CNContactFamilyNameKey,
                                                                                                       CNContactImageDataAvailableKey,
                                                                                                       CNContactEmailAddressesKey,
                                                                                                       CNContactImageDataKey]mutableCopy]];
    NSError *error;
    CNContactStore* contactStore = [[CNContactStore alloc]init];
    [contactStore enumerateContactsWithFetchRequest:contactsFetchRequest
                                              error:&error
                                         usingBlock:^(CNContact *contact, BOOL *stop) {
                                             Contact *cncontact = [[Contact alloc]init:contact];
                                             if(cncontact.email != nil){
                                                 [contacts  addObject:cncontact];
                                             }
                                             retrievedData(contacts);
                                         }];
}

@end
