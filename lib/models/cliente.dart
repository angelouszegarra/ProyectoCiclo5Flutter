class Cliente {
  final int? id;
  final int usuarioId;
  final String nombre;
  final String dni;
  final String distrito;
  final String direccionInstalacion;
  final String? telefono;
  final String fechaRegistro;

  Cliente({
    this.id,
    required this.usuarioId,
    required this.nombre,
    required this.dni,
    required this.distrito,
    required this.direccionInstalacion,
    this.telefono,
    required this.fechaRegistro,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId,
      'nombre': nombre,
      'dni': dni,
      'distrito': distrito,
      'direccionInstalacion': direccionInstalacion,
      'telefono': telefono,
      'fechaRegistro': fechaRegistro,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      usuarioId: map['usuario_id'],
      nombre: map['nombre'],
      dni: map['dni'],
      distrito: map['distrito'],
      direccionInstalacion: map['direccionInstalacion'],
      telefono: map['telefono'],
      fechaRegistro: map['fechaRegistro'],
    );
  }
}
