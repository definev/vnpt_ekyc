package com.definev.vnpt_ekyc

import VnptEkycPigeon
import android.app.Activity
import android.content.Intent
import android.content.res.Configuration
import androidx.core.app.ActivityCompat.startActivityForResult
import com.vnptit.idg.sdk.activity.VnptIdentityActivity
import com.vnptit.idg.sdk.utils.KeyIntentConstants
import com.vnptit.idg.sdk.utils.KeyResultConstants
import com.vnptit.idg.sdk.utils.SDKEnum
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import java.util.Locale


/** VnptEkycPlugin */
class VnptEkycPlugin : FlutterPlugin, ActivityAware, ActivityResultListener, VnptEkycPigeon {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    var activity: Activity? = null

    var ekycCompletionCallback: ((Result<Map<String, Any?>>) -> Unit)? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        VnptEkycPigeon.setUp(flutterPluginBinding.binaryMessenger, this)
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        VnptEkycPigeon.setUp(binding.binaryMessenger, null)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    private fun reloadLanguage(language: String) {
        val locale = Locale(language)
        val config = Configuration()
        config.setLocale(locale)

        val baseContext = activity?.baseContext
        baseContext?.resources?.updateConfiguration(
            config,
            baseContext.resources.displayMetrics
        )
    }

    override fun ekyc(
        accessToken: String,
        tokenId: String,
        tokenKey: String,
        language: String,
        callback: (Result<Map<String, Any?>>) -> Unit
    ) {
        val intent = Intent(
            this.activity,
            VnptIdentityActivity::class.java
        )

        intent.putExtra(KeyIntentConstants.ACCESS_TOKEN, accessToken)
        intent.putExtra(KeyIntentConstants.TOKEN_ID, tokenId)
        intent.putExtra(KeyIntentConstants.TOKEN_KEY, tokenKey)
        intent.putExtra(
            KeyIntentConstants.DOCUMENT_TYPE,
            SDKEnum.DocumentTypeEnum.IDENTITY_CARD.value
        )
        intent.putExtra(KeyIntentConstants.VERSION_SDK, SDKEnum.VersionSDKEnum.ADVANCED.getValue())

        intent.putExtra(KeyIntentConstants.IS_SHOW_TUTORIAL, true)
        intent.putExtra(KeyIntentConstants.IS_ENABLE_GOT_IT, true)
        intent.putExtra(KeyIntentConstants.IS_SHOW_SWITCH_CAMERA, true)
        intent.putExtra(KeyIntentConstants.IS_ENABLE_SCAN_QR, true)
        intent.putExtra(KeyIntentConstants.IS_CHECK_LIVENESS_CARD, true)
        intent.putExtra(KeyIntentConstants.IS_VALIDATE_POSTCODE, true)
        intent.putExtra(KeyIntentConstants.IS_ENABLE_SCAN_QR, true)

        intent.putExtra(
            KeyIntentConstants.TYPE_VALIDATE_DOCUMENT,
            SDKEnum.TypeValidateDocument.Basic.value
        )
        intent.putExtra(KeyIntentConstants.CHALLENGE_CODE, "INNOVATIONCENTER")

        reloadLanguage(language)
        when (language) {
            "vi" -> intent.putExtra(
                KeyIntentConstants.LANGUAGE_SDK,
                SDKEnum.LanguageEnum.VIETNAMESE.value
            )

            else -> intent.putExtra(
                KeyIntentConstants.LANGUAGE_SDK,
                SDKEnum.LanguageEnum.ENGLISH.value
            )
        }

        startActivityForResult(activity!!, intent, 1, null)
        ekycCompletionCallback = callback
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        val result: Result<Map<String, Any?>>?
        if (requestCode == 1 && resultCode == FlutterFragmentActivity.RESULT_OK) {
            val strDataInfo = data?.getStringExtra(KeyResultConstants.INFO_RESULT)
            val strDataCompare = data?.getStringExtra(KeyResultConstants.COMPARE_RESULT)

            println("strDataInfo: $strDataInfo")
            println("strDataCompare: $strDataCompare")

            if (strDataInfo == null || strDataCompare == null) {
                result = Result.success(
                    mapOf(
                        "data_info" to strDataInfo,
                        "data_compare" to strDataCompare,
                        "error" to "data is null",
                    )
                )
            } else {
                result = Result.success(
                    mapOf(
                        "data_info" to strDataInfo,
                        "data_compare" to strDataCompare,
                    )
                )
            }
            ekycCompletionCallback?.invoke(result)
            return true
        }

        return false
    }
}
