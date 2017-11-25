//
//  NSData+AES256.h
//  Looper
//
//  Created by lujiawei on 4/14/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData(AES256)

-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;



@end
