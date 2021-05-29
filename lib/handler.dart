import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'NameCard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vcard/vcard.dart';

class Handler {
  Handler();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<List<NameCard>> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      List<dynamic> jsonData = jsonDecode(contents);
      //print(jsonData);
      return jsonData.map((map) => NameCard.fromMap(map)).toList();
    } catch (e) {
      // If encountering an error, return 0
      print(e);
      return <NameCard>[];
    }
  }

  Future<File> writeCounter(List<NameCard> namecard) async {
    final file = await _localFile;
    String jsonUser = jsonEncode(namecard);

    // Write the file
    return file.writeAsString('$jsonUser');
  }

  NameCard saveCard(
      String name,
      String hp,
      String organisation,
      String workhp,
      String jobTitle,
      String url,
      String email,
      String address,
      String purpose) {
    VCard vCard = VCard();
    vCard.firstName = name;
    vCard.homePhone = hp;
    vCard.organization = organisation;
    vCard.workPhone = workhp;
    vCard.jobTitle = jobTitle;
    vCard.url = url;
    vCard.email = email;
    vCard.homeAddress.street = address;
    return NameCard(name, purpose, hp, email, url, organisation, jobTitle,
        address, vCard.getFormattedString());
  }

  void getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      //await Permission.contacts.request().then((value) => null)
    }
  }
}
