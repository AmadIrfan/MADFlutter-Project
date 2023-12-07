// ignore_for_file: prefer_typing_uninitialized_variables

// handle exceptions
class AppExceptions implements Exception {
  AppExceptions([this._message, this._prefix]);
  final _message;
  final _prefix;
  @override
  String toString() {
    return '$_prefix  $_message';
  }
}

// handle internet exceptions
class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No Internet');
}

// handle services exceptions
class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal Server Error');
}
