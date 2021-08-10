import 'package:flutter/material.dart';

import 'package:pay/pay.dart';

class PayForm extends StatefulWidget {
  //const PayForm({ Key? key }) : super(key: key);

  @override
  _PayFormState createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  int deposit = 300;
  int price = 7;

  final _paymentItems = <PaymentItem>[];
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 275,
                child: Text(
                  "На время поездки с Вас спишется залог $deposit рублей, который вернется по окончании поездки. Каждая минута поездки будет стоить $price рублей.",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                )),
            ApplePayButton(
              paymentConfigurationAsset:
                  'default_payment_profile_apple_pay.json',
              paymentItems: _paymentItems,
              height: 75,
              width: 275,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (data) {
                print(data);
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            GooglePayButton(
              paymentConfigurationAsset:
                  'default_payment_profile_google_pay.json',
              paymentItems: _paymentItems,
              height: 75,
              width: 275,
              style: GooglePayButtonStyle.white,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (data) {
                print(data);
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
