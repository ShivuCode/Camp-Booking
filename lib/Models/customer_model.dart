import 'dart:ffi';

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

  Map<String, dynamic> toJson(Customer customer) {
    return {
      'id': customer.id,
      'name': customer.name,
      'mobile': customer.mobNo,
      'adult': customer.adult,
      'child': customer.child,
      'vegPeopleCount': customer.vegPeopleCount,
      'nonVegPeopleCount': customer.nonVegPeopleCount,
      'bookingDate': customer.bookingDate,
      'groupType': customer.groupType,
      'email': customer.email,
      'price': customer.price,
      'ticketFlag': customer.ticketFlag,
      'advanceAmount': customer.advAmt,
      'address': customer.address,
      'total': customer.total
    };
  }

  Customer fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json['name'],
        mobNo: json['mobile'],
        address: json['address'],
        email: json['email'],
        adult: json['adult'],
        child: json['child'],
        groupType: json['groupType'],
        bookingDate: json['bookingDate'],
        vegPeopleCount: json[' vegPeopleCount'],
        nonVegPeopleCount: json['nonVegPeopleCount'],
        price: json['price'],
        advAmt: json['advanceAmount'],
        total: json['total'],
        ticketFlag: json['ticketFlag']);
  }
}
