import Combine
import Foundation

class CoinSocketAPIClient: NSObject, SocketAPIClient {

    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------

    override init() {
    }

    //----------------------------------------
    // MARK: - APIClient Protocol
    //----------------------------------------

    func apiRequest(
        _ url: URL,
        operation: Operation,
        arguments: [String],
        requiresAuthorization: Bool = false) -> AnyPublisher<Data, Error> {
            let emitValueSubject = PassthroughSubject<Data, Error>()

            let socketCommand = SocketCommand(operation: operation, arguments: arguments)
            let id = socketCommand.arguments.joined(separator: "")

            guard let data = try? JSONEncoder().encode(socketCommand),
                  let jsonString = String(data: data, encoding: .utf8) else {
                emitValueSubject.send(completion: .failure(AppError.badRequest))
                return emitValueSubject.eraseToAnyPublisher()
            }

            let webSocketTask: URLSessionWebSocketTask?

            switch operation {
            case .subscribe:
                webSocketTask = urlSession.webSocketTask(with: url)
                webSocketTask?.resume()
                connectingSocketTasks[id] = webSocketTask

            case .unsubscribe:
                webSocketTask = connectingSocketTasks[id]
                connectingSocketTasks.removeValue(forKey: id)
            }

            webSocketTask?.send(.string(jsonString)) { error in
                if let error = error {
                    print("WebSocket sending error: \(error)")
                    emitValueSubject.send(completion: .failure(error))
                }
            }

            func receiveMessage() {
                webSocketTask?.receive { result in
                    switch result {
                    case .failure(let error):
                        print("Failed to receive message: \(error)")
                        emitValueSubject.send(completion: .failure(error))

                    case .success(let message):
                        switch message {
                        case .string(let text):
                            print("Received text message: \(text)")
                            guard let data = text.data(using: .utf8) else {
                                emitValueSubject.send(completion: .failure(AppError.invalidData))
                                return
                            }
                            emitValueSubject.send(data)

                        case .data(let data):
                            print("Received binary message: \(data)")
                            emitValueSubject.send(data)

                        default:
                            break
                        }
                    }
                    receiveMessage()
                }
            }

            receiveMessage()

            return emitValueSubject.eraseToAnyPublisher()
        }

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    private lazy var urlSession: URLSession = {
        return URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    }()

    private var connectingSocketTasks: [String: URLSessionWebSocketTask] = [:]
}
