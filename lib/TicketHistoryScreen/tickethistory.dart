import 'package:flutter/material.dart';

class TicketData {
  final String issue;
  final String ticketId;
  final bool isActive;
  final String status;
  final String date;
  final String icon;

  TicketData({
    required this.issue,
    required this.ticketId,
    required this.isActive,
    required this.status,
    required this.date,
    required this.icon,
  });
}

class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['ALL', 'ACTIVE', 'RESOLVED'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabAnimation);
  }

  void _handleTabAnimation() {
    if (_tabController.index != _tabController.animation!.value) {
      final int newIndex =
          _tabController.animation!.value.round() % _tabs.length;
      if (newIndex != _tabController.index) {
        _tabController.index = newIndex;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.05,
                floating: true,
                pinned: false,
                snap: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'TICKET HISTORY',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.orange,
                        labelColor: Colors.orange,
                        unselectedLabelColor: Colors.white,
                        onTap: (index) {
                          setState(() {
                            _tabController.index = index; // Activate tapped tab
                          });
                        },
                        tabs:
                            _tabs.map((String tab) => Tab(text: tab)).toList(),
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildTicketList(allTickets),
              _buildTicketList(activeTickets),
              _buildTicketList(resolvedTickets),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketList(List<TicketData> tickets) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return _buildTicketItem(tickets[index]);
      },
    );
  }

  Widget _buildTicketItem(TicketData ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple.withOpacity(0.3),
            Colors.purple.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  ticket.issue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ticket.isActive
                      ? Colors.orange.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                ),
                child: Text(
                  ticket.isActive ? 'Active' : 'Resolved',
                  style: TextStyle(
                    color: ticket.isActive ? Colors.orange : Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ticket ID: ${ticket.ticketId}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              Text(
                ticket.date,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            ticket.status,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<TicketData> get allTickets {
    return [
      TicketData(
        issue: "I'm unable to withdraw money.",
        ticketId: "IN.2611TI25649556x",
        isActive: true,
        status: "We are working on it!",
        date: "17 Nov",
        icon: "support_icon",
      ),
      TicketData(
        issue: "I'm unable to withdraw money.",
        ticketId: "IN.2611TI25649556x",
        isActive: false,
        status: "Closed!",
        date: "17 Nov",
        icon: "support_icon",
      ),
      // Add more sample tickets as needed
    ];
  }

  List<TicketData> get activeTickets {
    return allTickets.where((ticket) => ticket.isActive).toList();
  }

  List<TicketData> get resolvedTickets {
    return allTickets.where((ticket) => !ticket.isActive).toList();
  }
}
