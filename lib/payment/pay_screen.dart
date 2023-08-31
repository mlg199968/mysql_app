import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_app/components/custom_button.dart';
import 'package:mysql_app/consts/utilties.dart';
import 'package:mysql_app/models/subscription.dart';
import 'package:mysql_app/payment/payment_services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class PayScreen extends StatefulWidget {
  static const String id = "/payScreen";

  const PayScreen({Key? key, this.passName, this.queryData}) : super(key: key);
  final String? passName;
  final Map? queryData;
  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  PaymentRequest paymentRequest = PaymentRequest();
  PaymentServices paymentServices = PaymentServices();
  String? statusPayback;

  payOptions(PaymentRequest paymentRequest) {
    paymentRequest
      ..setIsSandBox(true)
      ..setAmount(1000)
      ..setDescription("description")
      ..setMerchantID("332f20e0-3333-41ce-b15d-aff7476a92ba")
      ..setCallbackURL(
          "https://mlggrand.ir/%d9%be%d8%a7%db%8c%d8%a7%d9%86-%d9%be%d8%b1%d8%af%d8%a7%d8%ae%d8%aa/");

    ZarinPal().startPayment(paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        launchUrl(Uri.parse(paymentGatewayUri!),
            mode: LaunchMode.externalApplication);
      } else {
        Fluttertoast.showToast(
          msg: "error $status on the payment ",
        );
      }
    });
  }

  subscriptionPayment(context, PaymentRequest paymentRequest) async {
    if(widget.queryData!['Status']=="OK") {
      String id=widget.queryData!['user_id'];
      String status = widget.queryData!['Status'];
      String authority=widget.queryData!['Authority'];

      ZarinPal().verificationPayment(status, authority, paymentRequest,
          (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          //
          Subscription subscription = Subscription(
            id: stringToDouble(id).toInt(),
            level: 1,
            startDate: DateTime.now(),
            description: paymentRequest.description ?? "",
            payAmount: paymentRequest.amount!.toDouble(),
            refId: refID!,
          );
          paymentServices.saveSubscription(subscription);
          statusPayback = refID;
          setState(() {});
        }
      });
    }
  }

  @override
  void initState() {
     subscriptionPayment(context,paymentRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.maxFinite,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(statusPayback ?? " no payBack" "this is"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.passName ?? "No passName!"),
            Text(widget.queryData.toString()),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              color: Colors.orange,
              text: "Back to app",
              onPressed: () {
                launchUrl(Uri.parse("https://mlggrand2.ir/#/profileScreen"),mode: LaunchMode.externalNonBrowserApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}


//flutter build web --no-tree-shake-icons
