//
//  BBHandler.m
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBHandler.h"

@implementation BBHandler

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
    id displayTo_ = [dic objectForKey:@"display_to"];
    if ([displayTo_ isKindOfClass:[NSString class]])
    {
        self.displayTo = displayTo_;
    }
    
    id replacementUrl_ = [dic objectForKey:@"replacement_url"];
    if ([replacementUrl_ isKindOfClass:[NSString class]])
    {
        self.replacementUrl = replacementUrl_;
    }
    
    id rawRegex_ = [dic objectForKey:@"raw_regex"];
    if ([rawRegex_ isKindOfClass:[NSString class]])
    {
        self.rawRegex = rawRegex_;
    }
    
    id name_ = [dic objectForKey:@"name"];
    if ([name_ isKindOfClass:[NSString class]])
    {
        self.name = name_;
    }
    
    id displayFrom_ = [dic objectForKey:@"display_from"];
    if ([displayFrom_ isKindOfClass:[NSString class]])
    {
        self.displayFrom = displayFrom_;
    }
    
}


-(NSString*)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\ndisplay_to: %@\n", self.displayTo];
    [description appendFormat:@"replacement_url: %@\n", self.replacementUrl];
    [description appendFormat:@"raw_regex: %@\n", self.rawRegex];
    [description appendFormat:@"name: %@\n", self.name];
    [description appendFormat:@"display_from: %@\n", self.displayFrom];
    
    return description;
}


@end
