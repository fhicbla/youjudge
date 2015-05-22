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
    [self setNeedsStatusBarAppearanceUpdate];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [self configBackgroundImage];
    [self.tryAgainBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.loading setCenter:self.view.center];
    [self.loading startAnimating];
    self.visibleWebView.scrollView.bounces = NO;
    [self setParseDeviceTokenCookie];
    [self tryToConnect];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loading setHidden:YES];
    [self.visibleWebView setHidden:FALSE];
}

- (void)refresh {
    NSLog(@"tentando de novo...");
    [self setLoading];
    [self tryToConnect];
}

- (void)startYouJudge {
    if (!self.lastVisitedURL) {
        self.lastVisitedURL = [NSURL URLWithString: YOUJUDGE_URL];
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
    } else if (error.code == -1004) {
        self.lastVisitedURL = [NSURL URLWithString: YOUJUDGE_URL];
        NSLog(@"%@", error);
    }
    [self setDisconnected];
}

- (void)setDisconnected {
    [self.backgroundImage setHidden:YES];
    [self.visibleWebView setHidden:YES];
    [self.loading setHidden:YES];
    [self.noConnectionImage setHidden:NO];
    [self.tryAgainBtn setHidden:NO];
}

- (void)setLoading {
    [self.tryAgainBtn setHidden:YES];
    //[self.noConnectionImage setHidden:YES];
    [self.loading setHidden:NO];
}

- (void)configBackgroundImage {
    CGSize deviceScreenSize = [[UIScreen mainScreen] bounds].size;
    if (deviceScreenSize.height == 480) {
        // iPhone 4S
        if ([[UIScreen mainScreen] scale] > 1.9 && [[UIScreen mainScreen] scale] < 2.1)
            [self.backgroundImage setImage:[UIImage imageNamed:@"LaunchImage-700@2x.png"]];
    } else if (deviceScreenSize.height == 568) {
        // iPhone 5/5S
        if ([[UIScreen mainScreen] scale] > 1.9 && [[UIScreen mainScreen] scale] < 2.1)
            [self.backgroundImage setImage:[UIImage imageNamed:@"LaunchImage-700-568h@2x.png"]];
    } else if (deviceScreenSize.height == 667) {
        // iPhone 6
        if ([[UIScreen mainScreen] scale] > 1.9 && [[UIScreen mainScreen] scale] < 2.1)
            [self.backgroundImage setImage:[UIImage imageNamed:@"LaunchImage-800-667h@2x.png"]];
    } else if (deviceScreenSize.height == 736) {
        // iPhone 6 Plus
        if ([[UIScreen mainScreen] scale] > 2.1)
            [self.backgroundImage setImage:[UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x.png"]];
    } else if (deviceScreenSize.height == 1024) {
        // iPad 2
        if ([[UIScreen mainScreen] scale] < 1.1)
            [self.backgroundImage setImage:[UIImage imageNamed:@"LaunchImage-700-Portrait~ipad.png"]];
        // iPad Retina
        if ([[UIScreen mainScreen] scale] > 1.9 && [[UIScreen mainScreen] scale] < 2.1)
            [self.backgroundImage setImage:[UIImage imageNamed:@"LaunchImage-700-Portrait@2x~ipad.png"]];
    }
}

- (void)setParseDeviceTokenCookie {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies])
    {
        //NSLog(@"%@cookiecookiecookiecookie", cookie);
    }
}

@end