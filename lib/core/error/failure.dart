class Failure {
  final int? code;
  final String msg;
  Failure.network({required this.code, required this.msg});
  Failure.server({this.code, required this.msg});
  Failure.exception({this.code, required this.msg});
}
