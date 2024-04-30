class UserModel {
  String? id;
  String names;
  String lastNames;
  String email;
  String? photo;

  UserModel(
      {this.id,
      required this.names,
      required this.lastNames,
      required this.email,
      this.photo});

  factory UserModel.fromFirebaseJson(Map<String, dynamic> json) => UserModel(
      names: json['nombre'] ?? "",
      lastNames: json['apellidos'] ?? "",
      email: json['email'] ?? "",
      photo: json['photo'] ?? "");

  Map<String, dynamic> toFirebaseJson() =>
      {'nombre': names, 'apellidos': lastNames, 'email': email, 'photo': photo};
}
