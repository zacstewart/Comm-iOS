import XCTest
@testable import Comm

class ClientTest: XCTestCase {
    func testInitDestroy() {
        let address = Address.forContent("alpha")
        var client: Client? = Client(address: address)
        client = nil // Should deinit everything cleanly
        XCTAssertTrue(true)
    }
}
