package com.example.namoz_time_mobile

import android.content.Intent
import android.os.Bundle
import android.provider.AlarmClock
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "alarm_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setAlarm") {
                val message = call.argument<String>("message") ?: "Alarm"
                val hour = call.argument<Int>("hour") ?: 0
                val minute = call.argument<Int>("minute") ?: 0

                setAlarm(message, hour, minute)
                result.success("Alarm set successfully")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setAlarm(message: String, hour: Int, minute: Int) {
        val intent = Intent(AlarmClock.ACTION_SET_ALARM).apply {
            putExtra(AlarmClock.EXTRA_MESSAGE, message)
            putExtra(AlarmClock.EXTRA_HOUR, hour)
            putExtra(AlarmClock.EXTRA_MINUTES, minute)
            putExtra(AlarmClock.EXTRA_SKIP_UI, true) // UI’ni ko‘rsatmaslik uchun
        }

        if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
            Log.d("Alarm", "Alarm set for $hour:$minute")
        } else {
            Log.e("Alarm", "Failed to set alarm")
        }
    }
}
