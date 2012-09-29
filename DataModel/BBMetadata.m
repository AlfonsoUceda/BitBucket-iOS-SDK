//
//  BBMetadata.m
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBMetadata.h"

@implementation BBMetadata

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
    id kind_ = [dic objectForKey:@"kind"];
    if ([kind_ isKindOfClass:[NSString class]])
    {
        self.kind = kind_;
    }
    
    id version_ = [dic objectForKey:@"version"];
    if ([version_ isKindOfClass:[NSString class]])
    {
        self.version = version_;
    }
    
    id component_ = [dic objectForKey:@"component"];
    if ([component_ isKindOfClass:[NSString class]])
    {
        self.component = component_;
    }
    
    id milestone_ = [dic objectForKey:@"milestone"];
    if ([milestone_ isKindOfClass:[NSString class]])
    {
        self.milestone = milestone_;
    }
}


-(NSString*)description
{
    NSMutableString *descriptionUser = [NSMutableString stringWithFormat:@"\nkind: %@\n", self.kind];
    [descriptionUser appendFormat:@"version: %@\n", self.version];
    [descriptionUser appendFormat:@"component: %@\n", self.component];
    [descriptionUser appendFormat:@"milestone: %@\n", self.milestone];
    
    return descriptionUser;
}

@end
