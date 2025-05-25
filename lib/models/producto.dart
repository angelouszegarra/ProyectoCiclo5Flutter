class Producto {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String categoria; // 'plan', 'planta', 'semilla'
  final String subcategoria; // 'basico', 'premium', 'frutales', 'interior', etc.
  final String imagen;
  int cantidad;

  Producto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    required this.subcategoria,
    required this.imagen,
    this.cantidad = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'categoria': categoria,
      'subcategoria': subcategoria,
      'imagen': imagen,
      'cantidad': cantidad,
    };
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      precio: map['precio'],
      categoria: map['categoria'],
      subcategoria: map['subcategoria'],
      imagen: map['imagen'],
      cantidad: map['cantidad'] ?? 1,
    );
  }
}

class Cliente {
  final int? id;
  final String nombre;
  final String dni;
  final String distrito;
  final String direccionInstalacion;
  final String? telefono;
  final DateTime fechaRegistro;

  Cliente({
    this.id,
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
      'nombre': nombre,
      'dni': dni,
      'distrito': distrito,
      'direccionInstalacion': direccionInstalacion,
      'telefono': telefono,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nombre: map['nombre'],
      dni: map['dni'],
      distrito: map['distrito'],
      direccionInstalacion: map['direccionInstalacion'],
      telefono: map['telefono'],
      fechaRegistro: DateTime.parse(map['fechaRegistro']),
    );
  }
}
