using Toybox.Application as App;

var mLightNetworkListener;
var mLightNetwork;

class LightsFieldApp extends App.AppBase {
	
    function initialize() {
        AppBase.initialize();
        
        mLightNetworkListener = new LightNetworkListener();
        mLightNetwork = new AntPlus.LightNetwork(mLightNetworkListener);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new LightsFieldView(), new LightsFieldDelegate() ];
    }
}
