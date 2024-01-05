class Camp {
  final int campId;
  final String campName;
  final String campLocation;
  final int campFee;
  final int campImageGroupId;
  final String campBrochure;
  final String campViewDetails;
  final int campPlanId;
  final String titleImageUrl;
  final String videoUrl;
  final String discountStatus;
  final String controllerName;
  final int isActive;
  final int type;
  final int userId;

  Camp(
      {required this.campId,
      required this.campName,
      required this.campLocation,
      required this.campFee,
      required this.campImageGroupId,
      required this.campBrochure,
      required this.campViewDetails,
      required this.campPlanId,
      required this.titleImageUrl,
      required this.videoUrl,
      required this.discountStatus,
      required this.controllerName,
      required this.isActive,
      required this.type,
      required this.userId});

  Map<String, String> toJson() {
    return {
      "CampName": campName,
      "CampLocation": campLocation,
      "campFee": campFee.toString(),
      "CampImageGroupId": campImageGroupId.toString(),
      "CampBrochure": campBrochure,
      "CampViewDetails": campViewDetails,
      "CampPlanId": campPlanId.toString(),
      "DiscountStatus": discountStatus.toString(),
      "ControllerName": controllerName,
      "IsActive": isActive.toString(),
      "Type": type.toString(),
      "UserId": userId.toString()
    };
  }

  static Camp fromJson(Map<String, dynamic> json) {
    return Camp(
        campId: json['campId'] ?? '',
        campName: json['campName'] ?? '',
        campLocation: json['campLocation'] ?? '',
        campFee: json['campFee'] ?? 0,
        campImageGroupId: json['campImageGroupId'] ?? '',
        campBrochure: json['campBrochure'] ?? '',
        campViewDetails: json['campViewDetails'] ?? '',
        campPlanId: json['campPlanId'] ?? "",
        titleImageUrl: json["titleImageUrl"] ?? '', // Add a null check here
        videoUrl: json['videoUrl'] ?? '',
        discountStatus: json['discountStatus'] ?? '',
        controllerName: json['controllerName'] ?? '',
        isActive: json['isActive'] ?? 0,
        type: json['type'] ?? 0,
        userId: json['userId']);
  }
}
