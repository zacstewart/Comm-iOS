import Foundation
import libcomm

public class TextMessage: NSObject {
    private let raw: UnsafeMutablePointer<comm_text_message_t>
    private var consumed: Bool = false

    public init(rawPointer: UnsafeMutablePointer<comm_text_message_t>) {
        raw = rawPointer
    }

    public init(sender: Address, text: String) {
        let text = UnsafeMutablePointer<Int8>((text as NSString).UTF8String)
        raw = comm_text_message_new(sender.consume()!, text);
    }
    
    public func sender() -> Address {
        return Address(rawPointer: comm_text_message_sender(raw))
    }
    
    public func text() -> String? {
        let c_str = strdup(comm_text_message_text(raw));
        return String.fromCString(c_str)
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
