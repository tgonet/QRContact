class NameCard {
  String name;
  String purpose;
  String mobile;
  String email;
  String website;
  String organisation;
  String title;
  String address;
  String qrData;

  NameCard(this.name, this.purpose, this.mobile, this.email, this.website,
      this.organisation, this.title, this.address, this.qrData);

  Map toJson() => {
        'name': name,
        'purpose': purpose,
        'mobile': mobile,
        'email': email,
        'website': website,
        'organisation': organisation,
        'title': title,
        'address': address,
        'data': qrData
      };

  factory NameCard.fromMap(map) {
    return NameCard(
        map['name'] as String,
        map['purpose'] as String,
        map['mobile'] as String,
        map['email'] as String,
        map['website'] as String,
        map['organisation'] as String,
        map['title'] as String,
        map['address'] as String,
        map['data'] as String);
  }
}
