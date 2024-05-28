// OrderSummaryPage.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'complete_order.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key});

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  List<QueryDocumentSnapshot?> completedOrders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderSummaryList(
        onCompleteOrder: (order) async {
          await _saveCompletedOrderToFirebase(order);

          setState(() {
            completedOrders.add(order);
          });

          // Show "Complete Order!" dialog
          _showCompleteOrderDialog(context);

          print('Order Completed: ${order?['fname']}');
        },
        onMoveToCheck: (order) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteOrderPage(
                orders: completedOrders,
              ),
            ),
          );
        },
        showDetailsDialog: (order) {
          _showDetailsDialog(context, order);
        },
      ),
    );
  }

  Future<void> _saveCompletedOrderToFirebase(
      QueryDocumentSnapshot? order) async {
    if (order != null) {
      await FirebaseFirestore.instance.collection('CompleteOrders').add(
            (order.data() as Map<String, dynamic>).cast<String, dynamic>(),
          );

      // Remove the order from the Order collection
      await order.reference.delete();
    }
  }

  void _showDetailsDialog(BuildContext context, QueryDocumentSnapshot? order) {
    showDialog(
      context: context,
      builder: (context) {
        Set<String> uniqueProductNames = <String>{};

        return AlertDialog(
          title: const Center(
            child: Text(
              'Customer Order Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Name: ${order?['fname']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Address: ${order?['address']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Contact No: ${order?['contactNumber']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Message: ${order?['message']}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              if (order?['products'] != null)
                for (var item in order?['products'])
                  if (uniqueProductNames.add(item['productName']))
                    Row(
                      children: [
                        Image.network(
                          item['imageUrl'],
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 8),
                        Text('${item['productName']}'),
                        const Spacer(),
                        Text('x ${item['quantity']}'),
                      ],
                    ),
              const SizedBox(
                height: 6,
              ),
              if (order?['totalprice'] != null)
                Center(
                  child: Text(
                    'Total Amount: ₱ ${order?['totalprice']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );

    // Your existing code for showing details dialog
  }

  void _showCompleteOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Order Completed!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// OrderSummaryList.dart
class OrderSummaryList extends StatelessWidget {
  final void Function(QueryDocumentSnapshot?) onCompleteOrder;
  final void Function(QueryDocumentSnapshot?) onMoveToCheck;
  final void Function(QueryDocumentSnapshot?) showDetailsDialog;

  const OrderSummaryList({
    super.key,
    required this.onCompleteOrder,
    required this.onMoveToCheck,
    required this.showDetailsDialog,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Order').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var orders = snapshot.data?.docs;
        return ListView.builder(
          itemCount: orders?.length,
          itemBuilder: (context, index) {
            var order = orders?[index];

            return ListTile(
              title: Row(
                children: [
                  const Icon(Icons.person, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    ' ${order?['fname']}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      showDetailsDialog(order);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outlined, color: Colors.red),
                    onPressed: () {
                      _deleteOrder(order);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      _moveToCheck(order);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _moveToCheck(QueryDocumentSnapshot? order) {
    if (order != null) {
      onCompleteOrder(order);
      // No need to call onMoveToCheck here; it is now called in _moveToCheck method
    }
  }

  void _deleteOrder(QueryDocumentSnapshot? order) async {
    if (order != null) {
      await order.reference.delete();
    }
  }
}
