//
//  BBBitBucket.m
//  BitBucketSDK
//
//  Created by Joshka on 23/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBBitBucketManager.h"
#import "BBAsyncRequest.h"
#import "BBUser.h"
#import "BBEmail.h"
#import "BBChangeset.h"
#import "BBSSHKey.h"
#import "BBIssue.h"
#import "NSString+Encode.h"

#define API_ENDPOINT @"https://api.bitbucket.org/1.0"
#define USER_ENDPOINT @"/user"
#define USERS_ENDPOINT @"/users"
#define REPOSITORIES_ENDPOINT @"/repositories"

@interface BBBitBucketManager ()

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *password;

@end

@implementation BBBitBucketManager


#pragma mark - Initialization

- (id)init
{
    return [self initWithUser:nil andPassword:nil];
}

- (id)initWithUser:(NSString *)user andPassword:(NSString *)password
{
    if (self = [super init])
    {
        self.user = user;
        self.password = password;
    }
    
    return self;
}


#pragma mark - User Endpoint

- (void)getUserWithCompletionBlock:(BBUserBlock)completionBlock erroBlock:(BBErrorBlock)errorBlock
{
    NSParameterAssert(completionBlock != nil);
    NSString *stringURL = [self appendToAPIEndpoint:USER_ENDPOINT];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBUser *user = [[BBUser alloc] initWithJSONDictionary:dictionary];
        completionBlock(user);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getPrivilegesWithCompletionBlock:(BBDictionaryBlock)completionBlock erroBlock:(BBErrorBlock)errorBlock
{
    NSParameterAssert(completionBlock != nil);
    NSMutableString *stringURL = [self appendToAPIEndpoint:USER_ENDPOINT];
    [stringURL appendFormat:@"/privileges"];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getRepositoriesThatFollowWithCompletionBlock:(BBArrayBlock)completionBlock erroBlock:(BBErrorBlock)errorBlock compressed:(BOOL)compressed
{
    NSParameterAssert(completionBlock != nil);
    NSMutableString *stringURL = [self appendToAPIEndpoint:USER_ENDPOINT];
    if (compressed)
    {
        [stringURL appendFormat:@"/repositories"];
    }
    else
    {
        [stringURL appendFormat:@"/follows"];
    }
    
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark - Users Endpoint
#pragma mark - Accounts Resource

- (void)getUserAccount:(NSString*)accountNameOrEmail completionBlock:(BBUserBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@", accountNameOrEmail];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBUser *user = [[BBUser alloc] initWithJSONDictionary:dictionary];
        completionBlock(user);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getAccountPlan:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/plan", accountName];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getUserFollowers:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/followers", accountName];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark - Emails Resource

- (void)getListEmails:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/emails", accountName];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getEmail:(NSString*)email forAccount:(NSString*)accountName completionBlock:(BBEmailBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/emails/%@", accountName, email];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBEmail *email = [[BBEmail alloc] initWithJSONDictionary:dictionary];
        completionBlock(email);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)createEmail:(NSString*)email forAccount:(NSString*)accountName completionBlock:(BBEmailBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/emails/%@", accountName, email];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{ kHTTPVerb : @"POST" }];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBEmail *email = [[BBEmail alloc] initWithJSONDictionary:dictionary];
        completionBlock(email);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)updateEmail:(NSString*)email forAccount:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary completionBlock:(BBEmailBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/emails/%@", accountName, email];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{ kHTTPVerb : @"PUT" }];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBEmail *email = [[BBEmail alloc] initWithJSONDictionary:dictionary];
        completionBlock(email);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


#pragma mark - Invitations Resource

- (void)getListInvitations:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/invitations", accountName];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


#pragma mark - Privileges Resource

- (void)getListPrivileges:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/privileges", accountName];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


#pragma mark - SSH Keys Resource

- (void)getListSSHKeysForAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/ssh-keys", accountName];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


- (void)createSSHKey:(NSDictionary*)paramsDictionary forAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
    [stringURL appendFormat:@"/%@/ssh-keys", accountName];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{ kHTTPVerb : @"POST" }];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)updateSSHKey:(NSDictionary*)paramsDictionary forAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
#pragma mark TODO tener cuidado si params es incorrecto;
    [stringURL appendFormat:@"/%@/ssh-keys/%@", accountName, [paramsDictionary objectForKey:@"key_id"]];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{ kHTTPVerb : @"PUT" }];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)deleteSSHKey:(NSDictionary*)paramsDictionary forAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:USERS_ENDPOINT];
#pragma mark TODO tener cuidado si params es incorrecto;
    [stringURL appendFormat:@"/%@/ssh-keys/%@", accountName, [paramsDictionary objectForKey:@"key_id"]];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{ kHTTPVerb : @"DELETE" }];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


#pragma mark - Repositories Endpoint
#pragma mark - Changesets Resource

- (void)getListChangesetsForRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
#pragma mark TODO tener cuidado si params es incorrecto;
    [stringURL appendFormat:@"/%@/%@/changesets", accountName, repoSlug];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getchangeset:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBChangesetBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/changesets/%@", accountName, repoSlug, node];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBChangeset *changeset = [[BBChangeset alloc] initWithJSONDictionary:dictionary];
        completionBlock(changeset);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


- (void)getchangesetDiffstat:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/changesets/%@/diffstat", accountName, repoSlug, node];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}


- (void)getchangesetDiff:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/changesets/%@/diff", accountName, repoSlug, node];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getchangesetLikes:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/changesets/%@/likes", accountName, repoSlug, node];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getchangesetComments:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/changesets/%@/comments", accountName, repoSlug, node];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark - Deploy Keys Resource

- (void)getDeployKeysForRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/deploy-keys", accountName, repoSlug];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(array);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getDeployKey:(NSString*)deployKey forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBSSHKeyBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/deploy-keys", accountName, repoSlug];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBSSHKey *sshKey = [[BBSSHKey alloc] initWithJSONDictionary:dictionary];
        completionBlock(sshKey);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark - Events Resource

- (void)getListEventsForRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/events", accountName, repoSlug];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark - Followers Resource

- (void)getListFollowersForRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/followers", accountName, repoSlug];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark - Issues Resource

- (void)getListIssuesForRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/issues", accountName, repoSlug];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:paramsDictionary forKey:kParams];
    
    [self createRequestWithStringURL:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getIssue:(NSString*)issueId forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBIssueBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/issues/%@", accountName, repoSlug, issueId];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BBIssue *issue = [[BBIssue alloc] initWithJSONDictionary:dictionary];
        completionBlock(issue);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)getListFollowersForIssue:(NSString*)issueId forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    NSMutableString *stringURL = [self appendToAPIEndpoint:REPOSITORIES_ENDPOINT];
    [stringURL appendFormat:@"/%@/%@/issues/%@", accountName, repoSlug, issueId];
    
    [self createRequestWithStringURL:stringURL dictionary:nil completionBlock:^(NSData *data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        completionBlock(dictionary);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}



#pragma mark - Connection

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] > 1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Error"
                                                        message:@"Too many unsuccessul login attempts."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        NSURLCredential *cred = [[NSURLCredential alloc] initWithUser:self.user password:self.password
                                                          persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
        
        NSLog(@"OK");
    }
}


#pragma mark - Private

- (NSMutableString*)appendToAPIEndpoint:(NSString*)endpoint
{
    NSMutableString *apiEndpoint = [NSMutableString stringWithFormat:@"%@",API_ENDPOINT];
    [apiEndpoint appendString:endpoint];
    
    return apiEndpoint;
}

- (void)createRequestWithStringURL:(NSString*)stringURL dictionary:(NSMutableDictionary*)dictionary completionBlock:(BBCompletionBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    if (nil == dictionary)
    {
        dictionary = [NSMutableDictionary dictionary];
    }
    [dictionary setObject:self.user forKey:kUserCredential];
    [dictionary setObject:self.password forKey:kPasswordCredential];
    
    [BBAsyncRequest request:stringURL dictionary:dictionary completionBlock:^(NSData *data) {
        
        NSLog(@"BLOQUE DE CONEXIÖN COMPLETADO");
        completionBlock(data);
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@", [[error userInfo] objectForKey:kError]);
        NSLog(@"BLOQUE DE ERROR");
    }];
}

@end
