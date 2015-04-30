//
//  ViewController.h
//  youjudge
//
//  Created by Felipe Garcia Hespanhol on 4/28/15.
//  Copyright (c) 2015 Felipe Garcia Hespanhol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ViewController : UIViewController <UIWebViewDelegate>

@property IBOutlet UIWebView *visibleWebView;
@property IBOutlet UILabel *loadingMessage;
@property IBOutlet UILabel *noConnectionMessage;
@property IBOutlet UIButton *tryAgainBtn;

@property (strong) NSURL *lastVisitedURL;

- (void)refresh;
- (void)startYouJudge;
- (void)tryToConnect;
- (void)setDisconnected;
- (void)setLoading;

@end

