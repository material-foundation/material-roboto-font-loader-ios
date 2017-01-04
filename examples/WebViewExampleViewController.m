/*
 Copyright 2017-present Google Inc.. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "WebViewExampleViewController.h"
#import "MaterialRobotoFontLoader.h"

@implementation WebViewExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];
  UIViewAutoresizing flexibleMargins =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"WebViewExample" ofType:@"html"];
  NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile
                                                   encoding:NSUTF8StringEncoding error:nil];

  // This ensures that Roboto has been loaded and only needs to be called once.
  [[MDFRobotoFontLoader sharedInstance] regularFontOfSize:16];

  UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  webView.autoresizingMask = flexibleMargins;
  [webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
  [self.view addSubview:webView];
}


+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Typography and Fonts", @"UIWebView (local roboto)" ];
}

@end
