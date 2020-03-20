import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:sevenclass/bloc/classes/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
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

  Future<void> _alreadyJoined(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have joined this class'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Go to class'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          _alreadyJoined(context);
        } else if (state is EnrollClassNotFoundState) {
          _alreadyJoined(context);
        }
      },
      child: BlocBuilder(
        bloc: _classesBloc,
        builder: (context, state) {
          return Scaffold(
            body: SlidingPanel(
              controller: _pc,
              isDraggable: false,
              minHeight: _screenHeight * 0.32,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)
              ),
              body: Container(
                color: Colors.black87,
                child: Container(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      _backButton(context),
                      _classesBloc.isCameraPermissionGranted
                        ? Expanded(
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
                              overlay: QrScannerOverlayShape(
                                borderColor: AppColors.primaryColor,
                                borderRadius: 10,
                                borderLength: 30,
                                borderWidth: 10,
                                cutOutSize: 300,
                              ),
                            ),
                          )
                        : CameraPermission(),
                    ],
                  ),
                ),
              ),
              panel: _enterCodePanel(),
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
            backgroundColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.black87),
          ),
        )
      ],
    );
  }

  Widget _enterCodePanel() {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        right: 32,
        bottom: 32,
        left: 32
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
                  text: _classesBloc.isEnrollLoading ? 'Plese Wait...' : 'Gabung',
                  onTap: _classesBloc.isClassCodeValid && !_classesBloc.isEnrollLoading
                      ? _joinClass : null,
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}
