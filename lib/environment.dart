import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ENV { production, staging }

class EnvironmentType {
  const EnvironmentType({
    required this.isProd,
    required this.environment,
  });
  final bool isProd;
  final String environment;
}

class ProductionConfig {
  static String get environment => dotenv.env['ENV'] ?? 'production';
}

class StagingConfig {
  static String get environment => dotenv.env['ENV'] ?? 'production';
}

class Environment {
  static Environment? _instance;
  EnvironmentType? _current;
  Environment._();

  factory Environment() {
    _instance ??= Environment._();
    return _instance!;
  }

  EnvironmentType get environment => _current!;

  void setCurrentEnvironment({required bool isProd}) {
    _current = isProd
        ? EnvironmentType(
            isProd: true,
            environment: ProductionConfig.environment,
          )
        : EnvironmentType(
            isProd: false,
            environment: StagingConfig.environment,
          );
  }

  static EnvironmentType current({required bool isProd}) {
    final environment = Environment();
    environment.setCurrentEnvironment(isProd: isProd);
    return environment.environment;
  }
}
