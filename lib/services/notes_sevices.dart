import 'dart:convert';
import 'dart:io';

import 'package:note_app_api/constants/api_constants.dart';
import 'package:note_app_api/models/list_note_model.dart';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../models/note_adding.dart';

class NoteService {
  // GET
  Future<APIResponse<List<NoteForListing>>> getNotes() async {
    var url = Uri.parse(ApiEndPoints.kBaseUrl);

    try {
      var response = await http.get(url, headers: ApiEndPoints.headers);
      if (response.statusCode <= 299 && response.statusCode >= 200) {
        final List jsonBody = jsonDecode(response.body);
        final List<NoteForListing> jsonData =
            jsonBody.map((e) => NoteForListing.fromJson(e)).toList();
        return APIResponse<List<NoteForListing>>(
          data: jsonData,
          error: false,
        );
      } else {
        return APIResponse(data: [], error: true, errorMessage: 'Client Error');
      }
    } on SocketException {
      return APIResponse(
          data: [], error: true, errorMessage: 'Error with connection');
    } catch (e) {
      return APIResponse(
          data: [], error: true, errorMessage: 'Something Went Wrong');
    }
  }

  // GET Single Note
  Future<APIResponse<SingleNote>> getSingleNote(String noteId) async {
    var url = Uri.parse("${ApiEndPoints.kBaseUrl}/$noteId");

    try {
      var response = await http.get(url, headers: ApiEndPoints.headers);
      if (response.statusCode <= 299 && response.statusCode >= 200) {
        final jsonBody = jsonDecode(response.body);
        final SingleNote jsonData = SingleNote.fromJson(jsonBody);
        return APIResponse<SingleNote>(
          data: jsonData,
          error: false,
        );
      } else {
        return APIResponse<SingleNote>(
            error: true, errorMessage: 'Client Error');
      }
    } on SocketException {
      return APIResponse<SingleNote>(
          error: true, errorMessage: 'Error with connection');
    } catch (e) {
      return APIResponse<SingleNote>(
          error: true, errorMessage: 'Something Went Wrong');
    }
  }

  // POST
  Future<APIResponse<NoteForAdding>> addNotes(NoteForAdding note) async {
    var url = Uri.parse('${ApiEndPoints.kBaseUrl}/');

    try {
      var response = await http.post(url,
          headers: ApiEndPoints.headers, body: jsonEncode(note.toJson()));
      if (response.statusCode <= 299 && response.statusCode >= 200) {
        return APIResponse<NoteForAdding>(
          data: note,
          error: false,
        );
      } else {
        return APIResponse<NoteForAdding>(
            error: true, errorMessage: 'Client Error');
      }
    } on SocketException {
      return APIResponse<NoteForAdding>(
          error: true, errorMessage: 'Error with connection');
    } catch (e) {
      return APIResponse<NoteForAdding>(
          error: true, errorMessage: 'Something Went Wrong');
    }
  }

  // PUT
  Future<APIResponse<NoteForAdding>> updateNotes(
      String noteId, NoteForAdding note) async {
    var url = Uri.parse('${ApiEndPoints.kBaseUrl}/$noteId');

    try {
      var response = await http.put(url,
          headers: ApiEndPoints.headers, body: jsonEncode(note.toJson()));
      if (response.statusCode <= 299 && response.statusCode >= 200) {
        return APIResponse<NoteForAdding>(
          data: note,
          error: false,
        );
      } else {
        return APIResponse<NoteForAdding>(
            error: true, errorMessage: 'Client Error');
      }
    } on SocketException {
      return APIResponse<NoteForAdding>(
          error: true, errorMessage: 'Error with connection');
    } catch (e) {
      return APIResponse<NoteForAdding>(
          error: true, errorMessage: 'Something Went Wrong');
    }
  }

  // DELETE
  Future<APIResponse<NoteForAdding>> deleteNotes(String noteId) async {
    var url = Uri.parse('${ApiEndPoints.kBaseUrl}/$noteId');

    try {
      var response = await http.delete(
        url,
        headers: ApiEndPoints.headers,
      );
      if (response.statusCode <= 299 && response.statusCode >= 200) {
        return APIResponse<NoteForAdding>(
          error: false,
        );
      } else {
        return APIResponse<NoteForAdding>(
            error: true, errorMessage: 'Client Error');
      }
    } on SocketException {
      return APIResponse<NoteForAdding>(
          error: true, errorMessage: 'Error with connection');
    } catch (e) {
      return APIResponse<NoteForAdding>(
          error: true, errorMessage: 'Something Went Wrong');
    }
  }
}
