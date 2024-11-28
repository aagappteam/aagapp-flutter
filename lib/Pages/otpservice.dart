// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class OtpService {
  // Base URL for the API - replace with your actual base URL
  static const String baseUrl =
      'https://a2ed-2409-40e3-3117-f0ba-dc07-2ae6-ca16-511e.ngrok-free.app/api/v1/otp/test';

  // Method to test the API connection
  Future<bool> testApiConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/otp/test'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successfully connected to the test endpoint
        print('API Connection Test Successful');
        return true;
      } else {
        // Failed to connect
        print('API Connection Test Failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any network or connection errors
      print('Error testing API connection: $e');
      return false;
    }
  }

  // Method to send OTP
  Future<bool> sendOtp(String mobileNumber) async {
    try {
      // Validate mobile number (you can add more robust validation)
      if (mobileNumber.isEmpty) {
        throw Exception('Mobile number cannot be empty');
      }

      // Prepare the request body
      final requestBody = json.encode({
        'mobileNumber': mobileNumber,
      });

      // Send OTP request
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/otp/send-otp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // OTP sent successfully
        print('OTP sent successfully');
        return true;
      } else {
        // OTP sending failed
        print('OTP sending failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any network or connection errors
      print('Error sending OTP: $e');
      return false;
    }
  }

  // Method to show error dialog
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
