package asp.citic.ptframework.plugin.ocr;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.exidcard.CaptureActivity;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;


/**
 * Created by dora on 2016-09-22.
 */
public class OcrIdCard extends CordovaPlugin{

    private final String TAG = "OcrIdCard";

    private final int OCR_REQ = 100;
    private final int OCR_RES = 101;
    private CallbackContext callback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Log.d(">>>进入原生--OCR:>>>",action);
        callback = callbackContext;
        if (action.equals("aaa")){
            Intent intent = new Intent(cordova.getActivity(), CaptureActivity.class);
            cordova.setActivityResultCallback(this);
            cordova.startActivityForResult(this,intent,OCR_REQ);
            return true;
        }
        return false;
    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        Log.d(">>>>>>onActivityResult:>>>>" , "1");
        super.onActivityResult(requestCode, resultCode, intent);
        if (requestCode == OCR_REQ && resultCode == OCR_RES){
            if (intent != null){
                String result = intent.getStringExtra("resultOcr");
                Log.d(">>>>>>哈哈，OCR识别结果>>>>>",result + "***" +callback);
                if (callback != null){
                    callback.success(result);
                    Log.d(">>>>>>OCR结果已发送JS>>>>>",result);
                }
            }
        }
    }
    /**
     * Called when a plugin is the recipient of an Activity result after the
     * CordovaActivity has been destroyed. The Bundle will be the same as the one
     * the plugin returned in onSaveInstanceState()
     *
     * @param state             Bundle containing the state of the plugin
     * @param callbackContext   Replacement Context to return the plugin result to
     */
    public void onRestoreStateForActivityResult(Bundle state, CallbackContext callbackContext) {
        callback = callbackContext;
    }
}

