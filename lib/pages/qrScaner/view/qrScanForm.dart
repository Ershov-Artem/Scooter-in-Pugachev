import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scooter_pugachev/pages/home/widgets/customButton.dart';

class QRScanForm extends StatefulWidget {
  @override
  _QRScanFormState createState() => _QRScanFormState();
}

class _QRScanFormState extends State<QRScanForm> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: QRView(
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 25,
              borderWidth: 2,
              cutOutSize: 250,
            ),
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 400),
            child: Center(
                child: Text(
              "Отсканируйте код с самоката",
              style: Theme.of(context).textTheme.bodyText1,
            ))),
        Container(
            padding: EdgeInsets.only(top: 140, left: 20),
            child: CustomButton(
                onTap: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                height: 50,
                width: 50,
                decoration: BoxDecoration()))
      ],
    );
  }

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
