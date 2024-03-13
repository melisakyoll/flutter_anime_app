package com.example.flutter_anime_list

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter_anime_list/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "fetchAnimeData") {
                triggerFetchInFlutter()
                result.success(null) // Acknowledge the call without returning data
            } else {
                result.notImplemented()
            }
        }
    }

    private fun triggerFetchInFlutter() {
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).invokeMethod("triggerFetchInFlutter", null)
    }
}