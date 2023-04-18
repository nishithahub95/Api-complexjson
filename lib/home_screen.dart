import 'dart:convert';

import 'package:api_complexjson/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel>userList=[];

  Future<List<UserModel>>getUserApi()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;

    }else{
      return userList;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
             Expanded(
               child: FutureBuilder(
                   future: getUserApi(),
                   builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
                 if(!snapshot.hasData){
                   return Center(child: CircularProgressIndicator());
                 }
                 else{
                   return ListView.builder(
                       itemCount: userList.length,
                       itemBuilder: (context,index){
                         return Card(
                           child: Column(
                             children: [
                              NewRow(name: 'Name:- ', value: snapshot.data![index].name.toString()),
                               NewRow(name: 'UserName:- ', value: snapshot.data![index].username.toString()),
                               NewRow(name: 'Email:- ', value: snapshot.data![index].email.toString()),
                               NewRow(name: 'Address:- ', value: snapshot.data![index].address!.geo!.lat.toString())
                             ],
                           ),
                         );
                       });
                 }

               }),
             )

        ],
      ),
    );
  }
}
class NewRow extends StatelessWidget {
  String name,value;
NewRow({Key? key,required this.name,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
          Text(value)
        ],
      ),
    );
  }
}
