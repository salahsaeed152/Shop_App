import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String imagePath;
  final String title;
  final String body;

  BoardingModel({
    @required this.imagePath,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      imagePath: 'assets/images/on_boarding_2.jpg',
      title: 'DISCOVER',
      body: 'welcome to our shop',
    ),
    BoardingModel(
      imagePath: 'assets/images/on_boarding_2.jpg',
      title: 'MAKE THE PAYMENT',
      body: 'Screen Body 2',
    ),
    BoardingModel(
      imagePath: 'assets/images/on_boarding_2.jpg',
      title: 'ENJOY YOUR SHOPPING',
      body: 'Screen Body 3',
    ),
  ];

  var boardingController = PageController();

  bool isLast = false;

  void saveOnBoardingState(){
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value){
      if(value){
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    }).catchError((error){
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: saveOnBoardingState,
              text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => onBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      saveOnBoardingState();
                    }
                    boardingController.nextPage(
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: new Image.asset(
              boardingModel.imagePath,
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            '${boardingModel.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            '${boardingModel.body}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

}
