class Customer {
  int id;
  String name;
  String address;
  String email;
  String mobNo;
  int adult;
  int child;
  int vegPeopleCount;
  int nonVegPeopleCount;
  String bookingDate;
  String groupType;
  int price;
  int ticketFlag;
  String noteSection;
  int freeKid;
  int advAmt;
  int userId;
  int discount;

  Customer({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.mobNo,
    required this.adult,
    required this.child,
    required this.vegPeopleCount,
    required this.nonVegPeopleCount,
    required this.bookingDate,
    required this.groupType,
    required this.price,
    required this.ticketFlag,
    required this.noteSection,
    required this.freeKid,
    required this.advAmt,
    required this.userId,
    required this.discount,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        email: json['email'],
        mobNo: json['mobile'] ?? '',
        adult: json['adult'] ?? 0,
        child: json['child'] ?? 0,
        vegPeopleCount: json['vegPeopleCount'] ?? 0,
        nonVegPeopleCount: json['nonVegPeopleCount'] ?? 0,
        bookingDate: json['bookingDate'],
        groupType: json['groupType'] ?? 0,
        price: json['price'] ?? 0,
        ticketFlag: json['ticketFlag'] ?? 1,
        advAmt: json['advanceAmount'] ?? 0,
        userId: json['userId'],
        freeKid: json['freeKid'] ?? 0,
        noteSection: json['noteSection'] ?? '',
        discount: json['discount'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'mobile': mobNo,
      'adult': adult,
      'child': child,
      'vegPeopleCount': vegPeopleCount,
      'nonVegPeopleCount': nonVegPeopleCount,
      'bookingDate': bookingDate,
      'groupType': groupType,
      'price': price,
      'ticketFlag': ticketFlag,
      'advanceAmount': advAmt,
      'noteSection': noteSection,
      'userId': userId,
      'freeKid': freeKid,
      'discount': discount
    };
  }
}
