import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_lights_plugin_platform_interface.dart';

/// An implementation of [MyLightsPluginPlatform] that uses method channels.
class MethodChannelMyLightsPlugin extends MyLightsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_lights_plugin');

  @override
  Future<void> switchLights() {
    return methodChannel.invokeMethod<String>('switchLights');
  }
}
