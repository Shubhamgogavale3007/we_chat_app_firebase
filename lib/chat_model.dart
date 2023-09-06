class ChatModel {
  String? chat;

  ChatModel({this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    chat = json['chat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat'] = this.chat;
    return data;
  }
}
