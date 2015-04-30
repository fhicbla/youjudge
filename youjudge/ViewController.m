//
//  ViewController.m
//  youjudge
//
//  Created by Felipe Garcia Hespanhol on 4/28/15.
//  Copyright (c) 2015 Felipe Garcia Hespanhol. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tryAgainBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self tryToConnect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingMessage setHidden:YES];
    [self.visibleWebView setHidden:FALSE];
}

- (void)refresh {
    NSLog(@"tentando de novo...");
    [self setLoading];
    [self tryToConnect];
}

- (void)startYouJudge {
    if (!self.lastVisitedURL) {
        self.lastVisitedURL = [NSURL URLWithString:@"http://youjudge.la"];
    }
    [self.visibleWebView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.visibleWebView loadRequest:[NSURLRequest requestWithURL:self.lastVisitedURL]];
}

- (void)tryToConnect {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        [self setDisconnected];
    } else {
        NSLog(@"There IS internet connection");
        [self startYouJudge];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code == -1009) {
        self.lastVisitedURL = [NSURL URLWithString:webView.request.URL.absoluteString];
        [self setDisconnected];
    }
}

- (void)setDisconnected {
    [self.visibleWebView setHidden:YES];
    [self.loadingMessage setHidden:YES];
    [self.noConnectionMessage setHidden:NO];
    [self.tryAgainBtn setHidden:NO];
}

- (void)setLoading {
    [self.tryAgainBtn setHidden:YES];
    [self.noConnectionMessage setHidden:YES];
    [self.loadingMessage setHidden:NO];
}

@end