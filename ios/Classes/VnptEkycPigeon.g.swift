// Autogenerated from Pigeon (v21.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
      }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

private class VnptEkycPigeonPigeonCodecReader: FlutterStandardReader {
}

private class VnptEkycPigeonPigeonCodecWriter: FlutterStandardWriter {
}

private class VnptEkycPigeonPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return VnptEkycPigeonPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return VnptEkycPigeonPigeonCodecWriter(data: data)
  }
}

class VnptEkycPigeonPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = VnptEkycPigeonPigeonCodec(readerWriter: VnptEkycPigeonPigeonCodecReaderWriter())
}


/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol VnptEkycPigeon {
  func ekyc(accessToken: String, tokenId: String, tokenKey: String, language: String, completion: @escaping (Result<[String: Any?], Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class VnptEkycPigeonSetup {
  static var codec: FlutterStandardMessageCodec { VnptEkycPigeonPigeonCodec.shared }
  /// Sets up an instance of `VnptEkycPigeon` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: VnptEkycPigeon?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let ekycChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.vnpt_ekyc_pigeon.VnptEkycPigeon.ekyc\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      ekycChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let accessTokenArg = args[0] as! String
        let tokenIdArg = args[1] as! String
        let tokenKeyArg = args[2] as! String
        let languageArg = args[3] as! String
        api.ekyc(accessToken: accessTokenArg, tokenId: tokenIdArg, tokenKey: tokenKeyArg, language: languageArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      ekycChannel.setMessageHandler(nil)
    }
  }
}
