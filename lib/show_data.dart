import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:product_provider_pro/logic_fun.dart';
import 'package:product_provider_pro/product.dart';
import 'package:provider/provider.dart';

class show_data extends StatelessWidget {
  // const show_data({super.key});

  @override
  Widget build(BuildContext context) {

    product p = ModalRoute.of(context)!.settings.arguments as product;

    return ChangeNotifierProvider(
      create: (context) => logic_fun(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("${p.title}"),
          backgroundColor: Colors.grey,
        ),
        body: Consumer<logic_fun>(
          builder: (context, l2, child) {
            return FutureProvider(
              create: (context) => l2.getData_show("${p.id}"),
              initialData: l2.getData_show("${p.id}"),
              builder: (context, child) {
                // product p =product.fromJson(l2.m);
                List? l = l2.m['images'];
                // print(l);
                if(l!=null)
                {
                    return Column(children: [
                      SizedBox(height: 10,),
                      Center(child: Text("${p.title}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),),
                      SizedBox(height: 10,),
                      Center(child: Container(
                        height: 200,width: 300,
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 0.5,blurRadius: 8,)],
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage("${p.thumbnail}"))
                        ),
                      ),),
                      SizedBox(height: 10,),
                      GFCarousel(
                        height: 350,
                        items: l!.map(
                              (url) {
                            return Container(
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 0.5,blurRadius: 8,)],
                                  shape: BoxShape.rectangle,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black,width: 2)
                              ),
                              margin: EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                    width: 1000.0
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        // onPageChanged: (index) {
                        //   val_index = index;
                        //   setState(() {});
                        //   // setState(() {
                        //   //   index;
                        //   // });
                        // },
                      ),
                      SizedBox(height: 10,),
                      Center(child: SingleChildScrollView(child: Text("${p.description}",style: TextStyle(fontSize: 15,))),),
                      GFRating(
                        size: 50,
                        color: Colors.deepPurple.shade600,
                        value: p.rating,
                        onChanged: (value) {
                            p.rating = value;
                        },
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                        Center(child: Text("Price : ${p.price} ₹",style: TextStyle(fontSize: 25,color: Colors.lightBlue.shade300)),),
                        Center(child: Text("Discount price : ${p.discountPercentage} %",style: TextStyle(fontSize: 16)),)
                      ],),
                      SizedBox(height: 5,),
                      Center(child: Text("Brand : ${p.brand}",style: TextStyle(fontSize: 25)),),
                    ],);
                }
                else
                {
                    return Center(child: CircularProgressIndicator(),);
                }
                // List l = l2.m['images'];
              },
            );
          },
        ),
      ),
    );
  }
}
