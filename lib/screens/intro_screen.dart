import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/models/slider.dart';
import 'package:sevenclass/screens/welcome_screen.dart';
import 'package:sevenclass/widgets/base/descriptive.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    print(_currentPage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _itemImages(),
                    SizedBox(height: 40),
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              IntroItemDot(true)
                            else
                              IntroItemDot(false)
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Descriptive(
                        title: sliderArrayList[_currentPage].sliderHeading,
                        description: sliderArrayList[_currentPage].sliderSubHeading
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 92
                      ),
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {},
                        color: AppColors.bluePrimary,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)
                        ),
                        child: Text(
                          _currentPage != 2 ? 'Next' : 'Get Started',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstantHelper.PRIMARY_FONT,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: sliderArrayList.length,
                  itemBuilder: (ctx, i) => Container(
                    child: GestureDetector(
                      onTap: () {
                        int toPage = _currentPage;
                        print(toPage.toString());
                        if (_currentPage == 0) {
                          toPage = 1;
                          _pageController.jumpToPage(toPage);
                          setState(() {
                            _currentPage = toPage;
                          });
                        } else if (_currentPage == 1) {
                          toPage = _currentPage = 2;
                          _pageController.jumpToPage(toPage);
                          setState(() {
                            _currentPage = toPage;
                          });
                        } else if (_currentPage == 2) {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => WelcomeScreen()
                          ));
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }

  Widget _itemImages() {
    return Container(
      height: MediaQuery.of(context).size.width * 0.80,
      width: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(sliderArrayList[_currentPage].sliderImageUrl)
          )
      ),
    );
  }
}

class IntroItemDot extends StatelessWidget {
  bool isActive;
  IntroItemDot(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 11,
      width: 11.5,
      decoration: BoxDecoration(
        color: isActive ? AppColors.bluePrimary : AppColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}