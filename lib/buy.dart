import 'dart:convert';

import 'package:bactapp/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  String url = "https://htsy2019.000webhostapp.com/bact/api/buy.php";
  var item = [];
  Future alloffer() async {
    var res = await http.get(Uri.parse(url));
    var data = jsonDecode(res.body);
    setState(() {
      item = data;
    });
  }

  @override
  void initState() {
    alloffer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy Offers',
          style: TextStyle(color: Color(0xFFB99350), fontSize: 30.0),
        ),
        centerTitle: true,
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/logo.png'),
          backgroundColor: Color(0xFF1A2036),
          maxRadius: 22.0,
        ),
        backgroundColor: Color(0xFF1A2036),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: item.length,
          itemBuilder: (context, i) {
            return listitem(item[i]['companyname'], item[i]['type'],
                item[i]['logo'], item[i]['id']);
          },
        ),
      ),
    );
  }

  Widget listitem(String companyname, String type, String img, String id) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Details(id)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB99350)),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 3,
                color: Color(0xFFB99350),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(2),
            child: ListTile(
              title: Text(
                companyname,
                style: TextStyle(fontSize: 25, color: Color(0xFF1A2036)),
              ),
              subtitle: Text(
                type,
                style: TextStyle(fontSize: 18, color: Color(0xFF1A2036)),
              ),
              leading: Image(
                image: NetworkImage(
                    "https://htsy2019.000webhostapp.com/bact/admin/uploads/" +
                        img),
                width: 80,
                height: 80,
              ),
              trailing: Icon(
                Icons.arrow_right,
                size: 28,
                color: Color(0xFF1A2036),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
