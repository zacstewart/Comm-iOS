import Foundation
import libcomm

class Network {
    internal let raw: UnsafeMutablePointer<comm_network_t>

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

    deinit {
        comm_network_destroy(raw)
    }
}
