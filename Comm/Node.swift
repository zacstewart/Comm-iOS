import Foundation
import libcomm

class UdpNode {
    private let raw: UnsafeMutablePointer<comm_udp_node_t>
    private var consumed: Bool = false

    init(address: Address, socketAddress: String) {
        let socketAddress = UnsafeMutablePointer<Int8>((socketAddress as NSString).UTF8String)
        raw = comm_udp_node_new(address.consume()!, socketAddress)
    }
    
    internal func consume() -> UnsafeMutablePointer<comm_udp_node_t>? {
        if (!consumed) {
            consumed = true
            return raw
        } else {
            return nil
        }
    }

    deinit {
        if !consumed {
            comm_udp_node_destroy(raw)
        }
    }
}
