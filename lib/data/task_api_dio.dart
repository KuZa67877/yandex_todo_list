import 'package:dio/dio.dart';
import '../utils/logger.dart';
import 'task.dart';
import 'task_api.dart';

class DioTaskApi extends TaskApi {
  final Dio _dio;
  final String _baseUrl;
  final String _authToken;
  int revision = 5;

  DioTaskApi({required String baseUrl, required String authToken})
      : _dio = Dio(),
        _baseUrl = baseUrl,
        _authToken = authToken {
    _dio.options.headers['Authorization'] = 'Bearer $_authToken';
  }

  @override
  Stream<List<Task>> getTasks() async* {
    try {
      final response = await _dio.get('$_baseUrl/list');
      if (response.statusCode == 200) {
        final tasks =
            (response.data as List).map((json) => Task.fromJson(json)).toList();
        yield tasks;
      } else {
        logger.d(
            'Error: Failed to load tasks. Response is null or status code is not 200. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        logger.d(
            'Error: Failed to load tasks. DioError: ${e.message}, Status code: ${e.response?.statusCode}');
      } else {
        logger.d('Error: Failed to load tasks: $e');
      }
    }
  }

  @override
  Future<void> saveTask(Task task) async {
    try {
      final headers = {'X-Last-Known-Revision': revision.toString()};

      if (task.UUID.isEmpty) {
        await _dio.post('$_baseUrl/list',
            data: task.toJson(), options: Options(headers: headers));
        revision++;
      } else {
        await _dio.put('$_baseUrl/list/${task.UUID}',
            data: task.toJson(), options: Options(headers: headers));
      }
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
      final headers = {
        'X-Last-Known-Revision': '1'
      }; // Update revision appropriately
      await _dio.delete('$_baseUrl/list/$UUID',
          options: Options(headers: headers));
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
        final tasks =
            (response.data as List).map((json) => Task.fromJson(json)).toList();
        return tasks.where((task) => task.isDone).length;
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
