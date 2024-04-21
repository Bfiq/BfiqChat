class ChatModel {
  String idUserMessaging; //Id de la persona con quien chatea
  String nameUser;
  String lastName;
  String? photo;
  String? lastMessage;

  ChatModel(
      {required this.idUserMessaging,
      required this.nameUser,
      required this.lastName,
      this.lastMessage,
      this.photo});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
      idUserMessaging: json['idUser2'],
      nameUser: json['name'],
      lastName: json['lastNames'],
      lastMessage: json['message'],
      photo: json['photo']);
}
