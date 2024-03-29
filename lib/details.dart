import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_restapi/editdata.dart';
import 'package:latihan_restapi/main.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Details extends StatefulWidget {
  List list;
  int index;
  Details({required this.list, required this.index});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void delete() {
    var url =
        Uri.parse('http://192.168.100.68/restapi/delete.php'); //deletion api
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        MaterialButton(
          child: const Text("Hapus"),
          onPressed: () {
            delete();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
        ),
        MaterialButton(
          child: const Text("Tidak"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          centerTitle: true,
          title: Text(
            "${widget.list[widget.index]['title']}",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.list[widget.index]['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 21,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  widget.list[widget.index]['content'],
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 19,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: MaterialButton(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.brown,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Edit(list: widget.list, index: widget.index),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: MaterialButton(
                        child: Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.brown,
                        onPressed: () {
                          confirm();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
