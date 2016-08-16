import Foundation
import libcomm

var receivedMessageAction: (TextMessage) -> () = { _ in }

func receivedMesssage(rawMessage: UnsafeMutablePointer<comm_text_message_t>) {
    let message = TextMessage(rawPointer: rawMessage)
    receivedMessageAction(message)
}

public class Client: NSObject {
    private let raw: UnsafeMutablePointer<comm_client_t>
    private var rawCommands: UnsafeMutablePointer<comm_client_commands_t>?
    private var consumed: Bool = false

    public init(address: Address) {
        raw = comm_client_new(address.consume()!)
        comm_client_register_text_message_received_callback(raw, receivedMesssage)
    }

    public func run(network: Network) {
        rawCommands = comm_client_run(self.consume()!, network.consume()!)
    }

    public func attachTextMessageReceivedAction(action: (TextMessage) -> ()) {
        receivedMessageAction = action
    }

    public func sendTextMessage(textMessage: TextMessage, recipient: Address) {
        comm_client_commands_send_text_message(
            rawCommands!,
            recipient.consume()!,
            textMessage.consume()!)
    }

    internal func consume() -> UnsafeMutablePointer<comm_client_t>? {
        if !consumed {
            consumed = true
            return raw
        } else {
            return nil
        }
    }

    deinit {
        if !consumed {
            comm_client_destroy(self.consume()!)
        }
    }
}
