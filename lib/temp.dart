/* SlidingUpPanel(
      onPanelClosed: () async {
        await controller.pauseCamera();
      },
      onPanelOpened: () async => await controller.resumeCamera(),
      minHeight: MediaQuery.of(context).size.height * 0.08,
      maxHeight: MediaQuery.of(context).size.height * 0.6,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      panel: _qrBody(),
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
                  "Swipe up",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
      backdropEnabled: true,
      body: _mainBody(sHeight),
    ); */

/* void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.first.then((value) {
      result = value;
      print(result.code);

      print("HI");
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

  Widget _qrBody() {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          panelCue,
          SizedBox(
            height: 15.0,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(20.0),
              child: _buildQrView(context)),
        ],
      ),
    );
  } */
