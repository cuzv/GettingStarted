//
//  Copyright 2012 Christoph Jerolimov
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License
//

#import "NSData+Hashes.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Hashes)

- (NSData *)md5 {
	unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
	unsigned char output[outputLength];

	CC_MD5(self.bytes, (unsigned int) self.length, output);
	return [NSMutableData dataWithBytes:output length:outputLength];
}

- (NSData *)sha1 {
	unsigned int outputLength = CC_SHA1_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA1(self.bytes, (unsigned int) self.length, output);
	return [NSMutableData dataWithBytes:output length:outputLength];
}

- (NSData *)sha256 {
	unsigned int outputLength = CC_SHA256_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA256(self.bytes, (unsigned int) self.length, output);
	return [NSMutableData dataWithBytes:output length:outputLength];
}

- (NSData *)sha512 {
    unsigned int outputLength = CC_SHA512_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_SHA512(self.bytes, (unsigned int) self.length, output);
    return [NSMutableData dataWithBytes:output length:outputLength];
}

@end
