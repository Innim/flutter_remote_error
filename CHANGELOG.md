## [0.4.7]

* Added `isMaintenanceError` getter on `ErrorResult?` extension - returns `true`
  for `GlobalErrorCode.maintenanceError`.
* `isTemporaryServerError` now also returns `true` for maintenance errors -
  maintenance is treated as a temporary server state.
* `HttpStatus.badGateway` (502) is no longer included in
  `isTemporaryServerError`. It was a fallback for maintenance handling; with
  an explicit `maintenanceError` code, 502 should be reported separately.

## [0.4.6]

* Added `maintenanceError` and `serviceDownError` error codes to `GlobalErrorCode`.


## [0.4.5]

* `AuthErrorCode`: added `incorrectData`, `accessRecoveryInvalidUser`, `externalAuthAccountExists`, `externalAuthAccountNotFound` error codes.

## [0.4.4]

* Added `ValidationErrorCode`.
* Json serialization for `localizedMessage` in `RemoteError.toString()` (can be multi-line and contain special characters).

## [0.4.3]

* Added new error code `httpException` to `NetworkErrorCode`.

## [0.4.2]

* Added `InternalErrorCode`.
* Up min dio version to 5.2.0.

## [0.4.1+3]

* Added new error code `connectionError` to `NetworkErrorCode`.

## [0.4.1+2]

* Added new error code `badCertificate` to `NetworkErrorCode`.

## [0.4.1+1]

* Up max dio version to 6.0.0.

## [0.4.1]

* Export `DioError`.

## [0.4.0]

* Added `AuthErrorCode` (moved from `login`).

## [0.3.0]

* Add `retry` param to error model.
* Parameters `localizedMessage, description, data, retry` have become named.

## [0.2.0]

* Migrate to null-safety.

## [0.1.4]

* Use `innim_lint` analysis options. Refactoring with new rules.
* Add code for handshake phase failure.

## [0.1.3]

*  Modification  `isError` income not named parameter `code`.

## [0.1.2]

* Add code if socket connection failed.
* Add method return if socket connection failed.

## [0.1.1]

* Example code.
* Add pedantic analysis ruleset.
* Fix analysis problems.
* Added tests for some extension getters.
* Fixed: `isExternalServiceError` returns `true` for every internal server error.
* Removed `dart:io` import (for web support).

## [0.1.0+2]

* Export async `Result` and `ErrorResult`.

## [0.1.0+1]

* Lower version for dependencies.
* Readme: added link to pub.dev.

## [0.1.0]

* Moved from `innim_remote` package.
