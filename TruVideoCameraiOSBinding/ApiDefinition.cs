
using System;
using UIKit;
using Foundation;
using ObjCRuntime;

namespace TruvideoCameraiOS {
// @interface TruvideoCameraSdk : NSObject
[BaseType (typeof(NSObject), Name = "_TtC14TruvideoCamera17TruvideoCameraSdk")]
[DisableDefaultCtor]
interface TruvideoCameraSdk
{
	// @property (readonly, nonatomic, strong, class) TruvideoCameraSdk * _Nonnull shared;
	[Static]
	[Export ("shared", ArgumentSemantic.Strong)]
	TruvideoCameraSdk Shared { get; }

	// -(void)showCameraIn:(UIViewController * _Nonnull)viewController completion:(void (^ _Nonnull)(NSArray<NSString *> * _Nonnull))completion;
	[Export ("showCameraIn:completion:")]
	void ShowCameraIn (UIViewController viewController, Action<NSArray<NSString>> completion);
}
}