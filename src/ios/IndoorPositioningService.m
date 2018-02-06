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
                lastError = @"Cannot set property while running";
                break;
            case IPIndoorPositioningErrorAlreadyRunning:
                lastError = @"Already running";
                break;
            case IPIndoorPositioningErrorAlreadyStopped:
                lastError = @"Already stopped";
                break;
            case IPIndoorPositioningErrorDeviceNotSupported:
                lastError = @"Device not supported";
                break;
            case IPIndoorPositioningErrorCameraAccessNotGranted:
                lastError = @"Camera access not granted";
                break;
            case IPIndoorPositioningErrorLocationNotGranted:
                lastError = @"Location access not granted";
                break;
            case IPIndoorPositioningErrorLocationTimeOut:
                lastError = @"Location timeout";
                break;
            case IPIndoorPositioningErrorConnectionFailed:
                lastError = @"Connection failed";
                break;
            case IPIndoorPositioningErrorConfigurationFailed:
                lastError = @"Configuration failed";
                break;
            default:
                lastError = @"Unknown error";
                break;
        }
    }
}

@end
