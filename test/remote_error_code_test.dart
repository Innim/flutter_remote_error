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
  });
}

ErrorResult _dioError({int statusCode}) {
  return Result<Object>.error(
          DioError(response: Response<Object>(statusCode: statusCode)))
      .asError;
}
