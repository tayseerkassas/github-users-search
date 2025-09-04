import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import '../lib/Repositorys/user_search_repository.dart';
import '../lib/Models/user_details.dart';
import 'mock.mocks.dart';

void main() {
  late UserSearchRepository repo;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repo = UserSearchRepository(mockDio);
  });

  test('searchUsers returns list of UserDetails', () async {
    final fakeSearchResponse = Response(
      requestOptions: RequestOptions(path: '/search/users'),
      data: {
        'items': [
          {'login': 'john'}
        ]
      },
      statusCode: 200,
    );

    final fakeUserResponse = Response(
      requestOptions: RequestOptions(path: '/users/john'),
      data: {
        'login': 'john',
        'avatar_url': 'https://avatar.com/john.png',
        'company': 'ACME',
        'location': 'Earth',
        'email': 'john@example.com',
        'public_repos': 10,
        'updated_at': '2025-01-01T00:00:00Z',
        'name': 'John'
      },
      statusCode: 200,
    );

    when(mockDio.get(
      contains('/search/users') as String?,
      queryParameters: anyNamed('queryParameters'),
      options: anyNamed('options'),
    )).thenAnswer((_) async => fakeSearchResponse);

    // user details API
    when(mockDio.get(
      contains('/users/john') as String?,
      options: anyNamed('options'),
    )).thenAnswer((_) async => fakeUserResponse);

    final users = await repo.searchUsers('john');

    expect(users.length, 1);
    expect(users.first.login, 'john');
    expect(users.first.publicRepos, 10);
  });
}
