import 'package:AAG/LeagueScreen/scheduledleaguescreen.dart';
import 'package:AAG/PublishGameScreen/schedulegamescreen_2.dart';
import 'package:AAG/TournamentScreen/scheduletournamentscreen_2.dart';
import 'package:flutter/material.dart';

class ScheduledEventsScreen extends StatefulWidget {
  const ScheduledEventsScreen({super.key});

  @override
  State<ScheduledEventsScreen> createState() => _ScheduledEventsScreenState();
}

class _ScheduledEventsScreenState extends State<ScheduledEventsScreen>
    with TickerProviderStateMixin {
  // Changed from SingleTickerProviderStateMixin
  late TabController _tabController;
  bool isGamesSelected = true;
  bool isLeagueSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _handleViewNavigation() {
    if (isGamesSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditableScheduledGameScreen(),
        ),
      );
    } else {
      if (isLeagueSelected) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScheduledLeagueScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditableScheduledTournamentScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SCHEDULED EVENTS',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange)),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isGamesSelected = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isGamesSelected
                                ? Colors.orange
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'GAMES',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isGamesSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isGamesSelected
                                ? Colors.orange
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'EVENTS',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isGamesSelected)
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white24,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLeagueSelected = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'LEAGUE',
                                style: TextStyle(
                                  color: isLeagueSelected
                                      ? Colors.orange
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                color: isLeagueSelected
                                    ? Colors.orange
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLeagueSelected = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'TOURNAMENT',
                                style: TextStyle(
                                  color: !isLeagueSelected
                                      ? Colors.orange
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                color: !isLeagueSelected
                                    ? Colors.orange
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'September 2024',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    if (index == 4) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'October 2024',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          _buildEventCard(),
                        ],
                      );
                    }
                    return _buildEventCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: const Color.fromARGB(255, 233, 116, 17), width: 1),
      ),
      child: ListTile(
        title: const Text(
          'Monday, 11, 2023',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '8:30 AM',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            GestureDetector(
              onTap: _handleViewNavigation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'View ',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 233, 116, 17)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  const Icon(
                    Icons.remove_red_eye,
                    color: Color.fromARGB(255, 233, 116, 17),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
