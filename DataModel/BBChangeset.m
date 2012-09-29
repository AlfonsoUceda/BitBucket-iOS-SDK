//
//  BBChangeset.m
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBChangeset.h"
#import "BBFile.h"

@implementation BBChangeset

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
    
    id node_ = [dic objectForKey:@"node"];
    if ([node_ isKindOfClass:[NSString class]])
    {
        self.node = node_;
    }
    
    id files_ = [dic objectForKey:@"files"];
    if ([files_ isKindOfClass:[NSArray class]])
    {
        NSMutableArray *filesArray = [NSMutableArray array];
        for(NSDictionary *fileDic in files_)
        {
            BBFile *file = [[BBFile alloc] initWithJSONDictionary:fileDic];
            [filesArray addObject:file];
        }
        self.files = filesArray;
    }
    
    id rawAuthor_ = [dic objectForKey:@"raw_author"];
    if ([rawAuthor_ isKindOfClass:[NSString class]])
    {
        self.rawAuthor = rawAuthor_;
    }
    
    id utcTimeStamp_ = [dic objectForKey:@"utctimestamp"];
    if ([utcTimeStamp_ isKindOfClass:[NSString class]])
    {
        self.utcTimeStamp = utcTimeStamp_;
    }
    
    id author_ = [dic objectForKey:@"author"];
    if ([author_ isKindOfClass:[NSString class]])
    {
        self.author = author_;
    }
    
    id timestamp_ = [dic objectForKey:@"timestamp"];
    if ([timestamp_ isKindOfClass:[NSString class]])
    {
        self.timestamp = timestamp_;
    }
    
    id rawNode_ = [dic objectForKey:@"raw_node"];
    if ([rawNode_ isKindOfClass:[NSString class]])
    {
        self.rawNode = rawNode_;
    }
    
    id parents_ = [dic objectForKey:@"parents"];
    if ([parents_ isKindOfClass:[NSArray class]])
    {
        self.parents = parents_;
    }
    
    id branch_ = [dic objectForKey:@"branch"];
    if ([branch_ isKindOfClass:[NSString class]])
    {
        self.branch = branch_;
    }
    
    id message_ = [dic objectForKey:@"message"];
    if ([message_ isKindOfClass:[NSString class]])
    {
        self.message = message_;
    }
    
    id revision_ = [dic objectForKey:@"revision"];
    if ([revision_ isKindOfClass:[NSString class]])
    {
        self.revision = revision_;
    }
    
    id size_ = [dic objectForKey:@"size"];
    self.size = [NSNumber numberWithInteger:[size_ integerValue]];
}

-(NSString*)description
{
    NSMutableString *descriptionEmail = [NSMutableString stringWithFormat:@"\nnode: %@\n", self.node];
    [descriptionEmail appendFormat:@"files: %@\n", self.files];
    [descriptionEmail appendFormat:@"raw_author: %@\n", self.rawAuthor];
    [descriptionEmail appendFormat:@"utctimestamp: %@\n", self.utcTimeStamp];
    [descriptionEmail appendFormat:@"author: %@\n", self.author];
    [descriptionEmail appendFormat:@"timestamp: %@\n", self.timestamp];
    [descriptionEmail appendFormat:@"raw_node: %@\n", self.rawNode];
    [descriptionEmail appendFormat:@"parents: %@\n", self.parents];
    [descriptionEmail appendFormat:@"branch: %@\n", self.branch];
    [descriptionEmail appendFormat:@"message: %@\n", self.message];
    [descriptionEmail appendFormat:@"revision: %@\n", self.revision];
    [descriptionEmail appendFormat:@"size: %d\n", [self.size integerValue]];
    
    return descriptionEmail;
}

@end
