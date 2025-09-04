// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:github_users_search/Models/user_details.dart';
//
// import '../Repositorys/user_search_repository.dart';
//
// class UserSearchController extends GetxController {
//   final UserSearchRepository repo;
//   UserSearchController(this.repo);
//
//   var users = <UserDetails>[].obs;
//   var isLoading = false.obs;
//   var error = ''.obs;
//
//   Future<void> search(String query) async {
//     if (query.isEmpty) {
//       users.clear();
//       return;
//     }
//     try {
//       isLoading.value = true;
//       error.value = '';
//       final result = await repo.searchUsers(query);
//
//       // 👇 هنا من الأفضل تطبيق السورت
//       users.value = _sortUsers(result);
//       print('controller 🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴');
//       print(users.value);
//     } catch (e) {
//       error.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   List<UserDetails> _sortUsers(List<UserDetails> list) {
//     final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 183));
//
//     list.sort((a, b) {
//       final a50 = a!.publicRepos >= 50;
//       final b50 = b!.publicRepos >= 50;
//       if (a50 != b50) return a50 ? -1 : 1;
//
//       final aActive = a.updatedAt.isAfter(sixMonthsAgo);
//       final bActive = b.updatedAt.isAfter(sixMonthsAgo);
//       if (aActive != bActive) return aActive ? -1 : 1;
//
//       return a.login.compareTo(b.login); // fallback
//     });
//     return list.take(10).toList();
//   }
// }

import 'dart:async';
import 'package:get/get.dart';
import '../Repositorys/user_search_repository.dart';
import '../Models/user_details.dart';

class UserSearchController extends GetxController {
  final UserSearchRepository repo;
  UserSearchController(this.repo);

  var users = <UserDetails>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Timer? _debounce;

  void debounceSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(query);
    });
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      users.clear();
      return;
    }
    try {
      isLoading.value = true;
      error.value = '';
      final result = await repo.searchUsers(query);
      users.value = _sortUsers(result);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<UserDetails> _sortUsers(List<UserDetails> list) {
    final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 183));
    list.sort((a, b) {

      final a50 = a.publicRepos >= 50;

      final b50 = b.publicRepos >= 50;

      if (a50 != b50) return a50 ? -1 : 1;

      final aActive = a.updatedAt.isAfter(sixMonthsAgo);
      final bActive = b.updatedAt.isAfter(sixMonthsAgo);

      if (aActive != bActive) return aActive ? -1 : 1;

      return a.login.compareTo(b.login);
    });
    return list.take(10).toList();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
