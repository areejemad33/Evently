import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/resources/constant_manager.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static CollectionReference<UserModel> getUsersCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserModel> usersCollection = db
        .collection(RemoteConstant.usersCollection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return usersCollection;
  }

  static CollectionReference<EventModel> getEventsCollection(
    BuildContext context,
  ) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventModel> eventsCollection = db
        .collection(RemoteConstant.eventsCollection)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        );
    return eventsCollection;
  }

  static Future<void> addUserToFireStore(UserModel user) {
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(user.id);
    return userDocument.set(user);
    // CollectionReference<Map<String, dynamic>> usersCollection = db.collection(
    //   RemoteConstant.usersCollection,
    // );
    // DocumentReference<Map<String, dynamic>> userDocument = usersCollection.doc(
    //   user.id,
    // );
    // return userDocument.set(user.toJson());
  }

  static Future<UserModel> getUserFromFireStore(String userId) async {
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(userId);
    DocumentSnapshot<UserModel> snapshot = await userDocument.get();
    return snapshot.data()!;

    // CollectionReference<Map<String, dynamic>> usersCollection = db.collection(
    //   RemoteConstant.usersCollection,
    // );
    // DocumentReference<Map<String, dynamic>> userDocument = usersCollection.doc(
    //   userId,
    // );

    // DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await userDocument
    //     .get();
    // Map<String, dynamic>? userJson = documentSnapshot.data()!;
    // return UserModel.fromJson(userJson);
  }

  static Future<void> addEventToFireStore(
    EventModel event,
    BuildContext context,
  ) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
      context,
    );

    DocumentReference<EventModel> eventDocument = eventsCollection.doc();
    event.id = eventDocument.id;
    return eventDocument.set(event);
  }

  static Future<List<EventModel>> getEventsFromFireStore(
    BuildContext context, [
    CategoryModel? selectedCategory,
  ]) async {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
      context,
    );
    QuerySnapshot<EventModel> snapshot = await eventsCollection
        .where(
          "categoryId",
          isEqualTo: selectedCategory?.id == '0' ? null : selectedCategory?.id,
        )
        .orderBy('dateTime')
        .get();

    List<EventModel> events = snapshot.docs
        .map((documentSnapshot) => documentSnapshot.data())
        .toList();

    return events;
  }

  static Stream<List<EventModel>> getEventsFromFireStoreRealTime(
    BuildContext context, [
    CategoryModel? selectedCategory,
  ]) async* {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
      context,
    );
    Stream<QuerySnapshot<EventModel>> snapshots = eventsCollection
        .where(
          "categoryId",
          isEqualTo: selectedCategory?.id == '0' ? null : selectedCategory?.id,
        )
        .orderBy('dateTime')
        .snapshots();
    Stream<List<EventModel>> events = snapshots.map(
      (querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot.data())
          .toList(),
    );

    yield* events;
  }

  static Future<void> addEventToFavourite(EventModel event) {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favouriteEventsIds.add(event.id);
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(
      currentUser.id,
    );
    return userDocument.set(currentUser);
  }

  static Future<void> removeEventFromFavourite(EventModel event) {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favouriteEventsIds.remove(event.id);
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(
      currentUser.id,
    );
    return userDocument.set(currentUser);
  }

  static Future<List<EventModel>> getFavouriteEvents(
    BuildContext context
  
  ) async {
    List<EventModel> events = await getEventsFromFireStore(context);
    return events.where((event) => UserModel.currentUser!.favouriteEventsIds.contains(event.id)).toList();
  }
}
