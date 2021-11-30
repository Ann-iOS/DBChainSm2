//
//  ChainType.swift
//  GMObjC_Example
//
//  Created by iOS on 2021/9/27.
//  Copyright © 2021 lifei. All rights reserved.
//

import Foundation
import CommonCrypto

extension UInt8 {
    static func signerfromHex(hexString: String) -> UInt8 {
        return UInt8(strtoul(hexString, nil, 16))
    }
}

extension StringProtocol {
    var signertoBytes: [UInt8] {
        let hexa = Array(self)
        return stride(from: 0, to: count, by: 2).compactMap {
            UInt8.signerfromHex(hexString: String(hexa[$0..<$0.advanced(by: 2)]))
        }
    }
}


@objc public enum ChainType: Int {

    case COSMOS_MAIN
    case IRIS_MAIN
    case BINANCE_MAIN
    case KAVA_MAIN
    case IOV_MAIN
    case BAND_MAIN
    case SECRET_MAIN
    case DBCHAIN_MAIN

    case BINANCE_TEST
    case KAVA_TEST
    case IOV_TEST
    case OKEX_TEST
    case CERTIK_TEST

    static func SUPPRT_CHAIN() -> Array<ChainType> {
        var result = [ChainType]()
        result.append(COSMOS_MAIN)
        result.append(IRIS_MAIN)
        result.append(BINANCE_MAIN)
        result.append(IOV_MAIN)
        result.append(KAVA_MAIN)
        result.append(BAND_MAIN)
        result.append(SECRET_MAIN)

        result.append(DBCHAIN_MAIN)

//        result.append(BINANCE_TEST)
//        result.append(KAVA_TEST)
//        result.append(IOV_TEST)
        result.append(OKEX_TEST)
        result.append(CERTIK_TEST)
        return result
    }
}


/// 获取地址
/// - Parameters:
///   - pubHex: 公钥哈希
///   - chain: chain 类型
/// - Returns: 返回地址
@objcMembers
open class Address: NSObject {

    @objc public override init() {
         super.init()
     }

     @objc public func sm2GetPubToDpAddress(_ pubHex:Data, _ chain:ChainType) -> String {
        var result = ""
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        let pubHexData = pubHex as NSData
        CC_SHA256(pubHexData.bytes, UInt32(pubHexData.length), &hash)
        let sha256 = NSData(bytes: hash, length: digestLength)

        let shaArr = sha256[0...19]
//        print("公钥Sha256数组: \(shaArr)")
        let ripemd160 = Data(shaArr)
       if (chain == ChainType.COSMOS_MAIN) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "cosmos", program: ripemd160)
       } else if (chain == ChainType.DBCHAIN_MAIN) {
        result = try! SegwitAddrCoder.shared.encode2(hrp: "dbchain", program: ripemd160)
       } else if (chain == ChainType.IRIS_MAIN) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "iaa", program: ripemd160)
       } else if (chain == ChainType.BINANCE_MAIN) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "bnb", program: ripemd160)
       } else if (chain == ChainType.KAVA_MAIN || chain == ChainType.KAVA_TEST) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "kava", program: ripemd160)
       } else if (chain == ChainType.BAND_MAIN) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "band", program: ripemd160)
       } else if (chain == ChainType.SECRET_MAIN) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "secret", program: ripemd160)
       } else if (chain == ChainType.BINANCE_TEST) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "tbnb", program: ripemd160)
       } else if (chain == ChainType.IOV_MAIN || chain == ChainType.IOV_TEST) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "star", program: ripemd160)
       } else if (chain == ChainType.OKEX_TEST) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "okexchain", program: ripemd160)
       } else if (chain == ChainType.CERTIK_TEST) {
           result = try! SegwitAddrCoder.shared.encode2(hrp: "certik", program: ripemd160)
       }
       return result
    }

}

extension Data{
    public func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }
}



public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
