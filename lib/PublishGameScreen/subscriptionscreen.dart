import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isMonthly = true;
  String selectedPlan = '';
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'STANDARD',
      'monthlyPrice': '₹10,000',
      'annualPrice': '₹96,000', // 20% discount on annual plan
      'subtitle': 'Must Have 100K+ Followers',
      'color1': const Color.fromARGB(255, 113, 47, 160),
      'color2': const Color.fromARGB(255, 54, 47, 145),
      'features': [
        'Must Have 100K+ Followers.',
        'Upto 4 Themes/Skins for the game',
        'Monthly Feature Slots for the games',
        'Performance-Based Event Unlock',
        'Referral Bonus',
        'Analytics Dashboard',
        'Priority Support',
        'Unique Game invite link',
      ],
      'limitations': [
        'No Daily/ Weekly League Access option',
        'No Daily/ Weekly Tournament Access option',
        'No Dedicated Relationship Manager',
        'No Daily/ Weekly Promotional Activities',
        'No Event Customization Option',
      ],
    },
    {
      'title': 'PRO',
      'monthlyPrice': '₹20,000',
      'annualPrice': '₹192,000', // 20% discount on annual plan
      'subtitle': 'Must Have 500K+ Followers',
      'color1': const Color.fromARGB(255, 239, 38, 209),
      'color2': const Color.fromARGB(255, 255, 111, 79),
      'features': [
        'Must Have 500K+ Followers.',
        'Updated Daily Game Publish Limit.',
        'Upto 6 Themes/Skins for the game',
        'Daily/Monthly Feature Slots for the games.',
        'Performance-Based Events Unlock.',
        'Referral Bonus',
        'Analytics Dashboard',
        'Priority Support',
        'Unique Game invite link.',
        'Daily/ Weekly League Access option.',
        'Limited Time Tournament Access option.',
        'Weekly/Monthly Promotional Activities.',
        'Updated Games Access.',
      ],
      'limitations': [
        'Limited Event Customization Options',
        'No Dedicated Relationship Manager',
      ],
    },
    {
      'title': 'ELITE',
      'monthlyPrice': '₹30,000',
      'annualPrice': '₹288,000', // 20% discount on annual plan
      'subtitle': 'Must Have 1M+ Followers',
      'color1': const Color.fromARGB(155, 239, 105, 82),
      'color2': const Color.fromARGB(155, 255, 249, 71),
      'features': [
        'Must-Have 1M+ Followers.',
        'Updated Daily Game Publish Limit.',
        'Upto 12 Themes/Skins for the game',
        'Daily/Weekly/Monthly Feature Slots for the games.',
        'Daily/ Weekly/Monthly League Access option.',
        'Daily/Weekly/Monthly Tournament Access option.',
        'Daily/Weekly/Monthly Promotional Activities.',
        'Special Events Access.',
        'Referral Bonus',
        'Analytics Dashboard',
        'Customized Game invite link.',
        'All Platform Games Access.',
        'Priority Access to Beta Features.',
        'Additional Event Customization Options',
        'Dedicated Relationship Manager'
      ],
      'limitations': [], // No limitations for Elite plan
    },
    {
      'title': 'ENTERPRISE',
      'monthlyPrice': '₹40,000',
      'annualPrice': '₹384,000', // 20% discount on annual plan
      'subtitle': 'Upto 10X Return',
      'color1': const Color.fromARGB(255, 3, 189, 156),
      'color2': const Color.fromARGB(255, 3, 87, 12),
      'features': [
        'Customized Features and Plan Details',
        'Custom Plans For Business Individuals Only',
        '10x Return',
      ],
      'limitations': [], // No limitations for Enterprise plan
    },
  ];

  String _getPrice(Map<String, dynamic> plan) {
    return isMonthly ? plan['monthlyPrice'] : plan['annualPrice'];
  }

  String _getPeriod() {
    return isMonthly ? 'month' : 'year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'SUBSCRIPTION',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight + 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and s Ipsum.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            _buildSubscriptionToggle(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: plans.length,
                effect: WormEffect(
                  dotColor: Colors.grey.withOpacity(0.5),
                  activeDotColor: Colors.orange,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: plans.length,
                itemBuilder: (context, index) => _buildPlanCard(plans[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [plan['color1'], plan['color2']],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      plan['subtitle'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_getPrice(plan)} / ${_getPeriod()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!isMonthly)
                      Text(
                        '20% savings',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ...plan['features']
                        .map<Widget>((feature) => _buildFeatureItem(
                              feature,
                              isPositive: true,
                              colors: [plan['color1'], plan['color2']],
                            )),
                    ...plan['limitations']
                        .map<Widget>((limitation) => _buildFeatureItem(
                              limitation,
                              isPositive: false,
                              colors: [Colors.red, Colors.red.shade900],
                            )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 145,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(145, 30),
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              elevation: 0,
                            ),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF83410A),
                                    Color(0xFFE97411),
                                    Color(0xFF88440A),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Choose Plan',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text,
      {required bool isPositive, required List<Color> colors}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              isPositive ? Icons.check : Icons.close,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => isMonthly = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isMonthly ? Colors.orange : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Monthly',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => isMonthly = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: !isMonthly ? Colors.orange : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Annual',
                      style: TextStyle(color: Colors.white),
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
}
