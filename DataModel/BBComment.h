//
//  BBComment.h
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBUser;

@interface BBComment : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) BBUser *authorInfo;
@property (nonatomic, strong) NSNumber *commentId;
@property (nonatomic, strong) NSString *utcUpdatedOn;
@property (nonatomic, strong) NSString *utcCreatedOn;
@property (nonatomic, assign) BOOL isSpam;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
