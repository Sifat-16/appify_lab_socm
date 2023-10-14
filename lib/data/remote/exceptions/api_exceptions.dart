class ApiExceptions implements Exception{
  String? _message;
  String? _prefix;
  ApiExceptions(this._message, this._prefix);
  @override
  String toString() {
    // TODO: implement toString
    return '$_prefix & $_message';
  }
}

class FetchDataExceptions extends ApiExceptions{
  FetchDataExceptions({String? message}):super(message, 'Error during communication');
}

class BadRequestExceptions extends ApiExceptions{
  BadRequestExceptions({String? message}):super(message, 'Invalid Request');
}

class UnauthorizedExceptions extends ApiExceptions{
  UnauthorizedExceptions({String? message}):super(message, 'Unauthorized Request');
}

