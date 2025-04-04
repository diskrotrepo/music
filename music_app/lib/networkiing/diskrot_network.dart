import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_app/configuration/configuration.dart';
import 'package:music_app/dependency_context.dart';
import 'package:crypto/crypto.dart';

final logger = di.get<Logger>();

Future<http.Response> post(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  logger.i("${configuration.serverConfiguration.fullUrl}$url");
  logger.i("Body: $body");
  logger.i("Client ID: ${diskrotClient.id}");

  try {
    final response = await http.post(
      Uri.parse("${configuration.serverConfiguration.fullUrl}$url"),
      headers: {
        'Content-Type': 'application/json',
        'client-id': diskrotClient.id,
        'diskrot-signature': _computeHMAC(
          diskrotClient: diskrotClient,
          url: configuration.serverConfiguration.api + url,
          payload: body,
        ),
      },
      body: body,
    );
    return response;
  } catch (e) {
    logger.e("Error in POST request: $e");
    rethrow;
  }
}

Future<http.Response> get(String url) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  logger.i("${configuration.serverConfiguration.fullUrl}$url");

  try {
    final response = await http.get(
      Uri.parse("${configuration.serverConfiguration.fullUrl}$url"),
      headers: {
        'Content-Type': 'application/json',
        'client-id': diskrotClient.id,
        'diskrot-signature': _computeHMAC(
          diskrotClient: diskrotClient,
          url: configuration.serverConfiguration.api + url,
          payload: "{}",
        ),
      },
    );

    return response;
  } catch (e) {
    logger.e("Error in GET request: $e");
    rethrow;
  }
}

Future<http.Response> put(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  logger.i("${configuration.serverConfiguration.fullUrl}$url");

  try {
    final response = http.put(
      Uri.parse("${configuration.serverConfiguration.fullUrl}$url"),
      headers: {
        'Content-Type': 'application/json',
        'client-id': diskrotClient.id,
        'diskrot-signature': _computeHMAC(
          diskrotClient: diskrotClient,
          url: configuration.serverConfiguration.api + url,
          payload: body,
        ),
      },
      body: body,
    );

    return response;
  } catch (e) {
    logger.e("Error in PUT request: $e");
    rethrow;
  }
}

Future<http.Response> patch(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  logger.i("${configuration.serverConfiguration.fullUrl}$url");

  try {
    final response = await http.patch(
      Uri.parse("${configuration.serverConfiguration.fullUrl}$url"),
      headers: {
        'Content-Type': 'application/json',
        'client-id': diskrotClient.id,
        'diskrot-signature': _computeHMAC(
          diskrotClient: diskrotClient,
          url: configuration.serverConfiguration.api + url,
          payload: body,
        ),
      },
      body: body,
    );

    return response;
  } catch (e) {
    logger.e("Error in PATCH request: $e");
    rethrow;
  }
}

Future<http.Response> delete(String url) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  logger.i("${configuration.serverConfiguration.fullUrl}$url");

  try {
    final response = await http.delete(
      Uri.parse("${configuration.serverConfiguration.fullUrl}$url"),
      headers: {
        'Content-Type': 'application/json',
        'client-id': diskrotClient.id,
        'diskrot-signature': _computeHMAC(
          diskrotClient: diskrotClient,
          url: configuration.serverConfiguration.api + url,
          payload: "{}",
        ),
      },
    );

    return response;
  } catch (e) {
    logger.e("Error in DELETE request: $e");
    rethrow;
  }
}

String _createDigestString(String clientId, String url, String payload) {
  return "$clientId|$url|$payload";
}

String _computeHMAC({
  required DiskrotClient diskrotClient,
  required String url,
  required String payload,
}) {
  final digestString = _createDigestString(diskrotClient.id, url, payload);

  final key = utf8.encode(diskrotClient.sharedSecret);
  final bytes = utf8.encode(digestString);

  final hmacSha256 = Hmac(sha256, key);
  final digest = hmacSha256.convert(bytes);
  return digest.toString();
}

class DiskrotClient {
  DiskrotClient({
    required this.id,
    required this.sharedSecret,
    required this.nickname,
  });

  final String id;
  final String sharedSecret;
  final String nickname;
}
