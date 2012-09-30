//
//  BBComponent.h
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBCVM : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *componentId;

-(id)initWithJSONDictionary:(NSDictionary *)dic;
-(NSString*)description;

@end
