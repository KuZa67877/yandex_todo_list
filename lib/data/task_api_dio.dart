import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import '../utils/logger.dart';
import 'task.dart';
import 'task_api.dart';

class DioTaskApi extends TaskApi {
  final Dio _dio;
  final String _baseUrl;
  final String _authToken;
  late int revision;

  DioTaskApi({required String baseUrl, required String authToken})
      : _dio = Dio(),
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
        logger.d(
            'Error: Failed to load tasks. Response is null or status code is not 200. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        logger.d(
            'Error: Failed to load tasks. DioError: ${e.message}, Status code: ${e.response?.statusCode}. ');
      } else {
        logger.d('Error: Failed to load tasks: $e');
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
        logger.d(
            'Error: Failed to save task. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.d('Error: Failed to save task: $e');
      }
    }
  }

  @override
  Future<void> saveTask(Task task) async {
    try {
      final headers = {'X-Last-Known-Revision': revision.toString()};

      final response = await _dio.put(
        '$_baseUrl/list/${task.UUID}',
        data: {'element': task.toJson()},
        options: Options(headers: headers),
      );
      final data = response.data as Map<String, dynamic>;
      revision = data['revision'] as int;
      logger.d('Task updated: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        logger.d(
            'Error: Failed to save task. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.d('Error: Failed to save task: $e');
      }
    }
  }

  @override
  Future<void> deleteTask(String UUID) async {
    try {
      final headers = {'X-Last-Known-Revision': revision.toString()};
      final response = await _dio.delete(
        '$_baseUrl/list/$UUID',
        options: Options(headers: headers),
      );
      final data = response.data as Map<String, dynamic>;
      revision = data['revision'] as int;
      logger.d('Task deleted: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        logger.d(
            'Error: Failed to delete task. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.d('Error: Failed to delete task: $e');
      }
    }
  }

  @override
  Future<int> complitedTaskCount() async {
    try {
      final response = await _dio.get('$_baseUrl/list');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        revision = data['revision'] as int;
        final tasks = (data['list'] as List)
            .map((json) => Task.fromJson(json as Map<String, dynamic>))
            .toList();
        return tasks.where((task) => task.done == true).length;
      } else {
        logger.d(
            'Error: Failed to load tasks. Response is null or status code is not 200. Status code: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      if (e is DioException) {
        logger.d(
            'Error: Failed to load tasks. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.d('Error: Failed to load tasks: $e');
      }
      return 0;
    }
  }

  @override
  Future<void> close() async {
    _dio.close();
  }
}
