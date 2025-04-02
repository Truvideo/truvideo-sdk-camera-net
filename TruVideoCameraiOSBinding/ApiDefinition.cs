
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
	
	[Export ("showCameraIn:completion:")]
	void ShowCameraIn (UIViewController viewController, Action<NSArray<NSString>> completion);
}
}