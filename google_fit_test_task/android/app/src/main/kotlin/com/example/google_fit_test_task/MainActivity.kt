package com.example.google_fit_test_task



import com.example.google_fit_test_task.FieldMeasurement
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlinx.serialization.encodeToString
import com.example.google_fit_test_task.Measurement
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import android.content.Context
import android.content.ContextWrapper
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.fitness.Fitness
import com.google.android.gms.fitness.FitnessOptions
import com.google.android.gms.fitness.data.DataPoint
import com.google.android.gms.fitness.data.DataSet
import com.google.android.gms.fitness.data.DataSource
import com.google.android.gms.fitness.data.DataType
import com.google.android.gms.fitness.data.Field
import com.google.android.gms.fitness.request.DataDeleteRequest
import com.google.android.gms.fitness.request.DataReadRequest
import com.google.android.gms.fitness.request.DataUpdateRequest
import com.google.android.gms.fitness.result.DataReadResponse
import com.google.android.gms.tasks.Task
import java.text.DateFormat
import java.util.Calendar
import java.util.Date
import java.util.TimeZone
import java.util.concurrent.TimeUnit
import java.time.LocalDateTime
import java.time.LocalDate
import java.time.ZoneId
import java.time.Instant
import io.flutter.plugin.Pigeon



class MainActivity: FlutterActivity() {


private val CHANNEL = "samples.flutter.dev/readFitData"

var output : String? = ""
var measurements : ArrayList<Measurement> = arrayListOf()

private val fitnessOptions: FitnessOptions by lazy {
        FitnessOptions.builder()
                .addDataType(DataType.AGGREGATE_STEP_COUNT_DELTA, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_CALORIES_EXPENDED, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_SPEED_SUMMARY, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_BASAL_METABOLIC_RATE_SUMMARY, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_BODY_FAT_PERCENTAGE_SUMMARY, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_DISTANCE_DELTA, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_HEART_POINTS, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_HEART_RATE_SUMMARY, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_HEIGHT_SUMMARY, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_HYDRATION, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_MOVE_MINUTES, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_POWER_SUMMARY, FitnessOptions.ACCESS_READ)
                .addDataType(DataType.AGGREGATE_WEIGHT_SUMMARY, FitnessOptions.ACCESS_READ)
                .build()
    }

override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->    
      
val startTime = LocalDate.now().atStartOfDay(ZoneId.systemDefault())
val endTime = LocalDateTime.now().atZone(ZoneId.systemDefault())

val readRequest =
    DataReadRequest.Builder()
        .aggregate(DataType.TYPE_STEP_COUNT_DELTA)
        .aggregate(DataType.TYPE_CALORIES_EXPENDED)
        .aggregate(DataType.TYPE_SPEED)
        .aggregate(DataType.TYPE_BASAL_METABOLIC_RATE)
        .aggregate(DataType.TYPE_BODY_FAT_PERCENTAGE)
        .aggregate(DataType.TYPE_DISTANCE_DELTA)
        .aggregate(DataType.TYPE_HEART_POINTS)
        .aggregate(DataType.TYPE_HEART_RATE_BPM)
        .aggregate(DataType.TYPE_HEIGHT)
        .aggregate(DataType.TYPE_HYDRATION)
        .aggregate(DataType.TYPE_MOVE_MINUTES)
        .aggregate(DataType.TYPE_POWER_SAMPLE)
        .aggregate(DataType.TYPE_WEIGHT)
        .bucketByTime(1, TimeUnit.DAYS)
        .setTimeRange(startTime.toEpochSecond(), endTime.toEpochSecond(), TimeUnit.SECONDS)
        .build()


Fitness.getHistoryClient(this,  getGoogleAccount())
    .readData(readRequest)
    .addOnSuccessListener { response ->
        measurements.clear()
        for (dataSet in response.buckets.flatMap { it.dataSets }) {
            dumpDataSet(dataSet)
        }
    }
    .addOnFailureListener { e ->
        output = "There was an error reading data from Google Fit"
    }
    
    output = Json.encodeToString(measurements)
    result.success(output)
    }
  }

 private fun getGoogleAccount() =  GoogleSignIn.getAccountForExtension(this, fitnessOptions)


 


fun dumpDataSet(dataSet: DataSet) {
    var fields : ArrayList<FieldMeasurement> = arrayListOf()

    for (dp in dataSet.dataPoints) {
        for (field in dp.dataType.fields) {
            fields.add(FieldMeasurement(field.name.toString(),(dp.getValue(field)).toString()))
        }
        measurements.add(Measurement(dp.dataType.name.toString(),dp.getStartTimeString(),dp.getEndTimeString(),fields))
    }
}

fun DataPoint.getStartTimeString() = Instant.ofEpochSecond(this.getStartTime(TimeUnit.SECONDS))
    .atZone(ZoneId.systemDefault())
    .toLocalDateTime().toString()

fun DataPoint.getEndTimeString() = Instant.ofEpochSecond(this.getEndTime(TimeUnit.SECONDS))
    .atZone(ZoneId.systemDefault())
    .toLocalDateTime().toString()
}
