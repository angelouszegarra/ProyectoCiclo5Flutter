import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../models/producto.dart';

class AppState extends ChangeNotifier {
  Usuario? _usuario;
  List<Producto> _carrito = [];

  Usuario? get usuario => _usuario;
  List<Producto> get carrito => _carrito;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void limpiarUsuario() {
    _usuario = null;
    notifyListeners();
  }

  void setCarrito(List<Producto> productos) {
    _carrito = productos;
    notifyListeners();
  }

  void agregarAlCarrito(Producto producto) {
    _carrito.add(producto);
    notifyListeners();
  }

  void limpiarCarrito() {
    _carrito.clear();
    notifyListeners();
  }
}
