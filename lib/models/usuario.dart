class Usuario {
  final int? id;
  final String nombre;
  final String email;
  final String password;
  final String? avatar;

  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.password,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nombre: map['nombre'],
      email: map['email'],
      password: map['password'],
      avatar: map['avatar'],
    );
  }
}
