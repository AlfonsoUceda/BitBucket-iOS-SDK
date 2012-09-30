//
//  BBComponent.m
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBCVM.h"

@implementation BBCVM

-(id)initWithJSONDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self parseJSONDictionary:dic];
    }
    
    return self;
}

#pragma mark -- Private methods

-(void)parseJSONDictionary:(NSDictionary *)dic
{
    id name_ = [dic objectForKey:@"name"];
    if ([name_ isKindOfClass:[NSString class]])
    {
        self.name = name_;
    }
    
    id id_ = [dic objectForKey:@"id"];
    self.componentId = id_;
}


-(NSString*)description
{
    NSMutableString *descriptionUser = [NSMutableString stringWithFormat:@"\nname: %@\n", self.name];
    [descriptionUser appendFormat:@"id: %@\n", self.componentId];
    
    return descriptionUser;
}

@end
