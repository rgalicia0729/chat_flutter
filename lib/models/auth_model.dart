import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.ok,
    this.usuario,
    this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        ok: json['ok'],
        usuario: Usuario.fromJson(json['usuario']),
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'ok': ok,
        'usuario': usuario.toJson(),
        'token': token,
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
