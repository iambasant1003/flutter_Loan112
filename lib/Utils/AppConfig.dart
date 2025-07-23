
class AppConfig {
  static late String baseUrlNode;
  static late String baseUrlPhp;
  static late String authPhpToken;

  static init(String env) {
    switch (env) {
      case 'dev':
        baseUrlNode = "https://uat-node.loan112fintech.com/journey-service/api/v1/";
        baseUrlPhp = "https://uat-api.loan112fintech.com/";
        authPhpToken = "NWZmYzU2NDVkN2Y3ODIwNDJjZDFhZmViYjA3MTExZDM=";
        break;
      case 'prod':
        baseUrlNode = 'https://api.example.node.com';
        baseUrlPhp = 'https://api.example.php.com';
        authPhpToken = 'NWZmYzU2NDVkN2Y3ODIwNDJjZDFhZmViYjA3MTExZDM=';
        break;
    }
  }
}
