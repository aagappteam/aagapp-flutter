// ignore_for_file: constant_identifier_names

import 'package:AAG/LeagueScreen/leaguescreen_one.dart';
import 'package:AAG/PublishGameScreen/gamescreen2.dart';
import 'package:AAG/PublishGameScreen/leaguescreenpage.dart';
import 'package:AAG/PublishGameScreen/ludogamescreen.dart';
import 'package:AAG/PublishGameScreen/tournamentscreenpage.dart';
import 'package:AAG/TournamentScreen/tournamentscreen_one.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

enum HistoryType { Games, Leagues, Tournament }

class PublishGamesScreen extends StatefulWidget {
  const PublishGamesScreen({super.key});

  @override
  State<PublishGamesScreen> createState() => _PublishGamesScreenState();
}

class _PublishGamesScreenState extends State<PublishGamesScreen>
    with SingleTickerProviderStateMixin {
  int revealedCount = 1;
  late TabController _tabController;
  bool isPublishSelected = true;
  bool isGamesSelected = true;
  bool isLeagueSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      if (revealedCount < 5) {
        revealedCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.02; // 2% of screen width
    final verticalSpacing = screenSize.height * 0.02; // 2% of screen height
    final enhancedSpacing = screenSize.height * 0.03; // 3% for enhanced spacing

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
                    'GAMES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: _buildDailyLimit(context),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalSpacing - 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabButton('PUBLISH', isPublishSelected, () {
                          setState(() => isPublishSelected = true);
                        }),
                        SizedBox(width: screenSize.width * 0.06),
                        _buildTabButton('HISTORY', !isPublishSelected, () {
                          setState(() => isPublishSelected = false);
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: verticalSpacing * 0.5),
                    height: 1,
                    color: Colors.white,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            if (!isPublishSelected) ...[
              Container(
                margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildToggleButton('Games', isGamesSelected, () {
                        setState(() => isGamesSelected = true);
                      }),
                    ),
                    Expanded(
                      child: _buildToggleButton('Event', !isGamesSelected, () {
                        setState(() => isGamesSelected = false);
                      }),
                    ),
                  ],
                ),
              ),
              if (!isGamesSelected)
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalSpacing,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabButton('Leagues', isLeagueSelected, () {
                            setState(() => isLeagueSelected = true);
                          }),
                          SizedBox(width: screenSize.width * 0.06),
                          _buildTabButton('Tournament', !isLeagueSelected, () {
                            setState(() => isLeagueSelected = false);
                          }),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: verticalSpacing * 0.5),
                        height: 1,
                        color: Colors.white,
                        width: double.infinity,
                      ),
                    ],
                  ),
                )
            ],
            Expanded(
              child: isPublishSelected
                  ? ListView(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      children: [
                        _buildSection(
                          context,
                          'PUBLISH',
                          'lib/images/ic3.png',
                          'Games',
                          5,
                          verticalSpacing: verticalSpacing,
                        ),
                        SizedBox(height: enhancedSpacing),
                        _buildSection(
                          context,
                          'EVENTS',
                          'lib/images/ic3.png',
                          'Leagues',
                          2,
                          verticalSpacing: verticalSpacing,
                        ),
                        SizedBox(height: verticalSpacing),
                        _buildSection(
                          context,
                          '',
                          '',
                          'Tournament',
                          2,
                          verticalSpacing: verticalSpacing,
                        ),
                      ],
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: _buildHistoryContent(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 16), // Reduced padding
        decoration: BoxDecoration(
          color: isSelected ? Colors.white10 : Colors.transparent,
          borderRadius: BorderRadius.circular(12), // Smaller corner radius
          // border: Border.all(
          //   color: isSelected
          //       ? Colors.orange
          //       : Colors.white.withOpacity(0.5), // Add subtle border
          //   width: 1,
          // ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14, // Reduced font size
              color: Colors.white,
              fontWeight: isSelected
                  ? FontWeight.w600
                  : FontWeight.w400, // Subtle weight difference
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyLimit(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.18,
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade900,
                      Colors.orange.shade800,
                      Colors.orange.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'DAILY LIMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 2,
                            height: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '$revealedCount/5',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (index) => FlipCard(
                      index: index,
                      isRevealed: index < revealedCount,
                      onFlip: incrementCounter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String iconPath,
      String subtitle, int gameCount,
      {required double verticalSpacing}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 8),
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
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(8),
          children: List.generate(
            gameCount,
            (index) => GestureDetector(
              onTap: () {
                switch (subtitle) {
                  case 'Games':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PublishLudoScreen(),
                      ),
                    );
                    break;
                  case 'Leagues':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PublishLeagueScreen(),
                      ),
                    );
                    break;
                  case 'Tournament':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PublishTournamentscreen(),
                      ),
                    );
                    break;
                }
              },
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
      ],
    );
  }

  Widget _buildHistoryContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'September 2024',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        ...List.generate(
          8,
          (index) => _buildHistoryItem(
            // Pass the appropriate type based on the current selection
            type: !isGamesSelected
                ? (isLeagueSelected
                    ? HistoryType.Leagues
                    : HistoryType.Tournament)
                : HistoryType.Games,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem({required HistoryType type}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'lib/images/g1.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'Monday, Sep 11, 2023',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '8:30 AM',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // Navigation logic based on type
                switch (type) {
                  case HistoryType.Games:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LudoPopUpScreen(),
                      ),
                    );
                    break;
                  case HistoryType.Leagues:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeaguesScreenPopup(),
                      ),
                    );
                    break;
                  case HistoryType.Tournament:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TournamentScreenPopup(),
                      ),
                    );
                    break;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'View',
                    style: TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.orange,
                    size: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlipCard extends StatefulWidget {
  final int index;
  final bool isRevealed;
  final VoidCallback onFlip;

  const FlipCard({
    super.key,
    required this.index,
    required this.isRevealed,
    required this.onFlip,
  });

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRevealed = false;
  late Timer _gradientTimer;
  double _gradientPosition = -1.0;

  @override
  void initState() {
    super.initState();
    _isRevealed = widget.isRevealed;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (_isRevealed) {
      _controller.value = 1.0;
    }
    _gradientTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _gradientPosition += 0.02;
        if (_gradientPosition >= 2.0) _gradientPosition = -1.0;
      });
    });
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRevealed != oldWidget.isRevealed) {
      setState(() {
        _isRevealed = widget.isRevealed;
        if (_isRevealed) {
          _controller.value = 1.0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isRevealed) {
          setState(() {
            _isRevealed = true;
          });
          _controller.forward();
          widget.onFlip(); // Call the callback when card is flipped
        }
      },
      child: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.orange.withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * pi;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: angle >= pi / 2
                  ? Transform(
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          height: 80,
                          width: 60,
                          'lib/images/g1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin:
                              Alignment(_gradientPosition, _gradientPosition),
                          end: Alignment(
                              _gradientPosition + 1, _gradientPosition + 1),
                          colors: [
                            Colors.orange.shade800,
                            Colors.orange.shade400,
                            Colors.orange.shade800,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientTimer.cancel();
    super.dispose();
  }
}
