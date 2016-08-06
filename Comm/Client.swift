import Foundation
import libcomm

class Client {
    internal let raw: UnsafeMutablePointer<comm_client_t>

    init(address: Address) {
        raw = comm_client_new(address.consume()!)
    }
}
