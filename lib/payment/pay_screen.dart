import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/components/custom_button.dart';
import 'package:mysql_app/consts/utilties.dart';
import 'package:mysql_app/models/subscription.dart';
import 'package:mysql_app/payment/payment_services.dart';
import 'package:mysql_app/users/fragments/profile_screen.dart';

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
  String? payReference;


  subscriptionPayment(context, PaymentRequest paymentRequest) async {
    try {
      paymentRequest
        ..setIsSandBox(true)
        ..setAmount(1000)
        ..setDescription("description")
        ..setMerchantID("332f20e0-3333-41ce-b15d-aff7476a92ba")
        ..setCallbackURL("https://mlggrand2.ir");

      if (widget.queryData!['Status'] == "OK") {
        String id = widget.queryData!['user_id'];
        String status = widget.queryData!['Status'];
        String authority = widget.queryData!['Authority'];
print(authority);

        ZarinPal().verificationPayment(status, authority, paymentRequest,
                (isPaymentSuccess, refID, paymentRequest) {
                  print("after payment");
                  print(isPaymentSuccess);
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
                payReference = refID;
                setState(() {});
              }
            });
      }
    }catch(e){
      Fluttertoast.showToast(msg: "PayScreen subscriptionPayment function error");
      print("PayScreen subscriptionPayment function error");
      print(e);
    }
  }

  @override
  void initState() {
    subscriptionPayment(context, paymentRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String id = widget.queryData!['user_id'] ?? "no id";
    String status = widget.queryData!['Status'] ?? "no status";


    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black87)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.maxFinite,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pay Detail",style: TextStyle(fontSize: 25),),
                    const SizedBox(
                      height: 30,
                    ),
                    TextRow(
                        label: "Amount",
                        text: paymentRequest.amount.toString()),
                  TextRow(
                        label: "Authority",
                        text: paymentRequest.authority.toString()),
                  TextRow(
                        label: "Status",
                        text: status),
                   TextRow(
                        label: "user id",
                        text: id),
                  TextRow(
                        label: "Pay reference",
                        text: payReference ?? " no pay reference"),
                  TextRow(
                        label: "Query Data",
                        text: widget.queryData.toString()),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                color: Colors.orange,
                text: "Back to app",
                onPressed: () {
                  launchUrl(Uri.parse("https://mlggrand2.ir/#/"),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
              ),
            CustomButton(
                color: Colors.orange,
                text: "go to profile Screen",
                onPressed: () {
               context.goNamed(ProfileScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white54,
          border: Border(bottom: BorderSide(width: 2, color: Colors.black38))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              color: Colors.black38,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

//flutter build web --no-tree-shake-icons
