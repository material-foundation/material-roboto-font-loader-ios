/*
 Copyright 2015-present the Material Foundation for iOS authors. All Rights Reserved.

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

#import "AppDelegate.h"
#import "CatalogByConvention.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc]initWithFrame: [[UIScreen mainScreen] bounds]];

  UIViewController *rootViewController = [[CBCNodeListViewController alloc] initWithNode:CBCCreateNavigationTree()];
  rootViewController.title = @"Catalog by Convention";

  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
  self.window.rootViewController = navController;

  [self.window makeKeyAndVisible];
  return true;
}

@end