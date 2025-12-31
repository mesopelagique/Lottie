# Lottie for 4D

A 4D implementation for parsing, manipulating, and serializing [Lottie](https://lottiefiles.com/) animation files.

## Overview

This library provides a complete object model for working with Lottie JSON animations in 4D. It allows you to:

- **Load** Lottie animations from JSON files, JSON strings, or objects
- **Parse** all animation components (layers, shapes, keyframes, effects, etc.)
- **Manipulate** animation properties programmatically
- **Query** layers, shapes, colors, and other elements
- **Serialize** animations back to valid Lottie JSON
- **Save** animations to files

## Quick Start

```4d
// Load from file
var $lottie : cs.Lottie:=cs.Lottie.new(File("/path/to/animation.json"))

// Or from JSON text
var $lottie2 : cs.Lottie:=cs.Lottie.new("{\"v\":\"5.7.4\",\"fr\":30,...}")

// Or from object
var $lottie3 : cs.Lottie:=cs.Lottie.new({v: "5.7.4"; fr: 30; ip: 0; op: 60; w: 512; h: 512; layers: []})

// Access properties
$lottie.name:="My Animation"
$lottie.frameRate:=60
$lottie.width:=1024
$lottie.height:=1024

// Get animation info
var $duration : Real:=$lottie.duration  // in seconds
var $frames : Real:=$lottie.totalFrames

// Query layers
var $layer : cs.LottieLayer:=$lottie.getLayerByName("Background")
var $shapeLayers : Collection:=$lottie.shapeLayers
var $textLayers : Collection:=$lottie.textLayers

// Get all colors used
var $colors : Collection:=$lottie.colors

// Save to file
$lottie.save(File("/path/to/output.json"))

// Or get JSON object
var $json : Object:=$lottie.toJSON()
```

## Documentation

- [Lottie Class](Documentation/Classes/Lottie.md) - Main animation class


## Lottie Resources

### Official Documentation
- [Lottie Animation Format](https://lottiefiles.github.io/lottie-docs/) - Official Lottie documentation
- [LottieFiles](https://lottiefiles.com/) - Free Lottie animations and tools
- [Lottie JSON Schema](https://lottiefiles.github.io/lottie-docs/schema/) - JSON schema reference

### Tools
- [LottieFiles Editor](https://lottiefiles.com/editor) - Online Lottie editor
- [Bodymovin](https://aescripts.com/bodymovin/) - After Effects plugin to export Lottie

### Libraries
- [lottie-web](https://github.com/airbnb/lottie-web) - Lottie player for web
- [lottie-ios](https://github.com/airbnb/lottie-ios) - Lottie player for iOS
- [lottie-android](https://github.com/airbnb/lottie-android) - Lottie player for Android
- [lottie-js](https://github.com/LottieFiles/lottie-js) - JavaScript object model (inspiration for this library)

## Credits

This library is inspired by [lottie-js](https://github.com/LottieFiles/lottie-js) by LottieFiles, providing a similar object model approach for the 4D development environment.

## License

MIT
