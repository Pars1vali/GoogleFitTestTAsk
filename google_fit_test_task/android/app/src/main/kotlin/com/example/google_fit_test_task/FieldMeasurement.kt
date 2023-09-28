package com.example.google_fit_test_task

import kotlinx.serialization.Serializable

@Serializable
data class FieldMeasurement(val type: String, val value: String)