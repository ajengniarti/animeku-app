import 'dart:convert';

AnimeResponseModel animeResponseModelFromJson(String str) => AnimeResponseModel.fromJson(json.decode(str));

String animeResponseModelToJson(AnimeResponseModel data) => json.encode(data.toJson());

class AnimeResponseModel {
    List<AnimeModel> data;
    Meta meta;

    AnimeResponseModel({
        required this.data,
        required this.meta,
    });

    factory AnimeResponseModel.fromJson(Map<String, dynamic> json) => AnimeResponseModel(
        data: List<AnimeModel>.from(json["data"].map((x) => AnimeModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class AnimeModel {
    String id;
    String title;
    List<String> alternativeTitles;
    int ranking;
    List<String> genres;
    int episodes;
    bool hasEpisode;
    bool hasRanking;
    String image;
    String link;
    Status status;
    String synopsis;
    String thumb;
    Type type;

    AnimeModel({
        required this.id,
        required this.title,
        required this.alternativeTitles,
        required this.ranking,
        required this.genres,
        required this.episodes,
        required this.hasEpisode,
        required this.hasRanking,
        required this.image,
        required this.link,
        required this.status,
        required this.synopsis,
        required this.thumb,
        required this.type,
    });

    factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        id: json["_id"],
        title: json["title"],
        alternativeTitles: List<String>.from(json["alternativeTitles"].map((x) => x)),
        ranking: json["ranking"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        episodes: json["episodes"],
        hasEpisode: json["hasEpisode"],
        hasRanking: json["hasRanking"],
        image: json["image"],
        link: json["link"],
        status: statusValues.map[json["status"]]!,
        synopsis: json["synopsis"],
        thumb: json["thumb"],
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "alternativeTitles": List<dynamic>.from(alternativeTitles.map((x) => x)),
        "ranking": ranking,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "episodes": episodes,
        "hasEpisode": hasEpisode,
        "hasRanking": hasRanking,
        "image": image,
        "link": link,
        "status": statusValues.reverse[status],
        "synopsis": synopsis,
        "thumb": thumb,
        "type": typeValues.reverse[type],
    };
}

enum Status { FINISHED_AIRING, CURRENTLY_AIRING, NOT_YET_AIRED }

final statusValues = EnumValues({
    "Currently Airing": Status.CURRENTLY_AIRING,
    "Finished Airing": Status.FINISHED_AIRING,
    "Not yet aired": Status.NOT_YET_AIRED
});

enum Type { TV, SPECIAL, MOVIE }

final typeValues = EnumValues({
    "Movie": Type.MOVIE,
    "Special": Type.SPECIAL,
    "TV": Type.TV
});

class Meta {
    int page;
    int size;
    int totalData;
    int totalPage;

    Meta({
        required this.page,
        required this.size,
        required this.totalData,
        required this.totalPage,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        size: json["size"],
        totalData: json["totalData"],
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
        "totalData": totalData,
        "totalPage": totalPage,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
