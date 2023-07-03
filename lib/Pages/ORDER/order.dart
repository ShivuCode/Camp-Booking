import 'dart:io';

import 'package:camp_booking/Pages/CAMP/campTile.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pay/pay.dart';

import '../../Models/camp_model.dart';
import '../../Models/customer_model.dart';
// import '../../Responsive_Layout/responsive_layout.dart';
// import '../HOME/laptopHomeScreen.dart';
// import '../HOME/mobileHomeScreen.dart';
// import '../HOME/tabletHomeScreen.dart';

// ignore: must_be_immutable
class OrderPage extends StatefulWidget {
  Customer customer;
  Camp camp;
  OrderPage({super.key, required this.camp, required this.customer});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  int currentPos = 1;
  late TabController _tabController;
  double amount = 0;

  update(i) {
    if (i != 0) {
      setState(() {
        _tabController.animateTo(i,
            duration: const Duration(milliseconds: 200));
        currentPos = i;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Review Order", style: TextStyle(fontSize: 20)),
                  ),
                  height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(
                          FontAwesomeIcons.circleCheck,
                          size: 20,
                          color: Colors.grey,
                        ),
                        height(10),
                        const Text(
                          "Customer",
                          style: TextStyle(fontSize: 10),
                        )
                      ]),
                      Container(
                          width: size * .22,
                          height: 2,
                          color: currentPos >= 1 ? mainColor : Colors.grey),
                      GestureDetector(
                        onTap: () {
                          if (currentPos == 2) {
                            update(1);
                          }
                        },
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          currentPos == 1
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    "2",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                )
                              : const Icon(
                                  FontAwesomeIcons.circleCheck,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                          height(10),
                          const Text(
                            "Order summary",
                            style: TextStyle(fontSize: 10),
                          )
                        ]),
                      ),
                      Container(
                          width: size * .22,
                          height: 2,
                          color: currentPos == 2 ? mainColor : Colors.grey),
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        currentPos == 2
                            ? Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  "3",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              )
                            : Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  "3",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                        height(10),
                        const Text(
                          "Payment",
                          style: TextStyle(fontSize: 10),
                        )
                      ]),
                    ],
                  ),
                ],
              )),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 60,
            color: Colors.white,
            child: Row(children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ ${widget.customer.advAmt}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text("Advance payment")
                ],
              )),
              Expanded(
                  child: currentPos == 2
                      ? GooglePayButton(
                          // ignore: deprecated_member_use
                          paymentConfigurationAsset: 'gpay.json',
                          paymentItems: [
                            PaymentItem(
                              label: 'Total',
                              amount: widget.customer.advAmt.toString(),
                              status: PaymentItemStatus.final_price,
                            )
                          ],
                          type: GooglePayButtonType.pay,
                          width: double.infinity,
                          height: 50,
                          onPaymentResult: ((result) => Fluttertoast.showToast(
                              msg: "$result", backgroundColor: mainColor)),
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (currentPos == 1) {
                              update(2);
                            } else {}
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(mainColor),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(120, 50))),
                          child: Text("Continue".toUpperCase()),
                        ))
            ]),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Center(),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(20),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Container(
                            height: size < 600 ? 130 : 200,
                            width: size < 600 ? 120 : 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    onError: (exception, stackTrace) => {},
                                    image: FileImage(
                                        File(widget.camp.titleImageUrl)))),
                          ),
                          width(8),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.camp.campName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                              height(8),
                              const SizedBox(
                                width: 200,
                                child: Text(
                                  "Beautiful Couple Camping With Decoration light, food & support.",
                                  softWrap: true,
                                ),
                              ),
                              height(5),
                              Text.rich(TextSpan(
                                  text: "${widget.camp.discountStatus}%OFF",
                                  style: const TextStyle(color: Colors.blue),
                                  children: [
                                    TextSpan(
                                        text: " ₹ ${widget.customer.price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black))
                                  ])),
                              height(5),
                              Text.rich(TextSpan(
                                  text: "Total Person: ",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${widget.customer.adult} Adult, ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: "${widget.customer.adult} Child",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                  ])),
                            ],
                          )
                        ])),
                    Divider(
                      thickness: 10,
                      color: Colors.grey.shade200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Price Details",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600)),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Price(1 item)"),
                            Text("₹ ${widget.customer.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        height(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Price"),
                            Text(
                                "₹ ${((widget.customer.price * widget.customer.adult) + ((widget.customer.price * 0.45) * widget.customer.child))}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        height(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Advance payment"),
                            Text("- ₹ ${widget.customer.advAmt}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: mainColor))
                          ],
                        ),
                        height(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Remaining"),
                            Text(
                                "₹ ${(((widget.customer.price * widget.customer.adult) + ((widget.customer.price * 0.45) * widget.customer.child)) - widget.customer.advAmt).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ]),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Customer Price"),
                          Text(
                              "₹ ${((widget.customer.price * widget.customer.adult) + ((widget.customer.price * 0.45) * widget.customer.child))}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    height(10),
                    Expanded(
                      child: Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: size * .5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                FontAwesomeIcons.shield,
                                size: 19,
                                color: Colors.grey,
                              ),
                              width(5),
                              const Expanded(
                                child: Text(
                                  "Safe and Secure payments. Easy returns. 100% Authentic products.",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    height(60)
                  ]),
              Center(),
            ],
          )),
    );
  }
}
