// @dart=2.9
import 'package:platform/platform.dart';
import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/constant.dart';
import 'package:namecardqrcodeapp/contactDetails.dart';
import 'package:namecardqrcodeapp/NameCard.dart';
import 'package:namecardqrcodeapp/createContact.dart';
import 'package:namecardqrcodeapp/editContact.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:simple_vcard_parser/simple_vcard_parser.dart';

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
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_askPermissions();
    handler.readCounter().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  Widget _buildQrView(BuildContext context) {
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 10,
        borderWidth: 5,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.first.then((value) {
      result = value;
      print(result.code);
      VCard vCard = VCard(result.code);

      print("hi" + vCard.organisation);
      Fluttertoast.showToast(
          msg: "Contact saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Widget _qrBody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          panelCue,
          SizedBox(height: 10),
          Material(
              child: Text(
            'Scan a Contact QR Code',
            style: TextStyle(fontSize: 18, backgroundColor: Colors.white),
          )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.all(20.0),
                    child: _buildQrView(context))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _mainBody(double sHeight) {
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: sHeight + 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: primary,
                          ),
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
                        )),
                  ),
                ),
                Text(
                  "QRContact",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: accent),
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
                                            /* embeddedImage:
                                                AssetImage('images/image.jpg'), */
                                            data: list[i].qrData,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      )),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(26),
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
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 9),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: IconButton(
                                                                color: accent,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    list.removeAt(
                                                                        i);
                                                                    handler
                                                                        .writeCounter(
                                                                            list);
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 30))),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: IconButton(
                                                                color: accent,
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
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
                                                                    Icons.edit,
                                                                    size: 30)))
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
          ],
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).padding.top;
    return SlidingUpPanel(
      onPanelClosed: () async {
        await controller.pauseCamera();
      },
      onPanelOpened: () async => await controller.resumeCamera(),
      minHeight: MediaQuery.of(context).size.height * 0.1,
      maxHeight: MediaQuery.of(context).size.height * 0.6,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      panel: _qrBody(context),
      collapsed: Container(
        decoration:
            BoxDecoration(borderRadius: panelRadius, color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 12.0,
            ),
            panelCue,
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Material(
                color: Colors.white,
                child: Text(
                  "Swipe up to scan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
      backdropEnabled: true,
      body: _mainBody(sHeight),
    );
  }
}
