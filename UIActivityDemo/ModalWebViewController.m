//
//  ModalWebViewController.m
//  UIActivityDemo
//
//  Created by Boris Buegling on 29.09.12.
//  Copyright (c) 2012 Boris Buegling. All rights reserved.
//

#import "ModalWebViewController.h"
#import "WebViewController.h"

@interface SVModalWebViewController ()

@property (nonatomic, strong) SVWebViewController *webViewController;

@end

#pragma mark -

@implementation ModalWebViewController

- (id)initWithURL:(NSURL *)URL {
    self.webViewController = [[WebViewController alloc] initWithURL:URL];
    if (self = [super initWithRootViewController:self.webViewController]) {
        self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                                target:self.webViewController
                                                                                                                action:@selector(doneButtonClicked:)];
    }
    return self;
}

@end
