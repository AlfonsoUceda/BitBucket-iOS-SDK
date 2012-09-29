//
//  BBEmail.m
//  BitBucketSDK
//
//  Created by Joshka on 26/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBEmail.h"

@implementation BBEmail

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
    id active_ = [dic objectForKey:@"active"];
    self.active = [active_ boolValue];
    
    id email_ = [dic objectForKey:@"email"];
    if ([email_ isKindOfClass:[NSString class]])
    {
        self.email = email_;
    }
    
    id primary_ = [dic objectForKey:@"primary"];
    self.primary = [primary_ boolValue];
}

-(NSString*)description
{
    NSMutableString *descriptionEmail = [NSMutableString stringWithFormat:@"\nactive: %@\n", self.active ? @"YES" : @"NO" ];
    [descriptionEmail appendFormat:@"email: %@\n", self.email];
    [descriptionEmail appendFormat:@"primary: %@\n", self.primary ? @"YES" : @"NO"];
    
    return descriptionEmail;
}

@end
