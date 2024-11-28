import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/Pages/leaderboardpage.dart';
import 'package:AAG/tobeadded/custom_appbar.dart';
import 'package:AAG/tobeadded/custom_appdrawer.dart';
import 'package:AAG/tobeadded/homescreen_slider.dart';
import 'package:AAG/tobeadded/leaferboard.dart';
import 'package:AAG/tobeadded/plancard.dart';
import 'package:flutter/material.dart';

class GameHomepage extends StatefulWidget {
  const GameHomepage({super.key});

  @override
  State<GameHomepage> createState() => _GameHomepageState();
}

class _GameHomepageState extends State<GameHomepage>
    with SingleTickerProviderStateMixin {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1.0;
  bool isDrawerOpen = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openDrawer() {
    setState(() {
      xOffset = 290;
      yOffset = 80;
      scaleFactor = 0.85;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1.0;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final horizontalPadding =
        screenSize.width * 0.02; // Consistent horizontal padding
    final verticalSpacing =
        screenSize.height * 0.02; // Consistent vertical spacing

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aapka Apna Game',
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            Image.asset(
              'lib/images/idkbg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(scaleFactor),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(40)
                      : BorderRadius.circular(0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpacing),
                        const SizedBox(
                          height: 220,
                          child: EnhancedScrollView(),
                        ),
                        SizedBox(height: verticalSpacing),
                        SizedBox(
                          height: screenSize.height * 0.18,
                          width: double.infinity,
                          child: PromotionalsSlider2(),
                        ),
                        SizedBox(height: verticalSpacing),
                        _buildSectionHeader(
                          context,
                          icon: 'lib/images/ic3.png',
                          title: "ACTIVE GAMES",
                          onViewAll: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ActiveSessionsScreen(),
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacing),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildGameImages(screenSize),
                          ),
                        ),
                        SizedBox(height: verticalSpacing * 1.5),
                        _buildSectionHeader(
                          context,
                          icon: 'lib/images/ic4.png',
                          title: "LEADERBOARD",
                          onViewAll: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LeaderboardPage(),
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacing),
                        const LeaderboardWidget(),
                        SizedBox(height: verticalSpacing * 2.5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onViewAll,
  }) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side with icon and title
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: screenSize.width * 0.06,
                  height: screenSize.width * 0.06,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Right side with View All text
          Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onViewAll,
              behavior: HitTestBehavior.opaque, // Improves tap target
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Increases tap target area
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGameImages(Size screenSize) {
    final gameImages = [
      'lib/images/ludo.png',
      'lib/images/snakes.png',
      'lib/images/ludo.png',
      // 'lib/images/snakes.png',
      // 'lib/images/ludo.png',
      // 'lib/images/snakes.png',
    ];

    return gameImages.map((image) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Image.asset(
          image,
          height: screenSize.width * 0.30,
        ),
      );
    }).toList();
  }
}

class EnhancedScrollView extends StatefulWidget {
  const EnhancedScrollView({super.key});

  @override
  _EnhancedScrollViewState createState() => _EnhancedScrollViewState();
}

class _EnhancedScrollViewState extends State<EnhancedScrollView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: 0,
    );
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PageView.builder(
          controller: _pageController,
          itemCount: 4,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: index == _currentPage ? 1.0 : 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.025,
                ),
                child: _buildCard(index),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(int index) {
    final List<Map<String, String>> cardData = [
      {'name': 'Satyam', 'packageType': 'standard'},
      {'name': 'Anupam', 'packageType': 'pro'},
      {'name': 'Priya', 'packageType': 'elite'},
      {'name': 'Maharani', 'packageType': 'enterprise'},
    ];

    return CustomCard(
      address: '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
      name: cardData[index]['name']!,
      packageType: cardData[index]['packageType']!,
    );
  }
}
