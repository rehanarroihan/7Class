import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:sevenclass/bloc/classes/bloc.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/base/finger_tip.dart';
import 'package:sevenclass/widgets/base/primary_button.dart';
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

  Function _joinClass;

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if(qrText != scanData){
        setState(() {
          print(scanData);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _classesBloc = BlocProvider.of<ClassesBloc>(context);
    _classesBloc.add(IsCameraPermissionGrantedEvent());

    return BlocListener(
      bloc: _classesBloc,
      listener: (context, state) {},
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
                      SizedBox(height: 38),
                      _backButton(context),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      !_classesBloc.isCameraPermissionGranted
                        ? Expanded(
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                            overlay: QrScannerOverlayShape(
                              borderColor: Colors.red,
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
                  if (value.length < 6) {
                    setState(() {
                      _joinClass = null;
                    });
                  } else if (value.length > 6) {
                    setState(() {
                      _joinClass = () {

                      };
                    });
                  }
                },
                validator: (value) {
                  if (value == "") {
                    return 'Masukkan nama lengkap';
                  }

                  return null;
                },
                autovalidate: false,
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                child: PrimaryButton(
                  text:  'Gabung',
                  onTap: _joinClass,
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}
