// @dart=2.9
import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/constant.dart';
import 'package:namecardqrcodeapp/contactDetails.dart';
import 'package:namecardqrcodeapp/NameCard.dart';
import 'package:namecardqrcodeapp/createContact.dart';
import 'package:namecardqrcodeapp/editContact.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: background),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Handler handler = Handler();

  List<NameCard> list = [];
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler.readCounter().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: CustomPaint(
                painter: myPainter(),
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.4),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Text(
                    "QRContact",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: accent),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 14),
                    child: Text(
                      "QR NameCard Generator",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: accent),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .075,
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * 0.6, // card height
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      itemCount: list.length,
                      controller: PageController(viewportFraction: 0.8),
                      onPageChanged: (int index) => setState(() {
                        _index = index;
                      }),
                      itemBuilder: (_, i) {
                        return Transform.scale(
                          scale: list.length == 1
                              ? 1
                              : i == _index
                                  ? 1
                                  : 0.85,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          contactDetails(position: i)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 13.0),
                                child: Card(
                                  color: cardBackground,
                                  margin: EdgeInsets.all(0),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26)),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.93),
                                            ),
                                            child: QrImage(
                                              data: list[i].qrData,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        )),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(26),
                                                  bottomRight:
                                                      Radius.circular(26.0)),
                                              color: primary),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 25,
                                                    left: 25,
                                                    top: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      list[i].name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 22,
                                                          color: accent),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      list[i].purpose,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: accent),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 9),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: IconButton(
                                                                  color: accent,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      list.removeAt(
                                                                          i);
                                                                      handler.writeCounter(
                                                                          list);
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      size:
                                                                          30))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: IconButton(
                                                                  color: accent,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              editContact(position: i)),
                                                                    ).then(
                                                                        (value) {
                                                                      handler
                                                                          .readCounter()
                                                                          .then(
                                                                              (value) {
                                                                        setState(
                                                                            () {
                                                                          list =
                                                                              value;
                                                                        });
                                                                      });
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      size:
                                                                          30)))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width * .65, 49)),
                      elevation: MaterialStateProperty.all<double>(5),
                      backgroundColor: MaterialStateProperty.all<Color>(accent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ))),
                  onPressed: null,
                  child: Text(
                    "Scan QR Code",
                    style: TextStyle(color: primary, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: FloatingActionButton(
                  backgroundColor: primary,
                  child: Icon(Icons.add, color: background),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => createContact()))
                        .then((value) {
                      handler.readCounter().then((value) {
                        setState(() {
                          list = value;
                        });
                      });
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
