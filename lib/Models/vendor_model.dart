import 'dart:convert';

class Vendor {
  int vendorid;
  int userId;
  String organizationName;
  String gst;
  String website;
  String mobile;
  String email;
  String address;
  String ownerName;

  Vendor({
    required this.vendorid,
    required this.userId,
    required this.organizationName,
    required this.gst,
    required this.website,
    required this.mobile,
    required this.email,
    required this.address,
    required this.ownerName,
  });

  Map<String, dynamic> toJson() {
    return {
      "Vendorid": vendorid,
      'UserId': userId,
      'OrganizationName': organizationName,
      'GST': gst,
      'Website': website,
      'Mobile': mobile,
      'Email': email,
      'Address': address,
      'OwnerName': ownerName,
    };
  }

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorid: json['Vendorid'],
      userId: json['UserId'],
      organizationName: json['OrganizationName'],
      gst: json['GST'],
      website: json['Website'],
      mobile: json['Mobile'],
      email: json['Email'],
      address: json['Address'],
      ownerName: json['OwnerName'],
    );
  }

  factory Vendor.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Vendor.fromJson(json);
  }
}
