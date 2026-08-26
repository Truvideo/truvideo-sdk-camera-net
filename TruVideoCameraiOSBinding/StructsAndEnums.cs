using System;
using ObjCRuntime;
using Foundation;

namespace TruvideoCameraiOS
{
    // Define the ModeTypeRaw enum here separately from the interfaces
    [Native]
    public enum ModeTypeRaw : long
    {
        VideoAndPicture = 0,
        SingleVideo = 1,
        SinglePicture = 2,
        SingleVideoOrPicture = 3,
        Video = 4,
        Picture = 5,
        VideoAndPictureCounted = 6
    }
    
    public enum LensType
    {
        Back = 0,
        Front = 1
    }

    public enum FlashMode
    {
        On = 0,
        Off = 1
    }

    public enum OrientationMode
    {
        Portrait = 0,
        LandscapeLeft = 1,
        LandscapeRight = 2,
        PortraitReverse = 3,
        Any = 4
    }
    
    // NEW
    [Native]
    public enum CameraResolution : long
    {
        Sd640x480 = 0,
        Hd1280x720 = 1,
        Hd1920x1080 = 2
    }
    
    [Native]
    public enum ImageType : long
    {
        Jpeg = 0,
        Png = 1
    }
    
}
