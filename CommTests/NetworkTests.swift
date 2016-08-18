import XCTest
@testable import Comm

class NetworkTests: XCTestCase {
    func testInitDestroy() {
        let address = Address.forContent("alpha")
        let socketAddress = "1.3.3.7:9666"

        let routerAddress = Address.forContent("beta")
        let routerSocketAddress = "1.3.3.7:9667"
        let routers = [UdpNode(address: routerAddress, socketAddress: routerSocketAddress)]

        var network: Network? = Network(
            selfAddress: address,
            host: socketAddress,
            routers: routers)

        network = nil // Should deinit everything cleanly

        XCTAssertTrue(true)
    }
}
