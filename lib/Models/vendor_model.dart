class Vendor {
  String organisationName;
  String gstRegistration;
  String website;
  String mobileNumber;
  String emailAddress;
  String address;
  String ownerName;

  Vendor({
    required this.organisationName,
    required this.gstRegistration,
    required this.website,
    required this.mobileNumber,
    required this.emailAddress,
    required this.address,
    required this.ownerName,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      organisationName: json['organisationName'],
      gstRegistration: json['gstRegistration'],
      website: json['website'],
      mobileNumber: json['mobileNumber'],
      emailAddress: json['emailAddress'],
      address: json['address'],
      ownerName: json['ownerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organisationName': organisationName,
      'gstRegistration': gstRegistration,
      'website': website,
      'mobileNumber': mobileNumber,
      'emailAddress': emailAddress,
      'address': address,
      'ownerName': ownerName,
    };
  }
}
