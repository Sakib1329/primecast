import 'package:get/get.dart';

class LegalController extends GetxController {
  // Metadata
  final String lastUpdated = "January 27, 2026";

  // Terms of Service Data
  final List<Map<String, dynamic>> termsOfService = [
    {
      "title": "1. Acceptance of Terms",
      "content": "By accessing and using PrimeCast, you accept and agree to be bound by the terms and provision of this agreement."
    },
    {
      "title": "2. Service Description",
      "content": "PrimeCast is a premium video streaming service that offers a wide variety of TV shows, movies, and more on thousands of internet-connected devices."
    },
    {
      "title": "3. Subscription and Billing",
      "content": "Your PrimeCast membership will continue and automatically renew until terminated.",
      "bullets": [
        "Monthly subscription fees are charged at the beginning of each billing period",
        "You can cancel your subscription at any time",
        "Refunds are available within 7 days",
      ]
    },
    // Add more sections as needed...
  ];

  // Privacy Policy Data
  final List<Map<String, dynamic>> privacyPolicy = [
    {
      "title": "1. Information We Collect",
      "content": "We collect information to provide better services to all our users. This includes:",
      "bullets": [
        "Account information (name, email, phone)",
        "Payment information (processed securely)",
        "Viewing history and preferences"
      ]
    },
    // Add more sections as needed...
  ];
}