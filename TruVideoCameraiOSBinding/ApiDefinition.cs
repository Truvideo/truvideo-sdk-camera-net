
using System;
using UIKit;
using Foundation;
using ObjCRuntime;

namespace TruvideoCameraiOS {

// @interface TruvideoCamera : NSObject
[BaseType (typeof(NSObject), Name = "_TtC14TruvideoCamera14TruvideoCamera")]
[DisableDefaultCtor]
interface TruvideoCamera
{
	// @property (readonly, nonatomic, strong, class) TruvideoCamera * _Nonnull shared;
	[Static]
	[Export ("shared", ArgumentSemantic.Strong)]
	TruvideoCamera Shared { get; }

	// -(void)showCameraIn:(UIViewController * _Nonnull)viewController completion:(void (^ _Nonnull)(NSArray<NSString *> * _Nonnull))completion;
	[Export("showCameraWithLensFacing:flashMode:orientation:outputPath:mode:viewController:completion:")]
	void ShowCamera(string lensFacing,string flashMode,string orientation,string outputPath,string mode,UIViewController viewController, Action<NSArray<NSString>> completion);
	
	[Export ("subscribeToCameraEventsWithCompletion:")]
	void subscribeToCameraEvents(Action<NSString> completion);
}
}