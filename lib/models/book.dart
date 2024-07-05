// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookList bookFromJson(String str) => BookList.fromJson(json.decode(str));

String bookToJson(BookList data) => json.encode(data.toJson());

class BookList {
  List<Book>? docs;
  int? total;
  int? limit;
  int? offset;
  int? page;
  int? pages;

  BookList({
    this.docs,
    this.total,
    this.limit,
    this.offset,
    this.page,
    this.pages,
  });

  factory BookList.fromJson(Map<String, dynamic> json) => BookList(
    docs: json["docs"] == null ? [] : List<Book>.from(json["docs"]!.map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => x.toJson())),
  };
}

class Book {
  String? id;
  String? name;

  Book({
    this.id,
    this.name,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
