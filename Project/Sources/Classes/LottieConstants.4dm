// Layer Types (ty)
property LayerType : Object:={\
	PRECOMP: 0; \
	SOLID: 1; \
	IMAGE: 2; \
	GROUP: 3; \
	SHAPE: 4; \
	TEXT: 5\
	}

// Shape Types (ty)
property ShapeType : Object:={\
	ELLIPSE: "el"; \
	FILL: "fl"; \
	GRADIENT_FILL: "gf"; \
	GRADIENT_STROKE: "gs"; \
	GROUP: "gr"; \
	MERGE: "mm"; \
	OFFSET_PATH: "op"; \
	PATH: "sh"; \
	PUCKER_BLOAT: "pb"; \
	RECTANGLE: "rc"; \
	REPEATER: "rp"; \
	ROUNDED_CORNERS: "rd"; \
	STAR: "sr"; \
	STROKE: "st"; \
	TRIM: "tm"; \
	TWIST: "tw"\
	}

// Property Types (a)
property PropertyType : Object:={\
	ANCHOR: "a"; \
	COLOR: "c"; \
	OPACITY: "o"; \
	POSITION: "p"; \
	ROTATION: "r"; \
	SCALE: "s"; \
	SHAPE: "sh"; \
	SIZE: "sz"; \
	SKEW: "sk"; \
	SKEW_AXIS: "sa"; \
	STROKE_WIDTH: "sw"\
	}

// Blend Modes (bm)
property BlendMode : Object:={\
	NORMAL: 0; \
	MULTIPLY: 1; \
	SCREEN: 2; \
	OVERLAY: 3; \
	DARKEN: 4; \
	LIGHTEN: 5; \
	COLOR_DODGE: 6; \
	COLOR_BURN: 7; \
	HARD_LIGHT: 8; \
	SOFT_LIGHT: 9; \
	DIFFERENCE: 10; \
	EXCLUSION: 11; \
	HUE: 12; \
	SATURATION: 13; \
	COLOR: 14; \
	LUMINOSITY: 15\
	}

// Fill Rule (r)
property FillRule : Object:={\
	NON_ZERO: 1; \
	EVEN_ODD: 2\
	}

// Line Cap (lc)
property LineCap : Object:={\
	BUTT: 1; \
	ROUND: 2; \
	SQUARE: 3\
	}

// Line Join (lj)
property LineJoin : Object:={\
	MITER: 1; \
	ROUND: 2; \
	BEVEL: 3\
	}

// Mask Mode (mode)
property MaskMode : Object:={\
	NONE: "n"; \
	ADD: "a"; \
	SUBTRACT: "s"; \
	INTERSECT: "i"; \
	LIGHTEN: "l"; \
	DARKEN: "d"; \
	DIFFERENCE: "f"\
	}

// Matte Mode (tt)
property MatteMode : Object:={\
	NONE: 0; \
	ALPHA: 1; \
	ALPHA_INVERTED: 2; \
	LUMA: 3; \
	LUMA_INVERTED: 4\
	}

// Trim Mode (m)
property TrimMode : Object:={\
	SIMULTANEOUSLY: 1; \
	INDIVIDUALLY: 2\
	}

// Gradient Type (t)
property GradientType : Object:={\
	LINEAR: 1; \
	RADIAL: 2\
	}

// Star Type (sy)
property StarType : Object:={\
	STAR: 1; \
	POLYGON: 2\
	}

// Repeater Composite (m)
property RepeaterComposite : Object:={\
	ABOVE: 1; \
	BELOW: 2\
	}

// Text Justify (j)
property TextJustify : Object:={\
	LEFT: 0; \
	RIGHT: 1; \
	CENTER: 2; \
	JUSTIFY_LAST_LINE_LEFT: 3; \
	JUSTIFY_LAST_LINE_RIGHT: 4; \
	JUSTIFY_LAST_LINE_CENTER: 5; \
	JUSTIFY_LAST_LINE_FULL: 6\
	}

// Text Caps (ca)
property TextCaps : Object:={\
	REGULAR: 0; \
	ALL_CAPS: 1; \
	SMALL_CAPS: 2\
	}

// Asset Type
property AssetType : Object:={\
	IMAGE: "image"; \
	PRECOMPOSITION: "precomp"\
	}

// Effect Type (ty)
property EffectType : Object:={\
	CUSTOM: 5; \
	TINT: 20; \
	FILL: 21; \
	STROKE: 22; \
	TRITONE: 23; \
	PRO_LEVELS: 24; \
	DROP_SHADOW: 25; \
	RADIAL_WIPE: 26; \
	DISPLACEMENT_MAP: 27; \
	MATTE3: 28; \
	GAUSSIAN_BLUR: 29; \
	TWIRL: 30; \
	MESH_WARP: 31; \
	WAVY: 32; \
	SPHERIZE: 33; \
	PUPPET: 34\
	}

singleton Class constructor

// Get layer type name from value
Function getLayerTypeName($type : Integer) : Text
	var $key : Text
	For each ($key; This.LayerType)
		If (This.LayerType[$key]=$type)
			return $key
		End if 
	End for each 
	return "UNKNOWN"

// Get shape type name from value
Function getShapeTypeName($type : Text) : Text
	var $key : Text
	For each ($key; This.ShapeType)
		If (This.ShapeType[$key]=$type)
			return $key
		End if 
	End for each 
	return "UNKNOWN"

// Get blend mode name from value
Function getBlendModeName($mode : Integer) : Text
	var $key : Text
	For each ($key; This.BlendMode)
		If (This.BlendMode[$key]=$mode)
			return $key
		End if 
	End for each 
	return "NORMAL"
	