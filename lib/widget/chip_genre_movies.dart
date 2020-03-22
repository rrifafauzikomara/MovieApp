import 'package:flutter/material.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';

Widget buildGenreChip(int id) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(8),
    child: Text(
      Genres.genres[id],
      style: TextStyle(fontSize: 12),
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
