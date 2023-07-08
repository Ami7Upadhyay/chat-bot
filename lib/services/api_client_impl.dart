import 'package:ai_chat_bot/core/error/error_code_handling.dart';
import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/services/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';

import '../core/request_params/request_params.dart';

class ApiClientImpl implements ApiClient {
  final Dio _dio;

  ApiClientImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, Response>> dioGet(
      {required path, RequestParams? queryParameters, Options? options}) async {
    try {
      var response =
          await _dio.get(path, queryParameters: queryParameters?.toJson());
      return statusCodeHandling(response);
    } on DioException catch (e) {
      return Left(Failure.exception(msg: e.message!));
    } catch (error) {
      return Left(Failure.exception(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> dioPost(
      {required path, RequestParams? data, Options? options}) async {
    try {
      var response = await _dio.post(path, data: data?.toJson());
      return statusCodeHandling(response);
    } on DioException catch (e) {
      return Left(Failure.exception(msg: e.message!));
    } catch (error) {
      return Left(Failure.exception(msg: error.toString()));
    }
  }
}
