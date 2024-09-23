package com.definev.vnpt_ekyc

import VnptEkycPigeon
import android.app.Activity
import android.content.Intent
import android.content.res.Configuration
import androidx.core.app.ActivityCompat.startActivityForResult
import com.vnptit.nfc.activity.VnptScanNFCActivity
import com.vnptit.nfc.utils.KeyIntentConstantsNFC
import com.vnptit.nfc.utils.KeyResultConstantsNFC
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import java.util.Locale


/** VnptEkycPlugin */
class VnptEkycPlugin : FlutterPlugin, ActivityAware, ActivityResultListener, VnptEkycPigeon {
    val REQUEST_CODE: Int = 30

    var activity: Activity? = null

    private var ekycCompletionCallback: ((Result<Map<String, String?>>) -> Unit)? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        VnptEkycPigeon.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        VnptEkycPigeon.setUp(binding.binaryMessenger, null)
        activity = null
        ekycCompletionCallback = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
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
        callback: (Result<Map<String, String?>>) -> Unit
    ) {

        val intent: Intent = Intent(activity, VnptScanNFCActivity::class.java)

        intent.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN, accessToken)
        intent.putExtra(KeyIntentConstantsNFC.TOKEN_ID, tokenId)
        intent.putExtra(KeyIntentConstantsNFC.TOKEN_KEY, tokenKey)

        intent.putExtra(KeyIntentConstantsNFC.ACCESS_TOKEN, accessToken)
        intent.putExtra(KeyIntentConstantsNFC.TOKEN_ID, tokenId)
        intent.putExtra(KeyIntentConstantsNFC.TOKEN_KEY, tokenKey)
        intent.putExtra(KeyIntentConstantsNFC.IS_ENABLE_UPLOAD_IMAGE, false)
        intent.putExtra(KeyIntentConstantsNFC.IS_ENABLE_MAPPING_ADDRESS, false)

        reloadLanguage(language)
        when (language) {
            "vi" -> intent.putExtra(KeyIntentConstantsNFC.LANGUAGE_NFC, "vi")
            else -> intent.putExtra(KeyIntentConstantsNFC.LANGUAGE_NFC, "en")
        }

        startActivityForResult(activity!!, intent, REQUEST_CODE, null)
        ekycCompletionCallback = callback
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        val result: Result<Map<String, String?>>?
        if (requestCode == REQUEST_CODE) {

            if (resultCode == FlutterFragmentActivity.RESULT_OK) {
                val qrCode = data?.getStringExtra(KeyResultConstantsNFC.QR_CODE_RESULT_NFC)
                val avatar = data?.getStringExtra(KeyResultConstantsNFC.IMAGE_AVATAR_CARD_NFC)
                val logNFC = data?.getStringExtra(KeyResultConstantsNFC.LOG_NFC)

                println("personalInformation: $qrCode")
                println("logNFC: $logNFC")

                if (qrCode == null || logNFC == null || avatar == null) {
                    result = Result.success(
                        mapOf(
                            "qr_code" to null,
                            "log_nfc" to null,
                            "avatar" to null,
                            "error" to "cancelled",
                        )
                    )
                } else {
                    result = Result.success(
                        mapOf(
                            "qr_code" to qrCode,
                            "log_nfc" to logNFC,
                            "avatar" to avatar,
                        )
                    )
                }
                ekycCompletionCallback?.invoke(result)
                return true
            } else {
                result = Result.success(
                    mapOf(
                        "qr_code" to null,
                        "log_nfc" to null,
                        "avatar" to null,
                        "error" to "cancelled",
                    )
                )
                ekycCompletionCallback?.invoke(result)
                return false
            }
        }

        return false
    }
}
