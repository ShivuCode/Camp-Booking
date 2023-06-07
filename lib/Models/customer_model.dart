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
  double price;
  String ticketFlag;
  double advAmt;
  double total;

  Customer(
      {required this.id,
      required this.name,
      required this.mobNo,
      required this.address,
      required this.email,
      required this.adult,
      required this.child,
      required this.groupType,
      required this.bookingDate,
      required this.vegPeopleCount,
      required this.nonVegPeopleCount,
      required this.price,
      required this.advAmt,
      required this.total,
      required this.ticketFlag});

  void addAll(
    int id,
    String name,
    String address,
    String email,
    String mobNo,
    int adult,
    int child,
    int vegPeopleCount,
    int nonVegPeopleCount,
    String bookingDate,
    String groupType,
    double price,
    double advAmt,
    double total,
    String ticketFlag,
  ) {
    Customer(
        id: id,
        name: name,
        mobNo: mobNo,
        address: address,
        email: email,
        adult: adult,
        child: child,
        groupType: groupType,
        bookingDate: bookingDate,
        vegPeopleCount: vegPeopleCount,
        nonVegPeopleCount: nonVegPeopleCount,
        price: price,
        advAmt: advAmt,
        total: total,
        ticketFlag: ticketFlag);
  }

 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobNo,
      'adult': adult,
      'child': child,
      'vegPeopleCount': vegPeopleCount,
      'nonVegPeopleCount': nonVegPeopleCount,
      'bookingDate':bookingDate,
      'groupType':groupType,
      'email': email,
      'price':price,
      'ticketFlag': ticketFlag,
      'advanceAmount': advAmt,
      'address': address,
      'total': total
    };
  }

  factory Customer.fromJson(json) {
    return Customer(
        id: json['id'],
        name: json["name"],
        mobNo: json["mobile"],
        address: json["address"],
        email: json['email'],
        adult: json["adult"],
        child: json["child"],
        groupType: "couple",
        bookingDate: json['bookingDate'],
        vegPeopleCount: json["vegPeopleCount"],
        nonVegPeopleCount: json["nonVegPeopleCount"],
        price: double.parse(json["price"].toString()),
        advAmt: double.parse(json["advanceAmount"].toString()),
        total: (json["price"] * double.parse(json["adult"].toString())) +
            (json["price"] * double.parse(json["child"].toString())),
        ticketFlag: "1");
  }
}
