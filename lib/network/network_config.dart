

import 'package:tweety/configurations/flavor_configurations.dart';

class IPAddress {
  static const String DEV = 'test_url/';
  static const String QA = '';
  static const String UAT = '';
  static const String LIVE = '';
}
class ServerProtocol {
  static const String DEV = 'https://';
  static const String QA = 'https://';
  static const String UAT = 'https://';
  static const String LIVE = 'https://';
}
class ContextRoot {
  static const String DEV = '';
  static const String QA = '';
  static const String UAT = '';
  static const String LIVE = '';
}
class NetworkConfig {
  static String getNetworkUrl() {
    String url = _getProtocol() + _getIP() + _getContextRoot();
    print('API Endpoint: $url');
    return url;
  }
  static String _getContextRoot() {
    if (FlavorConfig.isDevelopment()) {
      return ContextRoot.DEV;
    } else if (FlavorConfig.isQA()) {
      return ContextRoot.QA;
    } else if (FlavorConfig.isUAT()) {
      return ContextRoot.UAT;
    } else {
      return ContextRoot.LIVE;
    }
  }
  static String _getProtocol() {
    if (FlavorConfig.isDevelopment()) {
      return ServerProtocol.DEV;
    } else if (FlavorConfig.isQA()) {
      return ServerProtocol.QA;
    } else if (FlavorConfig.isUAT()) {
      return ServerProtocol.UAT;
    } else {
      return ServerProtocol.LIVE;
    }
  }
  static String _getIP() {
    if (FlavorConfig.isDevelopment()) {
      return IPAddress.DEV;
    } else if (FlavorConfig.isQA()) {
      return IPAddress.QA;
    } else if (FlavorConfig.isUAT()) {
      return IPAddress.UAT;
    } else {
      return IPAddress.LIVE;
    }
  }
}

class APIResponse{
  static const String RESPONSE_SUCCESS = "1000";
  static const String RESPONSE_SUCCESS_OTP_NOT_SEND="1006";
}

class APIRequestStates{
  static const String REQUEST_IDEAL = "Ideal";
  static const String REQUEST_LOADING="Loading";
  static const String REQUEST_SUCCESS = "Success";
  static const String REQUEST_FAILED="Failed";

}







