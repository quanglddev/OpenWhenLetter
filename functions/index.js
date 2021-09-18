const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);





//////////INSTUCTION
//RUN 1st first
//Turn off
//Run second
//Turn second off
//Run first for 3 months

//Upload again when the new app is released
//Delete after 3 months of releasing Open When 2
//Run 1st

exports.updateDatabaseBetterStructureBoxes = functions.database.ref('/boxes/update/{updateID}').onWrite((change, context) => {
    return admin.database().ref('/boxes').once('value').then(rootSnapshot => {
        return rootSnapshot.forEach(function (snapshot) {
            admin.database().ref('/users').once('value').then(usersRootSnapshot => {
                return usersRootSnapshot.forEach(function (userSnapshot) {
                    const boxID = snapshot.child('boxID').val();
                    const boxTitle = snapshot.child('personName').val();
                    var tempAuthor = snapshot.child('author').val(); //use to search admin ID
                    var tempReceiverToken = snapshot.child('receiverToken').key;
                    //console.log(tempReceiverToken);
                    var letters = snapshot.child('letters').val(); // to convert to letterIDs

                    const name = userSnapshot.child('name').val(); //to check if match tempAuthor
                    const fcmToken = userSnapshot.child('fcmToken').val();//to check if match tempReceiverToken

                    admin.database().ref(`/boxes/${boxID}/boxTitle`).set(boxTitle);
                    admin.database().ref(`/boxes/${boxID}/letterIDs`).set(letters);

                    if (name === tempAuthor) {
                        const adminID = userSnapshot.child('id').val();

                        admin.database().ref(`/boxes/${boxID}/adminID`).set(adminID);
                        admin.database().ref(`/boxes/${boxID}/participants/${adminID}`).set(adminID);
                    }

                    if (fcmToken === tempReceiverToken) {
                        const participantOne = userSnapshot.child('id').val();

                        admin.database().ref(`/boxes/${boxID}/participants/${participantOne}`).set(participantOne);
                    }
                })
            })
                .catch((error) => {
                    console.log('Error sending message:', error);
                });
        });
    })
})


/*
exports.updateDatabaseBetterStructureBoxesRelated = functions.database.ref('/users/update/{updateID}').onWrite((change, context) => {
    return admin.database().ref('/users').once('value').then(rootSnapshot => {
        return rootSnapshot.forEach(function (snapshot) {
            var leaveFirst = true;
            const hisID = snapshot.child('id').val();

            snapshot.child('boxes').forEach(function (hisbox) {

                const hisBoxID = hisbox.key;

                admin.database().ref(`/boxes/${hisBoxID}/participants`).once('value').then(idsnap => {

                    return idsnap.forEach(function (idOfparticipants) {

                    })

                     rootSnapshot.forEach(function (snapshotClone) {
                        if (leaveFirst) {
                            leaveFirst = false;
                            return;
                        }

                        const herID = snapshotClone.child('id').val();
                        snapshotClone.child('boxes').forEach(function (herbox) {
                            const herBoxID = herbox.key;


                        })
                    })
                })
                    .catch((error) => {
                        console.log('Error sending message:', error);
                    });
            })
        })
    })
})*/

/*
//Run once and stop
exports.cleanBoxes = functions.database.ref('/users/update/{updateID}').onWrite((change, context) => {
    return admin.database().ref("/boxes").once('value').then(rootSnapshot => {
        return rootSnapshot.forEach(function (snapshot) {
            var leaveFirst = true;
            const leftValue = snapshot.child('participants').val();
            const leftBoxID = snapshot.child('boxID').val();

            rootSnapshot.forEach(function (snapClone) {
                if (leaveFirst) {
                    leaveFirst = false;
                    return;
                }
                const rightValue = snapClone.child('participants').val();
                //const reverseRightValue = snapClone.child('participants').reverse().val();

                if (leftValue === rightValue/* || leftValue === reverseRightValue) {
                    admin.database().ref(`/boxes/${leftBoxID}`).remove();

                    admin.database().ref("/users").once('value').then(usersSnapshot => {
                        return usersSnapshot.forEach(function (userData) {
                            const userID = userData.child('id').val();

                            admin.database().ref(`/users/${userID}/boxes/${leftBoxID}`).remove();
                            admin.database().ref(`/users/${userID}/inboxes/${leftBoxID}`).remove();
                        })
                    })
                    .catch((error) => {
                        console.log('Error sending message:', error);
                    });
                }
            })
        })
    })
})*/