class Camp {
  final int id;
  final String name;
  final String location;
  final double fee;
  final String imageUrl;
  final String videoUrl;
  final int discountStatus;

  Camp({
    required this.id,
    required this.name,
    required this.location,
    required this.fee,
    required this.imageUrl,
    required this.videoUrl,
    required this.discountStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'fee': fee,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'discountStatus': discountStatus,
    };
  }

  factory Camp.fromJson(Map<String, dynamic> json) {
    return Camp(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      fee: json['fee'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      discountStatus: json['discountStatus'],
    );
  }
}
