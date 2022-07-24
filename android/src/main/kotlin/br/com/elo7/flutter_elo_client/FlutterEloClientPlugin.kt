package br.com.elo7.flutter_elo_client

import android.content.Context
import androidx.annotation.NonNull

import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.CoroutineScope

import javax.security.auth.login.LoginException

import io.flutter.embedding.engine.plugins.FlutterPlugin

import br.com.elo7.flutter_elo_client.external.client.Client
import br.com.elo7.flutter_elo_client.external.models.Params

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

const val CHANNEL_NAME = "br.com.elo7.flutter_elo_client"

class FlutterEloClientPlugin : FlutterPlugin, MethodCallHandler {
    private val request = "request"

    private lateinit var context: Context
    private lateinit var channel: MethodChannel

    private val mainScope = CoroutineScope(Dispatchers.Main)

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            request -> mainScope.launch {
                withContext(Dispatchers.Default) {
                    makeRequest(call, result)
                }
            }
            else -> result.notImplemented()
        }
    }

    private suspend fun makeRequest(@NonNull call: MethodCall, @NonNull result: Result) {
        val params = Params(
            call.argument<String>("path")!!,
            call.argument<Map<String, Any>>("body"),
            call.argument<Map<String, Any>>("headers"),
            call.argument<String>("method")!!,
            call.argument<Map<String, Any>>("queryParams"),
        )

        if (params.path.isEmpty()) throw LoginException("One or more required parameters missing")

        try {
            result.success(Client.makeRequest(params))
        } catch (exception: Exception) {
            result.error("An error has occurred! ", exception.message, null)
        }
    }
}
