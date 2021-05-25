import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'NameCard.dart';

class contactDetails extends StatelessWidget {
  final int position;

  // receive data from the FirstScreen as a parameter
  contactDetails({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Name Card QR Code Creator'),
            automaticallyImplyLeading: true),
        body: RandomWords(position: position));
  }
}

class RandomWords extends StatefulWidget {
  final int position;
  RandomWords({Key? key, required this.position}) : super(key: key);
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  Handler handler = Handler();
  List<Widget> textbox = [];
  List<NameCard> list = [];
  late NameCard nc;

  @override
  Widget build(BuildContext context) {
    handler.readCounter().then((value) {
      setState(() {
        list = value;
        print(widget.position);
        nc = list[widget.position];
      });
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nc.name),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nc.mobile),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nc.email),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nc.website),
            )
          ],
        ),
      ),
    );
  }
}
