<p align="center">
<img src="Images/logo.jpg" height="200" max-width="90%" alt="Impression" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/swift-5.0-orange.svg" alt="swift 5.0 badge" />
    <img src="https://img.shields.io/badge/platform-iOS-lightgrey.svg" alt="platform iOS badge" />
    <img src="https://img.shields.io/badge/license-MIT-black.svg" alt="license MIT badge" />   
</p>

# Impression
A swift photo filter tool which is easy for user to add their own photo filters.

## Credits
The default photo filters come from [YPImagePicker](https://github.com/Yummypets/YPImagePicker).

## Features
* Default photo filters provided
* Easy to add your own photo filters as far as they comform to FilterProtocol
* Easy to add filters with localized name.

## Requirements
* iOS 11.0+
* Xcode 10.0+

## Install

### CocoaPods
pod 'Impression',  '~> 1.1.1'

## Usage
* Create default FilterViewController with default filters

```swift
    let image = UIImage(named: "sunflower.jpg")!
    let vc = Impression.createFilterViewController(image: image, delegate: self, useDefaultFilters: true)
```

* Add custom filters

```swift
Impression.addCustomFilters(filters: [ToasterFilter(), ClarendonFilter(), HazeRemovalFilter()])
```
* Create custom FilterViewController which can be embeded into another UIViewController

```swift
    let image = UIImage(named: "sunflower.jpg")!
    let vc = Impression.createCustomFilterViewController(image: image, delegate: self, useDefaultFilters: true)
```

* Remove default filters

```swift
    Impression.removeAllFilters()
```

* Provide localized name for your filter

```swift
YourFilter: Impression.FilterProtocol {

public var localizableNames: [Impression.LocaleLanguageCode : String] = 
[.English: "English Name", 
.SimplifiedChinese: "中文名",
.Japanese: "日本語の名前"]

}
```


