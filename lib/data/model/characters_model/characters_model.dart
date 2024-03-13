class CharacterModel {
  Character? character;
  String? role;
  int? favorites;
  List<VoiceActors>? voiceActors;

  CharacterModel({this.character, this.role, this.favorites, this.voiceActors});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    character = json['character'] != null
        ? new Character.fromJson(json['character'])
        : null;
    role = json['role'];
    favorites = json['favorites'];
    if (json['voice_actors'] != null) {
      voiceActors = <VoiceActors>[];
      json['voice_actors'].forEach((v) {
        voiceActors!.add(new VoiceActors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.character != null) {
      data['character'] = this.character!.toJson();
    }
    data['role'] = this.role;
    data['favorites'] = this.favorites;
    if (this.voiceActors != null) {
      data['voice_actors'] = this.voiceActors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Character {
  int? malId;
  String? url;
  Images? images;
  String? name;

  Character({this.malId, this.url, this.images, this.name});

  Character.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Images {
  Jpg? jpg;
  Webp? webp;

  Images({this.jpg, this.webp});

  Images.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? new Jpg.fromJson(json['jpg']) : null;
    webp = json['webp'] != null ? new Webp.fromJson(json['webp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpg != null) {
      data['jpg'] = this.jpg!.toJson();
    }
    if (this.webp != null) {
      data['webp'] = this.webp!.toJson();
    }
    return data;
  }
}

class Jpg {
  String? imageUrl;

  Jpg({this.imageUrl});

  Jpg.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Webp {
  String? imageUrl;
  String? smallImageUrl;

  Webp({this.imageUrl, this.smallImageUrl});

  Webp.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['small_image_url'] = this.smallImageUrl;
    return data;
  }
}

class VoiceActors {
  Person? person;
  String? language;

  VoiceActors({this.person, this.language});

  VoiceActors.fromJson(Map<String, dynamic> json) {
    person = json['person'] != null ? Person.fromJson(json['person']) : null;
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.person != null) {
      data['person'] = this.person!.toJson();
    }
    data['language'] = this.language;
    return data;
  }
}

class Person {
  int? malId;
  String? url;
  ImagesPerson? images;
  String? name;

  Person({this.malId, this.url, this.images, this.name});

  Person.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    images =
        json['images'] != null ? ImagesPerson.fromJson(json['images']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class ImagesPerson {
  Jpg? jpg;

  ImagesPerson({this.jpg});

  ImagesPerson.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? new Jpg.fromJson(json['jpg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpg != null) {
      data['jpg'] = this.jpg!.toJson();
    }
    return data;
  }
}
