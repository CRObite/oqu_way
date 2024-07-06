class AppApiEndpoints {
  static String apiBaseUrl = 'http://192.168.8.222:8080';
  static String oauth2RedirectUrl = 'http://192.168.8.222:3000/oauth2/redirect';
  static String googleAuthUrl = '$apiBaseUrl/oauth2/authorize/google?redirect_uri=$oauth2RedirectUrl';
}

