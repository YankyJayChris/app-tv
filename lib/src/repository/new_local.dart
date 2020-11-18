
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

abstract class ILocalStorageRepository {
  Future getAll(String key);
  Future<void> save(String key, dynamic item);
  Future<void> remove(String key);
}


class LocalStorageRepository implements ILocalStorageRepository {
  final LocalStorage _storage;

  LocalStorageRepository(String storageKey)
      : _storage = LocalStorage(storageKey);

  @override
  Future getAll(String key) async {
    await _storage.ready;

    return _storage.getItem(key);
  }

  @override
  Future<void> save(String key, dynamic value) async {
    await _storage.ready;

    return _storage.setItem(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.ready;

    return _storage.deleteItem(key);
  }
}

class LocalStorageService {
  LocalStorageService(
      {@required ILocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository;

  ILocalStorageRepository _localStorageRepository;
  final String authToken = "session";
  final String userData = "userData";
  final String subNot = "subNot";
  final String subNotNumber = "subNotNumber";
  final String welcom = "welcom";
  final String payData = "paydata";

  Future<dynamic> getAll(String key) async {
    return await _localStorageRepository.getAll(key);
  }
  
  Future<dynamic> removeFromStorage(String key) async {
    return await _localStorageRepository.remove(key);
  }

  Future<void> save(String key, dynamic item) async {
    await _localStorageRepository.save(key, item);
  }

  Future<String> getToken() async {
    return await _localStorageRepository.getAll(authToken);
  }

  Future<void> saveToken(String data) async {
    await _localStorageRepository.save(authToken, data);
  }

  Future<String> getuserData() async {
    return await _localStorageRepository.getAll(userData);
  }

  Future<void> saveuserData(String data) async {
    await _localStorageRepository.save(userData, data);
  }

  Future<String> getpayData() async {
    return await _localStorageRepository.getAll(payData);
  }

  Future<void> savepayData(String data) async {
    await _localStorageRepository.save(payData, data);
  }
}