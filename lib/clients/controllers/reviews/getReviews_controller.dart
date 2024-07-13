import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Define the Customer class
class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImage;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  String get fullName => '$firstName $lastName';

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }
}

// Define the CustomerReview class
class CustomerReview {
  final String id;
  final String shopId;
  final String customerId;
  final String shopType;
  final double rate;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  String name;
  String profileImage;

  CustomerReview({
    required this.id,
    required this.shopId,
    required this.customerId,
    required this.shopType,
    required this.rate,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.name = '',
    this.profileImage = '',
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      id: json['id'] ?? '',
      shopId: json['shop_id'] ?? '',
      customerId: json['customer_id'] ?? '',
      shopType: json['shop_type'] ?? '',
      rate: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
    );
  }

  CustomerReview copyWith({
    String? name,
    String? profileImage,
  }) {
    return CustomerReview(
      id: id,
      shopId: shopId,
      customerId: customerId,
      shopType: shopType,
      rate: rate,
      comment: comment,
      createdAt: createdAt,
      updatedAt: updatedAt,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

// Define the GetReviewController class
class GetReviewController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var customerReviews = <CustomerReview>[].obs;

  Future<void> getReviews(String shopId) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/reviews/getReviewsByShopId/$shopId'),
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = jsonDecode(response.body);
        print('data: ${response.statusCode}');
        print('data: ${responseBody}');
        if (responseBody != null && responseBody is List) {
          List<CustomerReview> reviews = _parseCustomerReviews(responseBody);
          customerReviews.assignAll(await _attachCustomerDetails(reviews));
        } else {
          print('Response body is not a list or is null');
        }
      } else {
        throw Exception('Failed to retrieve reviews');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  List<CustomerReview> _parseCustomerReviews(List<dynamic> responseBody) {
    return responseBody.map((item) => CustomerReview.fromJson(item)).toList();
  }

  Future<List<CustomerReview>> _attachCustomerDetails(
      List<CustomerReview> reviews) async {
    var customers = await fetchCustomers();
    return reviews.map((review) {
      var customer =
          customers.firstWhere((customer) => customer.id == review.customerId);
      return review.copyWith(
        name: customer.fullName,
        profileImage: customer.profileImage,
      );
    }).toList();
  }

  Future<List<Customer>> fetchCustomers() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.127:5000/api/customer/allCustomers'),
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = jsonDecode(response.body);
        return _parseCustomers(responseBody);
      } else {
        print(
            'Failed to retrieve customers. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to retrieve customers');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  List<Customer> _parseCustomers(List<dynamic> responseBody) {
    return responseBody.map((item) => Customer.fromJson(item)).toList();
  }
}
