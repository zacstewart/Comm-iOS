//
//  Address.swift
//  Comm
//
//  Created by Zac Stewart on 7/24/16.
//  Copyright © 2016 Zac Stewart. All rights reserved.
//

import Foundation
import libcomm

class Address: NSObject, NSCopying {
    internal let raw: UnsafeMutablePointer<Void>

    init(rawPointer: UnsafeMutablePointer<Void>) {
        raw = rawPointer
    }

    static func forContent(content: String) -> Address {
        let content = UnsafeMutablePointer<Int8>((content as NSString).UTF8String)
        return Address(rawPointer: comm_address_for_content(content))
    }

    static func fromString(string: String) -> Address {
        let string = UnsafeMutablePointer<Int8>((string as NSString).UTF8String)
        return Address(rawPointer: comm_address_from_str(string))
    }

    static func null() -> Address {
        return Address(rawPointer: comm_address_null());
    }

    deinit {
        comm_address_destroy(raw)
    }

    func toString() -> String? {
        // TODO: not sure with this strdup is necessary, but it appears that I
        // get junk memory when converting to a string otherwise
        let c_str = strdup(comm_address_to_str(raw));
        return String.fromCString(c_str)
    }

    func copyWithZone(zone: NSZone) -> AnyObject {
      return Address(rawPointer: comm_address_copy(raw))
    }
}
