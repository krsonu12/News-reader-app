class AppFailure implements Exception {
  const AppFailure(this.message, {this.code});

  final String message;
  final int? code;

  @override
  String toString() => 'AppFailure(message: $message, code: $code)';
}
