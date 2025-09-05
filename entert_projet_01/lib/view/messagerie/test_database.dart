// pages/messagerie/test_database.dart

/*import 'package:firebase_database/firebase_database.dart';

final myConnectionsRef =
    FirebaseDatabase.instance.ref("users/joe/connections");

final lastOnlineRef =
    FirebaseDatabase.instance.ref("/users/joe/lastOnline");

final connectedRef = FirebaseDatabase.instance.ref(".info/connected");
connectedRef.onValue.listen((event) {
  final connected = event.snapshot.value as bool? ?? false;
  if (connected) {
    final con = myConnectionsRef.push();

    // When this device disconnects, remove it.
    con.onDisconnect().remove();

    // When I disconnect, update the last time I was seen online.
    lastOnlineRef.onDisconnect().set(ServerValue.timestamp);

    // Add this device to my connections list.
    // This value could contain info about the device or a timestamp too.
    con.set(true);
  }
});*/
