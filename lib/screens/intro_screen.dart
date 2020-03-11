import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/splash/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/models/slider.dart';
import 'package:sevenclass/screens/welcome_screen.dart';
import 'package:sevenclass/widgets/base/descriptive.dart';
import 'package:sevenclass/widgets/base/primary_button.dart';

class IntroScreen extends StatelessWidget {
  SplashBloc _splashBloc;

  @override
  Widget build(BuildContext context) {
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    final PageController _pageController = PageController(initialPage: 0);

    return BlocListener(
      bloc: _splashBloc,
      listener: (context, state) {
        if (state is SetIntroCurrentPageState) {
          _pageController.jumpToPage(state.page);
        } else if (state is ClearFirstTimeConditionState) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()
          ));
        }
      },
      child: BlocBuilder(
        bloc: _splashBloc,
        builder: (context, state) {
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
                          Container(
                            height: MediaQuery.of(context).size.width * 0.80,
                            width: MediaQuery.of(context).size.height * 0.60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(sliderArrayList[_splashBloc.introCurrentPage].sliderImageUrl)
                              )
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            alignment: AlignmentDirectional.center,
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < sliderArrayList.length; i++)
                                  if (i == _splashBloc.introCurrentPage)
                                    IntroItemDot(true)
                                  else
                                    IntroItemDot(false)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Descriptive(
                            title: sliderArrayList[_splashBloc.introCurrentPage].sliderHeading,
                            description: sliderArrayList[_splashBloc.introCurrentPage].sliderSubHeading
                          ),
                          SizedBox(height: 40),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 92
                            ),
                            width: double.infinity,
                            child: PrimaryButton(
                              text: _splashBloc.introCurrentPage != 2 ? 'Next' : 'Get Started',
                              onTap: () {},
                              isRounded: true
                            ),
                          ),
                        ],
                      ),
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: (int index) => _splashBloc.add(SetIntroCurrentPageEvent(index)),
                        itemCount: sliderArrayList.length,
                        itemBuilder: (ctx, i) => Container(
                          child: GestureDetector(
                            onTap: () {
                              int toPage = _splashBloc.introCurrentPage;
                              if (_splashBloc.introCurrentPage == 0) {
                                toPage = 1;
                                _splashBloc.add(SetIntroCurrentPageEvent(toPage));
                              } else if (_splashBloc.introCurrentPage == 1) {
                                toPage = 2;
                                _splashBloc.add(SetIntroCurrentPageEvent(toPage));
                              } else if (_splashBloc.introCurrentPage == 2) {
                                _splashBloc.add(ClearFirstTimeConditionEvent());
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
        color: isActive ? AppColors.primaryColor : AppColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}