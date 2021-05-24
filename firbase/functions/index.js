const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

functions.pubsub.schedule("59 23 * * *").onRun(async () => {
    const oneDayOld = admin.firestore.Timestamp.now().toMillis - 86400000;

    const querySnapshot = await admin.firestore().collection("votes").where()
})