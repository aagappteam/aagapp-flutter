import 'package:AAG/ActiveSession_Screen/activesession_screen.dart';
import 'package:AAG/ActiveSession_Screen/animated_score_graph.dart';
import 'package:flutter/material.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  @override
  Widget build(BuildContext context) {
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
            // Custom AppBar
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
                    'LEAGUES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedTeamScore(
                            team: 'My TEAM',
                            score: 3000,
                            color: const Color.fromARGB(255, 213, 98, 45),
                            isLeft: true,
                          ),
                          Column(
                            children: [
                              Image.asset('lib/images/verses.png', height: 100),
                            ],
                          ),
                          AnimatedTeamScore(
                            team: 'KOHLI TEAM',
                            score: 1000,
                            color: Colors.blue,
                            isLeft: false,
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white38, thickness: 1),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF712FA0),
                              Color(0xFF362F91),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'IN LEAD',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'lib/images/prize.png',
                                width: 30,
                                height: 40,
                              ),
                              const Text(
                                '₹3373',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/images/team.png',
                                width: 30,
                                height: 40,
                              ),
                              const Text(
                                '1247',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            children: [
                              Text(
                                'Time Left',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              CountdownTimer(),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF83410A),
                                      Color(0xFFE97411),
                                      Color(0xFF88440A),
                                    ],
                                    stops: [0.071, 0.491, 0.951],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Entry Fee ₹3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
