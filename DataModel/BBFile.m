//
//  BBFile.m
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBFile.h"

@implementation BBFile

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
    
    id file_ = [dic objectForKey:@"file"];
    if ([file_ isKindOfClass:[NSString class]])
    {
        self.file = file_;
    }
    
    id type_ = [dic objectForKey:@"type"];
    if ([type_ isKindOfClass:[NSString class]])
    {
        self.type = type_;
    }
}

-(NSString*)description
{
    NSMutableString *descriptionEmail = [NSMutableString stringWithFormat:@"\nfile: %@\n", self.file];
    [descriptionEmail appendFormat:@"type: %@\n", self.type];
    
    return descriptionEmail;
}



@end
