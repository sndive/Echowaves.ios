//
//  EWWave.h
//  Echowaves
//
//  Created by Dmitry on 1/17/14.
//  Copyright (c) 2014 Echowaves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

#import "EWDataModel.h"

@interface EWWave : EWDataModel

@property (strong, nonatomic) NSString *waveName;


+ (NSURLProtectionSpace*) echowavesProtectionSpace;
+ (void) storeCredentialForWaveName:(NSString *)waveName withPassword:(NSString *)wavePassword;
+ (NSURLCredential*) getStoredCredential;

+(void) createWaveWithName:(NSString *)waveName
                  password:(NSString*)wavePassword
           confirmPassword:(NSString*)confirmPassword
                   success:(void (^)(NSString *waveName))success
                   failure:(void (^)(NSString *errorMessage))failure;

+(void) storeIosTokenForWave:(NSString *)waveName
                  token:(NSString*)token
                   success:(void (^)(NSString *waveName))success
                   failure:(void (^)(NSString *errorMessage))failure;

+(void) sendPushNotifyForWave:(NSString *) waveName
                        badge:(NSInteger) numberOfImages
               success:(void (^)())success
               failure:(void (^)(NSError *error))failure;


+(void) tuneInWithName:(NSString *)waveName
           andPassword:(NSString*)wavePassword
               success:(void (^)(NSString *waveName))success
               failure:(void (^)(NSString *errorMessage))failure;

+(void) tuneOut;


@end
