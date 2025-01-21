class LinkMailServerRequest {
  final String name;
  final String user;
  final String password;
  final String host;
  final int port;
  final bool tls;

  const LinkMailServerRequest({
    required this.name,
    required this.user,
    required this.password,
    required this.host,
    required this.port,
    required this.tls,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user': user,
      'password': password,
      'host': host,
      'port': port,
      'tls': tls,
    };
  }

  factory LinkMailServerRequest.fromJson(Map<String, dynamic> json) {
    return LinkMailServerRequest(
      name: json['name'],
      user: json['user'],
      password: json['password'],
      host: json['host'],
      port: json['port'],
      tls: json['tls'],
    );
  }
}
