import Foundation

struct CoinSocketAPIJSON<T>: Decodable where T: Decodable {
    let table: String
    let data: T
}
