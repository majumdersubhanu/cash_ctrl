import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../routes/app_pages.dart';
import 'lend_controller.dart';

class LendView extends GetView<LendController> {
  const LendView({super.key});

  @override
  Widget build(BuildContext context) {
    return const QRViewExample();
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Scan QR Code'),
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
        titleTextStyle: Get.textTheme.labelLarge?.copyWith(
          color: Get.theme.colorScheme.onPrimary,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              formatsAllowed: const [BarcodeFormat.qrcode],
              cameraFacing: CameraFacing.back,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Get.theme.colorScheme.primary,
                borderRadius: 4,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: Get.width * 0.8,
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        validateUPI();
      });
    });
  }

  validateUPI() async {
    var uri = Uri.parse(result?.code ?? '');

    if (uri.queryParameters.isNotEmpty) {
      Get.offNamed(Routes.TRANSACTION_DETAILS, arguments: uri.queryParameters);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}
