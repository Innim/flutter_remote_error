import 'package:innim_remote_error/innim_remote_error.dart';

void main() {
  final error = RemoteError(GlobalErrorCode.domain, GlobalErrorCode.notFound,
      'Sorry, not found!', 'Requested element is not found');

  print('Error: $error');
  // > Error: RemoteError{domain: Global, code: 1, localizedMessage: Sorry, not found!, description: Requested element is not found, data: null}
}