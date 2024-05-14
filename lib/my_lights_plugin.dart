import 'my_lights_plugin_platform_interface.dart';

class MyLightsPlugin {
  static Future<void> switchLights() {
    return MyLightsPluginPlatform.instance.switchLights();
  }
}
