import XCTest
@testable import Comm

class ClientTest: XCTestCase {
    func testInitDestroy() {
        let address = Address.forContent("alpha")
        var client: Client? = Client(address: address)
        client = nil // Should deinit everything cleanly
        XCTAssertTrue(true)
    }

    func testClientRun() {
        let address = Address.forContent("alpha")
        let socketAddress = "127.0.0.1:6000"

        let routerAddress = Address.forContent("beta")
        let routerSocketAddress = "127.0.0.1:7000"
        let routers = [UdpNode(address: routerAddress, socketAddress: routerSocketAddress)]

        let network = Network(
            selfAddress: address.copy() as! Address,
            host: socketAddress,
            routers: routers)

        let client = Client(address: address)
        client.run(network)
    }

    func testSendTextMesssage() {
        let address = Address.forContent("alpha")
        let socketAddress = "127.0.0.1:6001"

        let routerAddress = Address.forContent("beta")
        let routerSocketAddress = "127.0.0.1:7001"
        let routers = [UdpNode(address: routerAddress, socketAddress: routerSocketAddress)]

        let network = Network(
            selfAddress: address.copy() as! Address,
            host: socketAddress,
            routers: routers)

        let client = Client(address: address.copy() as! Address)
        client.run(network)

        let textMessage = TextMessage(sender: address, text: "hello")
        let recipient = Address.forContent("gimmel")
        client.sendTextMessage(textMessage, recipient: recipient)
    }
}
