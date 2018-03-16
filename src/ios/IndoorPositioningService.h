#import <Cordova/CDVPlugin.h>
#import <IndoorPositioning/IndoorPositioning.h>

@interface IndoorPositioningService : CDVPlugin <IPIndoorPositioningDelegate>

- (void)start:(CDVInvokedUrlCommand*)command;
- (void)stop:(CDVInvokedUrlCommand*)command;
- (void)getError:(CDVInvokedUrlCommand*)command;
- (void)getHeading:(CDVInvokedUrlCommand*)command;
- (void)getLocation:(CDVInvokedUrlCommand*)command;
- (void)setConfiguration:(CDVInvokedUrlCommand*)command;
- (void)setVenueData:(CDVInvokedUrlCommand*)command;

@end
