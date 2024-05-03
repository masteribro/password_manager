
import 'dart:io';

import 'package:password_manager/utills/storage_dir.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../model/social_media_model.dart';


class LocalStorage {
  Future save(String key, dynamic value) async {
    var store = StoreRef.main();

    await store.record(key).put(await _getDatabase(), value);
  }

  Future<void> saveMedia (String key, List<SocialMediaAccount> value) async {
    var store = StoreRef<String, dynamic>.main();

    await store.record(key).put(await _getDatabase(), value.map((e) => e.toJson()).toList());
  }

  Future<List<SocialMediaAccount>> fetchMedia(String key) async {
    var store = StoreRef<String, dynamic>.main();

    var result = await store.record(key).get(await _getDatabase());

    if (result != null) {
      return (result as List<dynamic>).map((e) => SocialMediaAccount.fromJson(e)).toList();
    }

    return [];
  }

  Future<dynamic> fetch(String key) async {
    var store = StoreRef.main();

    var result = await store.record(key).get(await _getDatabase());

    //??
    return result;
  }

  Future delete(String key) async {
    var store = StoreRef.main();

    await store.record(key).delete(await _getDatabase());
  }

  Future<Database> _getDatabase() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = "${appDir.path}/${StorageDir.dbName}";
    DatabaseFactory dbFactory = databaseFactoryIo;

    Database db = await dbFactory.openDatabase(dbPath);
    return db;
  }
}