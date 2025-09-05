// view/screens/add_products.dart

import 'package:entert_projet_01/repository/product_repository.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _form = GlobalKey<FormState>();
  final _productsNameCtrl = TextEditingController();
  final _productsPriceCtrl = TextEditingController();
  String? _productsQualityCtrl;
  final _productsDescriptionCtrl = TextEditingController();
  final _productsUrlCtrl = TextEditingController();

  //function for add products
  Future<void> addProducts() async {
    if (_form.currentState!.validate()) {
      final double price = double.tryParse(_productsPriceCtrl.text) ?? 0.0;
      final String quality = _productsQualityCtrl ?? 'aucun';
      final String description = _productsDescriptionCtrl.text;
      final String produitUrl = _productsUrlCtrl.text;
      ProductRepository product = ProductRepository();

      try {
        await product.addProduit(
          _productsNameCtrl.text,
          produitUrl,
          price,
          description,
          quality,
        );
        setState(() {
          _form.currentState!.reset();
          _productsQualityCtrl = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produit ajouté avec succès'),
            duration: Duration(seconds: 2),
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
  Widget formulaire(TextEditingController ctrl, String type, Color textColor) =>
      TextFormField(
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
          fillColor: ChangeColor().cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            gapPadding: 8,
          ),
          hintText: "Entrez le $type du produit",
          label: Text(type, style: style(12, 1, textColor)),
        ),
      );
  // fin du formulaire

  @override
  Widget build(BuildContext context) {
    final changeColor = Provider.of<ChangeColor>(context);
    final primaryColor = changeColor.primaryColor;
    final textColor = changeColor.textColor;
    final backgroundColor = changeColor.background;
    final secondaryColor = changeColor.secodaryColor;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: changeColor.iconColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: backgroundColor,
        title: Text('Add products', style: style(20, 4, textColor)),
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
                        style: style(12, 2, textColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _productsUrlCtrl,

                        /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ce champ ne peut pas être vide';
                          }

                          return null;
                        },*/
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
                formulaire(_productsNameCtrl, 'nom', textColor), // name form
                SizedBox(height: 20),
                formulaire(_productsDescriptionCtrl, 'description', textColor),
                SizedBox(height: 20),
                formulaire(_productsPriceCtrl, 'prix', textColor), // price form
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
                      color: changeColor.cardColor,
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
