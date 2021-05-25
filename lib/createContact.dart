import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/constant.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'package:vcard/vcard.dart';
import 'NameCard.dart';

class createContact extends StatelessWidget {
  Handler handler = Handler();
  List<Widget> textbox = [];
  List<NameCard> list = [];
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final websiteController = TextEditingController();
  final emailController = TextEditingController();
  final organisationController = TextEditingController();
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final purposeController = TextEditingController();
  String text = "";
  //Create vCard
  var vCard = VCard();

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).padding.top;
    handler.readCounter().then((value) => list = value);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Create Contact',
            style: header,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: primary,
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                text = nameController.text == "" ? " " : nameController.text;
                list.add(handler.saveCard(
                    nameController.text,
                    numberController.text,
                    organisationController.text,
                    numberController.text,
                    titleController.text,
                    websiteController.text,
                    emailController.text,
                    addressController.text,
                    purposeController.text));
                handler
                    .writeCounter(list)
                    .then((value) => Navigator.pop(context));
              },
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: CustomPaint(
                painter: myPainter(),
                size: Size(
                    MediaQuery.of(context).size.width,
                    (MediaQuery.of(context).size.height * 0.4) -
                        (sHeight / 2 + kToolbarHeight)),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    buildTextFormField(
                        nameController, "Name", TextInputType.name),
                    buildTextFormField(
                        purposeController, "Purpose", TextInputType.name),
                    buildTextFormField(
                        numberController, "Mobile Number", TextInputType.phone),
                    buildTextFormField(
                        emailController, "Email", TextInputType.emailAddress),
                    buildTextFormField(
                        websiteController, "Website", TextInputType.url),
                    buildTextFormField(organisationController, "Organisation",
                        TextInputType.text),
                    buildTextFormField(
                        titleController, "Title", TextInputType.text),
                    buildTextFormField(addressController, "Address",
                        TextInputType.streetAddress),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

Widget buildTextFormField(
    TextEditingController controller, String labelText, TextInputType type) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Container(
      decoration: textBoxDeco,
      child: TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide.none),
            fillColor: textBox,
            filled: true,
            hintText: labelText,
          )),
    ),
  );
}
