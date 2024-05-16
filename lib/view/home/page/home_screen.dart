import 'package:flutter/material.dart';
import 'package:flutter_bakery/config/color/color.dart';
import 'package:flutter_bakery/config/data/dummy_data.dart';
import 'package:flutter_bakery/view/home/page/page_view_item_widge.dart';

enum Sides { right, left }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int currentpage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  //*
  late final AnimationController _slideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 550),
  );
  late Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(0, 1.5),
    end: const Offset(0, -2),
  ).animate(_slideController);

  //*
  late final AnimationController _slideController2 = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late Animation<Offset> slideAnimation2 = Tween<Offset>(
    begin: const Offset(0, -1.5),
    end: const Offset(0, 1.5),
  ).animate(_slideController2);

  //*
  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  );
  late final Animation<double> rotationAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_rotationController);

  Future<void> onCupcakePageChange(int index, bool isRightSide) async {
    _rotationController.forward();
    _slideController.forward();
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    _slideController2.forward();

    _rotationController
      ..reset()
      ..forward().then((value) async {
        await Future.delayed(
          const Duration(milliseconds: 300),
        );
        _rotationController.reset();
        setState(() {
          slideAnimation2 = Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 1.5),
          ).animate(_slideController2);

          slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1.5),
            end: const Offset(0, -2),
          ).animate(_slideController);
        });
        _slideController.reset();
        _slideController2.reset();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        alignment: Alignment.center,
        color: DummyData.cupCakeList[currentpage].backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //*
            Container(
              height: 420,
              width: 300,
              margin: const EdgeInsets.only(
                top: 70,
              ),
              decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(200),
              ),
            ),

            //* pageview
            PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentpage = value;
                });
              },
              itemCount: DummyData.cupCakeList.length,
              itemBuilder: (context, index) {
                return PageViewItemWidge(
                  index: currentpage,
                  rotationAnimation: rotationAnimation,
                  slideAnimation2: slideAnimation2,
                  slideAnimation: slideAnimation,
                );
              },
            ),

            //* body
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //* Top
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 60,
                        right: 10,
                        left: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.search),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.shopping_cart_outlined),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: AppColor.white.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Choose Your favourite',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //* Bottom
                Column(
                  children: [
                    //*
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                        right: 20,
                        left: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildArrowWidet(Sides.right, 2),
                          _buildAddCardWidget(),
                          _buildArrowWidet(Sides.left, 1)
                        ],
                      ),
                    ),

                    //*
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 80,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 9,
                        ),
                        itemCount: DummyData.cupCakeList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final cupcakeItem = DummyData.cupCakeList[index];
                          return SizedBox(
                            width: 55,
                            child: Column(
                              children: [
                                Image.asset(
                                  cupcakeItem.cupCakeImage,
                                  fit: BoxFit.cover,
                                  height: 50,
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 240),
                                  margin: const EdgeInsets.only(top: 10),
                                  width: currentpage == index ? 40 : 0,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //* widgets
  Widget _buildArrowWidet(Sides sides, int index) {
    bool isRightSide = sides.name == "right";
    return Expanded(
      child: Container(
        height: 60,
        margin: EdgeInsets.only(
            left: isRightSide ? 0 : 20, right: isRightSide ? 20 : 0),
        width: 60,
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(60),
          ),
        ),
        child: IconButton(
          icon: Icon(
            isRightSide
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_forward_ios,
            color: AppColor.white,
          ),
          onPressed: () async {
            if (!isRightSide) {
              onCupcakePageChange(index, false);
      
              _pageController.animateToPage(
                  duration: const Duration(milliseconds: 700),
                  currentpage + 1,
                  curve: Curves.easeInOutSine);
            } else {
              onCupcakePageChange(index, true);
      
              _pageController.animateToPage(
                  duration: const Duration(milliseconds: 700),
                  currentpage - 1,
                  curve: Curves.easeInOutSine);
            }
          },
        ),
      ),
    );
  }

  Container _buildAddCardWidget() {
    return Container(
      height: 60,
      width: 230,
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Center(
        child: Text(
          'Add to card',
          style: TextStyle(
            color: AppColor.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
