using Toybox.AntPlus;

class LightNetworkListener extends AntPlus.LightNetworkListener {
    var mNetworkState = 0;

	function initialize() {
		LightNetworkListener.initialize();
	}
	
	function onBikeLightUpdate(data) {
		// HACK : don't know why do not call this method from FLY12CE
		System.println("type : "+data.type+", mode : "+data.mode);
		System.println(" -> onBikeLightUpdate : "+data.getCapableModes());
	}
	
    function onLightNetworkStateUpdate(data) {
        mNetworkState = data;
        
        var state = "UNKNOWN";
        
        switch(data) {
        	case AntPlus.LIGHT_NETWORK_STATE_FORMED : 
        		state = "LIGHT_NETWORK_STATE_NOT_FORMED";
        		break;
    		case 1 : 
    			state = "LIGHT_NETWORK_STATE_FORMING";
        		break;
    		case 2 : 
    			state = "LIGHT_NETWORK_STATE_FORMED";
        		break;
    		default:
        		break;
        }

        System.println("onLightNetworkStateUpdate : "+state);
    }
}