//
//  BBFile.h
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBFile : NSObject

@property (nonatomic, strong) NSString *file;
@property (nonatomic, strong) NSString *type;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
