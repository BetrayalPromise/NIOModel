# 所有的功能都集成在[SwiftModel](https://github.com/BetrayalPromise/SwiftModel.git)该工具已经停止更新
# NIOModel大法好

## Data -> String -> Object(iOS中成为Dictionary) -> Model

### Data转其他三种类型

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

### String转其他三种类型

String -> Data
```Swfit
let string = "{\"resultData\":[{\"name\":\"待审\",\"code\":\"5\",\"count\":0,\"icon\":null,\"type\":1},{\"name\":\"待做\",\"code\":\"6\",\"count\":57,\"icon\":null,\"type\":1},{\"name\":\"待阅\",\"code\":\"7\",\"count\":0,\"icon\":null,\"type\":1}],\"requestId\":\"d320092874a8470096e533a6e898b7f7\",\"serverTime\":\"2019-07-11 16:25:08\",\"resultCode\":\"0\",\"resultDesc\":null,\"message\":\"请求成功\"}"

print(string.toData())
```

String -> Object
```Swfit
let string = "{\"resultData\":[{\"name\":\"待审\",\"code\":\"5\",\"count\":0,\"icon\":null,\"type\":1},{\"name\":\"待做\",\"code\":\"6\",\"count\":57,\"icon\":null,\"type\":1},{\"name\":\"待阅\",\"code\":\"7\",\"count\":0,\"icon\":null,\"type\":1}],\"requestId\":\"d320092874a8470096e533a6e898b7f7\",\"serverTime\":\"2019-07-11 16:25:08\",\"resultCode\":\"0\",\"resultDesc\":null,\"message\":\"请求成功\"}"

print(string.toObject())
```

String -> Model
```Swfit
let string = "{\"resultData\":[{\"name\":\"待审\",\"code\":\"5\",\"count\":0,\"icon\":null,\"type\":1},{\"name\":\"待做\",\"code\":\"6\",\"count\":57,\"icon\":null,\"type\":1},{\"name\":\"待阅\",\"code\":\"7\",\"count\":0,\"icon\":null,\"type\":1}],\"requestId\":\"d320092874a8470096e533a6e898b7f7\",\"serverTime\":\"2019-07-11 16:25:08\",\"resultCode\":\"0\",\"resultDesc\":null,\"message\":\"请求成功\"}"

print(string.toModel(XXXX.self))
```

### Object转其他三种类型

Object -> Data
```Swfit
let dictionary = ["name": "5分钟突破iOS开发", "publishedTime": "2011-09-10"]
dictionary.toData()
```

Object -> String
```Swfit
let dictionary = ["name" : "5分钟突破iOS开发","publishedTime": "2011-09-10"]
dictionary.toString()
```

Object -> Model
```Swfit
let dictionary = ["name" : "5分钟突破iOS开发","publishedTime": "2011-09-10"]
dictionary.toModel(XXXX.self)
```

### Model转其他三种类型

```
struct School: Codable {
    var name: String?
    var count: Int?
    ...
}
```

Model -> Data
```Swfit
let m: School = School()
m.toData()
```

Model -> String
```Swfit
let m: School = School()
m.toString()
```

Model -> Object
```Swfit
let m: School = School()
m.toObject()
```

## 引入工具
```ruby
touch Cartfile
echo 'git "https://github.com/BetrayalPromise/NIOModel.git"' > Cartfile
carthage update --platform iOS
```
