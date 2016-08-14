import Foundation
import libcomm

class TextMessage {
    private let raw: UnsafeMutablePointer<comm_text_message_t>
    private var consumed: Bool = false

    init(rawPointer: UnsafeMutablePointer<comm_text_message_t>) {
        raw = rawPointer
    }

    init(sender: Address, text: String) {
        let text = UnsafeMutablePointer<Int8>((text as NSString).UTF8String)
        raw = comm_text_message_new(sender.consume()!, text);
    }

    internal func consume() -> UnsafeMutablePointer<comm_text_message_t>? {
        if !consumed {
            consumed = true
            return raw
        } else {
            return nil
        }
    }

    deinit {
        if !consumed {
            comm_text_message_destroy(raw)
        }
    }
}
