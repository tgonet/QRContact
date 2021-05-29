import 'package:flutter/material.dart';
import 'package:namecardqrcodeapp/handler.dart';
import 'package:vcard/vcard.dart';
import 'NameCard.dart';
import 'constant.dart';

class contactDetails extends StatefulWidget {
  int position;

  @override
  contactDetails({Key? key, required this.position}) : super(key: key);

  _contactDetailsState createState() => _contactDetailsState();
}

class _contactDetailsState extends State<contactDetails> {
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
    organisationController.dispose();
    titleController.dispose();
    addressController.dispose();
    purposeController.dispose();
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
          title: Text(
            'View',
            style: header,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: primary,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        //SizedBox(height: 10),
                        buildTextFormField(
                            nameController, "Name", TextInputType.name),
                        buildTextFormField(
                            purposeController, "Purpose", TextInputType.name),
                        buildTextFormField(organisationController,
                            "Organisation", TextInputType.text),
                        buildTextFormField(
                            titleController, "Job Title", TextInputType.text),
                        buildTextFormField(numberController, "Mobile Number",
                            TextInputType.phone),
                        buildTextFormField(addressController, "Address",
                            TextInputType.streetAddress),
                        buildTextFormField(emailController, "Email",
                            TextInputType.emailAddress),
                        buildTextFormField(
                            websiteController, "Website", TextInputType.url),
                      ],
                    ),
                  ),
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
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 4),
          child: Text(
            labelText,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          //decoration: textBoxDeco1,
          child: TextField(
              style: TextStyle(fontSize: 19),
              enabled: false,
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                /* contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10), */
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide.none),
                fillColor: primaryTextbox,
                filled: true,
              )),
        ),
      ],
    ),
  );
}
