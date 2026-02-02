
import Moya
import Foundation

public extension MoyaProvider {
    func requestAsync<T: Decodable>(_ target: Target, type: T.Type) async throws -> T {
        try await withCheckedThrowingContinuation { cont in
            request(target) { result in
                switch result {
                case .success(let resp):
                    do { cont.resume(returning: try JSONDecoder().decode(T.self, from: resp.data)) }
                    catch { cont.resume(throwing: error) }
                case .failure(let err):
                    cont.resume(throwing: err)
                }
            }
        }
    }
}
