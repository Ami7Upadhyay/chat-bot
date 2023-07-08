import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/core/request_params/request_params.dart';
import 'package:ai_chat_bot/data_source/data_source.dart';
import 'package:ai_chat_bot/models/chat_data.dart';
import 'package:ai_chat_bot/models/chat_model.dart';
import 'package:ai_chat_bot/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final DataSource _dataSource;
  RepositoryImpl({required DataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<Failure, ChatModel>> getChatModel(
      {RequestParams? params}) async {
    var response = await _dataSource.getChatModel(params: params);
    return response.fold((failed) {
      return Left(failed);
    }, (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, ChatData>> getChatResponse(
      {required RequestParams params}) async {
    var response = await _dataSource.getChatResponse(params: params);
    return response.fold((failed) {
      return Left(failed);
    }, (r) {
      return Right(r);
    });
  }
}
