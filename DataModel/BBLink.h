//
//  BBLink.h
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBHandler;

@interface BBLink : NSObject

@property (nonatomic, strong) BBHandler *handler;
@property (nonatomic, strong) NSNumber *linkId;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
