/*============================================================================
Copyright (c) 2020 PTC Inc. All Rights Reserved.

Copyright (c) 2010-2014 Qualcomm Connected Experiences, Inc.
All Rights Reserved.
Confidential and Proprietary - Protected under copyright and other laws.
============================================================================*/

#import "UnityAppController.h"
#import "UnityView.h"
// Controller to support native rendering callback
@interface VuforiaIOS : UnityAppController
{
}
@end
@implementation VuforiaIOS
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    BOOL ret = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if (ret)
    {
        _unityView.backgroundColor = UIColor.clearColor;
    }
    return ret;
}
@end
IMPL_APP_CONTROLLER_SUBCLASS(VuforiaIOS)

