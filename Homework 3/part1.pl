% knowledge base


% id-capacity-properties
room(id1, 12, projector).
room(id2, 10, smart_board).

% id-instructor-capacity-hour-room
course(cse241, yusuf, 3, 2, id2).
course(cse102, yakup, 7, 3, _).
course(cse101, mehmet, 7, 3, id2).

% id-room-needs
student(1,cse101, _).
student(1,cse102, _).
student(1,cse241, _).

student(2,cse101, _).
student(2,cse102, _).
student(2,cse241, _).

student(3,cse101, _).
student(3,cse102, _).
student(3,cse241, _).

student(4,cse101, hcapped).

student(5,cse101, hcapped).
student(5,cse102, hcapped).

schedule(id1, 8, cse101).
schedule(id1, 9, cse101).
schedule(id1, 10, cse101).

schedule(id1, 13, cse102).
schedule(id1, 14, cse102).
schedule(id1, 15, cse102).

schedule(id2, 15, cse241).
schedule(id2, 16, cse241).

schedule(id2, 15, cse101).
schedule(id2, 16, cse101).
schedule(id2, 17, cse101).

% name, id, needs
instructor(yakup, cse102, projector).
instructor(yusuf, cse241, smart_board).
instructor(mehmet, cse101, smart_board).


% rules
is_conflict(COURSE1, COURSE2) :-
    schedule(R1, T1, COURSE1), schedule(R2, T2, COURSE2), R1 == R2, T1 == T2.
