class MsgData {
  MsgData({
    this.author,
    this.message_body,
    this.time,
  });

  String author;
  String message_body;
  String time;

  Map<String, Object> toMap() {
    return {
      'author': author,
      'message_body': message_body,
      'time': time,
    };
  }

  static MsgData fromMap(Map value) {
    if (value == null) {
      return null;
    }

    return MsgData(
      author: value['author'],
      message_body: value['message_body'],
      time: value['time'],
    );
  }

  @override
  String toString() {
    return ('{author: $author, message_body: $message_body, time: $time}');
  }
}
