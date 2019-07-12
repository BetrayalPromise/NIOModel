# NIOModel大法好

## Data -> String -> Object(iOS中成为Dictionary) -> Model

Data -> String
```Swfit
do {
    let data: Data = try Data(contentsOf: URL(fileURLWithPath: "xxxxx.json"))
    print(data.toString())
} catch {
    debugPrint(error)
}

```

Data -> Object
```Swfit
do {
    let data: Data = try Data(contentsOf: URL(fileURLWithPath: "xxxxx.json"))
    print(data.toObject())
} catch {
    debugPrint(error)
}
```

Data -> Model
```Swfit
do {
    let data: Data = try Data(contentsOf: URL(fileURLWithPath: "xxxxx.json"))
    print(data.toString())
    data.toModel(type: XXXX.self)
} catch {
    debugPrint(error)
}
```


