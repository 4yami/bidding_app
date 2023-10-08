class BiddingItem {
  final String userName;
  final String uid;
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  // final DateTime timeLimit;
  final double startingBidPrice;
  double currentBidPrice;

  BiddingItem({
    required this.userName,
    required this.uid,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    // required this.timeLimit,
    required this.startingBidPrice,
    required this.currentBidPrice,
  });

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "uid": uid,
        "id": id,
        "title": title,
        "description": description,
        "image_urls": imageUrls,
        "starting_bid_price": startingBidPrice,
        "current_bid_price": currentBidPrice,
      };
}
