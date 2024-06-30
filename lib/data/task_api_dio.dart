import 'package:dio/dio.dart';
import 'task.dart';
import 'task_api.dart';

class DioTaskApi extends TaskApi {
  final Dio _dio;
  final String _baseUrl;
  final String _authToken;

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
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  @override
  Future<void> saveTask(Task task) async {
    try {
      if (task.UUID.isEmpty) {
        await _dio.post('$_baseUrl/list', data: task.toJson());
      } else {
        await _dio.put('$_baseUrl/list/${task.UUID}', data: task.toJson());
      }
    } catch (e) {
      throw Exception('Failed to save task: $e');
    }
  }

  @override
  Future<void> deleteTask(String UUID) async {
    try {
      await _dio.delete('$_baseUrl/list/$UUID');
    } catch (e) {
      throw Exception('Failed to delete task: $e');
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
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  @override
  Future<void> close() async {
    _dio.close();
  }
}
