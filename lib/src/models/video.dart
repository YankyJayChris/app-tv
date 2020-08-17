class Video {
  int id;
  String videoId;
  int userId;
  String shortId;
  String title;
  String description;
  String thumbnail;
  String videoLocation;
  String youtube;
  String vimeo;
  String daily;
  String facebook;
  String ok;
  String twitch;
  String twitchType;
  int time;
  String timeDate;
  int active;
  String tags;
  String duration;
  int size;
  int converted;
  String categoryId;
  int views;
  int featured;
  String registered;
  int privacy;
  int ageRestriction;
  String type;
  int approved;
  int i240p;
  int i360p;
  int i480p;
  int i720p;
  int i1080p;
  int i2048p;
  int i4096p;
  String sellVideo;
  String subCategory;
  String geoBlocking;
  String demo;
  String gif;
  int isMovie;
  String stars;
  String producer;
  String country;
  String movieRelease;
  String quality;
  String rating;
  int monetization;
  int rentPrice;
  String orgThumbnail;
  String videoNewId;
  String source;
  String videoType;
  String url;
  String editDescription;
  String markupDescription;
  Owner owner;
  int isLiked;
  int isDisliked;
  bool isOwner;
  int isPurchased;
  String timeAlpha;
  String timeAgo;
  String categoryName;

  Video(
      {this.id,
      this.videoId,
      this.userId,
      this.shortId,
      this.title,
      this.description,
      this.thumbnail,
      this.videoLocation,
      this.youtube,
      this.vimeo,
      this.daily,
      this.facebook,
      this.ok,
      this.twitch,
      this.twitchType,
      this.time,
      this.timeDate,
      this.active,
      this.tags,
      this.duration,
      this.size,
      this.converted,
      this.categoryId,
      this.views,
      this.featured,
      this.registered,
      this.privacy,
      this.ageRestriction,
      this.type,
      this.approved,
      this.i240p,
      this.i360p,
      this.i480p,
      this.i720p,
      this.i1080p,
      this.i2048p,
      this.i4096p,
      this.sellVideo,
      this.subCategory,
      this.geoBlocking,
      this.demo,
      this.gif,
      this.isMovie,
      this.stars,
      this.producer,
      this.country,
      this.movieRelease,
      this.quality,
      this.rating,
      this.monetization,
      this.rentPrice,
      this.orgThumbnail,
      this.videoNewId,
      this.source,
      this.videoType,
      this.url,
      this.editDescription,
      this.markupDescription,
      this.owner,
      this.isLiked,
      this.isDisliked,
      this.isOwner,
      this.isPurchased,
      this.timeAlpha,
      this.timeAgo,
      this.categoryName});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
    userId = json['user_id'];
    shortId = json['short_id'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    videoLocation = json['video_location'];
    youtube = json['youtube'];
    vimeo = json['vimeo'];
    daily = json['daily'];
    facebook = json['facebook'];
    ok = json['ok'];
    twitch = json['twitch'];
    twitchType = json['twitch_type'];
    time = json['time'];
    timeDate = json['time_date'];
    active = json['active'];
    tags = json['tags'];
    duration = json['duration'];
    size = json['size'];
    converted = json['converted'];
    categoryId = json['category_id'];
    views = json['views'];
    featured = json['featured'];
    registered = json['registered'];
    privacy = json['privacy'];
    ageRestriction = json['age_restriction'];
    type = json['type'];
    approved = json['approved'];
    i240p = json['240p'];
    i360p = json['360p'];
    i480p = json['480p'];
    i720p = json['720p'];
    i1080p = json['1080p'];
    i2048p = json['2048p'];
    i4096p = json['4096p'];
    sellVideo = json['sell_video'];
    subCategory = json['sub_category'];
    geoBlocking = json['geo_blocking'];
    demo = json['demo'];
    gif = json['gif'];
    isMovie = json['is_movie'];
    stars = json['stars'];
    producer = json['producer'];
    country = json['country'];
    movieRelease = json['movie_release'];
    quality = json['quality'];
    rating = json['rating'];
    monetization = json['monetization'];
    rentPrice = json['rent_price'];
    orgThumbnail = json['org_thumbnail'];
    videoNewId = json['video_id_'];
    source = json['source'];
    videoType = json['video_type'];
    url = json['url'];
    editDescription = json['edit_description'];
    markupDescription = json['markup_description'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
    isOwner = json['is_owner'];
    isPurchased = json['is_purchased'];
    timeAlpha = json['time_alpha'];
    timeAgo = json['time_ago'];
    categoryName = json['category_name'];
  }

  int get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_id'] = this.videoId;
    data['user_id'] = this.userId;
    data['short_id'] = this.shortId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['video_location'] = this.videoLocation;
    data['youtube'] = this.youtube;
    data['vimeo'] = this.vimeo;
    data['daily'] = this.daily;
    data['facebook'] = this.facebook;
    data['ok'] = this.ok;
    data['twitch'] = this.twitch;
    data['twitch_type'] = this.twitchType;
    data['time'] = this.time;
    data['time_date'] = this.timeDate;
    data['active'] = this.active;
    data['tags'] = this.tags;
    data['duration'] = this.duration;
    data['size'] = this.size;
    data['converted'] = this.converted;
    data['category_id'] = this.categoryId;
    data['views'] = this.views;
    data['featured'] = this.featured;
    data['registered'] = this.registered;
    data['privacy'] = this.privacy;
    data['age_restriction'] = this.ageRestriction;
    data['type'] = this.type;
    data['approved'] = this.approved;
    data['240p'] = this.i240p;
    data['360p'] = this.i360p;
    data['480p'] = this.i480p;
    data['720p'] = this.i720p;
    data['1080p'] = this.i1080p;
    data['2048p'] = this.i2048p;
    data['4096p'] = this.i4096p;
    data['sell_video'] = this.sellVideo;
    data['sub_category'] = this.subCategory;
    data['geo_blocking'] = this.geoBlocking;
    data['demo'] = this.demo;
    data['gif'] = this.gif;
    data['is_movie'] = this.isMovie;
    data['stars'] = this.stars;
    data['producer'] = this.producer;
    data['country'] = this.country;
    data['movie_release'] = this.movieRelease;
    data['quality'] = this.quality;
    data['rating'] = this.rating;
    data['monetization'] = this.monetization;
    data['rent_price'] = this.rentPrice;
    data['org_thumbnail'] = this.orgThumbnail;
    data['video_id_'] = this.videoNewId;
    data['source'] = this.source;
    data['video_type'] = this.videoType;
    data['url'] = this.url;
    data['edit_description'] = this.editDescription;
    data['markup_description'] = this.markupDescription;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    data['is_owner'] = this.isOwner;
    data['is_purchased'] = this.isPurchased;
    data['time_alpha'] = this.timeAlpha;
    data['time_ago'] = this.timeAgo;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Owner {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String language;
  String avatar;
  String cover;
  String about;
  String google;
  String facebook;
  String twitter;
  int verified;
  int isPro;
  int videoMon;
  int monetization;
  String url;

  Owner(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.language,
      this.avatar,
      this.cover,
      this.about,
      this.google,
      this.facebook,
      this.twitter,
      this.verified,
      this.isPro,
      this.videoMon,
      this.monetization,
      this.url});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    language = json['language'];
    avatar = json['avatar'];
    cover = json['cover'];
    about = json['about'];
    google = json['google'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    verified = json['verified'];
    isPro = json['is_pro'];
    videoMon = json['video_mon'];
    monetization = json['monetization'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['language'] = this.language;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['about'] = this.about;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['verified'] = this.verified;
    data['is_pro'] = this.isPro;
    data['video_mon'] = this.videoMon;
    data['monetization'] = this.monetization;
    data['url'] = this.url;
    return data;
  }
}