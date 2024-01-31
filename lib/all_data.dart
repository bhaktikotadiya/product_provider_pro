import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_provider_pro/logic_fun.dart';
import 'package:product_provider_pro/product.dart';
import 'package:product_provider_pro/show_data.dart';
import 'package:provider/provider.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "first",
      routes: {
        "first" : (context) => first(),
        "second" : (context) => show_data(),
      },
      // home: first(),
    ));
}
class first extends StatelessWidget {
  // const first({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: ChangeNotifierProvider(
      create: (context) => logic_fun(),
      child: Consumer<logic_fun>(
        builder: (context, l1, child) {
          return SafeArea(
            child: Scaffold(
                appBar: (l1.search)?AppBar(
                  title: TextField(
                    decoration: InputDecoration(hintText: "Search"),
                    onChanged: (value) {
                      l1.str_var = value;
                    },),
                  backgroundColor: Colors.grey,
                  actions: [
                    IconButton(onPressed: (){
                      l1.serch_cancel();
                    }, icon: Icon(Icons.cancel))
                  ],
                ):AppBar(
                  title: Text("PRODUCT"),
                  backgroundColor: Colors.grey,
                  actions: [
                    IconButton(onPressed: (){
                      l1.search_open();
                    }, icon: Icon(Icons.search))
                  ],
                ),
                body: Consumer<logic_fun>(
                  builder: (context, l1, child) {
                    return FutureProvider(
                      create: (context) => l1.getData(l1.str_var),
                      initialData: l1.getData(l1.str_var),
                      builder: (context, child) {
                        // print("${l1.m['products']}");
                        List? l = l1.m['products'] as List?;
                        // print("${l}");
                        if(l!=null)
                        {
                          return ListView.builder(
                            itemCount: l.length,
                            itemBuilder: (context, index) {

                              // print("${jsonEncode(l[index])}"); //Map
                              product s = product.fromJson(l[index]);
                              // print("s = ${s}");
                              List <bool> temp=List.filled(l.length, false);

                              return Card(
                                child: GestureDetector(
                                  onTapUp: (details) {
                                    temp[index] = false;
                                  },
                                  onTapCancel: () {
                                    temp[index] = false;
                                  },
                                  onTapDown: (details) {
                                    temp[index] = true;
                                  },
                                  child: ListTile(
                                    onTap: () => Navigator.pushNamed(context, "second" ,arguments: s),
                                    tileColor: (temp[index]==true)?Colors.grey.shade900:null,
                                    title: Text("${s.title}",style: TextStyle(fontSize: 17)),
                                    subtitle: Text("${s.description}",maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis),
                                    trailing: Text("${s.price} ₹"),
                                    leading: CircleAvatar(backgroundColor: Colors.black,backgroundImage: NetworkImage("${s.thumbnail}",)),
                                  ),
                                ),
                              );

                            },
                          );
                        }
                        else
                        {
                          return Center(child: CircularProgressIndicator(),);
                        }
                      },
                    );
                  },
                )
            ),
          );
        },
      ),
    ),
        onWillPop: () async{
          exit(0);
          // return true;
        },
    );
  }
}
