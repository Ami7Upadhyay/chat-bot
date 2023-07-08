import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Either<Failure, Response> statusCodeHandling(Response response) {
  if (response.statusCode == 200) {
    return Right(response);
  } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
    return Left(Failure.server(
        code: response.statusCode ?? 0, msg: response.statusMessage ?? ""));
  } else if (response.statusCode == 500) {
    return Left(Failure.server(
        code: response.statusCode!, msg: '"Internal Server Error"'));
  } else {
    return Left(Failure.server(
        code: response.statusCode!, msg: response.statusMessage!));
  }
}
