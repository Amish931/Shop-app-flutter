import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';
  // final String title;
  // ProductDetailScreen(this.title);
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProducts = Provider.of<Products>(context     //listener
    ,listen: false)      //listen is by default true 
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
      body: SingleChildScrollView(child: Column(children: [
        Container(
          height:300,
          width:double.infinity,
          child:Image.network(loadedProducts.imageUrl,fit:BoxFit.cover),
        ),
        SizedBox(height:10),
        Text("\$${loadedProducts.price}",style: TextStyle(color: Colors.grey,fontSize: 20),),
        SizedBox(height:10),
        Container(width: double.infinity,padding: EdgeInsets.all(10),
          child: Text(loadedProducts.description,textAlign: TextAlign.center,softWrap: true,))//softwrap means that if there is no more space it will add to the next line
      ],),)
    );
  }
}
