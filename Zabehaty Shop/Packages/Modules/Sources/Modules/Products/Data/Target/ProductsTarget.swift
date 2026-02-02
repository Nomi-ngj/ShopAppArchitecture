import Foundation
import Moya

public enum ProductsTarget: TargetType {
    case list
    case details(id: Int)
}

extension ProductsTarget{
    public var baseURL: URL {
        URL(string: "https://dummyjson.com")!
    }

    public var path: String {
        switch self {
        case .list:
            return "/products"
        case .details(let id):
            return "/products/\(id)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .details:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .list:
            return .requestPlain
        case .details(let id):
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
