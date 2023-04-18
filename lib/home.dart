import 'dart:convert';

import 'package:api_complexjson/Model/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Products>getProductsApi()async{
    final response=await http.get(Uri.parse('https://webhook.site/2e2b7847-6861-44ef-be2a-d2f28005e7e8'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return Products.fromJson(data);
    }else
      {
        return Products.fromJson(data);
      }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Products>(
                future: getProductsApi(),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
  ListTile(
  title: Text(snapshot.data!.data![index].shop!.name.toString()),
  subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
  leading: CircleAvatar(
  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
  ),
  ),
  Container(
  height: MediaQuery.of(context).size.height *.3,
  width: MediaQuery.of(context).size.width * 1,
  child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: snapshot.data!.data![index].images!.length,
  itemBuilder: (context, position){
  return Padding(
  padding: const EdgeInsets.only(right: 10),
  child: Container(
  height: MediaQuery.of(context).size.height *.25,
  width: MediaQuery.of(context).size.width * .5,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  image: DecorationImage(
  fit: BoxFit.cover,
  image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
  )
  ),
  ),
  );
  }),
  ),
  Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite : Icons.favorite_outline)
                            ],
                          );
                        });
                  }else {
                    return Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
