// pages/screens/add_products.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _db = FirebaseFirestore.instance;
  final _form = GlobalKey<FormState>();
  final _productsNameCtrl = TextEditingController();
  final _productsPriceCtrl = TextEditingController();
  String? _productsQualityCtrl;
  final _productsDescriptionCtrl = TextEditingController();
  final _productsUrlCtrl = TextEditingController();
  //function for add products
  Future<void> addProducts() async {
    if (_form.currentState!.validate()) {
      final product = ProductModel(
        name: _productsNameCtrl.text,
        price: double.tryParse(_productsPriceCtrl.text) ?? 0.0,
        quality: _productsQualityCtrl ?? 'aucun',
        description: _productsDescriptionCtrl.text,
        produitUrl: _productsUrlCtrl.text,
      );
      try {
        await _db.collection('Products').add(product.toMap());
         
        _form.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produit ajouté avec succès'),
            duration: Duration(seconds: 800),
          ),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("erreur d'jout du document")));
      }
    }
  }

  //end function add products

  // formulaire pour le textEditing form du nom, du prix/description
  Widget formulaire(TextEditingController ctrl, String type) => TextFormField(
    controller: ctrl,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'ce champ ne peut pas être vide';
      }
      if (type == 'nom' && value.length < 3) {
        return 'Le nom doit être 3 caractères ';
      }
      if (type == 'prix') {
        final double? tryParse = double.tryParse(value);
        if (tryParse == null || tryParse.isNegative) {
          return 'entrez un prix corect';
        }
      }
      return null;
    },
    keyboardType:
        type == 'prix'
            ? TextInputType.numberWithOptions(decimal: true)
            : type == 'description'
            ? TextInputType.multiline
            : TextInputType.text,
    decoration: InputDecoration(
      constraints: BoxConstraints(),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        gapPadding: 8,
      ),
      hintText: "Entrez le $type du produit",
      label: Text(type, style: style(12, 1)),
    ),
  );
  // fin du formulaire

  @override
  void dispose() {
    _productsDescriptionCtrl.dispose();
    _productsNameCtrl.dispose();
    _productsPriceCtrl.dispose();

    _productsUrlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Add products', style: style(20, 4)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                // begin of form of editing products's pictures
                Container(
                  // width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    left: 12,
                    right: 12,
                  ),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_sharp,
                        color: secondaryColor,
                        size: 32,
                      ),
                      Text(
                        'Choisir une photo\n ou ',
                        style: style(12, 2),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _productsUrlCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ce champ ne peut pas être vide';
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(left: 50, right: 50),
                          hintText: "Entrez l'url de la photo du produit",
                        ),
                      ),
                    ],
                  ),
                ),
                // end of form of editing products's pictures
                formulaire(_productsNameCtrl, 'nom'), // name form
                SizedBox(height: 20),
                formulaire(_productsDescriptionCtrl, 'description'),
                SizedBox(height: 20),
                formulaire(_productsPriceCtrl, 'prix'), // price form
                SizedBox(height: 20),

                DropdownButtonFormField(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  hint: Text('Quelle est la qualité du produit'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  value: _productsQualityCtrl,
                  items: [
                    DropdownMenuItem(value: 'medium', child: Text('medium')),
                    DropdownMenuItem(value: 'high', child: Text('high')),
                    DropdownMenuItem(
                      value: 'very high',
                      child: Text('very high'),
                    ),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      _productsQualityCtrl = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Choississez une qualité valide';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 12,
                    ),
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () async {
                    await addProducts();
                  },

                  child: Text(
                    'Add Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
