import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/classes/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/helpers/initial_text_helper.dart';
import 'package:sevenclass/widgets/base/button.dart';

class NewClassForm extends StatefulWidget {
  @override
  _NewClassFormState createState() => _NewClassFormState();
}

class _NewClassFormState extends State<NewClassForm> {
  ClassesBloc _classesBloc;
  BuildContext context;

  GlobalKey<FormState> _newClassForm =  GlobalKey();
  TextEditingController _classNameTEC = TextEditingController();
  TextEditingController _classDescTEC = TextEditingController();

  InitialTextHelper initialTextHelper = InitialTextHelper();
  String classNameInitial = '';

  _createNewClass() {
    _classesBloc.add(CreateNewClassEvent(
        className: _classNameTEC.text,
        classDescription: _classDescTEC.text
    ));
  }

  @override
  Widget build(BuildContext context) {
    _classesBloc = BlocProvider.of<ClassesBloc>(context);
    this.context = context;

    return Column(
      children: <Widget>[
        Form(
          key: _newClassForm,
          child: Column(
            children: <Widget>[
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 80,
                width: 80,
                child: classNameInitial == ''
                    ? Icon(
                        Icons.table_chart,
                        size: 52,
                        color: AppColors.primaryColor
                      )
                    : Center(
                        child: Text(
                          classNameInitial.toString(),
                          style: TextStyle(
                            fontFamily: ConstantHelper.PRIMARY_FONT,
                            fontWeight: FontWeight.w700,
                            fontSize: classNameInitial.length == 1
                                ? 40
                                : classNameInitial.length == 2
                                ? 28
                                : classNameInitial.length == 3
                                ? 24 : 2,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 14),
              TextFormField(
                  controller: _classNameTEC,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Nama Kelas",
                    fillColor: Colors.grey[100],
                    filled: true,
                    prefixIcon: Icon(Icons.short_text, color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                  ),
                  onChanged: (value) {
                    String initial = initialTextHelper.generateInitialText(value);
                    if (initial.length < 4) {
                      setState(() {
                        classNameInitial = initialTextHelper.generateInitialText(value);
                      });
                    }
                  }
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _classDescTEC,
                decoration: InputDecoration(
                  labelText: "Deskripsi Kelas",
                  fillColor: Colors.grey[100],
                  filled: true,
                  prefixIcon: Icon(Icons.textsms, color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: Button(
            style: ButtonStyle.PRIMARY,
            text: _classesBloc.isCreateClassLoading ? 'Please wait...' : 'Buat Kelas Baru',
            onTap: !_classesBloc.isCreateClassLoading ? () => _createNewClass() : null,
          ),
        )
      ],
    );
  }
}
