CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
); 

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(5000) NOT NULL,
  authorid INTEGER,
  FOREIGN KEY (authorid) REFERENCES users(id)
);

CREATE TABLE question_followers (
  relationshipid INTEGER PRIMARY KEY,
  questionid INTEGER,
  userid INTEGER,
  FOREIGN KEY (questionid) REFERENCES questions(id), 
  FOREIGN KEY (userid) REFERENCES users(id)
);

CREATE TABLE replies (
  reply_id INTEGER PRIMARY KEY,
  body VARCHAR(5000) NOT NULL,
  questionid INTEGER,
  userid INTEGER,
  parent_reply_id INTEGER,
  FOREIGN KEY (questionid) REFERENCES questions(id),
  FOREIGN KEY (userid) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(reply_id)
);

CREATE TABLE question_likes (
  likes_id INTEGER PRIMARY KEY,
  userid INTEGER,
  questionid INTEGER,
  FOREIGN KEY (userid) REFERENCES users(id),
  FOREIGN KEY (questionid) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
('Bob', 'Hannigan'),
('Seymore', 'Goldman'),
('Hugh', 'SilverHammer');

INSERT INTO
  questions (title, body, authorid)
VALUES
  ("Help", "How do you do sql?", (SELECT id FROM users WHERE id = 1)),
  ("What?", "Is ruby important?", (SELECT id FROM users WHERE id = 2)),
  ("How?", "How do I integrate?", (SELECT id FROM users WHERE id = 3)),
  ("When?", "When should I sql?", (SELECT id FROM users WHERE id = 2));

INSERT INTO 
  question_followers (questionid, userid)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 2),
  (3, 2);
  
INSERT INTO
  replies (body, questionid, userid, parent_reply_id)
VALUES
  ("It's easy, use SELECT", 1, 3, NULL), 
  ("No it's not important", 2, 3, NULL),
  ("You also need to use FROM and WHERE", 1, 2, 1);
  
INSERT INTO
  question_likes(userid, questionid)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (2, 2);


