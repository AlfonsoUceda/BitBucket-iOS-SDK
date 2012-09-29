//
//  BBEvent.h
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBRepository;
@class BBUser;

@interface BBEvent : NSObject

@property (nonatomic, strong) NSString *node;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) BBRepository *repository;
@property (nonatomic, strong) NSString *createdOn;
@property (nonatomic, strong) BBUser *user;
@property (nonatomic, strong) NSString *utcCreatedOn;
@property (nonatomic, strong) NSString *event;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
