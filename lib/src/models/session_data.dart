class Session {
  String refId;
  String s;
  String userId;
  String plan;

  Session({this.refId, this.s, this.userId, this.plan});

  Session.fromJson(Map<String, dynamic> json) {
    refId = json['refId'];
    s = json['s'];
    userId = json['userId'];
    plan = json['plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, String>();
    data['userId'] = this.userId;
    data['s'] = this.s;
    data['plan'] = this.plan;
    if (this.refId != null) {
      data['refId'] = this.refId;
    }
    return data;
  }
}
