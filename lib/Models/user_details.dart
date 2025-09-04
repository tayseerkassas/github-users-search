
class UserDetails {
  final String login;
  final String name;
  final String avatarUrl;
  final String company;
  final String location;
  final String email;
final int publicRepos;
final DateTime  updatedAt;

  UserDetails({
 required this.login,
 required this.avatarUrl,
  required this.name,
required this.company,
required this.location,
required this.email,
  required this.publicRepos,
    required this.updatedAt,
  });

  //
  factory UserDetails.fromJson(Map<String, dynamic> json) {

    return UserDetails(

        login: (json['login'] as String),
        name: (json['name'] as String?) ?? '',
        avatarUrl: (json['avatar_url'] as String?) ?? '',
        company: (json['company'] as String?) ?? '',
        location: (json['location'] as String?) ?? '',
        email: (json['email'] as String? ) ?? '',
        publicRepos: (json['public_repos'] as num?)?.toInt() ?? 0,
        updatedAt:   parse_date( json['updated_at'])
    );

  }

  static DateTime parse_date(Object v) {
    if (v is String)
    {  final dt = DateTime.tryParse(v);

      if (dt != null)
      {return dt.toUtc();}

    }

    return  DateTime.utc(1980, 1 ,1);
  }

}