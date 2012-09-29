//
//  AppDelegate.m
//  UIActivityDemo
//
//  Created by Boris Buegling on 29.09.12.
//  Copyright (c) 2012 Boris Buegling. All rights reserved.
//

#import "AppDelegate.h"
#import "ModalWebViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ModalWebViewController* webViewController = [[ModalWebViewController alloc] initWithAddress:@"http://buegling.com"];
    self.window.rootViewController = webViewController;
    
    return YES;
}

@end
