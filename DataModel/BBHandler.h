//
//  BBHandler.h
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBHandler : NSObject

@property (nonatomic, strong) NSString *displayTo;
@property (nonatomic, strong) NSString *replacementUrl;
@property (nonatomic, strong) NSString *rawRegex;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *displayFrom;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
