package br.com.elo7.flutter_elo_client.external.models

enum class Methods(val value: String) {
    GET("get"),
    PUT("put"),
    POST("post"),
    PATH("path"),
    DELETE("delete")
}

data class Params(
    val path: String,
    val body: Map<String, Any>? = null,
    val headers: Map<String, Any>? = null,
    val method: String = Methods.GET.value,
    val queryParams: Map<String, Any>? = null,
)