//
//  ViewController.m
//  CSNRequestModificationProtocolDemo
//
//  Created by griffin_stewie on 2014/05/11.
//  Copyright (c) 2014年 net.cyan-stivy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *URL = [NSURL URLWithString:@"http://taruo.net/e/"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reload:(id)sender
{
    [self.webView reload];
}

@end
