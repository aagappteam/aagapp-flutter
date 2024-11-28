// ignore_for_file: unused_import, sized_box_for_whitespace, avoid_print, use_build_context_synchronously, unused_field
//_initialChildSize
import 'package:AAG/HomeScreen/homescreen_game.dart';
import 'package:AAG/Pages/login_vendor_2.dart';
import 'package:AAG/Pages/loginsignup.dart';
import 'package:AAG/Pages/otp_veri.dart';
import 'package:AAG/Pages/signup.dart';
import 'package:AAG/tobeadded/gradient_button.dart';
import 'package:AAG/tobeadded/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// API Constants
class ApiConstants {
  static const String baseUrl =
      'https://a2ed-2409-40e3-3117-f0ba-dc07-2ae6-ca16-511e.ngrok-free.app/api/v1';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ngrok-skip-browser-warning': '69420',
  };
}

class LoginVendor extends StatefulWidget {
  final String selectedPlan;

  const LoginVendor({super.key, required this.selectedPlan});

  @override
  _LoginVendorState createState() => _LoginVendorState();
}

class _LoginVendorState extends State<LoginVendor> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  double _initialChildSize = 0.50;
  bool _isLoading = false;

  final Map<String, Map<String, String>> countries = {
    'IN': {'flag': '🇮🇳', 'code': '+91'},
    'US': {'flag': '🇺🇸', 'code': '+1'},
    'UK': {'flag': '🇬🇧', 'code': '+44'},
    'AE': {'flag': '🇦🇪', 'code': '+971'},
  };
  String selectedCountry = 'IN';

  // API Test Method
  Future<bool> _testApiConnection() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/otp/test'),
        headers: ApiConstants.headers,
      );
      return response.statusCode == 200;
    } catch (e) {
      print('API Connection Error: $e');
      return false;
    }
  }

  // Send OTP Method
  Future<Map<String, dynamic>> _sendOtp(String mobileNumber, int role) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/account/login-with-otp'),
        headers: ApiConstants.headers,
        body: json.encode({
          'mobileNumber': mobileNumber,
          'role': role, // 4 for Vendor, 5 for Customer
        }),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'otp': responseBody['data']
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to send OTP'
        };
      }
    } catch (e) {
      print('OTP Send Error: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Regular Login with Password Method
  Future<Map<String, dynamic>> _loginWithPassword(
      String mobileNumber, String password, int role) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/account/login-with-password'),
        headers: ApiConstants.headers,
        body: json.encode(
            {'mobileNumber': mobileNumber, 'password': password, 'role': role}),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': responseBody['message']};
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Login failed'
        };
      }
    } catch (e) {
      print('Login Error: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Show Error Dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  // Handle OTP Login
  void _handleOtpLogin() async {
    if (_phoneController.text.isEmpty) {
      _showErrorDialog('Please enter a phone number');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      bool isConnected = await _testApiConnection();
      if (!isConnected) {
        _showErrorDialog('Unable to connect to the server');
        return;
      }

      String fullPhoneNumber =
          '${countries[selectedCountry]!['code']}${_phoneController.text}';

      final otpResult = await _sendOtp(fullPhoneNumber, 4);

      if (otpResult['success']) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                LoginVendor2(
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
        _showErrorDialog(otpResult['message']);
      }
    } catch (e) {
      _showErrorDialog('An unexpected error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Regular Login Method
  void _handleRegularLogin() async {
    if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog('Please enter phone number and password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String fullPhoneNumber =
          '${countries[selectedCountry]!['code']}${_phoneController.text}';

      final loginResult = await _loginWithPassword(
          fullPhoneNumber, _passwordController.text, 4);

      if (loginResult['success']) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const GameHomepage(),
          ),
        );
      } else {
        _showErrorDialog(loginResult['message']);
      }
    } catch (e) {
      _showErrorDialog('An unexpected error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
    _passwordController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _initialChildSize = _phoneFocusNode.hasFocus ? 0.8 : 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Logo at the top
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'lib/images/aag_white.png',
                height: 30,
              ),
            ),
          ),

          // Promotional Slider
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

          // Draggable Login Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6,
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
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Phone Number Input
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
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
                        const SizedBox(height: 20),

                        // Password Input
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
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
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Enter password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // OTP Login Option
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.orange,
                                    )
                                  : TextButton(
                                      onPressed: _handleOtpLogin,
                                      child: const Text(
                                        'LogIn with OTP?',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Login Button
                        Center(
                          child: CustomButton(
                            onTap: _handleRegularLogin,
                            text: 'Login',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Sign Up Option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an Account?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(
                                    selectedPlan: widget.selectedPlan,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
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
                'lib/images/aag_white.png', // Replace with your image path
                height: 30,
                width: 80, // Adjust the height as needed
              ),
            ),
          ),
          Positioned(
              top: 50, // 15 pixels from the top
              left: -(MediaQuery.of(context).size.width * 0.84),
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ) // Adjust the height as needed
              ),
        ],
      ),
    );
  }
}

class CountryCodePicker extends StatefulWidget {
  final Function(String, String) onSelect; // Callback for code and flag

  const CountryCodePicker({
    super.key,
    required this.onSelect,
  });

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  // Map of country codes to their flag emojis
  final Map<String, Map<String, String>> countries = {
    'IN': {'flag': '🇮🇳', 'code': '+91'},
    'US': {'flag': '🇺🇸', 'code': '+1'},
    'UK': {'flag': '🇬🇧', 'code': '+44'},
    'AE': {'flag': '🇦🇪', 'code': '+971'},
  };

  String selectedCountry = 'IN'; // Default to India

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showCountryPicker(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              countries[selectedCountry]!['flag']!, // Flag emoji
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Text(
              '${countries[selectedCountry]!['code']} |',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            String countryKey = countries.keys.elementAt(index);
            return ListTile(
              leading: Text(
                countries[countryKey]!['flag']!,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(countryKey),
              trailing: Text(countries[countryKey]!['code']!),
              onTap: () {
                setState(() {
                  selectedCountry = countryKey;
                });
                widget.onSelect(
                  countries[countryKey]!['code']!,
                  countries[countryKey]!['flag']!,
                );
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
