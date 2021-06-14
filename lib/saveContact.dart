import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/constant.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'NameCard.dart';

class saveContact extends StatefulWidget {
  NameCard vcard;
  saveContact({Key? key, required this.vcard}) : super(key: key);

  @override
  _saveContactState createState() => _saveContactState();
}

class _saveContactState extends State<saveContact> {
  String text = "";
  var nameController,
      numberController,
      websiteController,
      emailController,
      organisationController,
      titleController,
      addressController;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    websiteController.dispose();
    emailController.dispose();
    numberController.dispose();
    organisationController.dispose();
    titleController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var nc = widget.vcard;
      print(nc.address + "hi:");
      nameController = TextEditingController(text: nc.name);
      numberController = TextEditingController(text: nc.mobile);
      websiteController = TextEditingController(text: nc.website);
      emailController = TextEditingController(text: nc.email);
      organisationController = TextEditingController(text: nc.organisation);
      titleController = TextEditingController(text: nc.title);
      addressController = TextEditingController(text: nc.address);
    });
  }

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Save',
            style: header,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: primary,
          actions: [
            IconButton(
              iconSize: 25,
              icon: Icon(Icons.check),
              onPressed: () {
                text = nameController.text == "" ? " " : nameController.text;
                /* list.add(handler.saveCard(
                    nameController.text,
                    numberController.text,
                    organisationController.text,
                    numberController.text,
                    titleController.text,
                    websiteController.text,
                    emailController.text,
                    addressController.text,
                    purposeController.text)); */
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
