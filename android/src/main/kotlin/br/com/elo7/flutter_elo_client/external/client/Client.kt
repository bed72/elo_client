package br.com.elo7.flutter_elo_client.external.client

import io.ktor.http.contentType
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode

import io.ktor.client.call.body
import io.ktor.client.HttpClient
import io.ktor.client.request.setBody
import io.ktor.client.request.headers
import io.ktor.client.request.request
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.statement.HttpResponse

import br.com.elo7.flutter_elo_client.external.models.Params
import br.com.elo7.flutter_elo_client.external.mappers.httpMapper
import br.com.elo7.flutter_elo_client.external.client.plugins.installCookies
import br.com.elo7.flutter_elo_client.external.client.plugins.installLogging
import br.com.elo7.flutter_elo_client.external.client.plugins.installRequestDefault
import br.com.elo7.flutter_elo_client.external.client.plugins.installResponseTimeout
import br.com.elo7.flutter_elo_client.external.client.plugins.installResponseObserver
import br.com.elo7.flutter_elo_client.external.client.plugins.installContentNegotiation
import io.ktor.http.cookies

object Client {
    private val instance = HttpClient(OkHttp) {
        installCookies()
        installLogging()
        installRequestDefault()
        installResponseTimeout()
        installResponseObserver()
        installContentNegotiation()
    }

    suspend fun makeRequest(params: Params): List<String> {
        val response: HttpResponse = instance.request(params.path) {
            cookies()
            setBody(params.body)
            headers { params.headers }
            method = httpMapper(params.method)
            contentType(ContentType.Application.Json)
            url {
                params.queryParams?.forEach { (name, value) -> parameters.append(name, "$value") }
            }
        }

        return when (response.status) {
            HttpStatusCode.OK, HttpStatusCode.Accepted -> listOf(response.body<String>().toString())
            else -> listOf(response.status.value.toString())
        }
    }
}