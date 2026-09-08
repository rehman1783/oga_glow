import 'package:flutter_test/flutter_test.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/auth/models/auth_response_model.dart';
import 'package:oga_glow/features/auth/repositories/auth_repository.dart';
import 'package:oga_glow/features/auth/services/auth_service.dart';

class MockFailingAuthService extends AuthService {
  final ApiException exceptionToThrow;

  MockFailingAuthService(this.exceptionToThrow);

  @override
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    throw exceptionToThrow;
  }
}

void main() {
  group('AuthRepository Error Propagation Tests', () {
    test('BadRequestException preserves "User already exists" message', () async {
      final mockService = MockFailingAuthService(
        BadRequestException(
          message: 'User already exists',
          data: {'success': false, 'message': 'User already exists'},
        ),
      );

      final repository = AuthRepository(authService: mockService);

      try {
        await repository.register(
          name: 'rehman',
          email: 'ranamano178@gmail.com',
          password: 'Password123!',
        );
        fail('Should have thrown an exception');
      } on BadRequestException catch (e) {
        expect(e.message, 'User already exists');
        expect(e.message.toLowerCase().contains('already exists'), isTrue);
      }
    });
  });
}
