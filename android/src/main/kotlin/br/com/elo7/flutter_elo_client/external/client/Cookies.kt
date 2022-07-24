package br.com.elo7.flutter_elo_client.external.client

import android.util.Log

import io.ktor.http.Url
import io.ktor.http.Cookie
import io.ktor.client.plugins.cookies.CookiesStorage

class Cookies : CookiesStorage {
    private val container: MutableList<Cookie> = mutableListOf()

    override suspend fun get(requestUrl: Url): List<Cookie> {

        Log.v("\n[GET COOKIES]: ", requestUrl.toString())

        return container.filter { it.equals(requestUrl) }
    }

    override suspend fun addCookie(requestUrl: Url, cookie: Cookie) {
        Log.v("\n[ADD COOKIES]: ", cookie.toString())
    }

    override fun close() { }
}