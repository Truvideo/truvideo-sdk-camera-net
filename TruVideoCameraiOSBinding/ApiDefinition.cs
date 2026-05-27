//
// using System;
// using UIKit;
// using Foundation;
// using ObjCRuntime;
//
// namespace TruvideoCameraiOS {
//
// // @interface TruvideoCamera : NSObject
// [BaseType (typeof(NSObject), Name = "_TtC14TruvideoCamera14TruvideoCamera")]
// [DisableDefaultCtor]
// interface TruvideoCamera
// {
// 	// @property (readonly, nonatomic, strong, class) TruvideoCamera * _Nonnull shared;
// 	[Static]
// 	[Export ("shared", ArgumentSemantic.Strong)]
// 	TruvideoCamera Shared { get; }
//
// 	// -(void)showCameraIn:(UIViewController * _Nonnull)viewController completion:(void (^ _Nonnull)(NSArray<NSString *> * _Nonnull))completion;
// 	[Export("showCameraWithLensFacing:flashMode:orientation:outputPath:mode:viewController:completion:")]
// 	void ShowCamera(string lensFacing,string flashMode,string orientation,string outputPath,string mode,UIViewController viewController, Action<NSArray<NSString>> completion);
// 	
// 	[Export ("subscribeToCameraEventsWithCompletion:")]
// 	void subscribeToCameraEvents(Action<NSString> completion);
// }
// }

using System;
using Foundation;
using ObjCRuntime;
using UIKit;

namespace TruvideoCameraiOS
{
    // ModeTypeConfig binding
    [BaseType(typeof(NSObject), Name = "_TtC14TruvideoCamera14ModeTypeConfig")]
    [DisableDefaultCtor]
    interface ModeTypeConfig 
    {
        [Export("rawType", ArgumentSemantic.Assign)]
        ModeTypeRaw RawType { get; set; }

        [Export("videoCount")]
        NSNumber VideoCount { get; set; }

         [Export("pictureCount")]
         NSNumber PictureCount { get; set; }

         [Export("videoDuration")]
         NSNumber VideoDuration { get; set; }

         [Export("mediaCount")]
         NSNumber MediaCount { get; set; }


         [Export("initWithRawType:videoCount:pictureCount:videoDuration:mediaCount:")]
         IntPtr Constructor(ModeTypeRaw rawType, [NullAllowed] NSNumber videoCount, [NullAllowed] NSNumber pictureCount, [NullAllowed] NSNumber videoDuration, [NullAllowed] NSNumber mediaCount);
         
        // Static factory methods
        [Static]
        [Export("videoAndPictureWithVideoCount:pictureCount:videoDuration:")]
        ModeTypeConfig VideoAndPicture([NullAllowed] NSNumber videoCount, [NullAllowed] NSNumber pictureCount, [NullAllowed] NSNumber videoDuration);

        [Static]
        [Export("singleVideoWithVideoDuration:")]
        ModeTypeConfig SingleVideo([NullAllowed] NSNumber videoDuration);

        [Static]
        [Export("singlePicture")]
        ModeTypeConfig SinglePicture();

        [Static]
        [Export("singleVideoOrPictureWithVideoDuration:")]
        ModeTypeConfig SingleVideoOrPicture([NullAllowed] NSNumber videoDuration);

        [Static]
        [Export("videoWithVideoCount:videoDuration:")]
        ModeTypeConfig Video([NullAllowed] NSNumber videoCount, [NullAllowed] NSNumber videoDuration);

        [Static]
        [Export("pictureWithPictureCount:")]
        ModeTypeConfig Picture([NullAllowed] NSNumber pictureCount);

        [Static]
        [Export("videoAndPictureCountedWithMediaCount:videoDuration:")]
        ModeTypeConfig VideoAndPictureCounted([NullAllowed] NSNumber mediaCount, [NullAllowed] NSNumber videoDuration);

    }

    // TruvideoCamera binding
    [BaseType(typeof(NSObject), Name = "_TtC14TruvideoCamera14TruvideoCamera")]
    [Protocol]
    [DisableDefaultCtor]
    interface TruvideoCamera
    {
        [Static]
        [Export("shared")]
        TruvideoCamera Shared { get; }

        [Export("showCameraWithLensFacing:flashMode:orientation:outputPath:modeConfig:viewController:completion:")]
        void ShowCamera(LensType lensFacing, FlashMode flashMode, OrientationMode orientation, string outputPath, ModeTypeConfig modeConfig, UIViewController viewController, Action<NSArray<NSDictionary>> completion);

        [Export("getCameraInfoWithCompletionHandler:")]
        void GetCameraInfo(Action<NSString, NSError> completionHandler);

       [Export("subscribeToCameraEventsWithCompletion:")]
        void SubscribeToCameraEvents(Action<NSString> completion);

        [Export("clearCameraEventSubscriptions")]
        void ClearCameraEventSubscriptions();
        
        [Export("showARCameraWithFlashMode:orientation:modeConfig:viewController:completion:")]
        void ShowARCamera(
            FlashMode flashMode,
            OrientationMode orientation,
            ModeTypeConfig modeConfig,
            UIViewController viewController,
            [BlockCallback] Action<NSArray<NSDictionary>> completion
        );
        
        [Export("showScannerCameraWithFlashMode:orientation:viewController:completion:")]
        void ShowScannerCamera(
            FlashMode flashMode,
            OrientationMode orientation,
            UIViewController viewController,
            [BlockCallback] Action<NSArray<NSDictionary>> completion
        );
    }
}
