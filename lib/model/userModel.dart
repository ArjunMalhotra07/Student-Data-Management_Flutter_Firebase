class User {
  String id, sn, ini, cn, b;
  User(
      {this.id = '',
      required this.sn,
      required this.ini,
      required this.cn,
      required this.b});
  Map<String, dynamic> toJson() =>
      {'Id': id, 'Name': sn, 'Initials': ini, 'College': cn, 'Branch': b};
}
