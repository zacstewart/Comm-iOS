import XCTest
@testable import Comm

class UpdNodeTests {
    func testInitDestroy() {
        let address = Address.forContent("hello")
        let socketAddress = "1.3.3.7:666"
        let node = UdpNode(address: address, socketAddress: socketAddress)
        XCTAssertTrue(true)
    }
}
