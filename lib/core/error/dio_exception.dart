// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';

// import 'failure.dart';

// class DioExceptions {
//   static late String message;

//   Future<Either<Failure, Response>> fromDioError(
//       {required DioError dioError}) async {
//     switch (dioError.type) {
//       case DioErrorType.cancel:
//         message = "Request to API server was cancelled";
//         return Left(Failure.exception(message: message));
//       case DioErrorType.connectionTimeout:
//         message = "Connection timeout with API server";
//         return Left(Failure.exception(message: message));
//       case DioErrorType.receiveTimeout:
//         message = "Receive timeout in connection with API server";
//         return Left(Failure.exception(message: message));
//       case DioErrorType.badResponse:
//         return statusCodeHandling(dioError.response!);
//       case DioErrorType.sendTimeout:
//         message = "Send timeout in connection with API server";
//         return Left(Failure.exception(message: message));
//       case DioErrorType.unknown:
//         message = "Unexpected error occurred";
//         return Left(Failure.exception(message: message));
//       default:
//         message = "Something went wrong";
//         return Left(Failure.exception(message: message));
//     }
//   }
// }
