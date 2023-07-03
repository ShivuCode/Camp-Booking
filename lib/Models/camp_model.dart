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

  Camp({
    required this.campId,
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
  });

  Map<String, dynamic> toJson() {
    return {
      'campId': campId,
      'campName': campName,
      'campLocation': campLocation,
      'campFee': campFee,
      'campImageGroupId': campImageGroupId,
      'campBrochure': campBrochure,
      'campViewDetails': campViewDetails,
      'campPlanId': campPlanId,
      'titleImageUrl': titleImageUrl,
      'videoUrl': videoUrl,
      'discountStatus': discountStatus,
      'controllerName': controllerName,
      'isActive': isActive,
      'type': type,
    };
  }

  static Camp fromJson(Map<String, dynamic> json) {
    return Camp(
      campId: json['campId'],
      campName: json['campName'],
      campLocation: json['campLocation'],
      campFee: json['campFee'],
      campImageGroupId: json['campImageGroupId'],
      campBrochure: json['campBrochure'],
      campViewDetails: json['campViewDetails'],
      campPlanId: json['campPlanId'],
      titleImageUrl: json["titleImageUrl"] ?? '', // Add a null check here
      videoUrl: json['videoUrl'] ?? '',
      discountStatus: json['discountStatus'] ?? '',
      controllerName: json['controllerName'] ?? '',
      isActive: json['isActive'],
      type: json['type'],
    );
  }
}
