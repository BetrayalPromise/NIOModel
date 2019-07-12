import Foundation
import UIKit

/// Model -> Data
///
/// - Parameter model: 模型
/// - Returns: 转化完毕后的Data
public func toData<T>(by model: T) -> Data? where T: Encodable {
    do {
        return try JSONEncoder().encode(model)
    } catch {
        debugPrint(error)
        return nil
    }
}

/// Model -> String
///
/// - Parameter model: 模型
/// - Returns: 转化完毕后的String
public func toString<T>(by model: T) -> String? where T: Encodable {
    return toData(by: model)?.toString()
}

/// Model -> Object
///
/// - Parameter model: 模型
/// - Returns: 转化完毕后的Object
public func toObject<T>(by model: T) -> Any? where T: Encodable {
    return toData(by: model)?.toObject()
}

public extension Dictionary {
    /// Object -> Model
    ///
    /// - Parameter type: 类型
    /// - Returns: 转化完毕后的Model
    func toModel<T>(type: T.Type) -> T? where T: Decodable {
        return self.toData()?.toModel(type: type)
    }
    
    /// Object -> Data
    ///
    /// - Returns: 转化完毕后的Data
    func toData() -> Data? {
        if !JSONSerialization.isValidJSONObject(self) { return nil }
        do {
            return try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    /// Object -> String
    ///
    /// - Returns: 转化完毕后的String
    func toString() -> String? {
        return self.toData()?.toString()
    }
}

public extension String {
    /// String -> Data
    ///
    /// - Returns: 转化完毕后的Data
    func toData() -> Data? {
        return self.data(using: String.Encoding.utf8)
    }
    
    /// String -> Model
    ///
    /// - Parameter type: 类型
    /// - Returns: 转化完毕后的Model
    func toModel<T>(type: T.Type) -> T? where T: Decodable {
        guard let data: Data = self.data(using: String.Encoding.utf8) else { return nil }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    /// String -> Object
    ///
    /// - Returns: 转化完毕后的Object
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
    /// Data -> Model
    ///
    /// - Parameter type: 类型
    /// - Returns: 转化完毕后的Model
    func toModel<T>(type: T.Type) -> T? where T: Decodable {
        do {
            /// 会自动h过滤Value为nil的项
            return try JSONDecoder().decode(type, from: self)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    /// Data -> Object
    ///
    /// - Returns: 转化完毕后的Object
    func toObject() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    /// Data -> String
    ///
    /// - Returns: 转化完毕后的String
    func toString() -> String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
}

public extension Encodable {
    /// Model -> Data
    ///
    /// - Returns: 转化完毕后的Data
    func toData() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    /// Model -> String
    ///
    /// - Returns: 转化完毕后的String
    func toString() -> String? {
        guard let data: Data = self.toData() else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    /// Model -> Object
    ///
    /// - Returns: 转化完毕后的Object
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
    /// Data -> Model
    ///
    /// - Parameter data: 二进制
    /// - Returns: 转化完毕后的Model
    static func toModel(from data: Data?) -> Self? {
        guard let `data`: Data = data else { return nil }
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    /// Object -> Model
    ///
    /// - Parameter dictionary: 对象
    /// - Returns: 转化完毕后的Model
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
    
    /// String -> Model
    ///
    /// - Parameter string: 字符串
    /// - Returns: 转化完毕后的Model
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

