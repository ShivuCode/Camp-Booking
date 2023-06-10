class Camp {
  final int id;
  final String name;
  final String location;
 
  final double pricePerUnit;
  final String imageUrl;

  Camp({
    required this.id,
    required this.name,
    required this.location,
   
    required this.pricePerUnit,
    required this.imageUrl,
  });

  factory Camp.fromJson(Map<String, dynamic> json) {
    return Camp(
      id: json['id'],
      name: json['name'],
      location: json['location'],
     
      pricePerUnit: json['price_per_unit'].toDouble(),
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      
      'price_per_unit': pricePerUnit,
      'image_url': imageUrl,
    };
  }
}
