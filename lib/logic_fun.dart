import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:product_provider_pro/product.dart';

class logic_fun extends ChangeNotifier
{
    Uri url = Uri();
    Map m= {};
    String str_var = "";
    bool search = false;

    //first page
    getData(String string_var) async {
        if(str_var == "")
        {
          url = Uri.https('dummyjson.com','products');
        }
        else
        {
          url = Uri.parse('https://dummyjson.com/products/search?q=$str_var');
        }
          var response = await http.get(url);
          m = jsonDecode(response.body);
          notifyListeners();
          return m;
    }

    //second page
    getData_show(String id)
    async {
        url = Uri.parse('https://dummyjson.com/products/${id}');
        var response = await http.get(url);
        m = jsonDecode(response.body);
        notifyListeners();
        return m;
    }

    serch_cancel()
    {
          str_var="";
          getData(str_var);
          search =! search;
          notifyListeners();
    }
    
    search_open()
    {
          search =! search;
          notifyListeners();
    }
}