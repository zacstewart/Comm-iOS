import Foundation
import libcomm

class UdpNode {
    private let raw: UnsafeMutablePointer<Void>

    init(address: Address, socketAddress: String) {
        let socketAddress = UnsafeMutablePointer<Int8>((socketAddress as NSString).UTF8String)
        raw = comm_udp_node_new(address.raw, socketAddress)
    }

    deinit {
        comm_udp_node_destroy(raw)
    }
}
