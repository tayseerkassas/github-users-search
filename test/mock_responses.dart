// test/mock_responses.dart

final mockSearchUsersResponse = {
  "total_count": 1,
  "incomplete_results": false,
  "items": [
    {
      "login": "john",
      "id": 12345,
      "avatar_url": "https://avatars.githubusercontent.com/u/12345?v=4",
      "html_url": "https://github.com/john",
      "type": "User",
      "score": 1.0
    }
  ]
};

final mockUserDetailsResponse = {
  "login": "john",
  "id": 12345,
  "avatar_url": "https://avatars.githubusercontent.com/u/12345?v=4",
  "html_url": "https://github.com/john",
  "type": "User",
  "name": "John Doe",
  "company": "OpenAI",
  "blog": "https://johndoe.dev",
  "location": "Earth",
  "email": "john@example.com",
  "hireable": true,
  "bio": "Software Developer",
  "twitter_username": "john_dev",
  "public_repos": 42,
  "public_gists": 10,
  "followers": 100,
  "following": 50,
  "created_at": "2011-01-25T18:44:36Z",
  "updated_at": "2025-09-01T15:32:00Z"
};
