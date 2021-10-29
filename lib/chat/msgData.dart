class MsgData {
  MsgData(
      {this.author, this.message_body, this.time, this.aurora, this.sticker});

  String author;
  String message_body;
  String time;
  bool aurora;
  String sticker;

  Map<String, Object> toMap() {
    return {
      'author': author,
      'message_body': message_body,
      'time': time,
      'aurora': aurora,
      'sticker': sticker
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
        aurora: value['aurora'],
        sticker: value['sticker']);
  }

  @override
  String toString() {
    return ('{author: $author, message_body: $message_body, time: $time, aurora: $aurora, sticker: $sticker}');
  }
}
