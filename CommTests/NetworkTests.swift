import XCTest
@testable import Comm

class NetworkTests: XCTestCase {
    func testInitDestroy() {
        let address = Address.forContent("alpha")
        let socketAddress = "1.3.3.7:666"
        let selfNode = UdpNode(address: address, socketAddress: socketAddress)

        let routerAddress = Address.forContent("beta")
        let routerSocketAddress = "1.3.3.7:667"
        let routers = [UdpNode(address: routerAddress, socketAddress: routerSocketAddress)]

        var network: Network? = Network(
            selfNode: selfNode,
            host: socketAddress,
            routers: routers)

        network = nil // Should deinit everything cleanly
        
        XCTAssertTrue(true)
    }
}
