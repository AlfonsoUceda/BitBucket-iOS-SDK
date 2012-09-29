//
//  BBChangeset.h
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBChangeset : NSObject

@property (nonatomic, strong) NSString *node;
@property (nonatomic, strong) NSArray *files;
@property (nonatomic, strong) NSString *rawAuthor;
@property (nonatomic, strong) NSString *utcTimeStamp;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *rawNode;
@property (nonatomic, strong) NSArray *parents;
@property (nonatomic, strong) NSString *branch;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *revision;
@property (nonatomic, strong) NSNumber *size;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
