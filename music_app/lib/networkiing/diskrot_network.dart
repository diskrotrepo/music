import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_app/configuration/configuration.dart';
import 'package:music_app/dependency_context.dart';

Future<void> post(String url, String body) async {
  final configuration = Configuration.fromEnvironment();
  final logger = di.get<Logger>();

  http
      .post(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      // 'client-id': this.client.id,
      'diskrot-signature': _computeHMAC(
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

  http.get(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      // 'client-id': this.client.id,
      'diskrot-signature': _computeHMAC(
        url: configuration.serverConfiguration.api + url,
        payload: body,
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

  http
      .put(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      // 'client-id': this.client.id,
      'diskrot-signature': _computeHMAC(
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

  http
      .patch(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      // 'client-id': this.client.id,
      'diskrot-signature': _computeHMAC(
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

  http.delete(
    Uri.parse("${configuration.serverConfiguration.fullUrl}/$url"),
    headers: {
      'Content-Type': 'application/json',
      // 'client-id': this.client.id,
      'diskrot-signature': _computeHMAC(
        url: configuration.serverConfiguration.api + url,
        payload: body,
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

String _computeHMAC({String url, String payload}) {
  // Implement HMAC computation here
  return 'computed-hmac';
}


/*
post = async (url: string, payload: any): Promise<any> => {

        const fullUrl = this.buildUrl(url);

        console.log("fullUrl", fullUrl);

        const response = await fetch(
            fullUrl,
            {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: payload
                    })
                },
                body: JSON.stringify(payload)
            }
        );


        if (!response.ok) {
            this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    get = async (url: string): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: {}
                    })
                },
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    put = async (url: string, payload: any): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: payload
                    })
                },
                body: JSON.stringify(payload)
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    patch = async (url: string, payload: any): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: payload
                    })
                },
                body: JSON.stringify(payload)
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    delete = async (url: string): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: {}
                    })
                },
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }*/