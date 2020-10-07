import 'package:flutter/material.dart';
import 'package:foodiie/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color(0xFFFFC529)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  PageController _pageController = PageController();

  AnimationController _animationController;
  Animation _animation;
  Animation _nextBtnAnimation;

  List<Widget> _onBoardingScreens = [
    OnBoardingDetail(
      title: 'Are you tired of cooking?\nGet in touch',
      subtitle: 'We deliver on time',
      image: 'assets/onboarding0.png',
    ),
    OnBoardingDetail(
      title: 'Working from home and without time to cook',
      subtitle: 'We deliver on time',
      image: 'assets/onboarding1.png',
    ),
    OnBoardingDetail(
      title: 'We are #1 Food App Delivery in the country',
      subtitle: 'We deliver on time',
      image: 'assets/onboarding2.png',
    ),
  ];

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = List<Widget>();

    for (int i = 0; i < _onBoardingScreens.length; i++) {
      indicators.add(_buildIndicator(currentPage == i));
    }

    return indicators;
  }

  Widget _buildIndicator(bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 6,
        width: active ? 28 : 5,
        decoration: BoxDecoration(
          color: active ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _nextBtnAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nextButtonWidth = MediaQuery.of(context).size.width * 0.28;
    final primaryColor = Theme.of(context).primaryColor;
    final safeAreaPadding = MediaQuery.of(context).padding;
    final getStartedButtonWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: safeAreaPadding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicators(),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _onBoardingScreens,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage != _onBoardingScreens.length - 1) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
                });
              },
            ),
          ),
          currentPage != _onBoardingScreens.length - 1
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: safeAreaPadding.bottom, horizontal: 40.0),
                  child: FadeTransition(
                    opacity: _nextBtnAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(color: Color(0xFF89898A)),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          child: Container(
                            width: nextButtonWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.0),
                                color: primaryColor),
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                'Next',
                                style: kOnBoardingButtonTextStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {},
                  child: FadeTransition(
                    opacity: _animation,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: safeAreaPadding.bottom),
                      child: Container(
                        width: getStartedButtonWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: primaryColor),
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Next',
                            style: kOnBoardingButtonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class OnBoardingDetail extends StatelessWidget {
  final title;
  final subtitle;
  final image;

  OnBoardingDetail({this.title, this.subtitle, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          subtitle,
          style: TextStyle(color: Color(0xFF89898A)),
        ),
        SizedBox(
          height: 86,
        ),
        Image(
          image: AssetImage(image),
        )
      ],
    );
  }
}
