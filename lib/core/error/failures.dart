/// Base class for all failures
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// API related errors (400, 401, 500, etc.)
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred'])
      : super(message);
}

/// No internet connection
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'No internet connection'])
      : super(message);
}

/// Local cache / storage error
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred'])
      : super(message);
}

/// Unknown or unexpected error
class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Something went wrong'])
      : super(message);
}