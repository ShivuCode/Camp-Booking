import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/hotmail.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/customer_model.dart';

class Email {
  static void sendMail(Customer customer) async {
    String username = "vivo182034@hotmail.com";
    final smtServer = hotmail(username, 'Vivvo!23');
    double rem = customer.total - customer.advAmt;

    final message = Message()
      ..from = Address(username, "Pawn Camping")
      ..recipients.add(customer.email)
      ..subject = "Booking Details"
      ..html =
          "<h2>Booking comfirmed....</h2><br>Name: ${customer.name}<br>Address: ${customer.address}<br>No. of Veg People: ${customer.vegPeopleCount}<br>Booking date: ${customer.bookingDate}<br>Price: ${customer.price} <br>No. of non-Veg people: ${customer.nonVegPeopleCount}<br>No. of Adults: ${customer.adult}<br>No. of Child: ${customer.child}<br><br>Total Amount : ${customer.total}<br>Advance: ${customer.advAmt} <br>----------------------------------------------<br>Remaining Amount: $rem <br><br> Thanks for connecting Us..";
    try {
      final sendReport = await send(message, smtServer);
      Fluttertoast.showToast(msg: "Email send", gravity: ToastGravity.CENTER);
    } on MailerException catch (e) {
      print(e);
    }
  }
}
