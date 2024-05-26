import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompleteOrderPage extends StatefulWidget {
  final List<QueryDocumentSnapshot?> orders;

  const CompleteOrderPage({super.key, required this.orders});

  @override
  _CompleteOrderPageState createState() => _CompleteOrderPageState();
}

class _CompleteOrderPageState extends State<CompleteOrderPage> {
  Future<List<QueryDocumentSnapshot>> _getOrders() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('CompleteOrders').get();

    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final orders = snapshot.data ?? [];

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    ' ${order['fname']}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
                          _showDetailsDialog(context, order);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outlined,
                            color: Colors.red),
                        onPressed: () {
                          _deleteOrder(order);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
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
                    'Total Amount: PHP ${order?['totalprice']}',
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
  }

  void _deleteOrder(QueryDocumentSnapshot? order) async {
    if (order != null) {
      await order.reference.delete();
    }
    // Update the UI to reflect the changes (remove the deleted order)
    setState(() {
      widget.orders.remove(order);
    });
  }
}
