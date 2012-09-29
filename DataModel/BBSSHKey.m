//
//  BBSSHKey.m
//  BitBucketSDK
//
//  Created by Joshka on 27/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBSSHKey.h"

@implementation BBSSHKey

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
    id pk_ = [dic objectForKey:@"pk"];
    self.pk = [NSNumber numberWithInteger:[pk_ integerValue]];

    id key_ = [dic objectForKey:@"key"];
    if ([key_ isKindOfClass:[NSString class]])
    {
        self.key = key_;
    }
    
    id label_ = [dic objectForKey:@"label"];
    if ([label_ isKindOfClass:[NSString class]])
    {
        self.label = label_;
    }
}

-(NSString*)description
{
    NSMutableString *descriptionEmail = [NSMutableString stringWithFormat:@"\npk: %d\n", [self.pk integerValue]];
    [descriptionEmail appendFormat:@"key: %@\n", self.key];
    [descriptionEmail appendFormat:@"label: %@\n", self.label];
    
    return descriptionEmail;
}

@end
