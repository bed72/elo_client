package br.com.elo7.flutter_elo_client.external.client.plugins

import android.util.Log
import br.com.elo7.flutter_elo_client.external.client.Cookies

import io.ktor.http.HttpHeaders
import io.ktor.http.ContentType

import io.ktor.client.request.header
import io.ktor.client.HttpClientConfig

import io.ktor.client.plugins.logging.Logger
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.plugins.logging.LogLevel

import io.ktor.client.engine.okhttp.OkHttpConfig

import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.DefaultRequest
import io.ktor.client.plugins.cookies.HttpCookies
import io.ktor.client.plugins.observer.ResponseObserver
import io.ktor.client.plugins.cookies.AcceptAllCookiesStorage
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation

private const val TIMEOUT_MILLIS = 15000L

fun HttpClientConfig<OkHttpConfig>.installCookies() {
    install(HttpCookies) {
        storage = Cookies(AcceptAllCookiesStorage()) //AcceptAllCookiesStorage()
    }
}

fun HttpClientConfig<OkHttpConfig>.installLogging() {
    install(Logging) {
        level = LogLevel.ALL
        logger = object : Logger {
            override fun log(message: String) {
                Log.v("[KTOR CLIENT]: ", message)
            }
        }
    }
}

fun HttpClientConfig<OkHttpConfig>.installRequestDefault() {
    install(DefaultRequest) {
        header(HttpHeaders.ContentType, ContentType.Application.Json)
    }
}

fun HttpClientConfig<OkHttpConfig>.installResponseObserver() {
    install(ResponseObserver) {
        onResponse { response ->
            Log.d("[KTOR HTTP STATUS]: ", "${response.status.value}")
        }
    }
}

fun HttpClientConfig<OkHttpConfig>.installResponseTimeout() {
    install(HttpTimeout) {
        socketTimeoutMillis = TIMEOUT_MILLIS
        requestTimeoutMillis = TIMEOUT_MILLIS
        connectTimeoutMillis = TIMEOUT_MILLIS
    }
}

fun HttpClientConfig<OkHttpConfig>.installContentNegotiation() {
    install(ContentNegotiation) {

        engine {
            config {
                followRedirects(true)
            }

            /*
            * Interceptors
            */
            // addInterceptor(Http)
        }
    }
}
