clean archtecture

Each widget does its own functionality

 WinCard() – Displays a win with reactions
 FounderAvatar() – Consistent founder avatars
 ReactionsRow() – Emoji interactions


--Firebase

separation of concern kept

 FirebaseService.getWinsStream() → Real-time wins
 FirebaseService.addWin() → Post a new win
 FirebaseService.addReaction() → Emoji reactions

--Models used

Strongly typed models keep data safe and predictable:

 Win.fromMap() → Convert Firestore data
 Win.toMap() → Save data back to Firestore


firestore data pattern

wins (collection)
├── winId1
│   ├── founderName: "Abdullah"
│   ├── company: "TechCorp"
│   ├── content: "Just closed our first major client!"
│   ├── timestamp: Timestamp
│   ├── reactions: {🎉: 5, 🚀: 3, 💪: 2}
│   └── avatar: "🚀"




 Problem-Solving



 Added dependencies, built a service layer, used real-time streams

 Split into reusable components with single responsibility

 Used Firebase transactions for atomic updates + live streams
 Optimistic UI for smooth experience


-- With 5 More Hours
 can implenet auth and founder profiles can be made categories, leaderboard, weekly highlights,offline handling and upon request things.

--working app
Fully working wins board demo
 Real-time Firebase backend




