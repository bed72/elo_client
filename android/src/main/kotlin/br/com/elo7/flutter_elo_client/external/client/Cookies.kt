package br.com.elo7.flutter_elo_client.external.client

import android.util.Log

import io.ktor.http.Url
import io.ktor.http.Cookie
import io.ktor.http.CookieEncoding
import io.ktor.client.plugins.cookies.CookiesStorage

class Cookies(private val cookiesStorage: CookiesStorage) : CookiesStorage by cookiesStorage {

    override suspend fun get(requestUrl: Url): List<Cookie> =
        cookiesStorage.get(requestUrl).map { cookie ->
            Log.v("[GET COOKIES]:", cookie.toString())
            cookie.copy(encoding = CookieEncoding.URI_ENCODING)
        }

    override suspend fun addCookie(requestUrl: Url, cookie: Cookie) {
        Log.v("[ADD COOKIES]:", cookie.toString())

        cookiesStorage.addCookie(requestUrl, cookie)
    }

    override fun close() { }
}
