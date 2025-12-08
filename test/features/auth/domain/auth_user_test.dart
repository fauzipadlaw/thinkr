import 'package:flutter_test/flutter_test.dart';
import 'package:thinkr/features/auth/domain/auth_user.dart';

void main() {
  group('AuthUser', () {
    test('should create instance with required id', () {
      const user = AuthUser(id: 'user-123');
      
      expect(user.id, 'user-123');
      expect(user.email, isNull);
    });

    test('should create instance with id and email', () {
      const user = AuthUser(id: 'user-123', email: 'test@example.com');
      
      expect(user.id, 'user-123');
      expect(user.email, 'test@example.com');
    });

    test('should support equality comparison', () {
      const user1 = AuthUser(id: 'user-123', email: 'test@example.com');
      const user2 = AuthUser(id: 'user-123', email: 'test@example.com');
      const user3 = AuthUser(id: 'user-456', email: 'test@example.com');
      
      expect(user1.id, user2.id);
      expect(user1.email, user2.email);
      expect(user1.id, isNot(user3.id));
    });

    test('should handle null email', () {
      const user1 = AuthUser(id: 'user-123');
      const user2 = AuthUser(id: 'user-123', email: null);
      
      expect(user1.email, isNull);
      expect(user2.email, isNull);
    });

    test('should allow empty string email', () {
      const user = AuthUser(id: 'user-123', email: '');
      
      expect(user.email, '');
      expect(user.email, isNotNull);
    });
  });
}