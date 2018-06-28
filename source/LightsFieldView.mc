using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

var heightDataField;
var widthDataField;

class LightsFieldView extends Ui.DataField  {
    function initialize() {
        DataField.initialize();
    }

    function compute(info) {
        // See Activity.Info in the documentation for available information.
        return 0.0;
    }
    
    function getLightModeText(mode) {
    	switch(mode) {
    		case AntPlus.LIGHT_MODE_OFF :
				return "OFF";
			case AntPlus.LIGHT_MODE_ST_81_100 : 
				return "ST 81~100%";
			case AntPlus.LIGHT_MODE_ST_61_80 :
				return "ST 61~80%";
			case AntPlus.LIGHT_MODE_ST_41_60 :
				return "ST 41~60%";
			case AntPlus.LIGHT_MODE_ST_21_40 :
				return "ST 21~40%";
			case AntPlus.LIGHT_MODE_ST_0_20 : // 5
				return "ST 0~20%";
			case AntPlus.LIGHT_MODE_SLOW_FLASH : // 6
				return "SLOW_FLASH";
			case AntPlus.LIGHT_MODE_FAST_FLASH : // 7
				return "FAST_FLASH";
			case AntPlus.LIGHT_MODE_RANDOM_FLASH :
				return "RANDOM_FLASH";
			case AntPlus.LIGHT_MODE_AUTO :
				return "AUTO";
			case AntPlus.LIGHT_MODE_SIGNAL_LEFT_SC :
				return "SIGNAL_LEFT_SC";
			case AntPlus.LIGHT_MODE_SIGNAL_LEFT :
				return "SIGNAL_LEFT";
			case AntPlus.LIGHT_MODE_SIGNAL_RIGHT_SC :
				return "SIGNAL_RIGHT_SC";
			case AntPlus.LIGHT_MODE_SIGNAL_RIGHT :
				return "SIGNAL_RIGHT";
			case AntPlus.LIGHT_MODE_HAZARD :
				return "HAZARD";
			case AntPlus.LIGHT_MODE_CUSTOM_5 :
				return "CUSTOM_5";
			case AntPlus.LIGHT_MODE_CUSTOM_4 :
				return "CUSTOM_4";
			case AntPlus.LIGHT_MODE_CUSTOM_3 :
				return "CUSTOM_3";
			case AntPlus.LIGHT_MODE_CUSTOM_2 :
				return "CUSTOM_2";
			case AntPlus.LIGHT_MODE_CUSTOM_1 :
				return "CUSTOM_1";
			default:
				return "UNKNOWN";
    	}
    }
    
    function getBatteryStateText(state) {
    	switch(state) {
    		case AntPlus.BATT_STATUS_NEW :
				return "NEW";
			case AntPlus.BATT_STATUS_GOOD :
				return "GOOD";
			case AntPlus.BATT_STATUS_OK :
				return "OK";
			case AntPlus.BATT_STATUS_LOW :
				return "LOW";
			case AntPlus.BATT_STATUS_CRITICAL :
				return "Critical";
			case AntPlus.BATT_STATUS_INVALID :
				return "Invaild";
			case AntPlus.BATT_STATUS_CNT :
				return "CNT";
    		default:
    			return "UNKNOWN";
    	}
    }
    
    function onLayout(dc) {
        heightDataField=dc.getHeight();
        widthDataField=dc.getWidth();
    }
    
    function onUpdate(dc) {
    	var bgColor = getBackgroundColor();
    	var textColor = Gfx.COLOR_BLACK;
    	if(bgColor == 0) {
    		textColor = Gfx.COLOR_WHITE;
		}

		//set background color    	
    	dc.setColor(Gfx.COLOR_TRANSPARENT, bgColor);
  		dc.clear();
  		
		dc.setColor(textColor, bgColor);
		dc.drawText(dc.getWidth()*0.25, dc.getHeight()*0.2, Gfx.FONT_TINY , "Head",
								   (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
		dc.drawText(dc.getWidth()*0.75, dc.getHeight()*0.2, Gfx.FONT_TINY , "Tail",
						           (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
		
        var bikeLights=mLightNetwork.getBikeLights();

        if(bikeLights != null) {
	        for(var i=0; i<bikeLights.size(); i++) {
				switch(bikeLights[i].type) {
					case AntPlus.LIGHT_TYPE_HEADLIGHT :
						//Do not come correct mode from FLY12CE, so can't use bikeLights[i].mode
						dc.drawText(dc.getWidth()*0.25, dc.getHeight()*0.5, Gfx.FONT_MEDIUM, getLightModeText(headLightModeNum), 
								   	(Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
					    dc.drawText(dc.getWidth()*0.25, dc.getHeight()*0.85, Gfx.FONT_XTINY, 
					    			getBatteryStateText(mLightNetwork.getBatteryStatus(bikeLights[i].identifier).batteryStatus),
								   	(Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
					   	//HACK:T_T
					   	mLightNetwork.setHeadlightsMode(headLightModeNum);
						break;
					case AntPlus.LIGHT_TYPE_TAILLIGHT :
						//tailValue.setText("Tail : "+tailLightModeNum);
						var currentStatus = bikeLights[i].mode == tailLightModeNum ? tailLightModeNum : -1;
						dc.drawText(dc.getWidth()*0.75, dc.getHeight()*0.5, Gfx.FONT_MEDIUM , getLightModeText(currentStatus),
						           	(Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
			            dc.drawText(dc.getWidth()*0.75, dc.getHeight()*0.85, Gfx.FONT_XTINY, 
			            			getBatteryStateText(mLightNetwork.getBatteryStatus(bikeLights[i].identifier).batteryStatus),
								   	(Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
					   	//HACK:T_T
					   	mLightNetwork.setTaillightsMode(tailLightModeNum);
						break;
					case AntPlus.LIGHT_TYPE_SIGNAL_CONFIG :
						System.println("AntPlus.LIGHT_TYPE_SIGNAL_CONFIG");
						break;
					case AntPlus.LIGHT_TYPE_SIGNAL_LEFT :
						System.println("AntPlus.LIGHT_TYPE_SIGNAL_LEFT");
						break;
					case AntPlus.LIGHT_TYPE_SIGNAL_RIGHT :
						System.println("AntPlus.LIGHT_TYPE_SIGNAL_RIGHT");
						break;
					case AntPlus.LIGHT_TYPE_OTHER :
						System.println("AntPlus.LIGHT_TYPE_OTHER");
						break;
					default:
						System.println("AntPlus.default");
						break; 
				}
	        }
        }
    }
}