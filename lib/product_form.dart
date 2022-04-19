import 'dart:math';

import 'package:flutter/material.dart';

import 'package:shopapp/model/product_item.dart';

class ProductForm extends StatefulWidget {
  static const routerName = '/product_form';
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ProductItem _productItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Object? productItem = ModalRoute.of(context)?.settings.arguments;
    if (productItem != null && productItem is ProductItem) {
      _productItem = ProductItem(
        id: productItem.id,
        name: productItem.name,
        imageUrl: productItem.imageUrl,
        description: productItem.description,
        price: productItem.price,
        quantity: productItem.quantity,
        isFavorite: productItem.isFavorite,
      );
    }else {
      _productItem = ProductItem(
        id: '',
        name: '',
        imageUrl: '',
        description: '',
        price: 0,
        quantity: 0,
        isFavorite: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Form'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();
                  Navigator.pop(context, _productItem);
                }
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _productItem.name,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productItem.name = value;
                  },
                ),
                TextFormField(
                  initialValue: _productItem.description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productItem.description = value;
                  },
                ),
                TextFormField(
                  initialValue: _productItem.price != null
                      ? _productItem.price.toString()
                      : '',
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Please enter some text';
                    }
                    if (double.tryParse(value ?? '') == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productItem.price = double.parse(value ?? '0');
                  },
                ),
                ImagePreview(
                  imageUrl: _productItem.imageUrl,
                  onImageSaved: (image) {
                    _productItem.imageUrl = image;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class ImagePreview extends StatefulWidget {
  final String? imageUrl;
  final void Function(String?)? onImageSaved;
  const ImagePreview({
    Key? key,
    this.imageUrl,
    this.onImageSaved,
  }) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  String? localImageUrl;

  @override
  void initState() {
    localImageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: localImageUrl != null
              ? Image.network(
            // 'https://picsum.photos/250?image=9',
            localImageUrl!,
            fit: BoxFit.cover,
          )
              : const Text('No image'),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: TextFormField(
            initialValue: widget.imageUrl,
            decoration: const InputDecoration(
              labelText: 'Image URL',
            ),
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Please enter some text';
              }
              String pattern =
                  r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
              RegExp regExp = RegExp(pattern);
              if (regExp.hasMatch(value!) == false) {
                return 'Please enter a valid URL';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                localImageUrl = value;
              });
            },
            onSaved: (value) {
              widget.onImageSaved?.call(value);
            },
          ),
        ),
      ],
    );
  }
}
