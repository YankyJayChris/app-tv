class Article {
  int id;
  String title;
  String description;
  String category;
  String image;
  String text;
  String tags;
  String time;
  int userId;
  String active;
  String views;
  int shared;
  String orginalText;
  String url;
  String timeFormat;
  String textTime;
  UserData userData;
  int commentsCount;
  int likes;
  int dislikes;
  int liked;
  int disliked;

  Article(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.image,
      this.text,
      this.tags,
      this.time,
      this.userId,
      this.active,
      this.views,
      this.shared,
      this.orginalText,
      this.url,
      this.timeFormat,
      this.textTime,
      this.userData,
      this.commentsCount,
      this.likes,
      this.dislikes,
      this.liked,
      this.disliked});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    text = json['text'];
    tags = json['tags'];
    time = json['time'];
    userId = json['user_id'];
    active = json['active'];
    views = json['views'];
    shared = json['shared'];
    orginalText = json['orginal_text'];
    url = json['url'];
    timeFormat = json['time_format'];
    textTime = json['text_time'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    commentsCount = json['comments_count'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    liked = json['liked'];
    disliked = json['disliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    data['text'] = this.text;
    data['tags'] = this.tags;
    data['time'] = this.time;
    data['user_id'] = this.userId;
    data['active'] = this.active;
    data['views'] = this.views;
    data['shared'] = this.shared;
    data['orginal_text'] = this.orginalText;
    data['url'] = this.url;
    data['time_format'] = this.timeFormat;
    data['text_time'] = this.textTime;
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    data['comments_count'] = this.commentsCount;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['liked'] = this.liked;
    data['disliked'] = this.disliked;
    return data;
  }
}

class UserData {
  int id;
  String username;
  String email;
  String ipAddress;
  String firstName;
  String lastName;
  String gender;
  String emailCode;
  String deviceId;
  String language;
  String avatar;
  String cover;
  String src;
  int countryId;
  int age;
  String about;
  String google;
  String facebook;
  String twitter;
  String instagram;
  int active;
  int admin;
  int verified;
  int lastActive;
  String registered;
  int isPro;
  int imports;
  int uploads;
  int wallet;
  String balance;
  int videoMon;
  int ageChanged;
  String donationPaypalEmail;
  String userUploadLimit;
  int twoFactor;
  String lastMonth;
  int activeTime;
  String activeExpire;
  String phoneNumber;
  String address;
  String city;
  String state;
  int zip;
  String subscriberPrice;
  int monetization;
  String newEmail;
  List<String> favCategory;
  int totalAds;
  String name;
  String exCover;
  String url;
  String aboutDecoded;
  String fullCover;
  String balanceOr;
  String nameV;
  String countryName;
  String genderText;
  int amISubscribed;

  UserData(
      {this.id,
      this.username,
      this.email,
      this.ipAddress,
      this.firstName,
      this.lastName,
      this.gender,
      this.emailCode,
      this.deviceId,
      this.language,
      this.avatar,
      this.cover,
      this.src,
      this.countryId,
      this.age,
      this.about,
      this.google,
      this.facebook,
      this.twitter,
      this.instagram,
      this.active,
      this.admin,
      this.verified,
      this.lastActive,
      this.registered,
      this.isPro,
      this.imports,
      this.uploads,
      this.wallet,
      this.balance,
      this.videoMon,
      this.ageChanged,
      this.donationPaypalEmail,
      this.userUploadLimit,
      this.twoFactor,
      this.lastMonth,
      this.activeTime,
      this.activeExpire,
      this.phoneNumber,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.subscriberPrice,
      this.monetization,
      this.newEmail,
      this.favCategory,
      this.totalAds,
      this.name,
      this.exCover,
      this.url,
      this.aboutDecoded,
      this.fullCover,
      this.balanceOr,
      this.nameV,
      this.countryName,
      this.genderText,
      this.amISubscribed});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    ipAddress = json['ip_address'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    emailCode = json['email_code'];
    deviceId = json['device_id'];
    language = json['language'];
    avatar = json['avatar'];
    cover = json['cover'];
    src = json['src'];
    countryId = json['country_id'];
    age = json['age'];
    about = json['about'];
    google = json['google'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    active = json['active'];
    admin = json['admin'];
    verified = json['verified'];
    lastActive = json['last_active'];
    registered = json['registered'];
    isPro = json['is_pro'];
    imports = json['imports'];
    uploads = json['uploads'];
    wallet = json['wallet'];
    balance = json['balance'];
    videoMon = json['video_mon'];
    ageChanged = json['age_changed'];
    donationPaypalEmail = json['donation_paypal_email'];
    userUploadLimit = json['user_upload_limit'];
    twoFactor = json['two_factor'];
    lastMonth = json['last_month'];
    activeTime = json['active_time'];
    activeExpire = json['active_expire'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    subscriberPrice = json['subscriber_price'];
    monetization = json['monetization'];
    newEmail = json['new_email'];
    favCategory = json['fav_category'].cast<String>();
    totalAds = json['total_ads'];
    name = json['name'];
    exCover = json['ex_cover'];
    url = json['url'];
    aboutDecoded = json['about_decoded'];
    fullCover = json['full_cover'];
    balanceOr = json['balance_or'];
    nameV = json['name_v'];
    countryName = json['country_name'];
    genderText = json['gender_text'];
    amISubscribed = json['am_i_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['ip_address'] = this.ipAddress;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['email_code'] = this.emailCode;
    data['device_id'] = this.deviceId;
    data['language'] = this.language;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['src'] = this.src;
    data['country_id'] = this.countryId;
    data['age'] = this.age;
    data['about'] = this.about;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['active'] = this.active;
    data['admin'] = this.admin;
    data['verified'] = this.verified;
    data['last_active'] = this.lastActive;
    data['registered'] = this.registered;
    data['is_pro'] = this.isPro;
    data['imports'] = this.imports;
    data['uploads'] = this.uploads;
    data['wallet'] = this.wallet;
    data['balance'] = this.balance;
    data['video_mon'] = this.videoMon;
    data['age_changed'] = this.ageChanged;
    data['donation_paypal_email'] = this.donationPaypalEmail;
    data['user_upload_limit'] = this.userUploadLimit;
    data['two_factor'] = this.twoFactor;
    data['last_month'] = this.lastMonth;
    data['active_time'] = this.activeTime;
    data['active_expire'] = this.activeExpire;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['subscriber_price'] = this.subscriberPrice;
    data['monetization'] = this.monetization;
    data['new_email'] = this.newEmail;
    data['fav_category'] = this.favCategory;
    data['total_ads'] = this.totalAds;
    data['name'] = this.name;
    data['ex_cover'] = this.exCover;
    data['url'] = this.url;
    data['about_decoded'] = this.aboutDecoded;
    data['full_cover'] = this.fullCover;
    data['balance_or'] = this.balanceOr;
    data['name_v'] = this.nameV;
    data['country_name'] = this.countryName;
    data['gender_text'] = this.genderText;
    data['am_i_subscribed'] = this.amISubscribed;
    return data;
  }
}