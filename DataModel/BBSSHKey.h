//
//  BBSSHKey.h
//  BitBucketSDK
//
//  Created by Joshka on 27/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSSHKey : NSObject

@property (nonatomic, strong) NSNumber *pk;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *label;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
