import Flutter
import UIKit

#if !targetEnvironment(simulator)
    import ICSdkEKYC
    import eKYCLib

    public class VnptEkycPlugin: NSObject, FlutterPlugin, VnptEkycPigeon, ICEkycCameraDelegate {
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

            ICEKYCSavedData.shared().tokenId = tokenId
            ICEKYCSavedData.shared().tokenKey = tokenKey
            ICEKYCSavedData.shared().authorization = accessToken

            guard let controller = viewController(with: nil) else { return }

            ekycCompletion = completion

            let objCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController

            objCamera.versionSdk = ProOval
            objCamera.flowType = full
            objCamera.documentType = IdentityCard
            objCamera.cameraDelegate = self

            // objCamera.arrayItemPostCode = [] as Array<PostCodeType>
            // objCamera.unitCustomer = "test1" // bỏ thuộc tính này
            // objCamera.resourceCustomer = "VNPT" // bỏ thuộc tính này
            objCamera.challengeCode = "INNOVATIONCENTER"

            // objCamera.isShowResult = false // bỏ thuộc tính này
            objCamera.isShowTutorial = true // đổi từ isShowHelp sang isShowTutorial
            objCamera.isShowTrademark = false
            objCamera.isCheckLivenessCard = true
            objCamera.isEnableCompare = true
            objCamera.isCheckMaskedFace = true
            // objCamera.isAddFace = true // bỏ thuộc tính này
            objCamera.languageSdk = "icekyc_\(language)"
            objCamera.isValidatePostcode = true

            objCamera.modalPresentationStyle = .fullScreen
            objCamera.modalTransitionStyle = .coverVertical

            controller.present(objCamera, animated: true, completion: nil)
        }

        public func icEkycGetResult() {
            let data = ICEKYCSavedData.shared()

            ekycCompletion?(Result.success([
                "data_info": data.ocrResult,
                "data_compare": data.compareFaceResult,
            ]))
            ekycCompletion = nil
        }

        public func icEkycCameraClosed(with type: ScreenType) {
            ekycCompletion?(Result.success(["error": "cancel by user"]))
            ekycCompletion = nil
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
