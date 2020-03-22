import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class PrivateRoomScreen extends StatefulWidget {
  PrivateRoomScreen({Key key}) : super(key: key);

  @override
  _PrivateRoomScreenState createState() => _PrivateRoomScreenState();
}

class _PrivateRoomScreenState extends State<PrivateRoomScreen>
    with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.5,
          backgroundColor: AppColors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.play_circle_outline, color: AppColors.black),
              SizedBox(width: 12),
              Text(
                'My Routine',
                style: TextStyle(
                  fontFamily: ConstantHelper.PRIMARY_FONT,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 8),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Container(
                    color: AppColors.white,
                    child: TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                      unselectedLabelColor: AppColors.grey,
                      labelColor: AppColors.primaryColor,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.grey
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'Deadline',
                            style: TextStyle(
                              fontFamily: ConstantHelper.PRIMARY_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Schedule',
                            style: TextStyle(
                              fontFamily: ConstantHelper.PRIMARY_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Notes',
                            style: TextStyle(
                              fontFamily: ConstantHelper.PRIMARY_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          Icon(Icons.apps),
          Icon(Icons.movie),
          Icon(Icons.games),
        ]),
      )
    );
  }
}