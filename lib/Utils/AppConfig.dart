
class AppConfig {
  static late String baseUrl;

  static init(String env) {
    switch (env) {
      case 'dev':
        baseUrl = "https://uat-node.loan112fintech.com/journey-service/api/v1/";
        break;
      case 'prod':
        baseUrl = 'https://api.example.com';
        break;
    }
  }
}
