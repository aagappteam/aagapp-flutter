import 'package:flutter/material.dart';

class Transaction {
  final String type; // 'Cr' or 'Db'
  final double amount;
  final String name;
  final DateTime date;
  final String upiTransactionId;
  final String from;
  final String to;
  final String transactionId;

  Transaction({
    required this.type,
    required this.amount,
    required this.name,
    required this.date,
    required this.upiTransactionId,
    required this.from,
    required this.to,
    required this.transactionId,
  });
}

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height:
                  MediaQuery.of(context).size.height * 0.5, // Reduced from 0.6
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF35035A),
                    Color(0xFF510985),
                    Color(0xFF35035A),
                  ],
                  stops: [0.1572, 0.50, 0.8753],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(color: Colors.orange, width: 2),
                  left: BorderSide(color: Colors.orange, width: 2),
                  right: BorderSide(color: Colors.orange, width: 2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40, // Reduced from 50
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF83410A),
                          Color(0xFFE97411),
                          Color(0xFF88440A),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'TRANSACTION DETAILS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Reduced from 20
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10), // Reduced from 15
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${transaction.date.day} ${_getMonth(transaction.date.month)} ${transaction.date.year}, ${_formatTime(transaction.date)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14, // Reduced from 16
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Reduced from 40
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transaction.type == 'Cr' ? 'Credited' : 'Debited',
                              style: const TextStyle(
                                color: Color(0xFFE97411),
                                fontSize: 15, // Reduced from 16
                              ),
                            ),
                            Text(
                              '₹${transaction.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: transaction.type == 'Cr'
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12), // Reduced from 16
                        _buildTransactionDetail(
                          'UPI Transaction ID',
                          transaction.upiTransactionId,
                        ),
                        _buildTransactionDetail('To', transaction.to),
                        _buildTransactionDetail('From', transaction.from),
                        _buildTransactionDetail(
                          'Transaction ID',
                          transaction.transactionId,
                        ),
                        const SizedBox(height: 20), // Reduced from 40
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildGradientButton('Send Email', () {}),
                            _buildGradientButton('PDF Download', () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    width: 36, // Reduced from 40
                    height: 36, // Reduced from 40
                    decoration: const BoxDecoration(
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
                      size: 20, // Reduced from 24
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

  static Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      width: 120,
      height: 50,
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  static Widget _buildTransactionDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFFE97411), fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  static String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  static String _formatTime(DateTime date) {
    final hours = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final minutes = date.minute.toString().padLeft(2, '0');
    return '$hours:$minutes $amPm';
  }

  @override
  Widget build(BuildContext context) {
    // Sample transaction data
    final List<Transaction> transactions = [
      Transaction(
        type: 'Cr',
        amount: 50.00,
        name: 'Sumit Singh',
        date: DateTime.now(),
        upiTransactionId: 'UPI123456',
        from: 'Aag',
        to: 'Sumit',
        transactionId: 'TXN123456',
      ),
      Transaction(
        type: 'Db',
        amount: 30.00,
        name: 'John Doe',
        date: DateTime.now().subtract(const Duration(days: 1)),
        upiTransactionId: 'UPI789012',
        from: 'Aag',
        to: 'John',
        transactionId: 'TXN789012',
      ),
      Transaction(
        type: 'Db',
        amount: 130000.00,
        name: 'Arpit Tripathi',
        date: DateTime.now().subtract(const Duration(days: 1)),
        upiTransactionId: 'UPI789012',
        from: 'Aag',
        to: 'Arpit Tripathi',
        transactionId: 'TXN789012',
      ),
      Transaction(
        type: 'Cr',
        amount: 130.00,
        name: 'Joe Goldberg',
        date: DateTime.now().subtract(const Duration(days: 1)),
        upiTransactionId: 'UPI789012',
        from: 'Aag',
        to: 'John',
        transactionId: 'TXN789012',
      ),
      Transaction(
        type: 'Db',
        amount: 37500.00,
        name: 'Randy Orton',
        date: DateTime.now().subtract(const Duration(days: 1)),
        upiTransactionId: 'UPI789012',
        from: 'Aag',
        to: 'Randy Orton',
        transactionId: 'TXN789012',
      ),
      Transaction(
        type: 'Cr',
        amount: 1530.00,
        name: 'Brock Lesnar',
        date: DateTime.now().subtract(const Duration(days: 1)),
        upiTransactionId: 'UPI789012',
        from: 'Aag',
        to: 'Brock Lesnar',
        transactionId: 'TXN789012',
      ),
      Transaction(
        type: 'Cr',
        amount: 7530.00,
        name: 'Snoopy Shukla',
        date: DateTime.now().subtract(const Duration(days: 1)),
        upiTransactionId: 'UPI789012',
        from: 'Aag',
        to: 'Snoopy Shukla',
        transactionId: 'TXN789012',
      ),
      // Add more sample transactions as needed
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/idkbg.jpg'),
            fit: BoxFit.cover,
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
                    'TRANSACTIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildMonthSection('October 2024'),
                  ...transactions.map(
                      (transaction) => _buildInvoiceItem(context, transaction)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSection(String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        month,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInvoiceItem(BuildContext context, Transaction transaction) {
    return InkWell(
      onTap: () => _showTransactionDetails(context, transaction),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.2),
              Colors.deepPurple.withOpacity(0.3),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            transaction.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            '${transaction.date.day} ${_getMonth(transaction.date.month)} ${transaction.date.year}, ${_formatTime(transaction.date)}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${transaction.type == 'Cr' ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.type == 'Cr' ? Colors.green : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
