//
//  BBRepository.m
//  BitBucketSDK
//
//  Created by Joshka on 24/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBRepository.h"

@implementation BBRepository

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
    id scm_ = [dic objectForKey:@"scm"];
    if ([scm_ isKindOfClass:[NSString class]])
    {
        self.scm = scm_;
    }
    
    id hasWiki_ = [dic objectForKey:@"has_wiki"];
    self.hasWiki = [hasWiki_ boolValue];
    
    id lastUpdated_ = [dic objectForKey:@"last_updated"];
    if ([lastUpdated_ isKindOfClass:[NSString class]])
    {
        self.lastUpdated = [self NSString2NSdate:lastUpdated_];
    }
    
    id creator_ = [dic objectForKey:@"creator"];
    if ([creator_ isKindOfClass:[NSString class]])
    {
        self.creator = creator_;
    }
    
    id createdOn_ = [dic objectForKey:@"created_on"];
    if ([createdOn_ isKindOfClass:[NSString class]])
    {
        self.createdOn = [self NSString2NSdate:createdOn_];
    }
    
    id owner_ = [dic objectForKey:@"owner"];
    if ([owner_ isKindOfClass:[NSString class]])
    {
        self.owner = owner_;
    }
    
    id logo_ = [dic objectForKey:@"logo"];
    if ([logo_ isKindOfClass:[NSString class]])
    {
        self.logo = logo_;
    }
    
    id emailMailingList_ = [dic objectForKey:@"email_mailinglist"];
    if ([emailMailingList_ isKindOfClass:[NSString class]])
    {
        self.emailMailingList = emailMailingList_;
    }
    
    id isMQ_ = [dic objectForKey:@"is_mq"];
    self.isMQ = [isMQ_ boolValue];
    
    id size_ = [dic objectForKey:@"size"];
    self.size = [size_ integerValue];
    
    id readOnly_ = [dic objectForKey:@"read_only"];
    self.readOnly = [readOnly_ boolValue];
    
    id forkOf_ = [dic objectForKey:@"fork_of"];
    if ([forkOf_ isKindOfClass:[NSString class]])
    {
        self.forkOf = forkOf_;
    }
    
    id mqOf_ = [dic objectForKey:@"mq_of"];
    if ([mqOf_ isKindOfClass:[NSString class]])
    {
        self.MQOf = mqOf_;
    }
    
    id followersCount_ = [dic objectForKey:@"followers_count"];
    self.followersCount = [followersCount_ integerValue];
    
    id state_ = [dic objectForKey:@"state"];
    if ([state_ isKindOfClass:[NSString class]])
    {
        self.state = state_;
    }
    
    id utcCreatedOn_ = [dic objectForKey:@"utc_created_on"];
    if ([utcCreatedOn_ isKindOfClass:[NSString class]])
    {
        self.utcCreatedOn = [self NSString2NSdate:utcCreatedOn_];
    }
    
    id website_ = [dic objectForKey:@"website"];
    if ([website_ isKindOfClass:[NSString class]])
    {
        self.website = website_;
    }
    
    id description_ = [dic objectForKey:@"description"];
    if ([description_ isKindOfClass:[NSString class]])
    {
        self.description = description_;
    }
    
    id hasIssues_ = [dic objectForKey:@"has_issues"];
    self.hasIssues = [hasIssues_ boolValue];
    
    id isFork_ = [dic objectForKey:@"is_fork"];
    self.isFork = [isFork_ boolValue];
    
    id slug_ = [dic objectForKey:@"slug"];
    if ([slug_ isKindOfClass:[NSString class]])
    {
        self.slug = slug_;
    }
    
    id isPrivate_ = [dic objectForKey:@"is_private"];
    self.isPrivate = [isPrivate_ boolValue];
    
    id name_ = [dic objectForKey:@"name"];
    if ([name_ isKindOfClass:[NSString class]])
    {
        self.name = name_;
    }
    
    id language_ = [dic objectForKey:@"language"];
    if ([language_ isKindOfClass:[NSString class]])
    {
        self.language = language_;
    }
    
    id utcLastUpdated_ = [dic objectForKey:@"utc_last_updated"];
    if ([utcLastUpdated_ isKindOfClass:[NSString class]])
    {
        self.utcLastUpdated = [self NSString2NSdate:utcLastUpdated_];
    }
    
    id emailWriters_ = [dic objectForKey:@"email_writers"];
    self.emailWriters = [emailWriters_ boolValue];
    
    id noPublicForks_ = [dic objectForKey:@"no_public_forks"];
    self.noPublicForks = [noPublicForks_ boolValue];
    
    id resourceURI_ = [dic objectForKey:@"resource_uri"];
    if ([resourceURI_ isKindOfClass:[NSString class]])
    {
        self.resourceURI = resourceURI_;
    }
}

-(NSDate*)NSString2NSdate:(NSString*)string
{
    string = [[string componentsSeparatedByString:@"+"] objectAtIndex:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFromString = [dateFormatter dateFromString:string];
    
    return dateFromString;
}

@end
