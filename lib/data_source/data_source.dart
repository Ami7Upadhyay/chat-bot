import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/core/request_params/request_params.dart';
import 'package:ai_chat_bot/data_source/data_source_impl.dart';
import 'package:ai_chat_bot/models/chat_data.dart';
import 'package:ai_chat_bot/models/chat_model.dart';
import 'package:ai_chat_bot/services/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataSourceProvider = Provider<DataSource>(
    (ref) => DataSourceImpl(apiClient: ref.watch(apiClientProvider)));

abstract class DataSource {
  Future<Either<Failure, ChatData>> getChatResponse(
      {required RequestParams params});
  Future<Either<Failure, ChatModel>> getChatModel({RequestParams? params});
}
