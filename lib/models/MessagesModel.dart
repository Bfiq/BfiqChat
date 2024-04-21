class MessageModel {
  String? id;
  final String user1;
  final String user2;
  String? message;
  String? audioUrl;
  String? imageUrl;

  MessageModel(
      {this.id,
      required this.user1,
      required this.user2,
      this.message,
      this.audioUrl,
      this.imageUrl});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['uid'],
        user1: json['user1'],
        user2: json['user2'],
        message: json['message'],
        audioUrl: json['audioUrl'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'user1': user1,
        'user2': user2,
        'message': message,
        'audioUrl': audioUrl,
        'imageUrl': imageUrl,
      };
}