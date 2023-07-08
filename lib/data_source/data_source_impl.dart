import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/core/request_params/request_params.dart';
import 'package:ai_chat_bot/data_source/data_source.dart';
import 'package:ai_chat_bot/models/chat_data.dart';
import 'package:ai_chat_bot/models/chat_model.dart';
import 'package:ai_chat_bot/services/api_client.dart';
import 'package:dartz/dartz.dart';

class DataSourceImpl implements DataSource {
  final ApiClient _apiClient;

  DataSourceImpl({required apiClient}) : _apiClient = apiClient;
  final getChatModelsEndpoints = 'v1/models';
  final getChatResponseEndpoints = 'v1/chat/completions';

  @override
  Future<Either<Failure, ChatModel>> getChatModel(
      {RequestParams? params}) async {
    var response = await _apiClient.dioGet(path: getChatModelsEndpoints);
    return response.fold((failed) {
      return Left(failed);
    }, (r) {
      return Right(ChatModel.fromJson(r.data));
    });
  }

  @override
  Future<Either<Failure, ChatData>> getChatResponse(
      {required RequestParams params}) async {
    var response =
        await _apiClient.dioPost(path: getChatResponseEndpoints, data: params);
    return response.fold((failed) {
      return Left(failed);
    }, (r) {
      return Right(ChatData.fromJson(r.data));
    });
  }
}
