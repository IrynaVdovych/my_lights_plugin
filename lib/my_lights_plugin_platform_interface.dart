import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_lights_plugin_method_channel.dart';

abstract class MyLightsPluginPlatform extends PlatformInterface {
  /// Constructs a MyLightsPluginPlatform.
  MyLightsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyLightsPluginPlatform _instance = MethodChannelMyLightsPlugin();

  /// The default instance of [MyLightsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyLightsPlugin].
  static MyLightsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyLightsPluginPlatform] when
  /// they register themselves.
  static set instance(MyLightsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> switchLights() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
