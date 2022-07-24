package br.com.elo7.flutter_elo_client.external.mappers

import io.ktor.http.HttpMethod

import br.com.elo7.flutter_elo_client.external.models.Methods

fun httpMapper(method: String): HttpMethod =
    when (method) {
        Methods.GET.value -> HttpMethod.Get
        Methods.PUT.value -> HttpMethod.Put
        Methods.POST.value -> HttpMethod.Post
        Methods.PATH.value -> HttpMethod.Patch
        Methods.DELETE.value -> HttpMethod.Delete
        else -> HttpMethod.Get
    }