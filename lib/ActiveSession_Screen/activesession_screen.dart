// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:AAG/ActiveSession_Screen/leaguespage.dart';
import 'package:AAG/ActiveSession_Screen/ludopopup.dart';
import 'package:AAG/ActiveSession_Screen/tournamentpopup.dart';
import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ActiveSessionsScreen extends StatefulWidget {
  const ActiveSessionsScreen({super.key});

  @override
  State<ActiveSessionsScreen> createState() => _ActiveSessionsScreenState();
}

class _ActiveSessionsScreenState extends State<ActiveSessionsScreen> {
  int revealedCount = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.02; // 2% of screen width
    final verticalSpacing = screenSize.height * 0.02; // 2% of screen height

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Updated AppBar section to match ReferAndEarnScreen
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'ACTIVE SESSIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                children: [
                  _buildSection(context, 'GAMES', 'lib/images/ic3.png', 2),
                  SizedBox(height: verticalSpacing - 10),
                  _buildLeagueSection(context, 'LEAGUES', 'lib/images/ic3.png'),
                  SizedBox(height: verticalSpacing - 10),
                  _buildTournamentSection(
                    context,
                    'TOURNAMENT',
                    'lib/images/ic3.png',
                  ),
                  SizedBox(height: verticalSpacing * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildLeagueSection(
    BuildContext context, String title, String iconPath) {
  final screenSize = MediaQuery.of(context).size;
  final horizontalPadding = screenSize.width * 0.02;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildHeader(context, title, iconPath),
      Container(
        // Make the list view take full width minus padding
        width: screenSize.width - (horizontalPadding * 2),
        child: _buildLeagueList(context, screenSize),
      ),
    ],
  );
}

Widget _buildHeader(BuildContext context, String title, String iconPath) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              width: MediaQuery.of(context).size.width * 0.06,
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'View All',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLeagueList(BuildContext context, Size screenSize) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 2,
    itemBuilder: (context, index) => _buildLeagueCard(context, screenSize),
  );
}

Widget _buildLeagueCard(BuildContext context, Size screenSize) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LeaguesPage()),
      ),
      child: _buildCardContainer(context, screenSize),
    ),
  );
}

Widget _buildCardContainer(BuildContext context, Size screenSize) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(233, 116, 17, 0.3),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    ),
    child: _buildAnimatedCard(context, screenSize),
  );
}

Widget _buildAnimatedCard(BuildContext context, Size screenSize) {
  return Animate(
    effects: [
      ShimmerEffect(
        duration: 5.seconds,
        color: const Color.fromARGB(122, 235, 233, 143).withOpacity(0.4),
      ),
    ],
    onPlay: (controller) => controller.repeat(),
    child: _buildGlassmorphicCard(context, screenSize),
  );
}

Widget _buildGlassmorphicCard(BuildContext context, Size screenSize) {
  return GlassmorphicContainer(
    width: screenSize.width * 0.90,
    height: 120, // Fixed height to prevent overflow
    borderRadius: 15,
    blur: 5,
    alignment: Alignment.bottomCenter,
    border: 1.5,
    linearGradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 64, 243, 133).withOpacity(0.4),
        const Color.fromARGB(255, 237, 63, 0).withOpacity(0.5),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderGradient: LinearGradient(
      colors: [
        const Color.fromRGBO(233, 116, 17, 1).withOpacity(0.5),
        const Color.fromRGBO(233, 116, 17, 1).withOpacity(0.1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    child: _buildCardContent(context, screenSize),
  );
}

Widget _buildCardContent(BuildContext context, Size screenSize) {
  return Container(
    height: 120, // Fixed height for the card
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 113, 47, 160),
          Color.fromARGB(255, 54, 47, 145),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: const Color.fromRGBO(233, 116, 17, 1),
        width: 1.5,
      ),
    ),
    child: Stack(
      children: [
        // Left Team (Dhoni)
        Positioned(
          left: screenSize.width * 0.01,
          top: 10,
          child: SizedBox(
            width: screenSize.width * 0.15,
            child: _buildTeamColumn(
              'lib/images/card.png',
              'TEAM DHONI',
              screenSize,
            ),
          ),
        ),

        // VS Image
        Positioned(
          left: screenSize.width * 0.13,
          top: 25,
          child: Image.asset(
            'lib/images/vssss.png',
            height: 40,
            width: screenSize.width * 0.05,
            fit: BoxFit.contain,
          ),
        ),

        // Right Team (Kohli)
        Positioned(
          left: screenSize.width * 0.15,
          top: 10,
          child: SizedBox(
            width: screenSize.width * 0.15,
            child: _buildTeamColumn(
              'lib/images/oppcard.png',
              'TEAM KOHLI',
              screenSize,
            ),
          ),
        ),

        // Timer Section
        Positioned(
          // left: screenSize.width * 0.30,
          right: screenSize.width * 0.24,
          top: 20,
          child: _buildTimerColumn(screenSize),
        ),

        // Ludo Logo
        Positioned(
          right: screenSize.width * 0.02,
          top: 10,
          child: Image.asset(
            'lib/images/ludo.png',
            height: 100,
            width: screenSize.width * 0.15,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTeamColumn(String imagePath, String teamName, Size screenSize) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 70,
          width: screenSize.width * 0.08,
        ),
      ),
      Text(
        teamName,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenSize.width * 0.028,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildTimerColumn(Size screenSize) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Time Left',
        style: TextStyle(
          color: Colors.white,
          fontSize: screenSize.width * 0.033,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const CountdownTimer(),
      ),
    ],
  );
}

Widget _buildTournamentSection(
    BuildContext context, String title, String iconPath) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TournamentScreenPopUp(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(233, 116, 17, 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Animate(
                  effects: [
                    ShimmerEffect(
                      duration: 5.seconds,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ],
                  onPlay: (controller) => controller.repeat(),
                  child: GlassmorphicContainer(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 125,
                    borderRadius: 15,
                    blur: 5,
                    alignment: Alignment.bottomCenter,
                    border: 1.5,
                    linearGradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 64, 243, 133)
                            .withOpacity(0.4),
                        const Color.fromARGB(255, 237, 63, 0).withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        const Color.fromRGBO(233, 116, 17, 1).withOpacity(0.5),
                        const Color.fromRGBO(233, 116, 17, 1).withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 59, 13, 92),
                            Color.fromARGB(255, 58, 26, 87),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color.fromRGBO(233, 116, 17, 1),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Team Card
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/images/card.png',
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 40,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'TEAM A',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),

                            // Prize Pool Column
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prize Pool',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '₹5000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(131, 65, 10, 1),
                                        Color.fromRGBO(233, 116, 17, 1),
                                        Color.fromRGBO(136, 68, 10, 1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    '₹50',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // VS Logo
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromRGBO(
                                            233, 116, 17, 0.3),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'lib/images/vs.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ],
                            ),

                            // Timer Column
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Starting in',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                CountdownTimer(), // You'll need to implement this widget
                              ],
                            ),

                            // Right Team Card
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  width: 39,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'lib/images/oppcard.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'TEAM B',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget _buildSection(
    BuildContext context, String title, String iconPath, int gameCount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            children: [
              Image.asset(iconPath, width: 24, height: 24),
              // const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: const EdgeInsets.all(12),
        children: List.generate(
          gameCount,
          (index) => GestureDetector(
            onTap: () {
              // Updated navigation logic based on subtitle
              switch (title) {
                case 'Games':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PublishLudoScreen()),
                  );
                  break;
                case 'Leagues':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PublishLeagueScreen()),
                  );
                  break;
                case 'Tournament':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PublishTournamentscreen()),
                  );
                  break;
              }
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActiveLudoPopUpScreen(),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.width * 0.30,
                // width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'lib/images/ludo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _timeLeft = 150; // 2:30 in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CountdownTimer2 extends StatefulWidget {
  const CountdownTimer2({super.key});

  @override
  State<CountdownTimer2> createState() => _CountdownTimer2State();
}

class _CountdownTimer2State extends State<CountdownTimer2> {
  late Timer _timer;
  int _timeLeft = 3550; // 2:30 in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
