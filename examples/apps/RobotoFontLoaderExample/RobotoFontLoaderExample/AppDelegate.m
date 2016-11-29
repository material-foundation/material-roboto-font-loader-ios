//
//  AppDelegate.m
//  RobotoFontLoaderExample
//
//  Created by Randall Li on 11/29/16.
//  Copyright © 2016 Randall Li. All rights reserved.
//

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
