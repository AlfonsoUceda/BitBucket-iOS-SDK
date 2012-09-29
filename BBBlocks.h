//
//  BBBlocks.h
//  BitBucketSDK
//
//  Created by Joshka on 25/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

@class BBUser;
@class BBEmail;
@class BBChangeset;

typedef void (^BBUserBlock)(BBUser* user);
typedef void (^BBEmailBlock)(BBEmail* email);
typedef void (^BBChangesetBlock)(BBChangeset* changesset);

typedef void(^BBCompletionBlock)(NSData *data);
typedef void(^BBErrorBlock)(NSError *error);

typedef void(^BBDictionaryBlock)(NSDictionary *dictionary);
typedef void(^BBArrayBlock)(NSArray *array);