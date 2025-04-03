Configuration? _configuration;

Configuration get configuration {
  _configuration ??= Configuration.fromEnvironment();
  return _configuration!;
}

class Configuration {
  const Configuration({
    required this.buildEnvironment,
    required this.serverConfiguration,
  });

  final BuildEnvironment buildEnvironment;
  final ServerConfiguration serverConfiguration;

  factory Configuration.fromEnvironment() {
    return Configuration(
        buildEnvironment: BuildEnvironment.release,
        serverConfiguration: ServerConfiguration(
          hostname: 'network.diskrot.com',
          port: '8080',
          secure: false,
          api: '/api/v1',
        ));
  }
}

enum BuildEnvironment { dev, release }

class ServerConfiguration {
  const ServerConfiguration({
    required this.hostname,
    required this.port,
    required this.secure,
    required this.api,
  });
  final String hostname;
  final String port;
  final bool secure;
  final String api;

  String get fullUrl {
    return '${secure ? 'https' : 'http'}://$hostname:$port$api';
  }
}
