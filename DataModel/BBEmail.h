//
//  BBEmail.h
//  BitBucketSDK
//
//  Created by Joshka on 26/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBEmail : NSObject

@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) BOOL primary;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
