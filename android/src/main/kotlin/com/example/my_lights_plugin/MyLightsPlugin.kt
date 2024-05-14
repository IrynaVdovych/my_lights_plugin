package com.example.my_lights_plugin

import android.content.Context

import android.hardware.camera2.CameraManager
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCharacteristics

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry;

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** MyLightsPlugin */
class MyLightsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context
  private var lightsOn = false

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_lights_plugin")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "switchLights") {
      try {
            val cameraManager = applicationContext.getSystemService(Context.CAMERA_SERVICE) as CameraManager
            val cameraId = cameraManager.cameraIdList[0]
            val characteristics = cameraManager.getCameraCharacteristics(cameraId)

            val flashAvailable = characteristics.get(CameraCharacteristics.FLASH_INFO_AVAILABLE) ?: false

            if (flashAvailable) {
                lightsOn = !lightsOn
                cameraManager.setTorchMode(cameraId, lightsOn)
                result.success("successfully")
            } else {
                result.error("NO_FLASH_AVAILABLE", "Flashlight is not available on this device", null)
            }
        } catch (e: CameraAccessException) {
            result.error("CAMERA_ACCESS_EXCEPTION", e.message, null)
        } catch (e: Exception) {
            result.error("TOGGLE_FAILED", e.message, null)
        }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
