package com.example.flutter_day_92

import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "flashLightChannel"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "turnOn" -> {
                    try {
                        toggleFlashlight(true)
                        result.success(null)
                    } catch (e: CameraAccessException) {
                        result.error("UNAVAILABLE", "Flashlight not available.", null)
                    }
                }

                "turnOff" -> {
                    try {
                        toggleFlashlight(false)
                        result.success(null)
                    } catch (e: CameraAccessException) {
                        result.error("UNAVAILABLE", "Flashlight not available.", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun toggleFlashlight(status: Boolean) {
        val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0] // Usually the rear camera is at index 0
        cameraManager.setTorchMode(cameraId, status)
    }
}
