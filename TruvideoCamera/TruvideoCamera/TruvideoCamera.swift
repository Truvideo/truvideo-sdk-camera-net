import UIKit
import TruvideoSdkCamera
import Combine

@objc
final public class TruvideoCamera: NSObject {
    @objc
    public static let shared = TruvideoCamera()

    var disposeBag = Set<AnyCancellable>()
    
    @objc public func showCamera(lensFacing: String, flashMode: String, orientation: String?, outputPath: String, mode: String,viewController: UIViewController, completion: @escaping (_ paths: [String]) -> Void) {
        
        let lensType = lensFacingType(lensFacing)
        let flashType = flashModeType(flashMode)
        let orientationType = videoOrientationType(orientation ?? "portrait")
        let modetype = modeType(mode)
        
        
        let configuration = TruvideoSdkCameraConfiguration(lensFacing: lensType, flashMode: flashType, orientation: orientationType, outputPath: outputPath, frontResolutions: [], frontResolution: nil, backResolutions: [], backResolution: nil, mode: modetype)
        
        viewController.presentTruvideoSdkCameraView(preset: configuration, onComplete: { result in
            completion(result.media.map({ $0.filePath }))
        })

    }
    
    func lensFacingType(_ string: String) -> TruvideoSdkCameraLensFacing {
        switch string {
        case "Back":
            return .back
            
        case "Front":
            return .front
        
        default:
            return .back
        }
    }
    
    func flashModeType(_ string: String) -> TruvideoSdkCameraFlashMode {
        switch string {
        case "On":
            return .on
       
        case "Off":
            return .off
            
        default:
            return .off
        }
    }
    
    func videoOrientationType(_ string: String) -> TruvideoSdkCameraOrientation {
        switch string {
        case "Portrait":
            return .portrait
           
        case "LandscapeLeft":
            return .landscapeLeft
            
        case "LandscapeRight":
            return .landscapeRight
            
        case "PortraitReverse":
            return .portraitReverse
            
        default:
            return .portrait
        }
    }
    
    func modeType(_ string: String) -> TruvideoSdkCameraMediaMode {
        switch string {
        case "Picture":
            return .picture()
            
        case "SinglePicture":
            return .singlePicture()
            
        case "SingleVideo":
            return .singleVideo()
            
        case "SingleVideoOrPicture":
            return .singleVideoOrPicture()
            
        case "Video":
            return .video()
            
        case "VideoAndPicture":
            return .videoAndPicture()
       
        default:
            return .videoAndPicture()
        }
    }
    
   @objc private func subscribeToCameraEvents(completion: @escaping (_ paths: String) -> Void) {
           TruvideoSdkCamera
               .events
               .sink { cameraEvent in
                   completion("cameraEvent: \(cameraEvent)")
               }
               .store(in: &disposeBag)
       }
}
