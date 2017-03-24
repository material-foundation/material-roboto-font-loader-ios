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

#import <XCTest/XCTest.h>

#import "MDFFontDiskLoader.h"
#import "MDFRobotoFontLoader.h"

static const CGFloat kEpsilonAccuracy = 0.001f;
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

/**
 For our tests we are following a Given When Then structure as defined in
 http://martinfowler.com/bliki/GivenWhenThen.html

 The essential idea is to break down writing a scenario (or test) into three sections:

 The |given| part describes the state of the world before you begin the behavior you're specifying
 in this scenario. You can think of it as the pre-conditions to the test.
 The |when| section is that behavior that you're specifying.
 Finally the |then| section describes the changes you expect due to the specified behavior.

 For us this just means that we have the Given When Then guide posts as comments for each unit test.
 */
@interface RobotoFontLoaderTests : XCTestCase
@end

@interface MDFFontDiskLoader (Testing)
@property(nonatomic, assign) BOOL disableSanityChecks;
@end

@interface MDFRobotoFontLoader (Testing)
@property(nonatomic, strong) MDFFontDiskLoader *lightFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *regularFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *mediumFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *boldFontLoader;

@property(nonatomic, strong) MDFFontDiskLoader *lightItalicFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *italicFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *mediumItalicFontLoader;
@property(nonatomic, strong) MDFFontDiskLoader *boldItalicFontLoader;

@property(nonatomic, strong, null_resettable) NSBundle *baseBundle;
@property(nonatomic, assign) BOOL disableSanityChecks;

+ (BOOL)isItalicFontName:(nonnull NSString *)fontName;
+ (BOOL)isBoldFontName:(nonnull NSString *)fontName;
+ (NSBundle *)baseBundle;

- (instancetype)initInternal;

@end

@implementation RobotoFontLoaderTests

- (void)testItalicFontFromFontRegular {
  // Given
  CGFloat size = arc4random_uniform(1000) / (arc4random_uniform(10) + 1);
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];
  UIFont *regularFont = [fontLoader regularFontOfSize:size];

  // When
  UIFont *font = [MDFRobotoFontLoader italicFontFromFont:regularFont];

  // Then
  XCTAssertEqualObjects(font.fontName, @"Roboto-Italic");
}

- (void)testRobotoRegularWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader regularFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The regular font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoRegularFontName,
                        @"The font name must match the regular font.");
}

- (void)testRobotoMediumWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader mediumFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The medium font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoMediumFontName,
                        @"The font name must match the medium font.");
}

- (void)testRobotoLightWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader lightFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The light font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoLightFontName,
                        @"The font name must match the light font.");
}

- (void)testRobotoBoldWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader boldFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The bold font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoBoldFontName,
                        @"The font name must match the bold font.");
}

- (void)testRobotoItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader italicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoRegularItalicFontName,
                        @"The font name must match the italic font.");
}

- (void)testRobotoMediumItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader mediumItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The medium italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoMediumItalicFontName,
                        @"The font name must match the medium italic font.");
}

- (void)testRobotoLightItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader lightItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The light italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoLightItalicFontName,
                        @"The font name must match the light italic font.");
}

- (void)testRobotoBoldItalicWithSize {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // When
  UIFont *font = [fontLoader boldItalicFontOfSize:size];

  // Then
  XCTAssertEqualWithAccuracy(font.pointSize, size, kEpsilonAccuracy,
                             @"The bold italic font must be the size that was asked for.");
  XCTAssertEqualObjects(font.fontName, MDFRobotoBoldItalicFontName,
                        @"The font name must match the bold italic font.");
}

- (void)testLightFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.lightFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.lightFontLoader.fontURL];
  fontLoader.lightFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader lightFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:size],
                        @"The system font must be returned when the fontloader fails to load a"
                        @"font.");
}

- (void)testFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.regularFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.regularFontLoader.fontURL];
  fontLoader.regularFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader regularFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont systemFontOfSize:size],
                        @"The system font must be returned when the fontloader fails to load a"
                        @"font.");
}

- (void)testMediumFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.mediumFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.mediumFontLoader.fontURL];
  fontLoader.mediumFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader mediumFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:size],
                        @"The bold system font must be returned when the fontloader fails to load a"
                        @"medium font.");
}

- (void)testBoldFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.boldFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.boldFontLoader.fontURL];
  fontLoader.boldFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader boldFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont boldSystemFontOfSize:size],
                        @"The bold system font must be returned when the fontloader fails to load a"
                        @"bold font.");
}

- (void)testLightItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.lightItalicFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.lightItalicFontLoader.fontURL];
  fontLoader.lightItalicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader lightItalicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to load"
                        @"an italic font.");
}

- (void)testItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.italicFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.italicFontLoader.fontURL];
  fontLoader.italicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader italicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to load"
                        @"an italic font.");
}

- (void)testMediumItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.mediumItalicFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.mediumItalicFontLoader.fontURL];
  fontLoader.mediumItalicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader mediumItalicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to "
                        @"load a medium italic font.");
}

- (void)testBoldItalicFallbackSystemFonts {
  // Given
  CGFloat size = [self randomNumber];
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  fontLoader.disableSanityChecks = YES;
  fontLoader.boldItalicFontLoader =
      [[MDFFontDiskLoader alloc] initWithFontName:@"something that doesn't exist"
                                          fontURL:fontLoader.boldItalicFontLoader.fontURL];
  fontLoader.boldItalicFontLoader.disableSanityChecks = YES;

  // When
  UIFont *font = [fontLoader boldItalicFontOfSize:size];

  // Then
  XCTAssertEqualObjects(font, [UIFont italicSystemFontOfSize:size],
                        @"The italic system font must be returned when the fontloader fails to "
                        @"load a bold italic font.");
}

- (void)testSettingBaseBundleResetsLoader {
  // Given
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  NSArray *existingFontLoaders = @[
    fontLoader.regularFontLoader, fontLoader.lightFontLoader, fontLoader.mediumFontLoader,
    fontLoader.boldFontLoader, fontLoader.italicFontLoader, fontLoader.lightItalicFontLoader,
    fontLoader.mediumItalicFontLoader, fontLoader.boldItalicFontLoader
  ];

  // When
  fontLoader.baseBundle = nil;
  fontLoader.baseBundle = [MDFRobotoFontLoader baseBundle];
  NSArray *newFontLoaders = @[
    fontLoader.regularFontLoader, fontLoader.lightFontLoader, fontLoader.mediumFontLoader,
    fontLoader.boldFontLoader, fontLoader.italicFontLoader, fontLoader.lightItalicFontLoader,
    fontLoader.mediumItalicFontLoader, fontLoader.boldItalicFontLoader
  ];

  // Then
  for (NSUInteger index = 0; index < existingFontLoaders.count; ++index) {
    MDFFontDiskLoader *exisitngFontLoader = existingFontLoaders[index];
    MDFFontDiskLoader *newFontLoader = newFontLoaders[index];
    XCTAssertNotEqual(newFontLoader, exisitngFontLoader,  // Check that pointers are different.
                      @"Fontloader must be new objects when the base bundle gets set.");
  }
}

- (void)testResetingBaseBundle {
  // Given
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];

  // When
  fontLoader.baseBundle = nil;

  // Then
  XCTAssertNotNil(fontLoader.baseBundle, @"The baseBundle must always have a value.");
}

- (void)testDescription {
  // Given
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  NSArray *expected = @[
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(lightFontLoader)),
                               fontLoader.lightFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(regularFontLoader)),
                               fontLoader.regularFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(mediumFontLoader)),
                               fontLoader.mediumFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(boldFontLoader)),
                               fontLoader.boldFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(lightItalicFontLoader)),
                               fontLoader.lightItalicFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(italicFontLoader)),
                               fontLoader.italicFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(mediumItalicFontLoader)),
                               fontLoader.mediumItalicFontLoader],
    [NSString stringWithFormat:@"%@: %@", NSStringFromSelector(@selector(boldItalicFontLoader)),
                               fontLoader.boldItalicFontLoader],
  ];

  // When
  NSString *actual = [fontLoader description];

  // Then
  for (NSString *LoaderDescriptoin in expected) {
    XCTAssertTrue([actual rangeOfString:LoaderDescriptoin].location != NSNotFound,
                  @"actual %@ does not end with: %@", actual, expected);
  }
}

- (void)testDescriptionWithNoLoaderMustBeMostlyEmpty {
  // Given
  MDFRobotoFontLoader *fontLoader = [[MDFRobotoFontLoader alloc] initInternal];
  NSString *expected = @" (\n)\n";

  // When
  NSString *actual = [fontLoader description];

  // Then
  XCTAssertTrue([actual hasSuffix:expected], @"Description %@ must end with: %@", actual, expected);
}

- (void)testIsItalicFontName {
  XCTAssertFalse([MDFRobotoFontLoader isItalicFontName:MDFRobotoRegularFontName]);
  XCTAssertFalse([MDFRobotoFontLoader isItalicFontName:MDFRobotoBoldFontName]);
  XCTAssertFalse([MDFRobotoFontLoader isItalicFontName:MDFRobotoMediumFontName]);
  XCTAssertFalse([MDFRobotoFontLoader isItalicFontName:MDFRobotoLightFontName]);

  XCTAssertTrue([MDFRobotoFontLoader isItalicFontName:MDFRobotoRegularItalicFontName]);
  XCTAssertTrue([MDFRobotoFontLoader isItalicFontName:MDFRobotoBoldItalicFontName]);
  XCTAssertTrue([MDFRobotoFontLoader isItalicFontName:MDFRobotoMediumItalicFontName]);
  XCTAssertTrue([MDFRobotoFontLoader isItalicFontName:MDFRobotoLightItalicFontName]);
}

- (void)testIsBoldFontName {
  XCTAssertTrue([MDFRobotoFontLoader isBoldFontName:MDFRobotoBoldItalicFontName]);
  XCTAssertTrue([MDFRobotoFontLoader isBoldFontName:MDFRobotoMediumItalicFontName]);
  XCTAssertTrue([MDFRobotoFontLoader isBoldFontName:MDFRobotoBoldFontName]);
  XCTAssertTrue([MDFRobotoFontLoader isBoldFontName:MDFRobotoMediumFontName]);

  XCTAssertFalse([MDFRobotoFontLoader isBoldFontName:MDFRobotoRegularFontName]);
  XCTAssertFalse([MDFRobotoFontLoader isBoldFontName:MDFRobotoLightFontName]);
  XCTAssertFalse([MDFRobotoFontLoader isBoldFontName:MDFRobotoRegularItalicFontName]);
  XCTAssertFalse([MDFRobotoFontLoader isBoldFontName:MDFRobotoLightItalicFontName]);
}

- (void)testItalicFontFromFontClassMethod {
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];
  CGFloat size = 10;
  NSDictionary *italicFontForFont = @{
      [fontLoader lightFontOfSize:size]:[fontLoader lightItalicFontOfSize:size],
      [fontLoader regularFontOfSize:size]:[fontLoader italicFontOfSize:size],
      [fontLoader mediumFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
      [fontLoader boldFontOfSize:size]:[fontLoader boldItalicFontOfSize:size],
      [fontLoader lightItalicFontOfSize:size]:[fontLoader lightItalicFontOfSize:size],
      [fontLoader italicFontOfSize:size]:[fontLoader italicFontOfSize:size],
      [fontLoader mediumItalicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
      [fontLoader boldItalicFontOfSize:size]:[fontLoader boldItalicFontOfSize:size],
  };
  for (UIFont *font in italicFontForFont) {
    XCTAssertEqualObjects([MDFRobotoFontLoader italicFontFromFont:font], italicFontForFont[font]);
  }
}

- (void)testBoldFontFromFontClassMethod {
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];
  CGFloat size = 10;
  NSDictionary *boldFontForFont = @{
      [fontLoader lightFontOfSize:size]:[fontLoader mediumFontOfSize:size],
      [fontLoader regularFontOfSize:size]:[fontLoader mediumFontOfSize:size],
      [fontLoader mediumFontOfSize:size]:[fontLoader mediumFontOfSize:size],
      [fontLoader boldFontOfSize:size]:[fontLoader boldFontOfSize:size],
      [fontLoader lightItalicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
      [fontLoader italicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
      [fontLoader mediumItalicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
      [fontLoader boldItalicFontOfSize:size]:[fontLoader boldItalicFontOfSize:size],
  };
  for (UIFont *font in boldFontForFont) {
    XCTAssertEqualObjects([MDFRobotoFontLoader boldFontFromFont:font], boldFontForFont[font]);
  }
}

- (void)testItalicFontFromFont {
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];
  CGFloat size = 10;
  NSDictionary *italicFontForFont = @{
                                      [fontLoader lightFontOfSize:size]:[fontLoader lightItalicFontOfSize:size],
                                      [fontLoader regularFontOfSize:size]:[fontLoader italicFontOfSize:size],
                                      [fontLoader mediumFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
                                      [fontLoader boldFontOfSize:size]:[fontLoader boldItalicFontOfSize:size],
                                      [fontLoader lightItalicFontOfSize:size]:[fontLoader lightItalicFontOfSize:size],
                                      [fontLoader italicFontOfSize:size]:[fontLoader italicFontOfSize:size],
                                      [fontLoader mediumItalicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
                                      [fontLoader boldItalicFontOfSize:size]:[fontLoader boldItalicFontOfSize:size],
                                      };
  for (UIFont *font in italicFontForFont) {
    XCTAssertEqualObjects([fontLoader italicFontFromFont:font], italicFontForFont[font]);
  }
}

- (void)testBoldFontFromFont {
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];
  CGFloat size = 10;
  NSDictionary *boldFontForFont = @{
                                    [fontLoader lightFontOfSize:size]:[fontLoader mediumFontOfSize:size],
                                    [fontLoader regularFontOfSize:size]:[fontLoader mediumFontOfSize:size],
                                    [fontLoader mediumFontOfSize:size]:[fontLoader mediumFontOfSize:size],
                                    [fontLoader boldFontOfSize:size]:[fontLoader boldFontOfSize:size],
                                    [fontLoader lightItalicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
                                    [fontLoader italicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
                                    [fontLoader mediumItalicFontOfSize:size]:[fontLoader mediumItalicFontOfSize:size],
                                    [fontLoader boldItalicFontOfSize:size]:[fontLoader boldItalicFontOfSize:size],
                                    };
  for (UIFont *font in boldFontForFont) {
    XCTAssertEqualObjects([fontLoader boldFontFromFont:font], boldFontForFont[font]);
  }
}

- (void)testIsLargeForContrastRatio {
  // Given
  CGFloat smallSize = 10.0f;
  CGFloat largeIfBoldSize = 15.0f;
  CGFloat largeSize = 18.0f;
  MDFRobotoFontLoader *fontLoader = [MDFRobotoFontLoader sharedInstance];

  // Then
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[UIFont systemFontOfSize:smallSize]]);
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[UIFont boldSystemFontOfSize:smallSize]]);
  XCTAssertTrue(
      [fontLoader isLargeForContrastRatios:[UIFont boldSystemFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[UIFont systemFontOfSize:largeSize]]);

  // Light
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader lightFontOfSize:smallSize]]);
  XCTAssertFalse(
      [fontLoader isLargeForContrastRatios:[fontLoader lightFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader lightFontOfSize:largeSize]]);

  // Regular
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader regularFontOfSize:smallSize]]);
  XCTAssertFalse(
      [fontLoader isLargeForContrastRatios:[fontLoader regularFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader regularFontOfSize:largeSize]]);

  // Medium
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader mediumFontOfSize:smallSize]]);
  // We treat medium as large for MDC accesibility.
  XCTAssertTrue(
      [fontLoader isLargeForContrastRatios:[fontLoader mediumFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader mediumFontOfSize:largeSize]]);

  // Bold
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader boldFontOfSize:smallSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader boldFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader boldFontOfSize:largeSize]]);

  // Italic
  XCTAssertFalse([fontLoader isLargeForContrastRatios:[fontLoader italicFontOfSize:smallSize]]);
  XCTAssertFalse(
      [fontLoader isLargeForContrastRatios:[fontLoader italicFontOfSize:largeIfBoldSize]]);
  XCTAssertTrue([fontLoader isLargeForContrastRatios:[fontLoader italicFontOfSize:largeSize]]);
}

#pragma mark private

- (CGFloat)randomNumber {
  return arc4random_uniform(1000) / (CGFloat)(arc4random_uniform(9) + 1);
}

@end
