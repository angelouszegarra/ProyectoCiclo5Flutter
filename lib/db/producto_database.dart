// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/producto.dart';

class ProductoDatabase {
  static final ProductoDatabase _instance = ProductoDatabase._internal();
  static Database? _database;

  ProductoDatabase._internal();

  factory ProductoDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

Future<Database> _initDatabase() async {
  String path = join(await getDatabasesPath(), 'regadora_app.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: _onCreate,
  ).then((db) {
    return db;
  }).catchError((e) {
    throw e;
  });
}


  Future<void> borrarBaseDeDatos() async {
    String path = join(await getDatabasesPath(), 'regadora_app.db'); // <- Corregido
    await deleteDatabase(path);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabla de productos
    await db.execute('''
      CREATE TABLE productos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        descripcion TEXT NOT NULL,
        precio REAL NOT NULL,
        categoria TEXT NOT NULL,
        subcategoria TEXT NOT NULL,
        imagen TEXT NOT NULL,
        cantidad INTEGER DEFAULT 1
      )
    ''');

    // Tabla de carrito
    await db.execute('''
      CREATE TABLE carrito(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        producto_id INTEGER NOT NULL,
        cantidad INTEGER NOT NULL,
        FOREIGN KEY (producto_id) REFERENCES productos (id)
      )
    ''');

    // Tabla de clientes
    await db.execute('''
      CREATE TABLE clientes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        dni TEXT NOT NULL,
        distrito TEXT NOT NULL,
        direccionInstalacion TEXT NOT NULL,
        telefono TEXT,
        fechaRegistro TEXT NOT NULL
      )
    ''');

    // Insertar datos iniciales
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Planes de regadoras
    await db.insert('productos', {
      'nombre': 'Plan Básico',
      'descripcion': 'Regadora automática para jardín pequeño',
      'precio': 299.0,
      'categoria': 'plan',
      'subcategoria': 'basico',
      'imagen': 'assets/images/plan_basico.png',
      'cantidad': 1,
    });

    await db.insert('productos', {
      'nombre': 'Plan Premium',
      'descripcion': 'Regadora automática con sensores avanzados',
      'precio': 599.0,
      'categoria': 'plan',
      'subcategoria': 'premium',
      'imagen': 'assets/images/plan_premium.png',
      'cantidad': 1,
    });

    // Plantas de interior
    await db.insert('productos', {
      'nombre': 'Pothos Dorado',
      'descripcion': 'Planta perfecta para interiores, requiere poca luz.',
      'precio': 20.0,
      'categoria': 'planta',
      'subcategoria': 'interior',
      'imagen': 'assets/images/pothos.png',
    });

    await db.insert('productos', {
      'nombre': 'Monstera',
      'descripcion': 'Planta de interior muy popular por sus hojas grandes.',
      'precio': 35.0,
      'categoria': 'planta',
      'subcategoria': 'interior',
      'imagen': 'assets/images/monstera.png',
    });

    // Árboles
    await db.insert('productos', {
      'nombre': 'Limonero',
      'descripcion': 'Árbol frutal ideal para jardines soleados.',
      'precio': 45.0,
      'categoria': 'planta',
      'subcategoria': 'árboles',
      'imagen': 'assets/images/limonero.png',
    });

    await db.insert('productos', {
      'nombre': 'Mango',
      'descripcion': 'Árbol frutal tropical, requiere espacio y sol.',
      'precio': 50.0,
      'categoria': 'planta',
      'subcategoria': 'árboles',
      'imagen': 'assets/images/mango.png',
    });

    // Frutas
    await db.insert('productos', {
      'nombre': 'Tomate',
      'descripcion': 'Planta frutal perfecta para huertos caseros.',
      'precio': 25.0,
      'categoria': 'planta',
      'subcategoria': 'frutas',
      'imagen': 'assets/images/tomate.png',
    });

    await db.insert('productos', {
      'nombre': 'Fresa',
      'descripcion': 'Deliciosas fresas para tu jardín o maceta.',
      'precio': 35.0,
      'categoria': 'planta',
      'subcategoria': 'frutas',
      'imagen': 'assets/images/fresa.png',
    });

    // Verduras
    await db.insert('productos', {
      'nombre': 'Lechuga',
      'descripcion': 'Verdura de fácil cultivo en pequeños espacios.',
      'precio': 18.0,
      'categoria': 'planta',
      'subcategoria': 'verduras',
      'imagen': 'assets/images/lechuga.png',
    });

    await db.insert('productos', {
      'nombre': 'Zanahoria',
      'descripcion': 'Verdura saludable, ideal para huertos urbanos.',
      'precio': 22.0,
      'categoria': 'planta',
      'subcategoria': 'verduras',
      'imagen': 'assets/images/zanahoria.png',
    });
  }

  Future<List<Producto>> getProductosPorCategoria(String categoria) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'productos',
      where: 'categoria = ?',
      whereArgs: [categoria],
    );
    return List.generate(maps.length, (i) => Producto.fromMap(maps[i]));
  }
  


  // Métodos para carrito (igual que antes)
  Future<void> agregarAlCarrito(int productoId, int cantidad) async {
    final db = await database;
    var carrito = await db.query(
      'carrito',
      where: 'producto_id = ?',
      whereArgs: [productoId],
    );
    if (carrito.isEmpty) {
      await db.insert('carrito', {
        'producto_id': productoId,
        'cantidad': cantidad,
      });
    } else {
      int cantidadActual = carrito[0]['cantidad'] as int;
      await db.update(
        'carrito',
        {'cantidad': cantidadActual + cantidad},
        where: 'producto_id = ?',
        whereArgs: [productoId],
      );
    }
  }

  Future<List<Producto>> getCarrito() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT p.*, c.cantidad FROM productos p
      INNER JOIN carrito c ON p.id = c.producto_id
    ''');
    return List.generate(maps.length, (i) => Producto.fromMap(maps[i]));
  }

  Future<void> eliminarDelCarrito(int productoId) async {
    final db = await database;
    await db.delete(
      'carrito',
      where: 'producto_id = ?',
      whereArgs: [productoId],
    );
  }

  Future<void> limpiarCarrito() async {
    final db = await database;
    await db.delete('carrito');
  }

  Future<int> registrarCliente({
    required String nombre,
    required String dni,
    required String distrito,
    required String direccionInstalacion,
    String? telefono,
  }) async {
    final db = await database;
    return await db.insert('clientes', {
      'nombre': nombre,
      'dni': dni,
      'distrito': distrito,
      'direccionInstalacion': direccionInstalacion,
      'telefono': telefono,
      'fechaRegistro': DateTime.now().toIso8601String(),
    });
  }
}
