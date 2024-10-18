class OfflineTable {
  static const offlineTable = "User";
  static const dbId = "id";
  static const dbIsSynced = "is_synced";
  static const dbServerData = "server_data";
  int id;
  String isSynced;
  String serverData;
  OfflineTable.create({
    required this.id,
    required this.isSynced,
    required this.serverData,
  });

  OfflineTable.update({
    required this.id,
    required this.isSynced,
    required this.serverData,
  });

  OfflineTable.fromJson(Map<String, dynamic> map)
      : id = map[dbId],
        isSynced = map[dbIsSynced],
        serverData = map[dbServerData];
  OfflineTable.fromMap(Map<String, dynamic> map)
      : id = map[dbId],
        isSynced = map[dbIsSynced],
        serverData = map[dbServerData];

  Map<String, dynamic> toJson() {
    return {
      dbId: id,
      dbIsSynced: isSynced,
      dbServerData: serverData,
    };
  }
}
