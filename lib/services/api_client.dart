import 'package:ai_chat_bot/core/dio/dio_client.dart';
import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/core/request_params/request_params.dart';
import 'package:ai_chat_bot/services/api_client_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider =
    Provider<ApiClient>((ref) => ApiClientImpl(dio: ref.watch(dioProvider)));

abstract class ApiClient {
  Future<Either<Failure, Response>> dioGet(
      {required path, RequestParams? queryParameters, Options? options});

  Future<Either<Failure, Response>> dioPost(
      {required path, RequestParams? data, Options? options});
}
