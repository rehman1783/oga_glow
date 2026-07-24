class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://ogaglow-apis.vercel.app/api';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String deleteAccount = '/auth/delete-account';
}

