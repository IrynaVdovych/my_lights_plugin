import 'package:flutter_test/flutter_test.dart';
import 'package:my_lights_plugin/my_lights_plugin.dart';
import 'package:my_lights_plugin/my_lights_plugin_platform_interface.dart';
import 'package:my_lights_plugin/my_lights_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyLightsPluginPlatform
    with MockPlatformInterfaceMixin
    implements MyLightsPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyLightsPluginPlatform initialPlatform = MyLightsPluginPlatform.instance;

  test('$MethodChannelMyLightsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyLightsPlugin>());
  });

  test('getPlatformVersion', () async {
    MyLightsPlugin myLightsPlugin = MyLightsPlugin();
    MockMyLightsPluginPlatform fakePlatform = MockMyLightsPluginPlatform();
    MyLightsPluginPlatform.instance = fakePlatform;

    expect(await myLightsPlugin.getPlatformVersion(), '42');
  });
}
