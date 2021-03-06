import Foundation
import libcomm

public class Address: NSObject, NSCopying {
    private let raw: UnsafeMutablePointer<comm_address_t>
    private var consumed: Bool = false

    public init(rawPointer: UnsafeMutablePointer<comm_address_t>) {
        raw = rawPointer
    }

    public static func forContent(content: String) -> Address {
        let content = UnsafeMutablePointer<Int8>((content as NSString).UTF8String)
        return Address(rawPointer: comm_address_for_content(content))
    }

    public static func fromString(string: String) -> Address {
        let string = UnsafeMutablePointer<Int8>((string as NSString).UTF8String)
        return Address(rawPointer: comm_address_from_str(string))
    }

    public static func null() -> Address {
        return Address(rawPointer: comm_address_null());
    }

    public func toString() -> String? {
        // TODO: not sure with this strdup is necessary, but it appears that I
        // get junk memory when converting to a string otherwise
        let c_str = strdup(comm_address_to_str(raw));
        return String.fromCString(c_str)
    }

    public func copyWithZone(zone: NSZone) -> AnyObject {
      return Address(rawPointer: comm_address_copy(raw))
    }

    internal func consume() -> UnsafeMutablePointer<comm_address_t>? {
        if !consumed {
            consumed = true
            return raw
        } else {
            return nil
        }
    }

    deinit {
        if !consumed {
            comm_address_destroy(raw)
        }
    }
}
