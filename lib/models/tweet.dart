class Tweet {
  String message = '';
  String time = '';

  Tweet.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}