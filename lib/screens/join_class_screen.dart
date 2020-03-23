import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:sevenclass/bloc/classes/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/base/app_alert_dialog.dart';
import 'package:sevenclass/widgets/base/button.dart';
import 'package:sevenclass/widgets/base/finger_tip.dart';
import 'package:sevenclass/widgets/base/sliding_panel.dart';
import 'package:sevenclass/widgets/modules/classes/camera_permission.dart';

class JoinClassScreen extends StatefulWidget {
  @override
  _JoinClassScreenState createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  PanelController _pc = PanelController();
  bool _onGoAheadClicked = false;

  double _screenHeight = 0;

  ClassesBloc _classesBloc;

  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrText = "";
  TextEditingController _classCodeTEC = TextEditingController();

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if(qrText != scanData){
        print(scanData);
      }
    });
  }

  _joinClass() {
    _classesBloc.add(EnrollClassEvent(
      classCode: _classCodeTEC.text
    ));
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _classesBloc = BlocProvider.of<ClassesBloc>(context);
    _classesBloc.add(IsCameraPermissionGrantedEvent());

    return BlocListener(
      bloc: _classesBloc,
      listener: (context, state) {
        if (state is EnrollClassJoinedState) {
          AppAlertDialog(
            title: 'Already Joined',
            message: 'You have joined this class',
            rightButtonText: 'Oh, oke',
            onRightButtonClick: () => Navigator.of(context).pop(),
          ).show(context);
        } else if (state is EnrollClassNotFoundState) {
          AppAlertDialog(
            title: 'Alert',
            message: 'Class not found',
            rightButtonText: 'Try Again',
            onRightButtonClick: () => Navigator.of(context).pop(),
          ).show(context);
        }
      },
      child: BlocBuilder(
        bloc: _classesBloc,
        builder: (context, state) {
          return Scaffold(
            body: Container(
              height: _screenHeight,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: _screenHeight * 0.74,
                      width: double.infinity,
                      color: Colors.black87,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _classesBloc.isCameraPermissionGranted || _onGoAheadClicked
                              ? Expanded(
                                child: QRView(
                                    key: qrKey,
                                    onQRViewCreated: _onQRViewCreated,
                                    overlay: QrScannerOverlayShape(
                                      borderColor: AppColors.primaryColor,
                                      borderRadius: 10,
                                      borderLength: 30,
                                      borderWidth: 10,
                                      cutOutSize: 220,
                                    ),
                                  ),
                                )
                              : CameraPermission(
                                  onGo: () {
                                    setState(() {
                                      _onGoAheadClicked = true;
                                    });
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 12),
                          _backButton(context)
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _enterCodePanel(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 14),
        SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: AppColors.white,
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.black87),
          ),
        )
      ],
    );
  }

  Widget _enterCodePanel() {
    return Container(
      height: _screenHeight * 0.32,
      padding: EdgeInsets.only(
        top: 16,
        right: 32,
        left: 32
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)
        ),
      ),
      child: Column(
        children: <Widget>[
          FingerTip(),
          SizedBox(height: 23),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Atau masukkan kode kelas secara manual',
                style: TextStyle(
                    fontFamily: ConstantHelper.PRIMARY_FONT,
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _classCodeTEC,
                decoration: InputDecoration(
                  labelText: "Kode Kelas",
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: Icon(Icons.short_text, color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                ),
                onChanged: (value) {
                  if (value.length < 5) {
                    _classesBloc.add(ClassCodeValidEvent(
                      isClassCodeValid: false
                    ));
                  } else if (value.length >= 5) {
                    _classesBloc.add(ClassCodeValidEvent(
                      isClassCodeValid: true
                    ));
                  }
                }
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                child: Button(
                  style: ButtonStyle.PRIMARY,
                  text: _classesBloc.isEnrollLoading ? 'Please Wait...' : 'Gabung',
                  onTap: _classesBloc.isClassCodeValid && !_classesBloc.isEnrollLoading
                      ? _joinClass
                      : null,
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}
