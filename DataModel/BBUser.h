//
//  BBUser.h
//  BitBucketSDK
//
//  Created by Joshka on 23/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBUser : NSObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *resourceURI;
@property (nonatomic, assign) BOOL isTeam;
@property (nonatomic, retain) NSArray *repositories;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
