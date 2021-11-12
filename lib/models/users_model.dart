import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel({
    this.ok,
    this.usuarios,
  });

  bool ok;
  List<Usuario> usuarios;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        ok: json['ok'],
        usuarios: List<Usuario>.from(
            json['usuarios'].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'ok': ok,
        'usuarios': List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}

class Usuario {
  Usuario({
    this.name,
    this.email,
    this.online,
    this.id,
  });

  String name;
  String email;
  bool online;
  String id;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        name: json['name'],
        email: json['email'],
        online: json['online'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'online': online,
        'id': id,
      };
}
