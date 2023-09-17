import Foundation
import Combine

protocol SocketAPIClient {
    func apiRequest(
        _ url: URL,
        operation: Operation,
        arguments: [String],
        requiresAuthorization: Bool) -> AnyPublisher<Data, Error>
}

extension SocketAPIClient {
    func apiRequest(
        _ url: URL,
        operation: Operation,
        arguments: [String],
        requiresAuthorization: Bool = false) -> AnyPublisher<Data, Error> {
            return apiRequest(url, operation: operation, arguments: arguments, requiresAuthorization: requiresAuthorization)
        }
}
