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
    });
  });
}

ErrorResult _dioError({required int statusCode}) {
  final requestOptions = RequestOptions(path: 'fake');
  return Result<Object>.error(
    DioException(
      requestOptions: requestOptions,
      response: Response<Object>(
        requestOptions: requestOptions,
        statusCode: statusCode,
      ),
    ),
  ).asError!;
}

ErrorResult _remoteError(String domain, int code) {
  return Result<Object>.error(RemoteError(domain, code)).asError!;
}
