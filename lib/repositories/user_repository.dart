import 'dart:convert';
import 'package:user_management/models/post.dart';
import 'package:user_management/models/todo.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers(
      {int limit = 10, int skip = 0, String? searchQuery}) async {
    String url;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      url = '$baseUrl/users/search?q=$searchQuery&limit=$limit&skip=$skip';
    } else {
      url = '$baseUrl/users?limit=$limit&skip=$skip';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> usersJson = data['users'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Error fetching users");
    }
  }

  Future<List<Post>> fetchPostsForUser(int userId) async {
    final url = '$baseUrl/posts/user/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final dynamic data = json.decode(response.body);
        List<dynamic> postsJson = [];
        if (data is Map && data.containsKey('posts')) {
          postsJson = data['posts'];
        } else if (data is List) {
          postsJson = data;
        } else {
          return [];
        }

        return postsJson.map((item) => Post.fromJson(item)).toList();
      } catch (e) {
        print('Error parsing posts: $e');
        throw Exception("Parsing error: $e");
      }
    } else {
      throw Exception("Error fetching posts: ${response.statusCode}");
    }
  }

  Future<List<Todo>> fetchTodosForUser(int userId) async {
    final url = '$baseUrl/todos/user/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> todosJson = data['todos'];
      return todosJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception("Error fetching todos");
    }
  }
}
