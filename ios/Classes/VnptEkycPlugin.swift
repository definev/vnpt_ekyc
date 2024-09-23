import Flutter
import UIKit

#if !targetEnvironment(simulator)
    import ICNFCCardReader

    public class VnptEkycPlugin: NSObject, FlutterPlugin, VnptEkycPigeon {
        public static func register(with registrar: FlutterPluginRegistrar) {
            let instance = VnptEkycPlugin()
            VnptEkycPigeonSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        }

        var ekycCompletion: ((Result<[String: String?], any Error>) -> Void)?

        func viewController(with window: UIWindow?) -> UIViewController? {
            var windowToUse = window
            if windowToUse == nil {
                for window in UIApplication.shared.windows {
                    if window.isKeyWindow {
                        windowToUse = window
                        break
                    }
                }
            }

            var topController = windowToUse?.rootViewController
            while (topController?.presentedViewController) != nil {
                topController = topController?.presentedViewController
            }
            return topController
        }

        func ekyc(
            accessToken: String,
            tokenId: String,
            tokenKey: String, language: String,
            completion: @escaping (
                Result<[String: String?], any Error>
            ) -> Void
        ) {
            let objICMainNFCReader = ICMainNFCReaderRouter.createModule() as!
            ICMainNFCReaderViewController
            objICMainNFCReader.icMainNFCDelegate = self
            // Nhập thông tin bộ mã truy cập.
            // Lấy tại mục Quản lý Token
            // https://ekyc.vnpt.vn/admin-dashboard/console/project-manager
            // Bộ token của NFC
            objICMainNFCReader.accessToken = accessToken
            objICMainNFCReader.tokenId = tokenId
            objICMainNFCReader.tokenKey = tokenKey
            // Bộ token của eKYC (dùng để upload ảnh, postcode nếu có)
            objICMainNFCReader.accessTokenEKYC = accessToken
            objICMainNFCReader.tokenIdEKYC = tokenId
            objICMainNFCReader.tokenKeyEKYC = tokenKey
            // Thuộc tính xác định bước quét thông tin thẻ căn cước
            objICMainNFCReader.cardReaderStep = QRCode
            // Ngôn ngữ SDK
            objICMainNFCReader.languageSdk = "icnfc_\(language)"

            objICMainNFCReader.modalPresentationStyle = .fullScreen
            objICMainNFCReader.modalTransitionStyle = .coverVertical

            guard let controller = viewController(with: nil) else { return }
            controller.present(objICMainNFCReader, animated: true, completion: nil)

            ekycCompletion = completion
        }
    }

    extension VnptEkycPlugin: ICMainNFCReaderDelegate {
        public func responseNfcResult() {
            let logNfc: [String: Any] = ICNFCSaveData.shared().dataNFCResult
            let qrCode = ICNFCSaveData.shared().scanQRCodeResult
            let avatar = ICNFCSaveData.shared().hashImageAvatar

            if qrCode.isEmpty {
                ekycCompletion?(
                    Result.success([
                        "qr_code": nil,
                        "log_nfc": nil,
                        "avatar": nil,
                        "error": "cancelled by user",
                    ])
                )
                return
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: logNfc, options: .prettyPrinted)
                if let logNfc = String(data: jsonData, encoding: .utf8) {
                    ekycCompletion?(
                        Result.success([
                            "qr_code": qrCode,
                            "log_nfc": logNfc,
                            "avatar": avatar,
                        ])
                    )
                }
            } catch {
                ekycCompletion?(
                    Result.success([
                        "qr_code": nil,
                        "log_nfc": nil,
                        "avatar": nil,
                        "error": "cancelled by user",
                    ])
                )
            }

            ekycCompletion = nil
        }

        public func icNFCMainDismissed(_ lastStep: ICNFCLastStep) {
            responseNfcResult()
        }
        public func icNFCPopupReaderChipDisappear() {
            responseNfcResult()
        }
        public func icNFCCardReaderGetResult() {
            responseNfcResult()
        }
    }
#else

    public class VnptEkycPlugin: NSObject, FlutterPlugin, VnptEkycPigeon {
        public static func register(with registrar: FlutterPluginRegistrar) {
        }


        func ekyc(
            accessToken: String,
            tokenId: String,
            tokenKey: String, language: String,
            completion: @escaping (
                Result<[String: Any?], any Error>
            ) -> Void
        ) {
            completion(Result.failure(PigeonError(code: "404", message: "EKYC not implemented in simulator", details: nil)))
        }
    }

#endif
