import 'package:dio/dio.dart';
import 'package:innim_remote_error/innim_remote_error.dart';
import 'package:test/test.dart';

void main() {
  group('CommonErrorResultExtensionErrorCode', () {
    group('isNotFound', () {
      test('should return true if http status is 404', () {
        final res = _dioError(statusCode: 404);

        expect(res.isNotFound, true);
      });

      test('should return false if http status is not 404', () {
        final res = _dioError(statusCode: 400);

        expect(res.isNotFound, false);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;

        expect(res.isNotFound, false);
      });
    });

    group('isBadRequest', () {
      test('should return true if http status is 400', () {
        final res = _dioError(statusCode: 400);

        expect(res.isBadRequest, true);
      });

      test('should return false if http status is not 400', () {
        final res = _dioError(statusCode: 401);

        expect(res.isBadRequest, false);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;

        expect(res.isBadRequest, false);
      });
    });

    group('isExternalServiceError', () {
      test('should return true for GlobalErrorCode.externalServiceError', () {
        final res = _remoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.externalServiceError,
        );

        expect(res.isExternalServiceError, true);
      });

      test('should return false for other error code', () {
        final res = _remoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.badRequest,
        );

        expect(res.isExternalServiceError, false);
      });

      test('should return false for other error domain', () {
        final res = _remoteError(
          'other_domain',
          GlobalErrorCode.externalServiceError,
        );

        expect(res.isExternalServiceError, false);
      });

      test('should return false when no RemoteError', () {
        final res = _dioError(statusCode: 401);

        expect(res.isExternalServiceError, false);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;

        expect(res.isExternalServiceError, false);
      });
    });

    group('isSocketConnectionFailed', () {
      test('should return true for NetworkErrorCode.socketConnectionFailed',
          () {
        final res = _remoteError(
          NetworkErrorCode.domain,
          NetworkErrorCode.socketConnectionFailed,
        );

        expect(res.isSocketConnectionFailed, true);
      });

      test('should return false for other network error code', () {
        final res = _remoteError(
          NetworkErrorCode.domain,
          NetworkErrorCode.receiveTimeout,
        );

        expect(res.isSocketConnectionFailed, false);
      });

      test('should return false for other error domain', () {
        final res = _remoteError(
          'other_domain',
          NetworkErrorCode.socketConnectionFailed,
        );

        expect(res.isSocketConnectionFailed, false);
      });

      test('should return false when no RemoteError', () {
        final res = _dioError(statusCode: 500);

        expect(res.isSocketConnectionFailed, false);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;

        expect(res.isSocketConnectionFailed, false);
      });
    });

    group('isUnauthorized', () {
      test('should return true if http status is 401', () {
        final res = _dioError(statusCode: 401);

        expect(res.isUnauthorized, true);
      });

      test('should return false if http status is not 401', () {
        final res = _dioError(statusCode: 400);

        expect(res.isUnauthorized, false);
      });

      test('should return true if custom error is unauthorized', () {
        final res = _remoteError(
          AuthErrorCode.domain,
          AuthErrorCode.unauthorized,
        );

        expect(res.isUnauthorized, true);
      });

      test('should return true if custom error has another domain', () {
        final res = _remoteError(
          'fake',
          AuthErrorCode.unauthorized,
        );

        expect(res.isUnauthorized, false);
      });

      test('should return true if custom error has another code', () {
        final res = _remoteError(
          AuthErrorCode.domain,
          AuthErrorCode.emailIsBusy,
        );

        expect(res.isUnauthorized, false);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;

        expect(res.isUnauthorized, false);
      });
    });

    group('isRemoteError()', () {
      test('should return true for matching domain and code', () {
        final res = _remoteError('test_domain', 123);
        expect(res.isRemoteError('test_domain', 123), isTrue);
      });

      test('should return false for non-matching domain', () {
        final res = _remoteError('test_domain', 123);
        expect(res.isRemoteError('other_domain', 123), isFalse);
      });

      test('should return false for non-matching code', () {
        final res = _remoteError('test_domain', 123);
        expect(res.isRemoteError('test_domain', 456), isFalse);
      });

      test('should return true for matching domain without code', () {
        final res = _remoteError('test_domain', 123);
        expect(res.isRemoteError('test_domain'), isTrue);
      });

      test('should return false when no RemoteError', () {
        final res = _dioError(statusCode: 500);

        expect(res.isRemoteError('test_domain'), isFalse);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;

        expect(res.isRemoteError('test_domain'), isFalse);
      });
    });

    group('isGlobalError()', () {
      test('should return true for GlobalErrorCode domain', () {
        final res = _remoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.externalServiceError,
        );
        expect(res.isGlobalError(), isTrue);
      });

      test('should return true for matching GlobalErrorCode code', () {
        final res = _remoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.notFound,
        );
        expect(res.isGlobalError(GlobalErrorCode.notFound), isTrue);
      });

      test('should return false for non-matching GlobalErrorCode code', () {
        final res = _remoteError(
          GlobalErrorCode.domain,
          GlobalErrorCode.badRequest,
        );
        expect(res.isGlobalError(GlobalErrorCode.notFound), isFalse);
      });

      test('should return false for non-matching domain', () {
        final res = _remoteError('other', 1);
        expect(res.isGlobalError(), isFalse);
      });

      test(
        'should return false for non-matching domain even if code matches',
        () {
          final res = _remoteError('other', 1);
          expect(res.isGlobalError(1), isFalse);
        },
      );

      test('should return false when no RemoteError', () {
        final res = _dioError(statusCode: 500);
        expect(res.isGlobalError(), isFalse);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;
        expect(res.isGlobalError(), isFalse);
      });
    });

    group('isNetworkError()', () {
      test('should return true for NetworkErrorCode domain', () {
        final res = _remoteError(
          NetworkErrorCode.domain,
          NetworkErrorCode.connectionError,
        );
        expect(res.isNetworkError(), isTrue);
      });

      test('should return true for matching NetworkErrorCode code', () {
        final res = _remoteError(
          NetworkErrorCode.domain,
          NetworkErrorCode.receiveTimeout,
        );
        expect(res.isNetworkError(NetworkErrorCode.receiveTimeout), isTrue);
      });

      test('should return false for non-matching NetworkErrorCode code', () {
        final res = _remoteError(
          NetworkErrorCode.domain,
          NetworkErrorCode.connectTimeout,
        );
        expect(res.isNetworkError(NetworkErrorCode.receiveTimeout), isFalse);
      });

      test('should return false for non-matching domain', () {
        final res = _remoteError('other', 1);
        expect(res.isNetworkError(), isFalse);
      });

      test(
        'should return false for non-matching domain even if code matches',
        () {
          final res = _remoteError('other', 1);
          expect(res.isNetworkError(1), isFalse);
        },
      );

      test('should return false when no RemoteError', () {
        final res = _dioError(statusCode: 500);
        expect(res.isNetworkError(), isFalse);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;
        expect(res.isNetworkError(), isFalse);
      });
    });

    group('isAuthError()', () {
      test('should return true for AuthErrorCode domain', () {
        final res = _remoteError(
          AuthErrorCode.domain,
          AuthErrorCode.incorrectPassword,
        );
        expect(res.isAuthError(), isTrue);
      });

      test('should return true for matching AuthErrorCode code', () {
        final res = _remoteError(
          AuthErrorCode.domain,
          AuthErrorCode.unauthorized,
        );
        expect(res.isAuthError(AuthErrorCode.unauthorized), isTrue);
      });

      test('should return false for non-matching AuthErrorCode code', () {
        final res = _remoteError(
          AuthErrorCode.domain,
          AuthErrorCode.emailIsBusy,
        );
        expect(res.isAuthError(AuthErrorCode.unauthorized), isFalse);
      });

      test('should return false for non-matching domain', () {
        final res = _remoteError('other', 1);
        expect(res.isAuthError(), isFalse);
      });

      test(
        'should return false for non-matching domain even if code matches',
        () {
          final res = _remoteError('other', 1);
          expect(res.isAuthError(1), isFalse);
        },
      );

      test('should return false when no RemoteError', () {
        final res = _dioError(statusCode: 500);
        expect(res.isAuthError(), isFalse);
      });

      test('should return false when called on null', () {
        const ErrorResult? res = null;
        expect(res.isAuthError(), isFalse);
      });
    });
  });

  group('toError()', () {
    test('should return RemoteError when error is RemoteError', () {
      const remoteError = RemoteError('test_domain', 123);
      final result = Result<Object>.error(remoteError).asError;

      expect(result.toError(), remoteError);
    });

    test('should return null when error is not RemoteError', () {
      final result = _dioError(statusCode: 500);

      expect(result.toError(), isNull);
    });

    test('should return null when called on null', () {
      const ErrorResult? res = null;

      expect(res.toError(), isNull);
    });
  });

  group('toDioError()', () {
    test('should return DioException when error is DioException', () {
      final dioError = _dioException(statusCode: 500);
      final result = Result<Object>.error(dioError).asError;

      expect(result.toDioError(), dioError);
    });

    test('should return null when error is not DioException', () {
      final result = _remoteError('test_domain', 123);

      expect(result.toDioError(), isNull);
    });

    test('should return null when called on null', () {
      const ErrorResult? res = null;

      expect(res.toDioError(), isNull);
    });
  });
}

ErrorResult _dioError({required int statusCode}) {
  return Result<Object>.error(_dioException(statusCode: statusCode)).asError!;
}

DioException _dioException({required int statusCode}) {
  final requestOptions = RequestOptions(path: 'fake');
  return DioException(
    requestOptions: requestOptions,
    response: Response<Object>(
      requestOptions: requestOptions,
      statusCode: statusCode,
    ),
  );
}

ErrorResult _remoteError(String domain, int code) {
  return Result<Object>.error(RemoteError(domain, code)).asError!;
}
