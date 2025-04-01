import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_app/configuration/configuration.dart';
import 'package:music_app/dependency_context.dart';
import 'package:crypto/crypto.dart';

Future<void> post(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  http
      .post(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
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
  )
      .then((response) {
    if (response.statusCode == 200) {
      logger.i(response.body);
    } else {
      logger.i(response.statusCode);
    }
  }).catchError((error) {
    logger.e('Error: $error');
  });
}

Future<void> get(String url) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  http.get(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      'client-id': diskrotClient.id,
      'diskrot-signature': _computeHMAC(
        diskrotClient: diskrotClient,
        url: configuration.serverConfiguration.api + url,
        payload: "{}",
      ),
    },
  ).then((response) {
    if (response.statusCode == 200) {
      logger.i(response.body);
    } else {
      logger.i(response.statusCode);
    }
  }).catchError((error) {
    logger.e('Error: $error');
  });
}

Future<void> put(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  http
      .put(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
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
  )
      .then((response) {
    if (response.statusCode == 200) {
      logger.i(response.body);
    } else {
      logger.i(response.statusCode);
    }
  }).catchError((error) {
    logger.e('Error: $error');
  });
}

Future<void> patch(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  http
      .patch(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
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
  )
      .then((response) {
    if (response.statusCode == 200) {
      logger.i(response.body);
    } else {
      logger.i(response.statusCode);
    }
  }).catchError((error) {
    logger.e('Error: $error');
  });
}

Future<void> delete(String url) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();
  final diskrotClient = di.get<DiskrotClient>();

  http.delete(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      'client-id': diskrotClient.id,
      'diskrot-signature': _computeHMAC(
        diskrotClient: diskrotClient,
        url: configuration.serverConfiguration.api + url,
        payload: "{}",
      ),
    },
  ).then((response) {
    if (response.statusCode == 200) {
      logger.i(response.body);
    } else {
      logger.i(response.statusCode);
    }
  }).catchError((error) {
    logger.e('Error: $error');
  });
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
