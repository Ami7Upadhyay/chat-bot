import 'package:ai_chat_bot/core/dio/custom_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var options = BaseOptions(
  baseUrl: 'https://api.openai.com/',
);
CustomInterceptor customInterceptor = CustomInterceptor();
Dio dio = Dio(options)..interceptors.add(CustomInterceptor());
final dioProvider = Provider<Dio>((ref) => dio);
