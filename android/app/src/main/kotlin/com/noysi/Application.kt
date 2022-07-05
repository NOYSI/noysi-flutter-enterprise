package com.noysi

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import android.content.Context
import android.media.*
import android.app.NotificationManager
import android.app.NotificationChannel
import android.net.Uri
import android.os.Build




class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        this.createChannel();
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {
//        FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
    }

    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Create the NotificationChannel
            val channelId: String = getString(R.string.default_notification_channel_id)
            val name: String = getString(R.string.default_notification_channel_name)
            val descriptionText: String = getString(R.string.default_notification_channel_desc)
            val importance = NotificationManager.IMPORTANCE_HIGH

            val channelIdWithoutSound: String = getString(R.string.default_notification_channel_id_without_sound)
            val nameWithoutSound: String = getString(R.string.default_notification_channel_name_without_sound)
            val descriptionTextWithoutSound: String = getString(R.string.default_notification_channel_desc_without_sound)
            val importanceWithoutSound = NotificationManager.IMPORTANCE_HIGH

            val channel = NotificationChannel(channelId, name, importance)
            channel.description = descriptionText
            channel.enableVibration(true)

            val channelWithoutSound = NotificationChannel(channelIdWithoutSound, nameWithoutSound, importanceWithoutSound)
            channelWithoutSound.description = descriptionTextWithoutSound
            channelWithoutSound.enableVibration(true)
            channelWithoutSound.setSound(null, null)

            val uri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
            val att = AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                    .build()
            val channelCall = NotificationChannel(
                    "incoming_calls",
                    "Incoming Call",
                    NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Channel for incoming calls"
                vibrationPattern =
                        longArrayOf(0, 1000, 500, 1000, 500)
                enableVibration(true)
                setSound(uri, att)
            }

            val channelCallMuted = NotificationChannel(
                    "incoming_calls_muted",
                    "Incoming Call(Muted)",
                    NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Channel for incoming calls muted"
                vibrationPattern =
                        longArrayOf(0, 1000, 500, 1000, 500)
                enableVibration(true)
                setSound(null, null)
            }

            val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channelWithoutSound)
            notificationManager.createNotificationChannel(channel)
            notificationManager.createNotificationChannel(channelCall)
            notificationManager.createNotificationChannel(channelCallMuted)
        }
    }
}
