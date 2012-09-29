//
//  BBMetadata.h
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBMetadata : NSObject

@property (nonatomic,strong) NSString *kind;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString *component;
@property (nonatomic,strong) NSString *milestone;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
