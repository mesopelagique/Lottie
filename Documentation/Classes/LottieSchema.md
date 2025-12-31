# LottieSchema Class

A singleton class that provides the official Lottie JSON Schema for validation purposes. Use this to validate Lottie JSON files or objects against the specification.

## Singleton Access

```4d
cs.lottie.LottieSchema.me
```

Returns the singleton instance of the schema. The schema is loaded once from `Resources/lottie.schema.json` and cached for subsequent use.

---

## Usage with JSON Validate

The primary use case is validating Lottie JSON data using 4D's `JSON Validate` command.

```4d
// Your Lottie JSON object
var $lottieJson : Object:={v: "5.7.4"; fr: 30; ip: 0; op: 60; w: 512; h: 512; layers: []}

// Validate against schema
var $validation : Object:=JSON Validate($lottieJson; cs.lottie.LottieSchema.me)
``` 
---

## See Also

- [Lottie Class](Lottie.md) - Main animation class
- [JSON Validate](https://doc.4d.com/4Dv20/4D/20/JSON-Validate.301-6237489.en.html) - 4D command documentation
- [Lottie JSON Schema](https://lottiefiles.github.io/lottie-docs/schema/) - Official schema reference
