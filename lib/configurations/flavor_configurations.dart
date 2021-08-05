import 'package:flutter/material.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/enums.dart';

class FlavorValues {
  FlavorValues({required this.baseUrl});

  final String baseUrl;
//TODO: Add other flavor specific values, e.g API Keys
//TODO: Add flavor values to the correct positions in gradle and manifest for android and configure for iOS
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig _instance = FlavorConfig._internal(Flavor.DEV, "dev",
      AppColors.primaryBackgroundColor, FlavorValues(baseUrl: ''));

  factory FlavorConfig({
    required Flavor flavor,
    Color color: Colors.blue,
    required String name,
    required FlavorValues values,
  }) {
    _instance = FlavorConfig._internal(flavor, name,
    color, values);
    print(_instance.flavor);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isLive() => _instance.flavor == Flavor.PRODUCTION;

  static bool isDevelopment() => _instance.flavor == Flavor.DEV;

  static bool isQA() => _instance.flavor == Flavor.QA;

  static bool isUAT() => _instance.flavor == Flavor.UAT;
}
