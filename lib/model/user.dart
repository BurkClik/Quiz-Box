class User {
  String name;
  String email;

  User();

  User.map(dynamic obj) {
    this.name = obj['name'];
    this.email = obj['email'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    return map;
  }
}
