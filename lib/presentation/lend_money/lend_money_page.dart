import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

@RoutePage()
class LendMoneyPage extends StatefulWidget {
  const LendMoneyPage({super.key});

  @override
  State<LendMoneyPage> createState() => _LendMoneyPageState();
}

class _LendMoneyPageState extends State<LendMoneyPage> {
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        titleTextStyle: context.textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
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
                  borderColor: Theme.of(context).colorScheme.primary,
                  borderRadius: 4,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: context.width * 0.8,
                  overlayColor: Colors.black.withOpacity(0.8)),
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
      context.replaceRoute(
          TransactionDetailsRoute(arguments: uri.queryParameters));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}
