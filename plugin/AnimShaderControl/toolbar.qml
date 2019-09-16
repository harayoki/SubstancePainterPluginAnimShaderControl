import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import AlgWidgets 2.0
import AlgWidgets.Style 2.0

Row
{
	id: root
	property var timer: null
	property var target_shaders: null
	property bool active: false
	property var start_time: null
	function stopAnimation() {
		if (root.timer !== null)
		{
			root.timer.stop();
			root.timer = null;
		}
		root.active = false;
	}
	function startAnimation() {
		try
		{
			root.target_shaders = [];
			
			var instances = alg.shaders.instances();
			for(var i in instances)
			{
				var parameters = alg.shaders.parameters(instances[i].id);				
				if( parameters.hasOwnProperty(shader_var_name.text) )
				{
					root.target_shaders.push(instances[i]);
				}
			}
			
			if (root.target_shaders.length === 0)
			{
				alg.log.error( "No animated shaders." );
				return;
			}
						
			root.timer = Qt.createQmlObject("import QtQuick 2.7; Timer {}", root);
			root.timer.interval = 1000.0 / fps_value.value;
			root.timer.repeat = true;
			root.timer.triggered.connect(root.progressAnimation);
			root.timer.start();
			root.active = true;

			if( root.start_time === null) {
				root.start_time = new Date().getTime();
			}
			
		}
		catch(err)
		{
			alg.log.exception( err );
		}	
	}
	function progressAnimation() {
		try
		{
			var date = new Date();
			var time = (date.getTime() - root.start_time) * 0.001;
			time *= speed_value.value;
			// alg.log.info(time);
			
			var params = {};
			params[shader_var_name.text] = time;
						
			for (var i in root.target_shaders)
			{
				alg.shaders.setParameters(
					root.target_shaders[i], params, {undoable: false}
				);
			}
			root.timer.interval = 1000.0 / fps_value.value;
		}
		catch(err)
		{
			root.stopAnimation();
			alg.log.exception( err );
		}
	}
	AlgLabel
	{
		text: "Animation\ncontrol"
        Layout.columnSpan: 2
		height: 29
	}
	AlgButton
	{
		text: "Start"
		id: btn1
		height: 29
		onClicked:
		{
			alg.log.info("Start animation");
			stopAnimation();
			startAnimation();
		}
	}
	AlgButton
	{
		text: "Stop"
		id: btn2
		height: 29
		onClicked:
		{
			alg.log.info("Stop animation");
			root.stopAnimation();
		}
	}
	AlgSlider {
      text: "speed"
	  id: speed_value
	  width: 200
      Layout.columnSpan: 2
      Layout.fillWidth:false
      stepSize: 0.01
	  value: 1
      minValue: 0
      maxValue: 10
    }
	AlgSlider {
      text: "fps"
	  id: fps_value
	  width: 100
      Layout.columnSpan: 2
      Layout.fillWidth:false
      stepSize: 1
	  value: 30
      minValue: 1
      maxValue: 60
    }
	AlgLabel
	{
		text: "  Shader  \n  variable  "
        Layout.columnSpan: 2
		height: 29
	}
	AlgTextInput {
      text: "Time"
	  id: shader_var_name
	  width: 80
	}
}
