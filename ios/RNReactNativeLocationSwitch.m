
#import "RNReactNativeLocationSwitch.h"
#import "UIKit/UIKit.h"
#import <Foundation/NSURL.h>
#import <CoreLocation/CoreLocation.h>

@implementation RNReactNativeLocationSwitch

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()


RCT_REMAP_METHOD(enableLocationService,
                 onPermissionGiven:(RCTResponseSenderBlock)successCallback
                 onPermissionDenied:(RCTResponseSenderBlock)errorCallback)
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (![CLLocationManager locationServicesEnabled]) {
        // redirect to the app settings page not the previously set "App-Prefs:root=Privacy&path=LOCATION"
        // thus to avoid app rejection from the app store
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Location Services Disabled");

        // show location settings
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

    } else {
        NSLog(@"Location Services Enabled");
        successCallback(@[[NSNull null]]);
    }
}


RCT_REMAP_METHOD(isLocationEnabled,
                 onLocationEnabled:(RCTResponseSenderBlock)successCallback
                 onLocationDisable:(RCTResponseSenderBlock)errorCallback)
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    if (![CLLocationManager locationServicesEnabled] || status == kCLAuthorizationStatusDenied) {
        NSLog(@"Location Services Disabled");
        errorCallback(@[[NSNull null]]);
    } else {
        NSLog(@"Location Services Enabled");
        successCallback(@[[NSNull null]]);
    }
}


@end
