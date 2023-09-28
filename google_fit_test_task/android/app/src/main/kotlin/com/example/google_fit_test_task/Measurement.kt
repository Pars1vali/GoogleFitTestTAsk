package com.example.google_fit_test_task

import com.example.google_fit_test_task.FieldMeasurement
import kotlinx.serialization.Serializable

@Serializable
data class Measurement(val type: String, val dateStart: String, val dateEnd: String, val FieldMeasurements : ArrayList<FieldMeasurement>)

 // var value = _value
