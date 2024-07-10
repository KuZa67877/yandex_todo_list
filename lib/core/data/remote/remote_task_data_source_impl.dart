import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../../domain/entities/task.dart';
import '../../utils/logger.dart';
import 'remote_task_data_source.dart';

class RemoteTaskDataSourceImpl implements RemoteTaskDataSource {
  final Dio _dio;
  final String _baseUrl;
  final String _authToken;
  late int revision;

  RemoteTaskDataSourceImpl({
    required String baseUrl,
    required String authToken,
  })  : _dio = Dio(),
        _baseUrl = baseUrl,
        _authToken = authToken {
    _dio.options.headers['Authorization'] = 'Bearer $_authToken';
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  Dio get dio => _dio;

  @override
  Stream<List<Task>> getTasks() async* {
    try {
      final response = await _dio.get('$_baseUrl/list');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final tasks = (data['list'] as List)
            .map((json) => Task.fromJson(json as Map<String, dynamic>))
            .toList();
        revision = (data['revision'] as int);
        yield tasks;
      } else {
        logger.e(
            'Error: Failed to load tasks. Response is null or status code is not 200. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        logger.e(
            'Error: Failed to load tasks. DioError: ${e.message}, Status code: ${e.response?.statusCode}. ');
      } else {
        logger.e('Error: Failed to load tasks: $e');
      }
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final headers = {'X-Last-Known-Revision': revision.toString()};
    try {
      final response = await _dio.post(
        '$_baseUrl/list',
        data: {'element': task.toJson()},
        options: Options(headers: headers),
      );
      final data = response.data as Map<String, dynamic>;
      revision = data['revision'] as int;
      logger.d('Task created: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        logger.e(
            'Error: Failed to save task. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.e('Error: Failed to save task: $e');
      }
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      final headers = {'X-Last-Known-Revision': revision.toString()};

      final response = await _dio.put(
        '$_baseUrl/list/${task.id}',
        data: {'element': task.toJson()},
        options: Options(headers: headers),
      );
      final data = response.data as Map<String, dynamic>;
      revision = data['revision'] as int;
      logger.d('Task updated: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        logger.e(
            'Error: Failed to save task. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.e('Error: Failed to save task: $e');
      }
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      final headers = {'X-Last-Known-Revision': revision.toString()};
      final response = await _dio.delete(
        '$_baseUrl/list/$id',
        options: Options(headers: headers),
      );
      final data = response.data as Map<String, dynamic>;
      revision = data['revision'] as int;
      logger.d('Task deleted: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        logger.e(
            'Error: Failed to delete task. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.e('Error: Failed to delete task: $e');
      }
    }
  }

  @override
  Future<void> patchTasks(List<Task> tasks) async {
    final headers = {'X-Last-Known-Revision': revision.toString()};
    try {
      final response = await _dio.patch(
        '$_baseUrl/list',
        data: {
          'list': tasks.map((task) => task.toJson()).toList(),
        },
        options: Options(headers: headers),
      );
      final data = response.data as Map<String, dynamic>;
      revision = data['revision'] as int;
      logger.d('Tasks patched: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        logger.e(
            'Error: Failed to patch tasks. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.e('Error: Failed to patch tasks: $e');
      }
    }
  }
}
