//
//  BBIssue.h
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBUser;
@class BBMetadata;

@interface BBIssue : NSObject

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *priority;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) BBUser *reporteBy;
@property (nonatomic, strong) NSString *utcLastUpdated;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) BBMetadata *metadata;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createdOn;
@property (nonatomic, strong) NSNumber *localId;
@property (nonatomic, strong) NSNumber *followerCount;
@property (nonatomic, strong) NSString *utcCreatedOn;
@property (nonatomic, strong) NSString *resourceURI;
@property (nonatomic, assign) BOOL isSpam;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
