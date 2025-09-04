import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:dio/dio.dart';
import 'package:github_users_search/Models/user_details.dart';



class UserSearchRepository {
  final Dio _dio;
  final Map<String, UserDetails> _cache = {}; // 🟢 كاش للمستخدمين

  UserSearchRepository(this._dio);

  Future<List<UserDetails>> searchUsers(String query) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/search/users',
        queryParameters: {'q': query},
        options: Options(
          headers: {
            'Authorization': 'Bearer ***************',
          },
        ),
      );

      final items = response.data['items'] as List<dynamic>;

      final users = await Future.wait(
        items.map((item) async {
          final login = item['login'];
          if (_cache.containsKey(login)) {
            return _cache[login]!;
          } else {
            final details = await getUserDetails(login);
            _cache[login] = details; // خزّنه في الكاش

            return details;
          }

        }),
      );

      return users;
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  Future<UserDetails> getUserDetails(String username) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/users/$username',
        options: Options(
          headers: {
            'Authorization': 'Bearer *********',
          },
        ),
      );
      return UserDetails.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user details for $username: $e');
    }
  }
}
