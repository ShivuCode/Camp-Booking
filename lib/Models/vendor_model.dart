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
  String location;

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
    required this.location,
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
      'location': location,
    };
  }

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorid: json['vendorId'] ?? 0,
      userId: json['userId'] ?? 0,
      organizationName: json['organizationName'] ?? '',
      gst: json['gst'] ?? '',
      website: json['website'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      ownerName: json['ownerName'] ?? '',
      location: json['location'] ?? '',
    );
  }

  factory Vendor.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Vendor.fromJson(json);
  }
}
