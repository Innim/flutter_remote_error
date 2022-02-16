## [0.4.1] - 2022-02-16

* Export `DioError`.

## [0.4.0] - 2022-02-07

* Added `AuthErrorCode` (moved from `login`).

## [0.3.0] - 2021-08-23

* Add `retry` param to error model.
* Parameters `localizedMessage, description, data, retry` have become named.

## [0.2.0] - 2021-04-27

* Migrate to null-safety.

## [0.1.4] - 2020-12-11

* Use `innim_lint` analysis options. Refactoring with new rules.
* Add code for handshake phase failure.

## [0.1.3] - 2020-08-25

*  Modification  `isError` income not named parameter `code`.

## [0.1.2] - 2020-08-24

* Add code if socket connection failed.
* Add method return if socket connection failed.

## [0.1.1] - 2020-07-20

* Example code.
* Add pedantic analysis ruleset.
* Fix analysis problems.
* Added tests for some extension getters.
* Fixed: `isExternalServiceError` returns `true` for every internal server error.
* Removed `dart:io` import (for web support).

## [0.1.0+2] - 2020-07-14

* Export async `Result` and `ErrorResult`.

## [0.1.0+1] - 2020-07-14

* Lower version for dependencies.
* Readme: added link to pub.dev.

## [0.1.0] - 2020-07-14

* Moved from `innim_remote` package.
