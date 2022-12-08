import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/ui/on_boarding/pages/on_boarding_page_1.dart';
import 'package:todo_app/ui/on_boarding/pages/on_boarding_page_2.dart';
import 'package:todo_app/ui/on_boarding/pages/on_boarding_page_3.dart';
import 'package:todo_app/ui/widgets/custom_button.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/const.dart';
import 'package:todo_app/utils/text_style.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<Widget> pages = const [
    OnBoardingPageOne(),
    OnBoardingPageTwo(),
    OnBoardingPageThree(),
  ];
  int currentPage = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SKIP BUTTON
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, authPage);
                },
                child: Text('SKIP', style: MyTextStyle.regularLato.copyWith(color: Colors.white.withOpacity(.44))),
              ),

              // PAGES
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  controller: _pageController,
                  children: pages,
                ),
              ),
              const SizedBox(height: 20),

              // PAGE INDICATOR
              Center(
                child: SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 3,
                    effect: const ExpandingDotsEffect(), // your preferred effect
                    onDotClicked: (index) {
                      _pageController.animateToPage(index, curve: Curves.ease, duration: const Duration(milliseconds: 200));
                      setState(() {
                        currentPage = index;
                      });
                    }),
              ),
              const SizedBox(height: 50),

              // BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage != 0
                      ? TextButton(
                          onPressed: () {
                            _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);
                          },
                          child: Text('BACK', style: MyTextStyle.regularLato.copyWith(color: Colors.white.withOpacity(.44))),
                        )
                      : const Expanded(child: SizedBox()),
                  CustomButton(
                    onPressed: () {
                      if (currentPage < 2) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);
                      } else {
                        Navigator.pushNamed(context, authPage);
                      }
                    },
                    fillColor: true,
                    text: currentPage != 2 ? 'NEXT' : 'Get Started',
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
