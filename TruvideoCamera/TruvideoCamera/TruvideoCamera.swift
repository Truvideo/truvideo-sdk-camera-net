
import UIKit
import TruvideoSdkCamera
import Combine

@objc
final public class TruvideoCamera: NSObject {
    @objc
    public static let shared = TruvideoCamera()

    var disposeBag = Set<AnyCancellable>()
    
    @objc public func showCamera(lensFacing: LensType, flashMode: FlashMode, orientation: OrientationMode, outputPath: String, modeConfig: ModeTypeConfig, viewController: UIViewController, completion: @escaping (_ paths: [String]) -> Void) {
        
        let lensType = lensFacingType(lensFacing)
        let flashType = flashModeType(flashMode)
        let orientationType = videoOrientationType(orientation)
        let modetype = convertModeType(modeConfig)
        
        let configuration = TruvideoSdkCameraConfiguration(lensFacing: lensType, flashMode: flashType, orientation: orientationType, outputPath: outputPath, frontResolutions: [], frontResolution: nil, backResolutions: [], backResolution: nil, mode: modetype)
        
        viewController.presentTruvideoSdkCameraView(preset: configuration, onComplete: { result in
            completion(result.media.map({ $0.filePath }))
        })
    }
    
    @objc public func getCameraInfo(completionHandler: @escaping (_ result: String?, _ error: Error?) -> Void) {
        Task {
            do {
                let cameraInfo: TruvideoSdkCameraInformation = TruvideoSdkCamera.camera.getTruvideoSdkCameraInformation()
                let jsonData = try JSONEncoder().encode(cameraInfo)
                let jsonString = String(data: jsonData, encoding: .utf8)
                completionHandler(jsonString, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }

    func lensFacingType(_ type: LensType) -> TruvideoSdkCameraLensFacing {
        switch type {
        case .back:
            return .back
            
        case .front:
            return .front
        
        default:
            return .back
        }
    }
    
    func flashModeType(_ mode: FlashMode) -> TruvideoSdkCameraFlashMode {
        switch mode {
        case .off:
            return .off
       
        case .on:
            return .on
            
        default:
            return .off
        }
    }
    
    func videoOrientationType(_ orientation: OrientationMode) -> TruvideoSdkCameraOrientation {
        switch orientation {
        case .portrait:
            return .portrait
           
        case .landscapeLeft:
            return .landscapeLeft
            
        case .landscapeRight:
            return .landscapeRight
            
        case .portraitReverse:
            return .portraitReverse
            
        default:
            return .portrait
        }
    }
    
    func convertModeType(_ config: ModeTypeConfig) -> TruvideoSdkCameraMediaMode {
        switch config.rawType {
        case .videoAndPicture:
            return .videoAndPicture(videoCount: config.videoCount?.intValue, pictureCount: config.pictureCount?.intValue, videoDuration: config.videoDuration?.intValue)

        case .singleVideo:
            return .singleVideo(videoDuration: config.videoDuration?.intValue)

        case .singlePicture:
            return .singlePicture()

        case .singleVideoOrPicture:
            return .singleVideoOrPicture(videoDuration: config.videoDuration?.intValue)

        case .video:
            return .video(videoCount: config.videoCount?.intValue, videoDuration: config.videoDuration?.intValue)

        case .picture:
            return .picture(pictureCount: config.pictureCount?.intValue)

        case .videoAndPictureCounted:
            return .videoAndPicture(mediaCount: config.mediaCount?.intValue ?? 0, videoDuration: config.videoDuration?.intValue)
        }
    }

    
   @objc public func subscribeToCameraEvents(completion: @escaping (_ paths: String) -> Void) {
           TruvideoSdkCamera
               .events
               .sink { cameraEvent in
                   completion("cameraEvent: \(cameraEvent)")
               }
               .store(in: &disposeBag)
       }
}

@objc public enum LensType: Int {
    case back
    case front
}

@objc public enum FlashMode: Int {
    case on
    case off
}

@objc public enum OrientationMode: Int {
    case portrait
    case landscapeLeft
    case landscapeRight
    case portraitReverse
}

@objc
public enum ModeTypeRaw: Int {
    case videoAndPicture = 0
    case singleVideo = 1
    case singlePicture = 2
    case singleVideoOrPicture = 3
    case video = 4
    case picture = 5
    case videoAndPictureCounted = 6
}

@objc
public class ModeTypeConfig: NSObject {
    @objc public var rawType: ModeTypeRaw
    @objc public var videoCount: NSNumber?  // <- Optional!
    @objc public var pictureCount: NSNumber?
    @objc public var videoDuration: NSNumber?
    @objc public var mediaCount: NSNumber?

    @objc public init(rawType: ModeTypeRaw,
                      videoCount: NSNumber? = nil,
                      pictureCount: NSNumber? = nil,
                      videoDuration: NSNumber? = nil,
                      mediaCount: NSNumber? = nil) {
        self.rawType = rawType
        self.videoCount = videoCount
        self.pictureCount = pictureCount
        self.videoDuration = videoDuration
        self.mediaCount = mediaCount
    }

    // Updated factory methods
    @objc public static func videoAndPicture(videoCount: NSNumber? = nil, pictureCount: NSNumber? = nil, videoDuration: NSNumber? = nil) -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .videoAndPicture, videoCount: videoCount, pictureCount: pictureCount, videoDuration: videoDuration)
    }

    @objc public static func singleVideo(videoDuration: NSNumber? = nil) -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .singleVideo, videoDuration: videoDuration)
    }

    @objc public static func singlePicture() -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .singlePicture)
    }

    @objc public static func singleVideoOrPicture(videoDuration: NSNumber? = nil) -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .singleVideoOrPicture, videoDuration: videoDuration)
    }

    @objc public static func video(videoCount: NSNumber? = nil, videoDuration: NSNumber? = nil) -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .video, videoCount: videoCount, videoDuration: videoDuration)
    }

    @objc public static func picture(pictureCount: NSNumber? = nil) -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .picture, pictureCount: pictureCount)
    }

    @objc public static func videoAndPictureCounted(mediaCount: NSNumber? = nil, videoDuration: NSNumber? = nil) -> ModeTypeConfig {
        return ModeTypeConfig(rawType: .videoAndPictureCounted, videoDuration: videoDuration, mediaCount: mediaCount)
    }
}
