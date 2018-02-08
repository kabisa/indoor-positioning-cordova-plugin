package nl.kabisa.lighting.ips;

import android.os.Handler;
import android.os.Looper;

import com.philips.indoorpositioning.library.IndoorPositioning;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

class IndoorPositioningService extends CordovaPlugin {
    private IndoorPositioning indoorPositioning;
    private IndoorPositioning.Listener listener;

    private JSONObject lastLocation;
    private JSONObject lastHeading;
    private String lastError;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        listener = new IndoorPositioning.Listener() {
            @Override
            public void didUpdateHeading(Map<String, Object> map) {
                lastHeading = new JSONObject(map);
            }

            @Override
            public void didUpdateLocation(Map<String, Object> map) {
                lastLocation = new JSONObject(map);
            }

            @Override
            public void didFailWithError(Error error) {
                lastError = error.toString();
            }
        };

        indoorPositioning = new IndoorPositioning(cordova.getActivity().getApplicationContext());
        indoorPositioning.register(listener, new Handler(Looper.getMainLooper()));
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        indoorPositioning.unregister();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "start":
                    indoorPositioning.start();
                    callbackContext.success();
                    return true;
                case "stop":
                    indoorPositioning.stop();
                    callbackContext.success();
                    return true;
                case "getError":
                    callbackContext.success(lastError);
                    return true;
                case "getHeading":
                    callbackContext.success(lastHeading);
                    return true;
                case "getLocation":
                    callbackContext.success(lastLocation);
                    return true;
                case "setConfiguration":
                    indoorPositioning.setConfiguration(args.getString(0));
                    callbackContext.success();
                    return true;
                default:
                    callbackContext.error(String.format("Unknown action '%s'", action));
                    return false;
            }
        } catch (Exception exception) {
            callbackContext.error(exception.getMessage());
            return true;
        }
    }
}
