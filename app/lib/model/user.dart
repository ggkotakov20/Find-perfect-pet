class User{
  int id;
  String first_name;
  String last_name;
  String phone;
  String email;
  String password;

  User(this.id,this.first_name,this.last_name,this.phone,this.email,this.password);

  factory User.fromJson(Map<String, dynamic> json) => User(
    int.parse(json['id']),
    json['first_name'],
    json['last_name'],
    json['phone'],
    json['email'],
    json['password']
  );

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'first_name': first_name,
    'last_name': last_name,
    'phone': phone,
    'email': email,
    'password': password,
  };
}