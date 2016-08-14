import Foundation
import libcomm

class Network {
    private let raw: UnsafeMutablePointer<comm_network_t>
    private var consumed: Bool = false

    init(selfNode: UdpNode, host: String, routers: [UdpNode]) {
        let host = UnsafeMutablePointer<Int8>((host as NSString).UTF8String)
        var rawRouters = routers.map({(router: UdpNode) -> UnsafeMutablePointer<comm_udp_node_t> in
            return router.consume()!
        })
        raw = comm_network_new(
            selfNode.consume()!,
            host,
            &rawRouters,
            rawRouters.count)
    }

    internal func consume() -> UnsafeMutablePointer<comm_network_t>? {
        if !consumed {
            consumed = true
            return raw
        } else {
            return nil
        }
    }

    deinit {
        if !consumed {
            comm_network_destroy(self.consume()!)
        }
    }
}
