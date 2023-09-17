import Foundation

struct SocketCommand: Codable, Hashable {
    let operation: Operation
    let arguments: [String]

    //----------------------------------------
    // MARK: - Coding keys
    //----------------------------------------

    enum CodingKeys: String, CodingKey {
        case operation = "op"
        case arguments = "args"
    }

    //----------------------------------------
    // MARK: - Hashable protocols
    //----------------------------------------

    func hash(into hasher: inout Hasher) {
        hasher.combine(arguments)
    }

    static func == (lhs: SocketCommand, rhs: SocketCommand) -> Bool {
        lhs.arguments == rhs.arguments
    }
}
