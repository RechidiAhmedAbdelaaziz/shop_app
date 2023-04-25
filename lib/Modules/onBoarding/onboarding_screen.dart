import 'package:flutter/material.dart';
import 'package:shop_app/Modules/Login/loginScreen.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';
import 'package:shop_app/Shared/Styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel(
    this.title,
    this.body,
    this.image,
  );
}

List<BoardingModel> boarding = [
  BoardingModel('title', 'body', 'image'),
  BoardingModel('title', 'body', 'image'),
  BoardingModel('title', 'body', 'image'),
];

var boardController = PageController();

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  navigateTo(context: context, widget: const LoginScreen());
                },
                child: const Text('Skip'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (value) {
                    setState(() {});
                    isLast = value == boarding.length - 1;
                  },
                  itemBuilder: (context, index) {
                    return itemBoardBuilder(boarding[index]);
                  },
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: !isLast
                        ? () {
                            boardController.nextPage(
                              duration: const Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }
                        : () {
                            replaceWith(
                                context: context, widget: const LoginScreen());
                          },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget itemBoardBuilder(BoardingModel boarding) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Container(
        margin: const EdgeInsets.all(55),
        color: Colors.green,
      )),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        boarding.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        boarding.body,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}
