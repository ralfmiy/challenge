import 'package:challenge/model/api/api_response.dart';
import 'package:challenge/model/media.dart';
import 'package:challenge/view/widgets/player_list_widget.dart';
import 'package:challenge/view/widgets/player_widget.dart';
import 'package:challenge/view_model/media_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../model/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List<Media>? mediaList = apiResponse.data as List<Media>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: PlayerListWidget(mediaList!, (Media media) {
                Provider.of<MediaViewModel>(context, listen: false)
                    .setSelectedMedia(media);
              }),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PlayerWidget(
                  function: () {
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search the song by Artist'),
        );
    }
  }

  // final List<ProductModel> products = [
  //   ProductModel(
  //     title: 'Producto 1',
  //     price: '\$10',
  //     brand: 'Marca 1',
  //     description: 'Descripción del Producto 1',
  //     stock: 5,
  //   ),
  //   ProductModel(
  //     title: 'Producto 2',
  //     price: '\$15',
  //     brand: 'Marca 2',
  //     description: 'Descripción del Producto 2',
  //     stock: 3,
  //   ),
  //   // Agrega más productos aquí...
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Título del Producto'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Listado de imágenes
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Número de imágenes
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  color: Colors.grey,
                  // Aquí puedes cargar las imágenes desde una fuente externa
                  // utilizando el widget Image.network()
                );
              },
            ),
          ),
          // Descripción del producto
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Descripción del producto',
              style: TextStyle(fontSize: 16),
            ),
          ),
          // Precio del producto
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Precio: \$99.99',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica para agregar al carrito
        },
        label: Text('Agregar al carrito'),
        icon: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  
  }
}
