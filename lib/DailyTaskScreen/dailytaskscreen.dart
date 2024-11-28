import 'dart:async';
import 'dart:math';

import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class DailyTaskScreen extends StatelessWidget {
  const DailyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set container height to screen height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDailyBonus(context),
                    SizedBox(height: 12),
                    _buildSpinAndEarn(context),
                    SizedBox(height: 20),
                    _buildTasksList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameHomepage()),
                );
              },
            ),
            Text(
              'DAILY TASK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              constraints: const BoxConstraints(
                minWidth: 40, // Minimum width
                minHeight: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(113, 47, 160, 1),
                    Color.fromRGBO(54, 47, 145, 1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset('lib/images/coin.png', height: 30),
                  SizedBox(width: 4),
                  Text(
                    '150',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    final tasks = [
      {'title': 'Refer and Earn', 'coins': '100', 'status': 'Completed'},
      {'title': 'Challenge a Friend', 'coins': '100', 'status': 'Completed'},
      {
        'title': 'Leader board Ranking Rewards',
        'coins': '100',
        'status': 'Start'
      },
      {'title': 'Publish Game Task', 'coins': '100', 'status': 'Start'},
      {'title': 'Seasonal Award', 'coins': '100', 'status': 'Start'},
      {'title': 'Challenge a Friend', 'coins': '100', 'status': 'Start'},
      {
        'title': 'Leader board Ranking Rewards',
        'coins': '100',
        'status': 'Start'
      },
      {'title': 'First Purchase Award', 'coins': '100', 'status': 'Start'},
      {'title': 'Seasonal Award', 'coins': '100', 'status': 'Start'},
      {'title': 'Challenge a Friend', 'coins': '100', 'status': 'Start'},
      {
        'title': 'Leader board Ranking Rewards',
        'coins': '100',
        'status': 'Start'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TASK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        ...tasks.map((task) => _buildTaskItem(task)),
      ],
    );
  }

  Widget _buildTaskItem(Map<String, String> task) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          // Left side text
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  task['title']!,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '${task['coins']} coins',
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          // Right side text
          Text(
            task['status']!,
            style: TextStyle(
              color:
                  task['status'] == 'Completed' ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpinAndEarn(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return GestureDetector(
      onTap: () => _showWheelOfRewardsPopup(context),
      child: Container(
        height: isSmallScreen ? 80 : 90,
        margin: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 12,
          vertical: isSmallScreen ? 4 : 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange,
            width: 1.0,
          ),
          borderRadius:
              BorderRadius.circular(10), // Optional: adds rounded corners
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8), // Matches the container's border radius
                child: Image.asset(
                  'lib/images/task2.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyBonus(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return GestureDetector(
      onTap: () => _showDailyBonusPopup(context),
      child: Container(
        height: isSmallScreen ? 80 : 90,
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 12,
          vertical: isSmallScreen ? 4 : 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange,
            width: 1.0,
          ),
          borderRadius:
              BorderRadius.circular(10), // Optional: adds rounded corners
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8), // Matches the container's border radius
                child: Image.asset(
                  'lib/images/task1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDailyBonusPopup(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final isSmallScreen = screenSize.width < 360;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Popup Content
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF35035A),
                    Color(0xFF510985),
                    Color(0xFF35035A),
                  ],
                  stops: [0.1572, 0.5, 0.8753],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFFE97411),
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 0.0 : 0.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(height: 40), // Space for close button
                      _buildHeader(context, 'DAILY BONUS'),
                      SizedBox(height: isSmallScreen ? 15 : 20),
                      _buildTopBoxes(isSmallScreen),
                      _buildProgressSlider(isSmallScreen, context),
                      SizedBox(height: isSmallScreen ? 5 : 10),
                      _buildDailyRewards(screenSize),
                      SizedBox(height: isSmallScreen ? 5 : 10),
                      _buildBronzeBonus(),
                      SizedBox(height: isSmallScreen ? 5 : 10),
                      _buildClaimButton(screenSize),
                      SizedBox(height: isSmallScreen ? 5 : 10),
                    ],
                  ),
                ),
              ),
            ),

            // Close Button
            Positioned(
              right: -10,
              top: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin:
                          Alignment(0, 0.0178), // approximately 178.17 degrees
                      end: Alignment(0, 0.9845),
                      colors: [
                        Color(0xFF712FA0), // #712FA0
                        Color(0xFF362F91), // #362F91
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 231, 143, 20)
                            .withOpacity(0.9),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildClaimButton(Size screenSize) {
  final buttonHeight = screenSize.height < 600 ? 40.0 : 48.0;

  return Container(
    width: 200,
    height: buttonHeight,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF712FA0),
          Color(0xFF362F91),
        ],
        stops: [0.0155, 0.9845],
      ),
      borderRadius: BorderRadius.circular(6), // Smooth corners
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // Matches container
        ),
      ),
      child: Text(
        'Claim',
        style: TextStyle(
          color: Colors.white,
          fontSize: screenSize.width < 360 ? 14 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

_buildBronzeBonus() {
  return LayoutBuilder(builder: (context, constraints) {
    final isSmallScreen = constraints.maxWidth < 360;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 5 : 10,
        horizontal: isSmallScreen ? 5 : 10,
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      // height: 110,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Day 7 ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'lib/images/box1.png',
                      // height: double.infinity,
                      // width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Bronze',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 116, 17, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 18 : 24,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Big Bonus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 16 : 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  });
}

_buildDailyRewards(Size screenSize) {
  return LayoutBuilder(builder: (context, constraints) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 5, // Reduced spacing between rows
        crossAxisSpacing: 5, // Consistent spacing between columns
        padding: EdgeInsets.all(4), // Added padding around the grid
        childAspectRatio: 1.0, // Made containers square
        children: List.generate(6, (index) {
          bool isActive = index == 0;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isActive
                    ? [
                        Color.fromRGBO(54, 47, 145, 1),
                        Color.fromRGBO(113, 47, 160, 1),
                        Color.fromRGBO(54, 47, 145, 1),
                      ]
                    : [
                        Color.fromRGBO(233, 116, 17, 1),
                        Color.fromRGBO(233, 116, 17, 0.7),
                        Color.fromRGBO(233, 116, 17, 1),
                      ],
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(16), // Reduced border radius
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Color.fromRGBO(233, 116, 17, 0.5)
                      : Colors.transparent,
                  blurRadius: 8, // Reduced blur
                  spreadRadius: 1, // Reduced spread
                ),
              ],
            ),
            child: Stack(
              children: [
                // Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4), // Reduced top padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Day ${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, // Reduced font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 0), // Reduced bottom padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ), // Added spacing
                          Image.asset(
                            'lib/images/coin.png',
                            height: 40, // Reduced image size
                          ),
                          Text(
                            '${400 + (index * 200)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14, // Reduced font size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Overlay for inactive days
                if (!isActive)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius:
                            BorderRadius.circular(16), // Match container radius
                      ),
                    ),
                  ),
                // Lock icon
                if (!isActive)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                      size: 16, // Reduced icon size
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  });
}

_buildTopBoxes(bool isSmallScreen) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      for (int i = 1; i <= 4; i++)
        Column(
          children: [
            Image.asset(
              'lib/images/box$i.png',
              height: isSmallScreen ? 32 : 40,
              width: isSmallScreen ? 32 : 40,
            ),
            // SizedBox(height: 5),
            // Text(
            //   '${i * 7}',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: isSmallScreen ? 12 : 14,
            //   ),
            // ),
          ],
        ),
    ],
  );
}

Widget _buildHeader(BuildContext context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 48,
    // height: MediaQuery.of(context).size.height * 0.048,
    // margin: const EdgeInsets.only(
    //     top: 20), // Add margin to account for close button
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF83410A),
          Color(0xFFE97411),
          Color(0xFF88440A),
        ],
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

_buildProgressSlider(bool isSmallScreen, BuildContext context) {
  final double progressWidth = MediaQuery.of(context).size.width * 0.94;
  final double progress = (3 / 28) * progressWidth; // Changed to day 3 of 28

  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: progressWidth,
        height: 20,
        child: Stack(
          children: [
            // Progress Bar Background
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // Progress Bar Fill
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              width: progress,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFFAA4900),
                    Color(0xFFFF8B00),
                    Color(0xFFD96B00),
                  ],
                  stops: [0.071, 0.491, 0.951],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // Marker Points
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: 3 >= 7 ? Color(0xFFFF8B00) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFFF8B00),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '7',
                        style: TextStyle(
                          color: 3 >= 7 ? Colors.white : Color(0xFFFF8B00),
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: 3 >= 14 ? Color(0xFFFF8B00) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFFF8B00),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '14',
                        style: TextStyle(
                          color: 3 >= 14 ? Colors.white : Color(0xFFFF8B00),
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: 3 >= 21 ? Color(0xFFFF8B00) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFFF8B00),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '21',
                        style: TextStyle(
                          color: 3 >= 21 ? Colors.white : Color(0xFFFF8B00),
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: 3 >= 28 ? Color(0xFFFF8B00) : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFFF8B00),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '28',
                        style: TextStyle(
                          color: 3 >= 28 ? Colors.white : Color(0xFFFF8B00),
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}

// Wheel of Rewards import 'dart:math';

void _showWheelOfRewardsPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Bottom Sheet
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(
                color: Color(0xFFE97411),
                width: 1,
              ),
            ),
            child: WheelOfRewardsContent(),
          ),

          // Floating Close Button
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF712FA0),
                        Color(0xFF362F91),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class WheelOfRewardsContent extends StatefulWidget {
  const WheelOfRewardsContent({super.key});

  @override
  _WheelOfRewardsContentState createState() => _WheelOfRewardsContentState();
}

class _WheelOfRewardsContentState extends State<WheelOfRewardsContent> {
  final selected = BehaviorSubject<int>();
  final items = [
    'Facebook Post',
    'Refer & Earn',
    'Facebook Post',
    'Special link',
    'Instagram',
    'Refer & Earn',
  ];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _spinWheel() {
    setState(() {
      selected.add(Random().nextInt(items.length));
    });
  }

  Widget _buildFortuneWheel() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 450,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer border layer
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFE97411), // Orange border
                width: 2,
              ),
            ),
          ),
          // Inner border layer
          Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFF99929B), // Gray border
                width: 1,
              ),
            ),
          ),
          // Fortune wheel
          Container(
            margin: EdgeInsets.all(4),
            child: FortuneWheel(
              selected: selected.stream,
              animateFirst: false,
              physics: CircularPanPhysics(
                duration: const Duration(seconds: 5),
                curve: Curves.easeOutCirc,
              ),
              indicators: [
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'lib/images/spin_wheel-01.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
              items: items.map((item) {
                final index = items.indexOf(item);
                return FortuneItem(
                  style: FortuneItemStyle(
                    color:
                        index % 2 == 0 ? Color(0xFF712FA0) : Color(0xFFE97411),
                    borderWidth: 0,
                    borderColor: Colors.transparent,
                  ),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return index % 2 == 0
                          ? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF712FA0),
                                Color(0xFF362F91),
                              ],
                              stops: [0.0155, 0.9845],
                            ).createShader(bounds)
                          : LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF83410A),
                                Color(0xFFE97411),
                                Color(0xFF88440A),
                              ],
                              stops: [0.071, 0.491, 0.951],
                            ).createShader(bounds);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                        right: 20,
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Bottom decoration
          Positioned(
            bottom: -10,
            child: Image.asset(
              'lib/images/spin_wheel-03.png',
              width: 200,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader2(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      // height: MediaQuery.of(context).size.height * 0.048,
      // margin: const EdgeInsets.only(
      //     top: 20), // Add margin to account for close button
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF83410A),
            Color(0xFFE97411),
            Color(0xFF88440A),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader2('WHEEL OF REWARDS'),
        _buildFortuneWheel(),
        SizedBox(height: 20),
        SpinButtonWidget(
          onPressed: _spinWheel,
        )
      ],
    );
  }
}

class SpinButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const SpinButtonWidget({super.key, required this.onPressed});

  @override
  State<SpinButtonWidget> createState() => _SpinButtonWidgetState();
}

class _SpinButtonWidgetState extends State<SpinButtonWidget> {
  bool isSpinning = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    setState(() {
      isSpinning = true;
    });

    // Cancel any existing timer
    _resetTimer?.cancel();

    // Create new timer to reset after 5 seconds
    _resetTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isSpinning = false;
        });
      }
    });

    widget.onPressed();
  }

  Widget _buildSpinButton() {
    return Container(
      width: 125,
      height: 48,
      decoration: BoxDecoration(
        gradient: isSpinning
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF83410A),
                  Color(0xFFE97411),
                  Color(0xFF88440A),
                ],
                stops: [0.071, 0.491, 0.951],
              )
            : null,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Color(0xFFCA630B),
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: isSpinning ? null : _handlePress,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          isSpinning ? 'Spinning' : 'SPIN',
          style: TextStyle(
            color: isSpinning ? Colors.white : Color(0xFFE97411),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSpinButton();
  }
}
