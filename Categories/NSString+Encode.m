//
//  NSString+Encode.m
//  BitBucketSDK
//
//  Created by Joshka on 28/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

- (NSString*)urlEncoding
{
    return (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

@end
