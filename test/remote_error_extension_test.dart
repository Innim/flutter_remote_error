import 'package:innim_remote_error/innim_remote_error.dart';
import 'package:test/test.dart';

void main() {
  group('CommonRemoteErrorExtensionErrorCode', () {
    group('isError()', () {
      test('should return true for matching domain and code', () {
        final error = _remoteError('test_domain', 42);
        expect(error.isError('test_domain', 42), isTrue);
      });

      test('should return false for non-matching domain', () {
        final error = _remoteError('test_domain', 42);
        expect(error.isError('other_domain', 42), isFalse);
      });

      test('should return false for non-matching code', () {
        final error = _remoteError('test_domain', 42);
        expect(error.isError('test_domain', 43), isFalse);
      });

      test('should return true for matching domain without code', () {
        final error = _remoteError('test_domain');
        expect(error.isError('test_domain'), isTrue);
      });

      test('should return false for non-matching domain without code', () {
        final error = _remoteError('test_domain');
        expect(error.isError('other_domain'), isFalse);
      });
    });

    group('isGlobalError()', () {
      test('should return true for GlobalErrorCode domain', () {
        final error = _globalError();
        expect(error.isGlobalError(), isTrue);
      });

      test('should return true for matching GlobalErrorCode code', () {
        final error = _globalError(GlobalErrorCode.notFound);
        expect(error.isGlobalError(GlobalErrorCode.notFound), isTrue);
      });

      test('should return false for non-matching GlobalErrorCode code', () {
        final error = _globalError(GlobalErrorCode.notFound);
        expect(error.isGlobalError(GlobalErrorCode.badRequest), isFalse);
      });

      test('should return false for non-matching domain', () {
        final error = _remoteError('other', 1);
        expect(error.isGlobalError(), isFalse);
      });

      test(
        'should return false for non-matching domain event if code matches',
        () {
          final error = _remoteError('other', 1);
          expect(error.isGlobalError(1), isFalse);
        },
      );
    });

    group('isNetworkError()', () {
      test('should return true for NetworkErrorCode domain', () {
        final error = _networkError();
        expect(error.isNetworkError(), isTrue);
      });

      test('should return true for matching NetworkErrorCode code', () {
        final error = _networkError(NetworkErrorCode.receiveTimeout);
        expect(error.isNetworkError(NetworkErrorCode.receiveTimeout), isTrue);
      });

      test('should return false for non-matching NetworkErrorCode code', () {
        final error = _networkError(NetworkErrorCode.receiveTimeout);
        expect(error.isNetworkError(NetworkErrorCode.connectTimeout), isFalse);
      });

      test('should return false for non-matching domain', () {
        final error = _remoteError('other', 1);
        expect(error.isNetworkError(), isFalse);
      });

      test(
        'should return false for non-matching domain even if code matches',
        () {
          final error = _remoteError('other', 1);
          expect(error.isNetworkError(1), isFalse);
        },
      );
    });

    group('isAuthError()', () {
      test('should return true for AuthErrorCode domain', () {
        final error = _authError();
        expect(error.isAuthError(), isTrue);
      });

      test('should return true for matching AuthErrorCode code', () {
        final error = _authError(AuthErrorCode.tokenExpired);
        expect(error.isAuthError(AuthErrorCode.tokenExpired), isTrue);
      });

      test('should return false for non-matching AuthErrorCode code', () {
        final error = _authError(AuthErrorCode.tokenExpired);
        expect(error.isAuthError(AuthErrorCode.refreshTokenNotFound), isFalse);
      });

      test('should return false for non-matching domain', () {
        final error = _remoteError('other', 1);
        expect(error.isAuthError(), isFalse);
      });

      test(
        'should return false for non-matching domain even if code matches',
        () {
          final error = _remoteError('other', 1);
          expect(error.isAuthError(1), isFalse);
        },
      );
    });
  });

  group('InternalErrorCodeExtensionRemoteError', () {
    group('isInternalError()', () {
      test('should return true for InternalErrorCode domain', () {
        final error = _internalError();
        expect(error.isInternalError(), isTrue);
      });

      test('should return true for matching InternalErrorCode code', () {
        final error = _internalError(InternalErrorCode.emptyData);
        expect(
          error.isInternalError(InternalErrorCode.emptyData),
          isTrue,
        );
      });

      test('should return false for non-matching InternalErrorCode code', () {
        final error = _internalError(InternalErrorCode.temporaryServerError);
        expect(error.isInternalError(InternalErrorCode.emptyData), isFalse);
      });

      test('should return false for non-matching domain', () {
        final error = _remoteError('other', 1);
        expect(error.isInternalError(), isFalse);
      });

      test(
        'should return false for non-matching domain even if code matches',
        () {
          final error = _remoteError('other', 1);
          expect(error.isInternalError(1), isFalse);
        },
      );
    });
  });
}

RemoteError _remoteError(String domain, [int? code]) =>
    RemoteError(domain, code ?? 1);

RemoteError _globalError([
  int code = GlobalErrorCode.systemError,
]) =>
    _remoteError(GlobalErrorCode.domain, code);

RemoteError _networkError([
  int code = NetworkErrorCode.socketConnectionFailed,
]) =>
    _remoteError(NetworkErrorCode.domain, code);

RemoteError _authError([
  int code = AuthErrorCode.unauthorized,
]) =>
    _remoteError(AuthErrorCode.domain, code);

RemoteError _internalError([
  int code = InternalErrorCode.temporaryServerError,
]) =>
    _remoteError(InternalErrorCode.domain, code);
