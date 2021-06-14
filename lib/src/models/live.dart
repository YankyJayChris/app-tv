class Live {
  int id;
  String title;
  String description;
  String category;
  String image;
  int userId;
  String url;
  String time;
  int active;
  String views;
  int shared;
  String createdAt;
  String updated;

  Live(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.image,
      this.userId,
      this.url,
      this.time,
      this.active,
      this.views,
      this.shared,
      this.createdAt,
      this.updated});

  Live.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    userId = json['user_id'];
    url = json['url'];
    time = json['time'];
    active = json['active'];
    views = json['views'];
    shared = json['shared'];
    createdAt = json['created_at'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['url'] = this.url;
    data['time'] = this.time;
    data['active'] = this.active;
    data['views'] = this.views;
    data['shared'] = this.shared;
    data['created_at'] = this.createdAt;
    data['updated'] = this.updated;
    return data;
  }
}

Live tv1 = Live(
  id: 0,
  title: 'TV1 LIVE',
  description: 'this is tv1 rwanda.',
  category: '1',
  image: 'assets/images/logo_44.png',
  userId: 1,
  url: 'rtmp://80.241.215.175:1935/tv1rwanda/tv1rwanda',
  time: '01-January-1970',
  active: 1,
  views: '0',
  shared: 0,
  createdAt: '2021-03-13 15:38:49',
  updated: '2021-03-13 15:38:49',
);
