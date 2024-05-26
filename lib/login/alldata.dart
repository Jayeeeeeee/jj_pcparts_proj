import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/functions/add_data.dart';
import 'package:jj_pcparts_proj/functions/update_data.dart';
import 'package:jj_pcparts_proj/login/user.dart';

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  Stream<List<User>> readUsers() {
    return FirebaseFirestore.instance.collection('User').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => User.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Widget buildList(User user) => ListTile(
        leading: const Icon(Icons.person),
        title: Text(user.name),
        subtitle: Text(user.email),
        dense: true,
        onTap: () {},
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateData(user: user),
                  ),
                );
              },
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              onPressed: () {
                deleteUser(user.id);
              },
              icon: const Icon(Icons.delete_outline),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Firebase Data'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddData(),
              ));
            },
            icon: const Icon(Icons.add_circle),
          )
        ],
      ),
      body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return ListView(
                children: user.map(buildList).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future deleteUser(String id) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    docUser.delete();
  }
}
