import UIKit
import TruvideoSdkCamera

@objc
final public class TruvideoCameraSdk: NSObject {
    @objc
    public static let shared = TruvideoCameraSdk()

    @objc public func showCamera(in viewController: UIViewController, completion: @escaping (_ paths: [String]) -> Void) {
        viewController.presentTruvideoSdkCameraView { result in
            completion(result.media.map({ $0.filePath }))
        }
    }
}
