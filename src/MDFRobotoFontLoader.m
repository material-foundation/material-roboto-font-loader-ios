/*
 Copyright 2015-present Google Inc.. All Rights Reserved.

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

#import "MDFRobotoFontLoader.h"

#import "MaterialFontDiskLoader.h"

NSString *const MDFRobotoRegularFontName = @"Roboto-Regular";
NSString *const MDFRobotoRegularItalicFontName = @"Roboto-Italic";
NSString *const MDFRobotoBoldFontName = @"Roboto-Bold";
NSString *const MDFRobotoBoldItalicFontName = @"Roboto-BoldItalic";
NSString *const MDFRobotoMediumFontName = @"Roboto-Medium";
NSString *const MDFRobotoMediumItalicFontName = @"Roboto-MediumItalic";
NSString *const MDFRobotoLightFontName = @"Roboto-Light";
NSString *const MDFRobotoLightItalicFontName = @"Roboto-LightItalic";

NSString *const MDFRobotoRegularFontFilename = @"Roboto-Regular.ttf";
NSString *const MDFRobotoRegularItalicFontFilename = @"Roboto-Italic.ttf";
NSString *const MDFRobotoBoldFontFilename = @"Roboto-Bold.ttf";
NSString *const MDFRobotoBoldItalicFontFilename = @"Roboto-BoldItalic.ttf";
NSString *const MDFRobotoMediumFontFilename = @"Roboto-Medium.ttf";
NSString *const MDFRobotoMediumItalicFontFilename = @"Roboto-MediumItalic.ttf";
NSString *const MDFRobotoLightFontFilename = @"Roboto-Light.ttf";
NSString *const MDFRobotoLightItalicFontFilename = @"Roboto-LightItalic.ttf";

NSString *const MDFRobotoBundle = @"MaterialRobotoFontLoader.bundle";


@interface MDFRobotoFontLoader ()
@property(nonatomic, strong) MDFFontDiskLoader *lightFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *regularFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *mediumFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *boldFontLoader;

@property(nonatomic, strong) MDFFontDiskLoader *lightItalicFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *italicFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *mediumItalicFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *boldItalicFontLoader;

@property(nonatomic, strong) NSBundle *baseBundle;
@property(nonatomic, strong) NSString *bundleFileName;

@property(nonatomic, assign) BOOL disableSanityChecks;

@end

@implementation MDFRobotoFontLoader

+ (MDFRobotoFontLoader *)sharedInstance {
  static id sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] initInternal];
  });
  return sharedInstance;
}

+ (NSBundle *)baseBundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // We may not be included by the main bundle, but rather by an embedded framework, so figure out
    // to which bundle our code is compiled, and use that as the starting point for bundle loading.
    bundle = [NSBundle bundleForClass:[self class]];
  });

  return bundle;
}

- (instancetype)initInternal {
  self = [super init];
  if (self) {
    self = [super init];
    _baseBundle = [MDFRobotoFontLoader baseBundle];
    _bundleFileName = MDFRobotoBundle;
  }
  return self;
}

- (NSString *)description {
  NSMutableString *description = [super.description mutableCopy];
  [description appendString:@" (\n"];
  NSNull *null = [NSNull null];
  NSDictionary *selectors = @{
    NSStringFromSelector(@selector(lightFontLoader)) : _lightFontLoader ?: null,
    NSStringFromSelector(@selector(regularFontLoader)) : _regularFontLoader ?: null,
    NSStringFromSelector(@selector(mediumFontLoader)) : _mediumFontLoader ?: null,
    NSStringFromSelector(@selector(boldFontLoader)) : _boldFontLoader ?: null,
    NSStringFromSelector(@selector(lightItalicFontLoader)) : _lightItalicFontLoader ?: null,
    NSStringFromSelector(@selector(italicFontLoader)) : _italicFontLoader ?: null,
    NSStringFromSelector(@selector(mediumItalicFontLoader)) : _mediumItalicFontLoader ?: null,
    NSStringFromSelector(@selector(boldItalicFontLoader)) : _boldItalicFontLoader ?: null,
  };
  for (NSString *selectorName in selectors) {
    MDFFontDiskLoader *loader = [selectors objectForKey:selectorName];
    if ([loader isEqual:[NSNull null]]) {
      continue;
    }
    [description appendFormat:@"%@: %@\n", selectorName, loader];
  }

  [description appendString:@")\n"];
  return description;
}

#pragma mark - Private

- (void)setBundleFileName:(NSString *)bundleFileName {
  if ([bundleFileName isEqualToString:_bundleFileName]) {
    return;
  }
  if (bundleFileName) {
    _bundleFileName = bundleFileName;
  } else {
    _bundleFileName = MDFRobotoBundle;
  }
  [self resetFontLoaders];
}

- (void)setBaseBundle:(NSBundle *)baseBundle {
  if ([baseBundle isEqual:_baseBundle]) {
    return;
  }
  if (baseBundle) {
    _baseBundle = baseBundle;
  } else {
    _baseBundle = [MDFRobotoFontLoader baseBundle];
  }
  [self resetFontLoaders];
}

- (void)resetFontLoaders {
  _regularFontLoader = nil;
  _lightFontLoader = nil;
  _mediumFontLoader = nil;
  _boldFontLoader = nil;
  _italicFontLoader = nil;
  _lightItalicFontLoader = nil;
  _mediumItalicFontLoader = nil;
  _boldItalicFontLoader = nil;
}

- (MDFFontDiskLoader *)regularFontLoader {
  if (!_regularFontLoader) {
    _regularFontLoader = [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoRegularFontName
                                                            filename:MDFRobotoRegularFontFilename
                                                      bundleFileName:_bundleFileName
                                                          baseBundle:_baseBundle];
  }
  return _regularFontLoader;
}

- (MDFFontDiskLoader *)mediumFontLoader {
  if (!_mediumFontLoader) {
    _mediumFontLoader = [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoMediumFontName
                                                           filename:MDFRobotoMediumFontFilename
                                                     bundleFileName:_bundleFileName
                                                         baseBundle:_baseBundle];
  }
  return _mediumFontLoader;
}

- (MDFFontDiskLoader *)lightFontLoader {
  if (!_lightFontLoader) {
    _lightFontLoader = [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoLightFontName
                                                          filename:MDFRobotoLightFontFilename
                                                    bundleFileName:_bundleFileName
                                                        baseBundle:_baseBundle];
  }
  return _lightFontLoader;
}

- (MDFFontDiskLoader *)boldFontLoader {
  if (!_boldFontLoader) {
    _boldFontLoader = [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoBoldFontName
                                                         filename:MDFRobotoBoldFontFilename
                                                   bundleFileName:_bundleFileName
                                                       baseBundle:_baseBundle];
  }
  return _boldFontLoader;
}

- (MDFFontDiskLoader *)italicFontLoader {
  if (!_italicFontLoader) {
    _italicFontLoader =
        [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoRegularItalicFontName
                                           filename:MDFRobotoRegularItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _italicFontLoader;
}

- (MDFFontDiskLoader *)lightItalicFontLoader {
  if (!_lightItalicFontLoader) {
    _lightItalicFontLoader =
        [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoLightItalicFontName
                                           filename:MDFRobotoLightItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _lightItalicFontLoader;
}

- (MDFFontDiskLoader *)mediumItalicFontLoader {
  if (!_mediumItalicFontLoader) {
    _mediumItalicFontLoader =
        [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoMediumItalicFontName
                                           filename:MDFRobotoMediumItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _mediumItalicFontLoader;
}

- (MDFFontDiskLoader *)boldItalicFontLoader {
  if (!_boldItalicFontLoader) {
    _boldItalicFontLoader =
        [[MDFFontDiskLoader alloc] initWithFontName:MDFRobotoBoldItalicFontName
                                           filename:MDFRobotoBoldItalicFontFilename
                                     bundleFileName:_bundleFileName
                                         baseBundle:_baseBundle];
  }
  return _boldItalicFontLoader;
}

#pragma mark - Public

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.regularFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.mediumFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.lightFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont systemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)boldFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.boldFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont boldSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)italicFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.italicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)lightItalicFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.lightItalicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)mediumItalicFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.mediumItalicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

- (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize {
  MDFFontDiskLoader *fontLoader = self.boldItalicFontLoader;
  UIFont *font = [fontLoader fontOfSize:fontSize];
  NSAssert(_disableSanityChecks || font, @"Font %@ not found in location: %@.", fontLoader.fontName,
           fontLoader.fontURL);
  if (!font) {
    font = [UIFont italicSystemFontOfSize:fontSize];
  }
  return font;
}

+ (BOOL)isItalicFontName:(nonnull NSString *)fontName {
  return [fontName isEqual:MDFRobotoRegularItalicFontName] ||
  [fontName isEqual:MDFRobotoBoldItalicFontName] ||
  [fontName isEqual:MDFRobotoMediumItalicFontName] ||
  [fontName isEqual:MDFRobotoLightItalicFontName];
}

+ (BOOL)isBoldFontName:(nonnull NSString *)fontName {
  return [fontName isEqualToString:MDFRobotoMediumFontName] ||
  [fontName isEqualToString:MDFRobotoBoldFontName] ||
  [fontName isEqualToString:MDFRobotoMediumItalicFontName] ||
  [fontName isEqualToString:MDFRobotoBoldItalicFontName];
}

- (UIFont *)boldFontFromFont:(UIFont *)font {
  NSString *fontName = font.fontName;
  CGFloat fontSize = font.pointSize;
  if ([[self class] isBoldFontName:fontName]) {
    return font;
  } else if ([fontName isEqual:MDFRobotoRegularFontName]) {
    return [self mediumFontOfSize:fontSize];
  } else if ([fontName isEqual:MDFRobotoRegularItalicFontName]) {
    return [self mediumItalicFontOfSize:fontSize];
  } else if ([fontName isEqual:MDFRobotoLightFontName]) {
    return [self mediumFontOfSize:fontSize];
  } else if ([fontName isEqual:MDFRobotoLightItalicFontName]) {
    return [self mediumItalicFontOfSize:fontSize];
  }
  return [UIFont boldSystemFontOfSize:fontSize];
}

- (UIFont *)italicFontFromFont:(UIFont *)font {
  NSString *fontName = font.fontName;
  CGFloat fontSize = font.pointSize;
  if ([[self class] isItalicFontName:fontName]) {
    return font;
  } else if ([fontName isEqual:MDFRobotoRegularFontName]) {
    return [self italicFontOfSize:fontSize];
  } else if ([fontName isEqual:MDFRobotoBoldFontName]) {
    return [self boldItalicFontOfSize:fontSize];
  } else if ([fontName isEqual:MDFRobotoMediumFontName]) {
    return [self mediumItalicFontOfSize:fontSize];
  } else if ([fontName isEqual:MDFRobotoLightFontName]) {
    return [self lightItalicFontOfSize:fontSize];
  }
  return [UIFont italicSystemFontOfSize:fontSize];
}

+ (UIFont *)boldFontFromFont:(UIFont *)font {
  return [[self sharedInstance] boldFontFromFont:font];
}

+ (UIFont *)italicFontFromFont:(UIFont *)font {
  return [[self sharedInstance] italicFontFromFont:font];
}

- (BOOL)isLargeForContrastRatios:(UIFont *)font {
  if (font.pointSize >= 18) {
    return YES;
  }
  if (font.pointSize < 14) {
    return NO;
  }

  UIFontDescriptor *fontDescriptor = font.fontDescriptor;
  if ((fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) == UIFontDescriptorTraitBold) {
    return YES;
  }

  // We treat medium as large for MDC accesibility when larger than 14
  if ([font.fontName rangeOfString:@"medium" options:NSCaseInsensitiveSearch].location != NSNotFound) {
    return YES;
  }

  return NO;
}

@end
