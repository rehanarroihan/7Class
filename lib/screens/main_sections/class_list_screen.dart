import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/classes/bloc.dart';
import 'package:sevenclass/bloc/classes/classes_bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/models/my_classes_model.dart';
import 'package:sevenclass/screens/join_class_screen.dart';

class ClassListScreen extends StatelessWidget {
  ClassesBloc _classesBloc;

  @override
  Widget build(BuildContext context) {
    _classesBloc = BlocProvider.of<ClassesBloc>(context);

    return BlocListener(
      bloc: _classesBloc,
      listener: (context, state) {},
      child: BlocBuilder(
        bloc: _classesBloc,
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.blueBackground,
          appBar: _appBar(),
          body: _body(),
          floatingActionButton: _fab(context),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 2.5,
      backgroundColor: AppColors.white,
      title: Text(
        'My Classes',
        style: TextStyle(
          fontFamily: ConstantHelper.PRIMARY_FONT,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: _classesBloc.classList.length,
            itemBuilder: (BuildContext context, index) {
              Classes item = _classesBloc.classList[index];
              return _classItem(item);
            },
          ),
        )
      ],
    );
  }

  Widget _fab(context) {
    return FloatingActionButton(
      tooltip: 'Join class',
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => JoinClassScreen()
        ));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }

  Widget _classItem(Classes item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0XFFD3D6DA).withAlpha(50),
            offset: Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 1
          )
        ]
      ),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.name,
                  style: TextStyle(
                    fontFamily: ConstantHelper.PRIMARY_FONT,
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  item.description,
                  style: TextStyle(
                    fontFamily: ConstantHelper.PRIMARY_FONT,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
