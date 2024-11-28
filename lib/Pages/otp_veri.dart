// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:AAG/Pages/login_vendor.dart';
import 'package:AAG/Pages/otpservice.dart';
import 'package:AAG/Pages/package_screen.dart'; // Import the OtpService
import 'package:AAG/tobeadded/promo_slider.dart';
import 'package:flutter/material.dart';
import '../tobeadded/gradient_button.dart';
import 'otp_verification.dart';

class SignUpPage extends StatefulWidget {
  final String selectedPlan;
  const SignUpPage({super.key, required this.selectedPlan});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Map of country codes to their flag emojis
  final Map<String, Map<String, String>> countries = {
    'IN': {'flag': '🇮🇳', 'code': '+91'},
    'US': {'flag': '🇺🇸', 'code': '+1'},
    'UK': {'flag': '🇬🇧', 'code': '+44'},
    'AE': {'flag': '🇦🇪', 'code': '+971'},
  };

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final OtpService _otpService =
      OtpService(); // Create an instance of OtpService
  double _initialChildSize = 0.5;
  String selectedCountry = 'IN'; // Default to India
  bool _isLoading = false; // Add loading state

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _phoneFocusNode.removeListener(_onFocusChange);
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _initialChildSize = _phoneFocusNode.hasFocus ? 0.8 : 0.5;
    });
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(22, 13, 37, 1),
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              String countryKey = countries.keys.elementAt(index);
              return ListTile(
                leading: Text(
                  countries[countryKey]!['flag']!,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  countryKey,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  countries[countryKey]!['code']!,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    selectedCountry = countryKey;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _sendVendorSignupOtp() async {
    // Validate phone number
    if (_phoneController.text.isEmpty) {
      _otpService.showErrorDialog(context, 'Please enter a phone number');
      return;
    }

    // Construct full phone number
    String fullPhoneNumber =
        '${countries[selectedCountry]!['code']!}${_phoneController.text}';

    setState(() {
      _isLoading = true;
    });

    try {
      // Call vendor signup OTP method
      Map<String, dynamic> response =
          await _otpService.sendVendorSignupOtp(fullPhoneNumber);

      if (response['success']) {
        // Navigate to OTP Verification Page
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                OTPVerificationPage(
              phoneNumber: fullPhoneNumber,
              selectedPlan: widget.selectedPlan,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      } else {
        // Show error dialog if OTP sending fails
        _otpService.showErrorDialog(context, response['message']);
      }
    } catch (e) {
      _otpService.showErrorDialog(
          context, 'An error occurred while sending OTP');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  child: PromotionalsSlider(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/idkbg.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white30,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(243, 21, 136, 0.945),
                                  Color.fromRGBO(169, 3, 210, 1)
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(22, 13, 37, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.only(bottom: 2),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => _showCountryPicker(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            countries[selectedCountry]![
                                                'flag']!,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${countries[selectedCountry]!['code']} |',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneController,
                                      focusNode: _phoneFocusNode,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter phone number',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : CustomButton(
                                  onTap: _sendVendorSignupOtp,
                                  text: 'Send OTP',
                                ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an Account?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginVendor(
                                    selectedPlan: widget.selectedPlan,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'lib/images/aag_white.png',
                height: 30,
                width: 80,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: -(MediaQuery.of(context).size.width * 0.84),
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PackageScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
