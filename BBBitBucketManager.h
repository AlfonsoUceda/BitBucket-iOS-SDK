//
//  BBBitBucket.h
//  BitBucketSDK
//
//  Created by Joshka on 23/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBBlocks.h"

@interface BBBitBucketManager : NSObject

@property (nonatomic, readonly) BOOL isLogged;


#pragma mark - Initialization 

- (id)initWithUser:(NSString*)user andPassword:(NSString*)password;


#pragma mark - User Endpoint

- (void)getUserWithCompletionBlock:(BBUserBlock)completionBlock erroBlock:(BBErrorBlock)errorBlock;
- (void)getPrivilegesWithCompletionBlock:(BBDictionaryBlock)completionBlock erroBlock:(BBErrorBlock)errorBlock;
- (void)getRepositoriesThatFollowWithCompletionBlock:(BBArrayBlock)completionBlock erroBlock:(BBErrorBlock)errorBlock compressed:(BOOL)compressed;


#pragma mark - Users Endpoint
#pragma mark - Accounts Resource

- (void)getUserAccount:(NSString*)accountNameOrEmail completionBlock:(BBUserBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getAccountPlan:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getUserFollowers:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;

#pragma mark - Emails Resource

- (void)getListEmails:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getEmail:(NSString*)email forAccount:(NSString*)accountName completionBlock:(BBEmailBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)createEmail:(NSString*)email forAccount:(NSString*)accountName completionBlock:(BBEmailBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)updateEmail:(NSString*)email forAccount:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary  completionBlock:(BBEmailBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;

#pragma mark - Invitations Resource

- (void)getListInvitations:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;

#pragma mark - Privileges Resource

- (void)getListPrivileges:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;

#pragma mark - SSH Keys Resource

- (void)getListSSHKeysForAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)createSSHKey:(NSDictionary*)paramsDictionary forAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)updateSSHKey:(NSDictionary*)paramsDictionary forAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)deleteSSHKey:(NSDictionary*)paramsDictionary forAccount:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;


#pragma mark - Repositories Endpoint
#pragma mark - Changesets Resource

- (void)getListChangesets:(NSString*)repoSlug forAccountName:(NSString*)accountName dictionary:(NSDictionary*)paramsDictionary completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getchangeset:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBChangesetBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getchangesetDiffstat:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getchangesetDiff:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBDictionaryBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getchangesetLikes:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
- (void)getchangesetComments:(NSString*)node forRepo:(NSString*)repoSlug forAccountName:(NSString*)accountName completionBlock:(BBArrayBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;


@end