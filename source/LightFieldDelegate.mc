using Toybox.WatchUi as Ui;

var headLightModeNum=0;
var tailLightModeNum=0;

class LightsFieldDelegate extends Ui.InputDelegate {
	function setHeadLight(mode) {
		// HACK : don't know why must to 3 times..
		for(var i=0; i <= 3; i++) {
        	mLightNetwork.setHeadlightsMode(mode);
        }
	}
	
	function setTailLight(mode) {
		mLightNetwork.setTaillightsMode(mode);
	}

	function initialize() {
		InputDelegate.initialize();
		setHeadLight(0);
		setTailLight(0);
	}
	
    function onTap(clickEvent) {
    	var cood = clickEvent.getCoordinates();
    	var x=cood[0];
    	var y=cood[1];
    	
//      System.println(cood);
//      System.println("Network Mode : "+mLightNetwork.getNetworkMode());
//      System.println("Network State : "+mLightNetwork.getNetworkState());
        
//      LIGHT_NETWORK_STATE_NOT_FORMED = 0
//		LIGHT_NETWORK_STATE_FORMING = 1
//		LIGHT_NETWORK_STATE_FORMED = 2 

//		CapableModes 
//		Fly6CE  : [0, 1, 2, 3, 6, 7, 63, 62, 61, 60, 59, null]
//		Fly12CE : [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

		if(x < widthDataField/2) {    
	    	switch(headLightModeNum) {
	    		case 0 : headLightModeNum=1;
	    			break;
	    		case 1 : headLightModeNum=3;
	    			break;
	    		case 3 : headLightModeNum=6;
	    			break;
    			case 6 : headLightModeNum=0;
	    			break;
	    		default:
	    			headLightModeNum=0;
	    	}
	    	setHeadLight(headLightModeNum);
        } else {
	    	switch(tailLightModeNum) {
	    		case 0 : tailLightModeNum=1;
	    			break;
    			case 1 : tailLightModeNum=3;
	    			break;
	    		case 3 : tailLightModeNum=7;
	    			break;
	    		case 7 : tailLightModeNum=0;
	    			break;
	    		default:
	    			tailLightModeNum=0;
	    	}
	        setTailLight(tailLightModeNum);
        }
    }
}