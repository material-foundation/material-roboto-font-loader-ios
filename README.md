# Roboto Font Loader

The Roboto Font Loader lazy loads the Roboto font.

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://www.google.com/design/spec/resources/roboto-noto-fonts.html">
      Roboto font resource
    </a>
  </li>
  <li class="icon-link">
    <a href="https://www.google.com/design/spec/typography.html">
      Typography
    </a>
  </li>
</ul>

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MDFRobotoFontLoader'
```

Then, run the following command:

~~~ bash
pod install
~~~

## Usage

The Roboto Font Loader provides APIs for getting the Roboto Fonts. Consider using the
Typography Material Component for iOS font styles recommended by Material spec.

### Importing

Before using Roboto Font Loader, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialRobotoFontLoader.h"
~~~

#### Swift
~~~ swift
import MDFRobotoFontLoader
~~~
<!--</div>-->

### Dependencies

The Roboto Font Loader Component depends on the FontDiskLoader Component.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
UIFont *font = [[MDFRobotoFontLoader sharedInstance] regularFontOfSize:16];
~~~

#### Swift
~~~ swift
let myFont:UIFont = MDFRobotoFontLoader.sharedInstance()regularFontOfSize(16)
~~~
<!--</div>-->
