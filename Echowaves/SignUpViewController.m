//
//  SignUpViewController.m
//  Echowaves
//
//  Created by Dmitry on 1/17/14.
//  Copyright (c) 2014 Echowaves. All rights reserved.
//

#import "SignUpViewController.h"
#import "EWWave.h"
#import "NavigationTabBarViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController


- (IBAction)createWave:(UIButton *)sender {
    NSLog(@"-------calling createWave");
    [EWWave showLoadingIndicator:self];
    [EWWave createWaveWithName:self.waveName.text
                      password:self.wavePassword.text
               confirmPassword:self.confirmPassword.text
                   success:^(NSString *waveName) {
                       [EWWave hideLoadingIndicator:self];
                       [EWWave storeCredentialForWaveName:self.waveName.text withPassword:self.wavePassword.text];

                       [EWWave storeIosTokenForWave:self.waveName.text
                                              token:[(EchowavesAppDelegate *)[[UIApplication sharedApplication] delegate] deviceToken]
                                            success:^(NSString *waveName) {
                                                NSLog(@"stored device token for: %@", waveName);
                                            }
                                            failure:^(NSString *errorMessage) {
                                                NSLog(@"failed storing deviceToken %@", errorMessage);
                                            }];

                       [self performSegueWithIdentifier: @"CreateWave" sender: self];
                       
                   }
                   failure:^(NSString *errorMessage) {
                       [EWWave hideLoadingIndicator:self];
                       [EWWave showErrorAlertWithMessage:errorMessage FromSender:self];
                   }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"----------------seguiing");
    NavigationTabBarViewController *navigationTabBarViewController = segue.destinationViewController;
    
    // Make sure your segue name in storyboard is the same as this line
   if ([[segue identifier] isEqualToString:@"CreateWave"])
    {
        NSLog(@"----calling prepareForSegue CreateWave");
        navigationTabBarViewController.waveName.title = self.waveName.text;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"----calling shouldPerformSegueWithIdentifier CreateWave");
    
    if ([identifier isEqualToString:@"CreateWave"]) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    switch(theTextField.tag)
    {
        case 0:
            [_wavePassword becomeFirstResponder];
            break;
        case 1:
            [_confirmPassword becomeFirstResponder];
            break;
        default:
            [theTextField resignFirstResponder];
            [self createWave:nil];
    }
    return YES;
}

@end
