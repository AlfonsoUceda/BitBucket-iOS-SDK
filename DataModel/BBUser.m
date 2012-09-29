//
//  BBUser.m
//  BitBucketSDK
//
//  Created by Joshka on 23/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBUser.h"
#import "BBRepository.h"

@implementation BBUser

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
    NSDictionary *dicUser = [dic objectForKey:@"user"];
    
    id avatar_ = [dicUser objectForKey:@"avatar"];
    if ([avatar_ isKindOfClass:[NSString class]])
    {
        self.avatar = avatar_;
    }
    
    id firstname_ = [dicUser objectForKey:@"first_name"];
    if ([firstname_ isKindOfClass:[NSString class]])
    {
        self.firstName = firstname_;
    }
    
    id lastname_ = [dicUser objectForKey:@"last_name"];
    if ([lastname_ isKindOfClass:[NSString class]])
    {
        self.lastName = lastname_;
    }
    
    id is_team_ = [dicUser objectForKey:@"is_team"];
    self.isTeam = [is_team_ boolValue];
    
    
    id username_ = [dicUser objectForKey:@"username"];
    if ([username_ isKindOfClass:[NSString class]])
    {
        self.username = username_;
    }
    
    id resourceuri_ = [dicUser objectForKey:@"resource_uri"];
    if ([resourceuri_ isKindOfClass:[NSString class]])
    {
        self.resourceURI = resourceuri_;
    }
    
    NSArray *arrayRepos = [dic objectForKey:@"repositories"];
    
    NSMutableArray *repoMutable = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dicRepo in arrayRepos)
    {
        BBRepository *repository = [[BBRepository alloc] initWithJSONDictionary:dicRepo];
        [repoMutable addObject:repository];
    }
    
    self.repositories = repoMutable;
}

-(NSString*)description
{
    NSMutableString *descriptionUser = [NSMutableString stringWithFormat:@"\nfirstname: %@\n", self.firstName];
    [descriptionUser appendFormat:@"lastname: %@\n", self.lastName];
    [descriptionUser appendFormat:@"username: %@\n", self.username];
    [descriptionUser appendFormat:@"is_team: %@\n", self.isTeam ? @"YES":@"NO"];
    [descriptionUser appendFormat:@"resource_uri: %@\n", self.resourceURI];
    [descriptionUser appendFormat:@"avatar: %@\n", self.avatar];
    
    return descriptionUser;
}

@end
