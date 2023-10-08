import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bidding_app/model/bidding_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BiddingItemPage extends StatefulWidget {
  const BiddingItemPage({super.key});

  @override
  State<BiddingItemPage> createState() => _BiddingItemPageState();
}

class _BiddingItemPageState extends State<BiddingItemPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startingBidController = TextEditingController();
  // DateTime _timeLimit = DateTime.now();
  // List<String> _imageUrls = []; // Assuming you allow multiple images.

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bidding Item Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _startingBidController,
              decoration:
                  const InputDecoration(labelText: 'Starting Bid Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Create a BiddingItem object based on user input.
                BiddingItem newBiddingItem = BiddingItem(
                  userName: _auth.currentUser!.displayName.toString(),
                  uid: _auth.currentUser!.uid,
                  id: UniqueKey().toString(), // Generate a unique ID.
                  title: _titleController.text,
                  description: _descriptionController.text,
                  // imageUrls: _imageUrls,
                  // timeLimit: _timeLimit,
                  startingBidPrice: double.parse(_startingBidController.text),
                  currentBidPrice: double.parse(
                      _startingBidController.text), // Initial bid price.
                );

                // Save or upload the newBiddingItem to Firestore or your data store.
                try {
                  await FirebaseFirestore.instance
                      .collection('bidding_items')
                      .doc(newBiddingItem.id)
                      .set(newBiddingItem.toJson());
                } catch (e) {
                  debugPrint(e.toString());
                }
                // Optionally, navigate to a different page or show a confirmation message.
              },
              child: const Text('Create Bidding Item'),
            ),
          ],
        ),
      ),
    );
  }
}
