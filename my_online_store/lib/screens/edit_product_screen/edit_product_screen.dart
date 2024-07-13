import 'package:flutter/material.dart';
import 'package:my_shop/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../providers/products/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routName = "/edit-product";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imgForm = GlobalKey<FormState>();

  var _product =
      Product(id: "", title: "", description: "", price: 0.0, imgUrl: "");

  bool _init = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      //print(productId);
      if (productId != null) {
        final _editingProduct =
            Provider.of<Products>(context).findById(productId.toString());
        _product = _editingProduct;
      }
    }
    _init = false;
  }

  void saveForm() {
    final isValidate = _form.currentState!.validate();
    if (isValidate && _product.imgUrl!.isNotEmpty) {
      _form.currentState!.save();
      if (_product.id.isEmpty) {
        Provider.of<Products>(context, listen: false).addProduct(_product);
      } else {
        Provider.of<Products>(context, listen: false).updatedProduct(_product);
      }
      Navigator.of(context).pop();
    } else if (_product.imgUrl!.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(const MaterialBanner(
          content: Text(
            "Rasim URL-ni kiriting!",
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            Icon(
              Icons.error,
              color: Colors.red,
            )
          ]));
      Future.delayed(const Duration(seconds: 2)).then(
          (value) => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
    }
  }

  void saveImgForm() {
    final validate = _imgForm.currentState!.validate();
    if (validate) {
      _imgForm.currentState!.save();
      setState(() {});
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(
          const MaterialBanner(content: Text("Rasim qo'shildi"), actions: [
        Icon(
          Icons.check_circle,
          color: Colors.green,
        )
      ]));
      Future.delayed(const Duration(seconds: 2)).then(
          (value) => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
    }
  }

  void showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Rasim linkini kiriting!"),
          content: Form(
            key: _imgForm,
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Rasim URL-ni kiriting!",
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.url,
              onSaved: (newValue) {
                _product = Product(
                    id: _product.id,
                    title: _product.title,
                    description: _product.description,
                    price: _product.price,
                    imgUrl: newValue!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Rasim URL-ni kiriting!!";
                } else if (value.length < 10) {
                  return "To'g'iri URL kiriting!";
                } else if (!value.startsWith("https://")) {
                  return "Xatolik sodir bo'ldi, qayta urining!";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Bekor qilish")),
            TextButton(
                onPressed: () {
                  saveImgForm();
                },
                child: const Text("Saqlash"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Maxsulot qo'shish",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                saveForm();
              },
              child: const Text(
                "Saqlash",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: const InputDecoration(
                      labelText: "Nomi", border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) {
                    _product = Product(
                        id: _product.id,
                        title: newValue!,
                        description: _product.description,
                        price: _product.price,
                        imgUrl: _product.imgUrl,
                        isFavorite: _product.isFavorite);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot nomini kiriting!";
                    } else if (value.length < 4) {
                      return "Kamida 4 ta harif kiriting! ";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product.price.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Narxi", border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) {
                    _product = Product(
                        id: _product.id,
                        title: _product.title,
                        description: _product.description,
                        price: double.parse(newValue!),
                        imgUrl: _product.imgUrl,
                      isFavorite: _product.isFavorite
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mahsulot narxini kiriting!";
                    } else if (double.parse(value) < 1) {
                      return "Mahsulot narxi 0 dan katta bo'lishi kerak!";
                    } else if (double.tryParse(value) == null) {
                      return "Iltimos to'g'ri narx kiriting!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product.description,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Qo'shimcha ma'luot",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    _product = Product(
                        id: _product.id,
                        title: _product.title,
                        description: newValue!,
                        price: _product.price,
                        imgUrl: _product.imgUrl,
                      isFavorite: _product.isFavorite

                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mahsulot tarifini kiriting!";
                    } else if (value.length < 20) {
                      return "Iltimos ko'proq ma'lumot kiriting!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.grey)),
                  child: InkWell(
                    onTap: () {
                      showImageDialog(context);
                    },
                    splashColor: Colors.teal,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: _product.imgUrl!.isEmpty
                          ? const Text("Rasim URL-ni kiriting")
                          : Image.network(
                              _product.imgUrl!,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
