//
//  BBRepository.h
//  BitBucketSDK
//
//  Created by Joshka on 24/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBUser;

@interface BBRepository : NSObject

@property (nonatomic, strong) NSString *scm;
@property (nonatomic, assign) BOOL hasWiki;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, strong) NSString *creator;
@property (nonatomic, strong) NSDate *createdOn;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *emailMailingList;
@property (nonatomic, assign) BOOL isMQ;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) BOOL readOnly;
@property (nonatomic, strong) NSString *forkOf;
@property (nonatomic, strong) NSString *MQOf;
@property (nonatomic, assign) NSInteger followersCount;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSDate *utcCreatedOn;
@property (nonatomic, strong) NSURL *website;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) BOOL hasIssues;
@property (nonatomic, assign) BOOL isFork;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSDate *utcLastUpdated;
@property (nonatomic, assign) BOOL emailWriters;
@property (nonatomic, assign) BOOL noPublicForks;
@property (nonatomic, strong) NSString *resourceURI;

-(id)initWithJSONDictionary:(NSDictionary *)dic;

@end
