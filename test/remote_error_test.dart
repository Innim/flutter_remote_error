import 'package:innim_remote_error/innim_remote_error.dart';
import 'package:test/test.dart';

void main() {
  group('RemoteError', () {
    group('creation', () {
      test('should create instance with required fields', () {
        const error = RemoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.systemError,
        );

        expect(error.domain, GlobalErrorCode.domain);
        expect(error.code, GlobalErrorCode.systemError);
        expect(error.localizedMessage, isNull);
        expect(error.description, isNull);
        expect(error.data, isNull);
        expect(error.retry, isFalse);
      });

      test('should create instance with all fields', () {
        const error = RemoteError(
          InternalErrorCode.domain,
          InternalErrorCode.temporaryServerError,
          localizedMessage: 'Server error',
          description: 'Internal server error',
          data: {'traceId': 'abc123'},
          retry: true,
        );

        expect(error.domain, InternalErrorCode.domain);
        expect(error.code, InternalErrorCode.temporaryServerError);
        expect(error.localizedMessage, 'Server error');
        expect(error.description, 'Internal server error');
        expect(error.data, {'traceId': 'abc123'});
        expect(error.retry, isTrue);
      });
    });

    group('JSON serialization', () {
      test('should serialize with all fields', () {
        const error = RemoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.notFound,
          localizedMessage: 'Not found',
          description: 'Resource not found',
          data: {'resource': 'user'},
          retry: false,
        );

        final json = error.toJson();
        expect(json['domain'], 'Global');
        expect(json['code'], 1);
        expect(json['localizedMessage'], 'Not found');
        expect(json['description'], 'Resource not found');
        expect(json['data'], {'resource': 'user'});
        expect(json['retry'], false);
        expect(json.length, 6);
      });

      test('should serialize with null optional fields', () {
        const error = RemoteError(
          AuthErrorCode.domain,
          AuthErrorCode.incorrectPassword,
        );

        final json = error.toJson();
        expect(json['domain'], 'Auth');
        expect(json['code'], 9);
        expect(json.containsKey('localizedMessage'), isFalse);
        expect(json.containsKey('description'), isFalse);
        expect(json.containsKey('data'), isFalse);
        expect(json['retry'], false);
        expect(json.length, 3);
      });
    });

    group('JSON deserialization', () {
      test('should deserialize with all fields', () {
        final json = {
          'domain': 'Global',
          'code': 0,
          'localizedMessage': 'DB error',
          'description': 'Database unavailable',
          'data': {'db': 'main'},
          'retry': true,
        };

        final error = RemoteError.fromJson(json);

        expect(error.domain, GlobalErrorCode.domain);
        expect(error.code, GlobalErrorCode.systemError);
        expect(error.localizedMessage, 'DB error');
        expect(error.description, 'Database unavailable');
        expect(error.data, {'db': 'main'});
        expect(error.retry, isTrue);
      });

      test('should handle null optional fields', () {
        final json = {
          'domain': 'Auth',
          'code': 8,
        };

        final error = RemoteError.fromJson(json);

        expect(error.domain, AuthErrorCode.domain);
        expect(error.code, AuthErrorCode.incorrectClientVersion);
        expect(error.localizedMessage, isNull);
        expect(error.description, isNull);
        expect(error.data, isNull);
        expect(error.retry, isFalse);
      });
    });

    group('equals()', () {
      test('should return true for equal errors', () {
        const error1 = RemoteError('domain', 1, retry: true);
        const error2 = RemoteError('domain', 1, retry: true);

        expect(error1, equals(error2));
        expect(error1.hashCode, error2.hashCode);
      });

      test('should return false for different errors', () {
        const error1 = RemoteError('domain1', 1);
        const error2 = RemoteError('domain2', 2);

        expect(error1, isNot(equals(error2)));
        expect(error1.hashCode, isNot(error2.hashCode));
      });
    });

    group('toString()', () {
      test('should return expected format', () {
        const error = RemoteError(
          'test',
          123,
          localizedMessage: 'msg\nwith newline',
          description: 'desc',
          data: {'foo': 'bar'},
          retry: true,
        );

        final str = error.toString();
        expect(str, contains('RemoteError{domain: test, code: 123'));
        expect(str, contains(r'localizedMessage: "msg\nwith newline"'));
        expect(str, contains('description: desc'));
        expect(str, contains('data: {foo: bar}'));
        expect(str, contains('retry: true'));
      });
    });
  });
}
