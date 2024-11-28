// ignore_for_file: avoid_print, constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// Top-level enum for user roles
enum UserRole {
  SUPPORT(1),
  ADMIN(2),
  ADMIN_VENDOR_PROVIDER(3),
  VENDOR(4),
  CUSTOMER(5);

  final int value;
  const UserRole(this.value);
}

class OtpService {
  // Base URL for the API
  static const String baseUrl = 'https://your-actual-base-url.com/api/v1';

  // Method to send OTP for customer login
  Future<Map<String, dynamic>> sendCustomerOtp(String mobileNumber) async {
    try {
      final requestBody = json.encode({'mobileNumber': mobileNumber});

      final response = await http.post(
        Uri.parse('$baseUrl/otp/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
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
      print('Error sending OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method to verify OTP for login
  Future<Map<String, dynamic>> verifyOtp(
      {required String mobileNumber,
      required UserRole role,
      required String otpEntered}) async {
    try {
      final requestBody = json.encode({
        'mobileNumber': mobileNumber,
        'role': role.value,
        'otpEntered': otpEntered
      });

      final response = await http.post(
        Uri.parse('$baseUrl/otp/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'userDetails': responseBody['data']['userDetails'],
          'token': responseBody['token']
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'OTP verification failed'
        };
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method for admin signup OTP
  Future<Map<String, dynamic>> sendAdminSignupOtp(String mobileNumber) async {
    try {
      final requestBody = json.encode(
          {'mobileNumber': mobileNumber, 'role': UserRole.SUPPORT.value});

      final response = await http.post(
        Uri.parse('$baseUrl/otp/admin-signup'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
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
          'message':
              responseBody['message'] ?? 'Failed to send admin signup OTP'
        };
      }
    } catch (e) {
      print('Error sending admin signup OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method for vendor signup OTP
  Future<Map<String, dynamic>> sendVendorSignupOtp(String mobileNumber) async {
    try {
      final requestBody = json.encode({'mobileNumber': mobileNumber});

      final response = await http.post(
        Uri.parse('$baseUrl/otp/vendor-signup'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
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
          'message':
              responseBody['message'] ?? 'Failed to send vendor signup OTP'
        };
      }
    } catch (e) {
      print('Error sending vendor signup OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method for login with password
  Future<Map<String, dynamic>> loginWithPassword(
      {required String mobileNumber,
      required String password,
      required UserRole role}) async {
    try {
      final requestBody = json.encode({
        'mobileNumber': mobileNumber,
        'password': password,
        'role': role.value
      });

      final response = await http.post(
        Uri.parse('$baseUrl/account/login-with-password'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
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
      print('Error logging in with password: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Utility method to show error dialog
  void showErrorDialog(BuildContext context, String message) {
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
}
