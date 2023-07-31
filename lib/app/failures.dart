abstract class Failure {
  final String message;

  const Failure({required this.message});

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Failure(message: $message)';
}

class ServerFailure extends Failure {
  ServerFailure({String message = 'Server Failure'}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String message = 'Cache Failure'}) : super(message: message);
}
