package paymentez.com.flutter_kount

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.kount.api.DataCollector
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

 class MethodCallHandlerImpl(private val context: Context): MethodChannel.MethodCallHandler {

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getSessionId" -> handleGetSessionId(call, result)
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun handleGetSessionId(call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments as Map<*, *>
        val testMode:Boolean = arguments["test_mode"] as Boolean


        val sessionID = UUID.randomUUID().toString()
        val deviceSessionID = sessionID.replace("-", "")


        // Configure the collector
        // Configure the collector
        val dataCollector: DataCollector = DataCollector.getInstance()
        if (testMode) dataCollector.setDebug(true) else dataCollector.setDebug(false)
        dataCollector.setContext(context)
        dataCollector.setMerchantID(500005)

        dataCollector.setEnvironment(if (testMode) DataCollector.ENVIRONMENT_TEST else DataCollector.ENVIRONMENT_PRODUCTION)
        dataCollector.setLocationCollectorConfig(DataCollector.LocationConfig.COLLECT)

        Handler(Looper.getMainLooper()).post {
            dataCollector.collectForSession(deviceSessionID, object : DataCollector.CompletionHandler {
                override fun completed(s: String) {}
                override fun failed(s: String, error: DataCollector.Error) {}
            })
        }
        result.success(deviceSessionID)
    }
}
