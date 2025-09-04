import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:github_users_search/Controllers/user_search_controller.dart';
import 'package:github_users_search/Models/user_details.dart';
import 'package:mockito/mockito.dart';

import 'mock_repo.dart'; // MockUserSearchRepository
import 'mock_responses.dart';

void main() {
  late MockUserSearchRepository mockRepo;
  late UserSearchController controller;

  final usersMock = [
    UserDetails(
      login: 'alice',
      avatarUrl: 'https://avatar.com/alice.png',
      company: 'ACME',
      location: 'Earth',
      email: 'alice@example.com',
      publicRepos: 60,
      updatedAt: DateTime.now(),
      name: 'Alice',
    ),
    UserDetails(
      login: 'bob',
      avatarUrl: 'https://avatar.com/bob.png',
      company: 'XYZ',
      location: 'Mars',
      email: 'bob@example.com',
      publicRepos: 20,
      updatedAt: DateTime.now().subtract(const Duration(days: 200)),
      name: 'Bob',
    ),
  ];

  setUp(() {
    mockRepo = MockUserSearchRepository();
    controller = UserSearchController(mockRepo);

    when(mockRepo.searchUsers( any as String))
        .thenAnswer((_) async => usersMock);
  });

  test('search updates users and sorts correctly', () async {
    await controller.search('query');

    expect(controller.users.length, 2);
    expect(controller.users.first.login, 'alice');
    expect(controller.users.last.login, 'bob');
  });

  test('isLoading set correctly', () async {
    final future = controller.search('query');
    expect(controller.isLoading.value, true);

    await future;
    expect(controller.isLoading.value, false);
  });
}
