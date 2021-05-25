import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'package:vcard/vcard.dart';

import 'NameCard.dart';
import 'constant.dart';

class editContact extends StatefulWidget {
  int position;

  @override
  editContact({Key? key, required this.position}) : super(key: key);

  _editContactState createState() => _editContactState();
}

class _editContactState extends State<editContact> {
  var nameController,
      numberController,
      websiteController,
      emailController,
      organisationController,
      titleController,
      addressController,
      purposeController;
  Handler handler = Handler();
  List<NameCard> list = [];
  late NameCard nc;
  var vCard = VCard();
  String text = "";
  String dropdownvalue = "0";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    websiteController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler.readCounter().then((value) {
      setState(() {
        list = value;
        nc = list[widget.position];
        nameController = TextEditingController(text: nc.name);
        numberController = TextEditingController(text: nc.mobile);
        websiteController = TextEditingController(text: nc.website);
        emailController = TextEditingController(text: nc.email);
        organisationController = TextEditingController(text: nc.organisation);
        titleController = TextEditingController(text: nc.title);
        addressController = TextEditingController(text: nc.address);
        purposeController = TextEditingController(text: nc.purpose);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Edit Contact',
            style: header,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: primary,
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                text = nameController.text == "" ? " " : nameController.text;
                list[widget.position] = handler.saveCard(
                    nameController.text,
                    numberController.text,
                    organisationController.text,
                    numberController.text,
                    titleController.text,
                    websiteController.text,
                    emailController.text,
                    addressController.text,
                    purposeController.text);
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
                    buildTextFormField(organisationController, "Organisation",
                        TextInputType.text),
                    buildTextFormField(
                        titleController, "Job Title", TextInputType.text),
                    buildTextFormField(
                        numberController, "Mobile Number", TextInputType.phone),
                    buildTextFormField(addressController, "Address",
                        TextInputType.streetAddress),
                    buildTextFormField(
                        emailController, "Email", TextInputType.emailAddress),
                    buildTextFormField(
                        websiteController, "Website", TextInputType.url),
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
