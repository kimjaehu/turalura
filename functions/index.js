const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
var moment = require('moment');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });


// exports.onCreateBaby = functions.firestore.document("/babies/{userId}/userBabies/{babyId}").onCreate((snap, context) => {
//     const userId = context.params.userId;
//     const babyId = context.params.babyId;

//     const name = snap.data()['name'];
//     const dob = snap.data()['dob'];
//     const gender = snap.data()['gender'];
//     const timestamp = snap.data()['gender'];

//     // 1) update users info
//     const usersRef = admin.firestore().collection('users').doc(userId);
//     usersRef.update({
//         currentBaby: name,
//         dob: dob,
//     });
//     // 2) create summaries
//     const summariesRef = admin.firestore().collection('summaries').doc(userId).collection(name.toLowerCase()).doc('summary');
//     summariesRef.set(
//         {
//             dob: dob,
//             gender: gender,
//             milestonesCompleted: null,
//             milestonesCount: null,
//             lastUpdated: null,
//             unit: null,
//             height: null,
//             weight: null,
//             heightPercentile: null,
//             weightPercentile: null,
//             name: name,
//         }
//     );

//     // 3) create milestones
//     const milestonesRef = admin.firestore().collection('milestones').doc(userId)

//     milestonesRef.set({
//             "2": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                   },
//                   "4": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                   },
//                   "6": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                   },
//                   "9": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                   },
//                   "12": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                     '20': false,
//                     '21': false,
//                     '22': false,
//                     '23': false,
//                     '24': false,
//                     '25': false,
//                     '26': false,
//                     '27': false,
//                   },
//                   "18": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                     '20': false,
//                     '21': false,
//                     '22': false,
//                     '23': false,
//                   },
//                   "24": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                     '20': false,
//                     '21': false,
//                     '22': false,
//                     '23': false,
//                     '24': false,
//                     '25': false,
//                     '26': false,
//                   },
//                   "36": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                     '20': false,
//                     '21': false,
//                     '22': false,
//                     '23': false,
//                     '24': false,
//                     '25': false,
//                     '26': false,
//                     '27': false,
//                     '28': false,
//                     '29': false,
//                   },
//                   "48": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                     '20': false,
//                     '21': false,
//                     '22': false,
//                     '23': false,
//                     '24': false,
//                   },
//                   "60": {
//                     '1': false,
//                     '2': false,
//                     '3': false,
//                     '4': false,
//                     '5': false,
//                     '6': false,
//                     '7': false,
//                     '8': false,
//                     '9': false,
//                     '10': false,
//                     '11': false,
//                     '12': false,
//                     '13': false,
//                     '14': false,
//                     '15': false,
//                     '16': false,
//                     '17': false,
//                     '18': false,
//                     '19': false,
//                     '20': false,
//                     '21': false,
//                     '22': false,
//                     '23': false,
//                   }
//         })

//     // 4) create delays
//     const delaysRef = admin.firestore().collection('delays').doc(userId)

//     delaysRef.set({
//         "2": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//               },
//               "4": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//               },
//               "6": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//                 '8': false,
//                 '9': false,
//               },
//               "9": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//                 '8': false,
//               },
//               "12": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//               },
//               "18": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//                 '8': false,
//               },
//               "24": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//               },
//               "36": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//                 '8': false,
//                 '9': false,
//               },
//               "48": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//                 '8': false,
//                 '9': false,
//                 '10': false,
//                 '11': false,
//               },
//               "60": {
//                 '1': false,
//                 '2': false,
//                 '3': false,
//                 '4': false,
//                 '5': false,
//                 '6': false,
//                 '7': false,
//                 '8': false,
//                 '9': false,
//                 '10': false,
//                 '11': false,
//                 '12': false,
//                 '13': false,
//               }
//     })
// });