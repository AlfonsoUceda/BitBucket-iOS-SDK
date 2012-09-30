//
//  BBLink.m
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBLink.h"
#import "BBHandler.h"

@implementation BBLink

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
    id handler_ = [dic objectForKey:@"handler"];
    if ([handler_ isKindOfClass:[NSDictionary class]])
    {
        BBHandler *handler = [[BBHandler alloc] initWithJSONDictionary:handler_];
        self.handler = handler;
    }
    
    id id_ = [dic objectForKey:@"id"];
    self.linkId = id_;
}


-(NSString*)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\nid: %@\n", self.linkId];
    [description appendFormat:@"handler: %@\n", self.handler];
    
    return description;
}

@end
