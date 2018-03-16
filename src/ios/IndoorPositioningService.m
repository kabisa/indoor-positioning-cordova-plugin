#import "IndoorPositioningService.h"
#import <Cordova/CDVPlugin.h>


@implementation IndoorPositioningService {
    IPIndoorPositioning *indoorPositioning;
    NSDictionary *lastHeading;
    NSDictionary *lastLocation;
    NSString *lastError;
}

- (void)pluginInitialize
{
    indoorPositioning = IPIndoorPositioning.sharedInstance;
    indoorPositioning.delegate = self;
    indoorPositioning.mode = IPIndoorPositioningModeDefault;
    indoorPositioning.headingOrientation = IPIndoorPositioningHeadingOrientationPortrait;
}

- (void)sendCommandStatusOkForCallbackId:(NSString*)callbackId
{
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:callbackId];
}
- (void)start:(CDVInvokedUrlCommand *)command
{
    [indoorPositioning start];
    [self sendCommandStatusOkForCallbackId:command.callbackId];
}

- (void)stop:(CDVInvokedUrlCommand *)command
{
    [indoorPositioning stop];
    [self sendCommandStatusOkForCallbackId:command.callbackId];
}

- (void)getError:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:lastError];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getHeading:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:lastHeading];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getLocation:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:lastLocation];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)setConfiguration:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result;
    NSString *configuration = [command.arguments objectAtIndex:0];
    if (configuration == nil) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No configuration provided"];
    } else {
        [indoorPositioning setConfiguration:configuration];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)setVenueData:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result;
    NSString *base64EncodedVenueData = [command.arguments objectAtIndex:0];
    if (base64EncodedVenueData == nil) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No venue data provided"];
    } else {
        NSData* venueData = [[NSData alloc] initWithBase64EncodedString:base64EncodedVenueData options:0];
        [indoorPositioning setVenueData:venueData];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)indoorPositioning:(IPIndoorPositioning *)indoorPositioning didUpdateHeading:(NSDictionary *)heading
{
    lastHeading = heading;
}

- (void)indoorPositioning:(IPIndoorPositioning *)indoorPositioning didUpdateLocation:(NSDictionary *)location
{
    lastLocation = location;
}

- (void)indoorPositioning:(IPIndoorPositioning *)indoorPositioning didFailWithError:(NSError *)error
{
    if ([[error domain] isEqualToString:IPIndoorPositioningErrorDomain]) {
        switch ([error code]) {
            case IPIndoorPositioningErrorCannotSetPropertyWhileRunning:
                lastError = @"CANNOT_SET_PROPERTY_WHILE_RUNNING";
                break;
            case IPIndoorPositioningErrorAlreadyRunning:
                lastError = @"ALREADY_RUNNING";
                break;
            case IPIndoorPositioningErrorAlreadyStopped:
                lastError = @"ALREADY_STOPPED";
                break;
            case IPIndoorPositioningErrorDeviceNotSupported:
                lastError = @"DEVICE_NOT_SUPPORTED";
                break;
            case IPIndoorPositioningErrorCameraAccessNotGranted:
                lastError = @"CAMERA_ACCESS_ERROR";
                break;
            case IPIndoorPositioningErrorLocationNotGranted:
                lastError = @"LOCATION_ACCESS_ERROR";
                break;
            case IPIndoorPositioningErrorLocationTimeOut:
                lastError = @"LOCATION_TIMEOUT";
                break;
            case IPIndoorPositioningErrorConnectionFailed:
                lastError = @"CONNECTION_FAILED";
                break;
            case IPIndoorPositioningErrorConfigurationFailed:
                lastError = @"CONFIGURATION_FAILED";
                break;
            case IPIndoorPositioningErrorBluetoothPoweredOff:
                lastError = @"BLUETOOTH_POWERED_OFF";
                break;
            case IPIndoorPositioningErrorCameraNotSupported:
                lastError = @"CAMERA_NOT_SUPPORTED";
                break;
            default:
                lastError = @"UNKNOWN_ERROR";
                break;
        }
    }
}

@end
