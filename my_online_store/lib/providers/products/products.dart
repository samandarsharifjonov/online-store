import 'package:flutter/cupertino.dart';
import '../../models/product_model.dart';

class Products with ChangeNotifier {
  final List<Product> _list = [
    Product(
        id: "s1",
        title: "MacBook pro 13",
        description:
            "The new M2 chip makes the 13‑inch MacBook Pro more capable than ever. The same compact design supports up to 20 hours of battery life1 and an active cooling system to sustain enhanced performance. Featuring a brilliant Retina display, a FaceTime HD camera, and studio‑quality mics, it’s our most  pro laptop.",
        imgUrl:
            "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fG1hY2Jvb2slMjBwcm98ZW58MHx8MHx8fDA%3D",
        price: 2150.25),
    Product(
        id: "s2",
        title: "Apple Watch",
        description: "Ajoyib apple watch ",
        imgUrl:
            "https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXBwbGUlMjB3YXRjaHxlbnwwfHwwfHx8MA%3D%3D",
        price: 854.8),
    Product(
        id: "s3",
        title: "iPhone 15 pro max",
        description: "Iphone 15 pro max 256GB",
        imgUrl:
            "https://images.unsplash.com/photo-1695048064926-4da0dd8259d1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGlwaG9uZSUyMDE1fGVufDB8fDB8fHww",
        price: 1250.25),
    Product(
        id: "s4",
        title: "iPad",
        description: "iPad Pro judayam qulay va sifatli apple maxsuloti",
        imgUrl:
            "https://images.unsplash.com/photo-1587033411391-5d9e51cce126?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aVBhZHxlbnwwfHwwfHx8MA%3D%3D",
        price: 1050.10),
    Product(
        id: "s5",
        title: "airPods",
        description: "Apple tomonidan ishlab chiqilgan judayam ajoyib AirPods ",
        imgUrl:
            "https://images.unsplash.com/photo-1588940086836-36c7d89611a0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YXBwbGUlMjBhaXJQb2RzfGVufDB8fDB8fHww",
        price: 310.40),
    Product(
        id: "s6",
        title: "iPhone 14 Pro",
        description: "iPhone 14, 128GB, Grey, ",
        imgUrl:
            "https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGlwaG9uZSUyMDE0fGVufDB8fDB8fHww",
        price: 830.50),
  ];

  List<Product> get list {
    return [..._list];
  }

  List<Product> favorites() {
    return _list.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
        id: UniqueKey().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imgUrl: product.imgUrl);
    _list.add(newProduct);
    notifyListeners();
  }

  void updatedProduct(Product updatedProduct){
    final productIndex = _list.indexWhere((element) => element.id == updatedProduct.id);
    if(productIndex >= 0){
      _list[productIndex] = updatedProduct;
      notifyListeners();
    }

  }

  Product findById(String productId) {
    return _list.firstWhere((element) => element.id == productId);
  }

  void deleteProduct(String id){
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
