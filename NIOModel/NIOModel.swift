import Foundation

// MARK: Model转Data
public func toData<T>(by model: T) -> Data? where T: Encodable {
    do {
        return try JSONEncoder().encode(model)
    } catch {
        debugPrint(error)
        return nil
    }
}

// MARK: Model转JSON字符串
public func toString<T>(by model: T) -> String? where T: Encodable {
    return toData(by: model)?.toString()
}

// MARK: Model转JSON对象
public func toObject<T>(by model: T) -> Any? where T: Encodable {
    return toData(by: model)?.toObject()
}

public extension Dictionary {
    // MARK: JSON对象转Model
    func toModel<T>(type: T.Type) -> T? where T: Decodable {
        return self.toData()?.toModel(type: type)
    }
    
    // MARK: JSON对象转Data
    func toData() -> Data? {
        if !JSONSerialization.isValidJSONObject(self) { return nil }
        do {
            return try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    // MARK: JSON对象转JSON字符串
    func toString() -> String? {
        return self.toData()?.toString()
    }
}

public extension Array where Element: Codable {
    func toData() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    func toString() -> String? {
        guard let data: Data = self.toData() else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func toObject() -> Any? {
        guard let data: Data = self.toData() else {
            return nil
        }
        if JSONSerialization.isValidJSONObject(data) { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}

public extension String {
    // MARK: JSON字符串转Data
    func toData() -> Data? {
        return self.data(using: String.Encoding.utf8)
    }
    
    // MARK: JSON字符串转Model
    func toModel<T>(type: T.Type) -> T? where T: Decodable {
        guard let data: Data = self.data(using: String.Encoding.utf8) else { return nil }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    // MARK: JSON字符串转JSON对象
    func toObject() -> Any? {
        guard let data: Data = self.data(using: String.Encoding.utf8) else { return nil }
        if JSONSerialization.isValidJSONObject(data) { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}

public extension Data {
    // MARK: JSON二进制转Model
    func toModel<T>(type: T.Type) -> T? where T: Decodable {
        do {
            /// 会自动h过滤Value为nil的项
            return try JSONDecoder().decode(type, from: self)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    // MARK: JSON二进制转JSON对象
    func toObject() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    // MARK: JSON二进制转JSON字符串
    func toString() -> String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
}

public extension Encodable {
    // MARK: 转二进制
    func toData() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    // MARK: 转字符串
    func toString() -> String? {
        guard let data: Data = self.toData() else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    // MARK: 转对象
    func toObject() -> Any? {
        guard let data = self.toData() else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            return nil
        }
    }
}

public extension Decodable {
    // MARK: 二进制转模型
    static func toModel(from data: Data?) -> Self? {
        guard let `data`: Data = data else { return nil }
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: 对象转模型
    static func toModel(from dictionary: [AnyHashable: Any]?) -> Self? {
        guard let `dictionary`: [AnyHashable: Any] = dictionary, let jsonData = try? JSONSerialization.data(withJSONObject: dictionary) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: 字符串转模型
    static func toModel(from string: String?) -> Self? {
        guard let `string`: String = string, let jsonData = string.data(using: .utf8) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

