# Lottie Class

The main class for working with Lottie animations. Provides methods to load, manipulate, query, and save Lottie animation files.

## Constructor

```4d
cs.lottie.Lottie.new($data : Variant) : cs.lottie.Lottie
```

Creates a new Lottie instance from various input types.

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `$data` | `Variant` | Can be: JSON string, file path (Text), 4D.File object, or JSON Object |

### Examples

```4d
// From file path
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new("/path/to/animation.json")

// From 4D.File
var $file : 4D.File:=Folder(fk resources folder).file("animations/intro.json")
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new($file)

// From JSON string
var $json : Text:=File("/path/to/animation.json").getText()
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new($json)

// From JSON object
var $obj : Object:={v: "5.7.4"; fr: 30; ip: 0; op: 60; w: 512; h: 512; layers: []}
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new($obj)

// Empty animation
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new(Null)
```

---

## Properties

### Animation Properties

| Property | Type | Description |
|----------|------|-------------|
| `version` | `Text` | Lottie format version (e.g., "5.7.4") |
| `name` | `Text` | Animation name |
| `frameRate` | `Real` | Frames per second |
| `width` | `Integer` | Animation width in pixels |
| `height` | `Integer` | Animation height in pixels |
| `inPoint` | `Real` | Start frame |
| `outPoint` | `Real` | End frame |
| `is3D` | `Boolean` | Whether animation uses 3D layers |

### Collections

| Property | Type | Description |
|----------|------|-------------|
| `layers` | `Collection` | Array of `LottieLayer` objects |
| `assets` | `Collection` | Array of `LottieAsset` objects (images, precomps) |
| `markers` | `Collection` | Array of `LottieMarker` objects |
| `characters` | `Collection` | Array of `LottieCharacter` objects (for text) |

### Objects

| Property | Type | Description |
|----------|------|-------------|
| `fonts` | `cs.lottie.LottieFontList` | Font list for text layers |
| `meta` | `cs.lottie.LottieMeta` | Animation metadata |

---

## Computed Properties

### duration

```4d
$lottie.duration : Real
```

Returns the animation duration in seconds.

```4d
var $seconds : Real:=$lottie.duration
// If frameRate=30 and outPoint-inPoint=90, duration=3.0
```

### totalFrames

```4d
$lottie.totalFrames : Real
```

Returns the total number of frames.

```4d
var $frames : Real:=$lottie.totalFrames
```

### shapeLayers

```4d
$lottie.shapeLayers : Collection
```

Returns all shape layers in the animation.

### textLayers

```4d
$lottie.textLayers : Collection
```

Returns all text layers in the animation.

### imageLayers

```4d
$lottie.imageLayers : Collection
```

Returns all image layers in the animation.

### precompLayers

```4d
$lottie.precompLayers : Collection
```

Returns all precomposition layers in the animation.

### colors

```4d
$lottie.colors : Collection
```

Returns all colors used in the animation (from fills, strokes, solid layers).

```4d
var $colors : Collection:=$lottie.colors
// Returns: [[1, 0, 0, 1], [0, 0.5, 1, 1], ...]  // RGBA values 0-1
```

### textContent

```4d
$lottie.textContent : Collection
```

Returns all text content from text layers.

```4d
var $texts : Collection:=$lottie.textContent
// Returns: [{layer: "Title", text: "Hello World"}, ...]
```

### fileSize

```4d
$lottie.fileSize : Integer
```

Returns the estimated file size (JSON string length in characters).

---

## Methods

### getLayerByName

```4d
$lottie.getLayerByName($name : Text) : cs.lottie.LottieLayer
```

Find a layer by its name.

```4d
var $layer : cs.lottie.LottieLayer:=$lottie.getLayerByName("Background")
If ($layer#Null)
    $layer.isHidden:=True
End if
```

### getLayerByIndex

```4d
$lottie.getLayerByIndex($index : Integer) : cs.lottie.LottieLayer
```

Find a layer by its index number.

```4d
var $layer : cs.lottie.LottieLayer:=$lottie.getLayerByIndex(1)
```

### getLayerById

```4d
$lottie.getLayerById($id : Text) : cs.lottie.LottieLayer
```

Find a layer by its ID.

### getLayersByType

```4d
$lottie.getLayersByType($type : Integer) : Collection
```

Get all layers of a specific type.

```4d
var $const : cs.lottie.LottieConstants:=cs.lottie.LottieConstants.me
var $shapes : Collection:=$lottie.getLayersByType($const.LayerType.SHAPE)
var $images : Collection:=$lottie.getLayersByType($const.LayerType.IMAGE)
```

### getAssetById

```4d
$lottie.getAssetById($id : Text) : cs.lottie.LottieAsset
```

Find an asset by its ID.

```4d
var $asset : cs.lottie.LottieAsset:=$lottie.getAssetById("image_0")
```

### getMarkerByName

```4d
$lottie.getMarkerByName($name : Text) : cs.lottie.LottieMarker
```

Find a marker by its name.

```4d
var $marker : cs.lottie.LottieMarker:=$lottie.getMarkerByName("loop_start")
If ($marker#Null)
    var $frame : Real:=$marker.time
End if
```

### toJSON

```4d
$lottie.toJSON() : Object
```

Serialize the animation to a Lottie JSON object.

```4d
var $json : Object:=$lottie.toJSON()
var $text : Text:=JSON Stringify($json)
```

### save

```4d
$lottie.save($file : Variant) : Boolean
```

Save the animation to a file.

```4d
// Save to path
$lottie.save("/path/to/output.json")

// Save to 4D.File
var $file : 4D.File:=Folder(fk desktop folder).file("animation.json")
$lottie.save($file)
```

---

## Layer Types

Use `cs.LottieConstants.me.LayerType` to access layer type constants:

| Constant | Value | Description |
|----------|-------|-------------|
| `PRECOMP` | 0 | Precomposition layer |
| `SOLID` | 1 | Solid color layer |
| `IMAGE` | 2 | Image layer |
| `NULL` | 3 | Null/empty layer |
| `SHAPE` | 4 | Shape layer |
| `TEXT` | 5 | Text layer |

---

## Shape Types

Use `cs.LottieConstants.me.ShapeType` to access shape type constants:

| Constant | Description |
|----------|-------------|
| `ELLIPSE` | Ellipse shape |
| `RECTANGLE` | Rectangle shape |
| `PATH` | Bezier path |
| `FILL` | Fill color |
| `STROKE` | Stroke |
| `GROUP` | Shape group |
| `TRANSFORM` | Transform |
| `TRIM` | Trim paths |
| `MERGE` | Merge paths |
| `STAR` | Star/polygon |
| `GRADIENT_FILL` | Gradient fill |
| `GRADIENT_STROKE` | Gradient stroke |
| `ROUNDED_CORNERS` | Rounded corners |
| `REPEATER` | Repeater |

---

## Example: Modify Animation

```4d
// Load animation
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new(File(fk resources folder).file("animation.json"))

// Modify properties
$lottie.name:="Modified Animation"
$lottie.frameRate:=60
$lottie.width:=1920
$lottie.height:=1080

// Find and modify a layer
var $bg : cs.lottie.LottieShapeLayer:=$lottie.getLayerByName("Background")
If ($bg#Null)
    // Get fills in the layer
    var $fills : Collection:=$bg.getShapesByType(cs.lottie.LottieConstants.me.ShapeType.FILL)
    For each ($fill; $fills)
        // Change color to red (RGBA, values 0-1)
        $fill.color.staticValue:=[1; 0; 0; 1]
    End for each
End if

// Save modified animation
$lottie.save(Folder(fk desktop folder).file("modified.json"))
```

---

## Example: Create Animation from Scratch

```4d
// Create empty animation
var $lottie : cs.lottie.Lottie:=cs.lottie.Lottie.new({v: "5.7.4"; fr: 30; ip: 0; op: 90; w: 512; h: 512; layers: []})

$lottie.name:="My Animation"

// Animation is 3 seconds at 30fps (90 frames)
// Ready to add layers and shapes...

var $json : Object:=$lottie.toJSON()
```

---

## See Also

- [LottieSchema Class](LottieSchema.md) - JSON Schema validation
- [Lottie Animation Format](https://lottiefiles.github.io/lottie-docs/) - Official specification
- [LottieFiles](https://lottiefiles.com/) - Animation library and tools
