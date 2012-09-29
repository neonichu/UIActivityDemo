//
//  WebViewController.m
//  UIActivityDemo
//
//  Created by Boris Buegling on 29.09.12.
//  Copyright (c) 2012 Boris Buegling. All rights reserved.
//

#import "VUFlattrActivity.h"
#import "WebViewController.h"

#define SHARE_LINK_ACTION_TITLE     NSLocalizedString(@"Share Link", @"")

// This is hacky, but it's a demo, so...

@interface SVWebViewController (Private) 

@property (nonatomic, assign) BOOL hasActionSheet;

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (UIWebView*)mainWebView;
- (UIActionSheet *)pageActionSheet;

@end

#pragma mark -

@implementation WebViewController

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:SHARE_LINK_ACTION_TITLE]) {
        NSArray* activityItems = @[ self.mainWebView.request.URL ];
        NSArray* appActivities = @[ [[VUFlattrActivity alloc] init] ];
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                         applicationActivities:appActivities];
        [self presentViewController:activityController animated:YES completion:nil];
    }
}

- (BOOL)actionSheet:(UIActionSheet *)actionSheet hasButtonWithTitle:(NSString *)title {
    for (int index = 0; index < actionSheet.numberOfButtons; index++) {
        if ([[actionSheet buttonTitleAtIndex:index] isEqualToString:title]) {
            return YES;
        }
    }
    
    return NO;
}

-(UIActionSheet*)pageActionSheet {
    UIActionSheet* actionSheet = [super pageActionSheet];
    
    if (![self actionSheet:actionSheet hasButtonWithTitle:SHARE_LINK_ACTION_TITLE]) {
        [actionSheet addButtonWithTitle:SHARE_LINK_ACTION_TITLE];
    }
    
    return actionSheet;
}

@end
