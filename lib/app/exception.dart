class ServerException implements Exception {
  final String message;

  ServerException({required this.message});

  @override
  String toString() {
    return message;
  }
}
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() {
    return message;
  }
}
