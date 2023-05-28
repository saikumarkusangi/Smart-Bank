import 'dart:io';
import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/images.dart';
import 'package:bank/views/features/qr/qrPage.dart';
import 'package:bank/views/features/send/chat_screen.dart';
import 'package:bank/views/features/home/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  static String tag = '/QrScannerComponent';
  String? screenName;

  QrScannerScreen({this.screenName});

  @override
  QrScannerScreenState createState() => QrScannerScreenState();
}

class QrScannerScreenState extends State<QrScannerScreen> {
  File? val;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  QRViewController? controller;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              const Center(child: QRViewExample()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: backgroundColor),
                    onPressed: () {
                      if (widget.screenName == "qrpage") {
                        finish(context);
                      } else {
                        finish(context);
                        const MainScreen().launch(context);
                      }
                    },
                  ),
                  Image.asset(focus,
                          height: 24, width: 24, color: backgroundColor)
                      .onTap(() {})
                ],
              ).paddingOnly(left: 12, right: 12, top: 0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Scan QR code to pay",
                        style:
                            primaryTextStyle(size: 14, color: backgroundColor)),
                    Text("Scan Spot Code to connect",
                        style:
                            primaryTextStyle(size: 14, color: backgroundColor)),
                    120.height,
                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 8, bottom: 8),
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          color: Colors.black.withOpacity(0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(brightnessicon,
                              height: 20, width: 20, color: backgroundColor),
                          10.width,
                          Text("Show my Spot Code",
                                  style: primaryTextStyle(
                                      size: 14, color: backgroundColor),
                                  textAlign: TextAlign.center)
                              .onTap(() {
                            finish(context);
                            Get.to(const QrScreen());
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ).paddingBottom(16)
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (Get.currentRoute == '/QrScannerComponent') {
          const MainScreen().launch(context);
        } else {
          const MainScreen().launch(context);
        }
        return true;
      },
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  String result = '';
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width / 1.2);
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.black,
              borderRadius: 10,
              borderLength: 0,
              borderWidth: 10,
              cutOutSize: scanArea),
          // onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        Align(
            alignment: Alignment.center,
            child: Image.asset(camerabg,
                width: MediaQuery.of(context).size.width / 1.1)),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
        Get.to(ChatScreen(
          nickname: result,
          image: '',
          nicknameeng: result,
        ));
      });
    });
  }

  // void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  //   log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  //   if (!p) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('no Permission')),
  //     );
  //   }
  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
