//
//  ViewController.h
//  youjudge
//
//  Created by Felipe Garcia Hespanhol on 4/28/15.
//  Copyright (c) 2015 Felipe Garcia Hespanhol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <Parse/Parse.h>

#define YOUJUDGE_URL @"http://youjudge.la/"

@interface ViewController : UIViewController <UIWebViewDelegate>

@property IBOutlet UIWebView *visibleWebView;
@property IBOutlet UIButton *tryAgainBtn;
@property IBOutlet UIActivityIndicatorView *loading;
@property IBOutlet UIImageView *backgroundImage;
@property IBOutlet UIImageView *noConnectionImage;

@property (strong) NSURL *lastVisitedURL;

- (void)refresh;
- (void)startYouJudge;
- (void)tryToConnect;
- (void)setDisconnected;
- (void)setLoading;
- (void)configBackgroundImage;

@end