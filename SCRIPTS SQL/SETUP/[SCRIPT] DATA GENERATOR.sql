USE QUEENSWOOD_SUMMER_CAMP
GO

-- ============================================================
-- QUEENSWOOD SUMMER CAMP — DATA SCRIPT
-- ============================================================

-- ------------------------------------------------------------
-- 1. EMPLOYEES
-- ------------------------------------------------------------

INSERT INTO EMPLOYEE (EmployeeID, Name, Email, Phone, Position, Salary, ActivitiesBonus, TutorBonus) VALUES
(1,  'Carlos Martínez', 'carlos.martinez@queenswood.com', '612345678', 'Manager', 2200.00, 0.00, 0.00),
(2,  'Emma Johnson',    'emma.johnson@queenswood.com',    '611223344', 'Coach',   1500.00, 0.00, 0.00),
(3,  'Lucía Gómez',     'lucia.gomez@queenswood.com',     '622334455', 'Coach',   1500.00, 0.00, 0.00),
(4,  'Daniel Smith',    'daniel.smith@queenswood.com',    '633445566', 'Coach',   1500.00, 0.00, 0.00),
(5,  'María López',     'maria.lopez@queenswood.com',     '644556677', 'Coach',   1500.00, 0.00, 0.00),
(6,  'James Brown',     'james.brown@queenswood.com',     '655667788', 'Coach',   1500.00, 0.00, 0.00),
(7,  'Laura Torres',    'laura.torres@queenswood.com',    '666778899', 'Coach',   1500.00, 0.00, 0.00),
(8,  'Michael Taylor',  'michael.taylor@queenswood.com',  '677889900', 'Coach',   1500.00, 0.00, 0.00),
(9,  'Carmen Ruiz',     'carmen.ruiz@queenswood.com',     '688990011', 'Coach',   1500.00, 0.00, 0.00),
(10, 'David Wilson',    'david.wilson@queenswood.com',    '699001122', 'Coach',   1500.00, 0.00, 0.00),
(11, 'Ana Herrera',     'ana.herrera@queenswood.com',     '600112233', 'Cook',    1600.00, 0.00, 0.00);
GO

-- ------------------------------------------------------------
-- 2. CABINS
--    Female cabins: Willow(3), Birch(3), Cherry(3), Elm(6), Linden(5)
--    Male cabins:   Oak(4), Pine(4), Cedar(6), Maple(6)
--    Initial tutors assigned; TRIG3 will be tested via UPDATE later.
-- ------------------------------------------------------------

INSERT INTO CABIN (CabinID, Name, Type, Spots, EmployeeID) VALUES
(1, 'Willow', 'F', 3, 3),   -- Lucía Gómez (initially)
(2, 'Birch',  'F', 3, 9),   -- Carmen Ruiz
(3, 'Cherry', 'F', 3, 9),   -- Carmen Ruiz (2 cabins → TutorBonus should be 80)
(4, 'Elm',    'F', 6, 10),  -- David Wilson
(5, 'Linden', 'F', 5, 10),  -- David Wilson (2 cabins)
(6, 'Oak',    'M', 4, 4),   -- Daniel Smith
(7, 'Pine',   'M', 4, 6),   -- James Brown
(8, 'Cedar',  'M', 6, 8),   -- Michael Taylor
(9, 'Maple',  'M', 6, 3);   -- Lucía Gómez
GO

-- Manually set initial TutorBonus to reflect pre-assigned cabins
-- (Normally TRIG3 handles this; we set it to match the PDF expected state)
UPDATE EMPLOYEE SET TutorBonus = 80.00 WHERE EmployeeID = 9;  -- Carmen Ruiz: 2 cabins × 40
UPDATE EMPLOYEE SET TutorBonus = 80.00 WHERE EmployeeID = 10; -- David Wilson: 2 cabins × 40
UPDATE EMPLOYEE SET TutorBonus = 80.00 WHERE EmployeeID = 3;  -- Lucía Gómez: 2 cabins × 40 (Willow+Maple)
UPDATE EMPLOYEE SET TutorBonus = 40.00 WHERE EmployeeID = 4;  -- Daniel Smith: 1 cabin × 40
UPDATE EMPLOYEE SET TutorBonus = 40.00 WHERE EmployeeID = 6;  -- James Brown: 1 cabin × 40
UPDATE EMPLOYEE SET TutorBonus = 40.00 WHERE EmployeeID = 8;  -- Michael Taylor: 1 cabin × 40
GO

-- ------------------------------------------------------------
-- 3. PARENTS
-- ------------------------------------------------------------

INSERT INTO PARENT (ParentID, Name, Surnames, Gender, Phone) VALUES
(1,  'Laura',    'García',    'F', '611000001'),
(2,  'Michael',  'Smith',     'M', '611000002'),
(3,  'Ana',      'López',     'F', '611000003'),
(4,  'James',    'Brown',     'M', '611000004'),
(5,  'David',    'Johnson',   'M', '611000005'),
(6,  'Marta',    'Sánchez',   'F', '611000006'),
(7,  'Patricia', 'Romero',    'F', '611000007'),
(8,  'John',     'Miller',    'M', '611000008'),
(9,  'Robert',   'Davis',     'M', '611000009'),
(10, 'Sofía',    'Castro',    'F', '611000010'),
(11, 'Daniel',   'Martínez',  'M', '611000011'),
(12, 'Raquel',   'Flores',    'F', '611000012'),
(13, 'Andrew',   'Moore',     'M', '611000013'),
(14, 'Clara',    'Jiménez',   'F', '611000014'),
(15, 'Thomas',   'Anderson',  'M', '611000015'),
(16, 'Brian',    'Martin',    'M', '611000016'),
(17, 'Noelia',   'Cabrera',   'F', '611000017'),
(18, 'Beatriz',  'Morales',   'F', '611000018'),
(19, 'Charles',  'Jackson',   'M', '611000019'),
(20, 'Cristina', 'León',      'F', '611000020'),
(21, 'Irene',    'Ferrer',    'F', '611000021'),
(22, 'Kevin',    'Harris',    'M', '611000022'),
(23, 'William',  'Wilson',    'M', '611000023'),
(24, 'George',   'Thompson',  'M', '611000024'),
(25, 'Lucía',    'Molina',    'F', '611000025'),
(26, 'Natalia',  'Rubio',     'F', '611000026'),
(27, 'Eva',      'Gil',       'F', '611000027'),
(28, 'Mark',     'Taylor',    'M', '611000028'),
(29, 'Steven',   'White',     'M', '611000029'),
(30, 'Verónica', 'Herrera',   'F', '611000030');
GO

-- ------------------------------------------------------------
-- 4. ACTIVITIES
-- ------------------------------------------------------------

-- Activity 1: Yoga for Teens (Mon-Wed-Fri 10:00-12:00)
-- TRIG2 fires: assigns coaches from pool with no 10:00-12:00 Mon-Wed-Fri conflict
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(1, 'Yoga for Teens', 'Morning yoga session to improve flexibility', 'Mon-Wed-Fri', '10:00-12:00', 'Physical', 15);

-- Activity 2: Drama Workshop (Mon-Wed-Fri 10:00-12:00) — simultaneous with Act 1
-- TRIG2 fires: needs 2 coaches NOT already in 10:00-12:00 Mon-Wed-Fri
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(2, 'Drama Workshop', 'Creative theatre games and roleplay', 'Mon-Wed-Fri', '10:00-12:00', 'Recreational', 20);

-- Activity 3: Team Sports (Tue-Thu-Sat 16:00-18:00)
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(3, 'Team Sports', 'Group games like football and basketball', 'Tue-Thu-Sat', '16:00-18:00', 'Physical', 25);

-- Activity 4: Dance Class (Mon-Wed-Fri 16:00-18:00)
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(4, 'Dance Class', 'Hip hop and freestyle dance session', 'Mon-Wed-Fri', '16:00-18:00', 'Physical', 15);

-- Activity 5: Photography Basics (Tue-Thu-Sat 10:00-12:00)
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(5, 'Photography Basics', 'Learn to take great photos with smartphones', 'Tue-Thu-Sat', '10:00-12:00', 'Recreational', 10);

-- Activity 6: Board Game Club (Tue-Thu-Sat 16:00-18:00) — simultaneous with Act 3
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(6, 'Board Game Club', 'Strategy and fun with classic board games', 'Tue-Thu-Sat', '16:00-18:00', 'Recreational', 15);

-- Activity 7: Evening Hike (Tue-Thu-Sat 19:00-21:00)
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(7, 'Evening Hike', 'Nature walks around the campsite area', 'Tue-Thu-Sat', '19:00-21:00', 'Physical', 12);

-- Activity 8: Campfire Stories (Mon-Wed-Fri 19:00-21:00)
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(8, 'Campfire Stories', 'Storytelling and games around the fire', 'Mon-Wed-Fri', '19:00-21:00', 'Recreational', 15);

-- Activity 9: Movie Night (Tue-Thu-Sat 19:00-21:00) — simultaneous with Act 7
INSERT INTO ACTIVITY (ActivityID, Name, Description, Days, TimeSlot, Type, AvailableSpots) VALUES
(9, 'Movie Night', 'Watch and discuss family-friendly films', 'Tue-Thu-Sat', '19:00-21:00', 'Recreational', 15);
GO

-- ------------------------------------------------------------
-- 5. CHILDREN
-- ------------------------------------------------------------

-- FEMALE CHILDREN (20 total — exactly fills all F cabins)
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (1,  'Emily Smith',      'F', '2010-05-14');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (2,  'Sophia López',     'F', '2011-09-22');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (3,  'Olivia Johnson',   'F', '2012-01-30');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (4,  'Ava Brown',        'F', '2009-11-03');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (5,  'Isabella Miller',  'F', '2010-07-17');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (6,  'Mia Molina',       'F', '2011-03-10');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (7,  'Charlotte Wilson', 'F', '2010-04-27');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (8,  'Evelyn Anderson',  'F', '2012-08-15');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (9,  'Harper Morales',   'F', '2011-06-09');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (10, 'Luna Martínez',    'F', '2009-10-03');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (11, 'Ella Moore',       'F', '2010-01-25');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (12, 'Scarlett Taylor',  'F', '2011-11-12');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (13, 'Grace Rubio',      'F', '2012-02-04');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (14, 'Chloe Jackson',    'F', '2009-06-18');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (15, 'Layla Harris',     'F', '2011-07-08');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (16, 'Riley Herrera',    'F', '2012-05-02');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (17, 'Lily Martin',      'F', '2010-03-15');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (18, 'Zoe Thompson',     'F', '2009-08-20');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (19, 'Amelia Davis',     'F', '2009-12-19');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (20, 'Camila White',     'F', '2010-10-29');
GO

-- MALE CHILDREN (20 total — exactly fills all M cabins)
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (21, 'Liam Smith',       'M', '2012-06-11');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (22, 'Noah López',       'M', '2010-09-01');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (23, 'Elijah Johnson',   'M', '2011-02-20');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (24, 'James Brown',      'M', '2009-12-13');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (25, 'Benjamin Miller',  'M', '2010-05-05');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (26, 'Lucas Molina',     'M', '2011-08-25');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (27, 'Henry Davis',      'M', '2012-01-16');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (28, 'Alexander Wilson', 'M', '2009-03-11');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (29, 'Sebastian Anderson','M', '2010-07-07');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (30, 'Jackson Morales',  'M', '2011-04-19');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (31, 'Mateo Martínez',   'M', '2012-10-26');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (32, 'Levi Moore',       'M', '2009-05-22');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (33, 'Daniel Taylor',    'M', '2010-09-09');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (34, 'Logan Rubio',      'M', '2011-01-04');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (35, 'Jacob Jackson',    'M', '2012-12-08');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (36, 'Ethan White',      'M', '2009-06-30');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (37, 'David Harris',     'M', '2010-02-14');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (38, 'Joseph Herrera',   'M', '2011-11-28');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (39, 'Samuel Martin',    'M', '2012-03-06');
INSERT INTO CHILD (ChildID, Name, Gender, DateOfBirth) VALUES (40, 'Owen Thompson',    'M', '2009-07-17');
GO

-- ------------------------------------------------------------
-- 6. HAS_PARENT (each child has at least 1 parent, up to 2)
-- ------------------------------------------------------------
INSERT INTO HAS_PARENT (ChildID, ParentID) VALUES
(1,  1), (1,  2),   -- Emily Smith: Laura García + Michael Smith
(2,  3),            -- Sophia López: Ana López (solo 1 padre)
(3,  5), (3,  6),   -- Olivia Johnson: David Johnson + Marta Sánchez
(4,  4),            -- Ava Brown: James Brown (solo 1 padre)
(5,  7), (5,  8),   -- Isabella Miller: Patricia Romero + John Miller
(6,  25),           -- Mia Molina: Lucía Molina (solo 1 padre)
(7,  23),           -- Charlotte Wilson: William Wilson (solo 1 padre)
(8,  14),(8,  15),  -- Evelyn Anderson: Clara Jiménez + Thomas Anderson
(9,  18),           -- Harper Morales: Beatriz Morales
(10, 11),(10, 12),  -- Luna Martínez: Daniel Martínez + Raquel Flores
(11, 13),           -- Ella Moore: Andrew Moore
(12, 27),(12, 28),  -- Scarlett Taylor: Eva Gil + Mark Taylor
(13, 26),           -- Grace Rubio: Natalia Rubio
(14, 19),(14, 20),  -- Chloe Jackson: Charles Jackson + Cristina León
(15, 21),(15, 22),  -- Layla Harris: Irene Ferrer + Kevin Harris
(16, 30),           -- Riley Herrera: Verónica Herrera
(17, 16),(17, 17),  -- Lily Martin: Brian Martin + Noelia Cabrera
(18, 24),           -- Zoe Thompson: George Thompson
(19, 9), (19, 10),  -- Amelia Davis: Robert Davis + Sofía Castro
(20, 29),           -- Camila White: Steven White
-- Male children
(21, 1), (21, 2),   -- Liam Smith: Laura García + Michael Smith
(22, 3),            -- Noah López: Ana López
(23, 5), (23, 6),   -- Elijah Johnson: David Johnson + Marta Sánchez
(24, 4),            -- James Brown: James Brown
(25, 7), (25, 8),   -- Benjamin Miller: Patricia Romero + John Miller
(26, 25),           -- Lucas Molina: Lucía Molina
(27, 9), (27, 10),  -- Henry Davis: Robert Davis + Sofía Castro
(28, 23),           -- Alexander Wilson: William Wilson
(29, 14),(29, 15),  -- Sebastian Anderson: Clara Jiménez + Thomas Anderson
(30, 18),           -- Jackson Morales: Beatriz Morales
(31, 11),(31, 12),  -- Mateo Martínez: Daniel Martínez + Raquel Flores
(32, 13),           -- Levi Moore: Andrew Moore
(33, 27),(33, 28),  -- Daniel Taylor: Eva Gil + Mark Taylor
(34, 26),           -- Logan Rubio: Natalia Rubio
(35, 19),(35, 20),  -- Jacob Jackson: Charles Jackson + Cristina León
(36, 29),           -- Ethan White: Steven White
(37, 21),(37, 22),  -- David Harris: Irene Ferrer + Kevin Harris
(38, 30),           -- Joseph Herrera: Verónica Herrera
(39, 16),(39, 17),  -- Samuel Martin: Brian Martin + Noelia Cabrera
(40, 24);           -- Owen Thompson: George Thompson
GO

-- ------------------------------------------------------------
-- 7. MEDICAL_ISSUES (only some children have them)
-- ------------------------------------------------------------
INSERT INTO MEDICAL_ISSUE (ChildID, Number, IssueDescription, Medication, SpecialNeeds) VALUES
(4, 1, 'Seasonal allergies with frequent sneezing', 'Loratadine', 'Avoid grass exposure'),
(4, 2, 'Mild asthma episodes during physical activity', 'Salbutamol inhaler', 'Monitor during sports'),
(4, 3, 'Skin rash due to detergent allergy', 'Hydrocortisone cream', 'Use hypoallergenic detergents'),
(8, 1, 'Lactose intolerance diagnosed at age 9', NULL, 'Lactose-free meals required'),
(8, 2, 'Mild anxiety in unfamiliar environments', 'Rescue medication if needed', 'Daily emotional check-in'),
(15,1, 'Sensitive digestive system', 'Probiotics', 'Avoid spicy food'),
(23,1, 'Mild scoliosis', NULL, 'Avoid heavy backpacks'),
(31,1, 'Peanut allergy — anaphylaxis risk', 'EpiPen', 'No peanuts in any form'),
(36,1, 'ADHD — attention and hyperactivity', 'Methylphenidate', 'Structured environment needed');
GO

-- ------------------------------------------------------------
-- 8. REGISTER
-- ------------------------------------------------------------

-- FEMALE CHILDREN REGISTRATIONS
-- Emily Smith (1):     Yoga(1), Photography(5), Team Sports(3), Dance Class(4)
INSERT INTO REGISTER VALUES (1,1); INSERT INTO REGISTER VALUES (1,5); 
INSERT INTO REGISTER VALUES (1,3); INSERT INTO REGISTER VALUES (1,4);

-- Sophia López (2):    Yoga(1), Dance Class(4), Movie Night(9), Campfire(8)
INSERT INTO REGISTER VALUES (2,1); INSERT INTO REGISTER VALUES (2,4); 
INSERT INTO REGISTER VALUES (2,9); INSERT INTO REGISTER VALUES (2,8);

-- Olivia Johnson (3):  Yoga(1), Board Game(6), Movie Night(9)
INSERT INTO REGISTER VALUES (3,1); INSERT INTO REGISTER VALUES (3,6); INSERT INTO REGISTER VALUES (3,9);

-- Ava Brown (4):       Yoga(1), Photography(5), Team Sports(3)
INSERT INTO REGISTER VALUES (4,1); INSERT INTO REGISTER VALUES (4,5); INSERT INTO REGISTER VALUES (4,3);

-- Isabella Miller (5): Yoga(1), Photography(5), Campfire(8)
INSERT INTO REGISTER VALUES (5,1); INSERT INTO REGISTER VALUES (5,5); INSERT INTO REGISTER VALUES (5,8);

-- Mia Molina (6):      Dance Class(4), Movie Night(9), Campfire(8)
INSERT INTO REGISTER VALUES (6,4); INSERT INTO REGISTER VALUES (6,9); INSERT INTO REGISTER VALUES (6,8);

-- Charlotte Wilson (7):Board Game(6), Dance Class(4), Movie Night(9)
INSERT INTO REGISTER VALUES (7,6); INSERT INTO REGISTER VALUES (7,4); INSERT INTO REGISTER VALUES (7,9);

-- Evelyn Anderson (8): Drama(2), Photography(5), Campfire(8)
INSERT INTO REGISTER VALUES (8,2); INSERT INTO REGISTER VALUES (8,5); INSERT INTO REGISTER VALUES (8,8);

-- Harper Morales (9):  Photography(5), Dance Class(4), Campfire(8)
INSERT INTO REGISTER VALUES (9,5); INSERT INTO REGISTER VALUES (9,4); INSERT INTO REGISTER VALUES (9,8);

-- Luna Martínez (10):  Drama(2), Team Sports(3), Evening Hike(7), Campfire(8)
INSERT INTO REGISTER VALUES (10,2); INSERT INTO REGISTER VALUES (10,3); 
INSERT INTO REGISTER VALUES (10,7); INSERT INTO REGISTER VALUES (10,8);

-- Ella Moore (11):     Photography(5), Team Sports(3), Dance Class(4), Movie Night(9)
INSERT INTO REGISTER VALUES (11,5); INSERT INTO REGISTER VALUES (11,3); 
INSERT INTO REGISTER VALUES (11,4); INSERT INTO REGISTER VALUES (11,9);

-- Scarlett Taylor (12):Photography(5), Board Game(6), Evening Hike(7)
INSERT INTO REGISTER VALUES (12,5); INSERT INTO REGISTER VALUES (12,6); INSERT INTO REGISTER VALUES (12,7);

-- Grace Rubio (13):    Drama(2), Board Game(6), Evening Hike(7)
INSERT INTO REGISTER VALUES (13,2); INSERT INTO REGISTER VALUES (13,6); INSERT INTO REGISTER VALUES (13,7);

-- Chloe Jackson (14):  Drama(2), Team Sports(3), Campfire(8)
INSERT INTO REGISTER VALUES (14,2); INSERT INTO REGISTER VALUES (14,3); INSERT INTO REGISTER VALUES (14,8);

-- Layla Harris (15):   Drama(2), Evening Hike(7), Campfire(8)
INSERT INTO REGISTER VALUES (15,2); INSERT INTO REGISTER VALUES (15,7); INSERT INTO REGISTER VALUES (15,8);

-- Riley Herrera (16):  Drama(2), Evening Hike(7), Campfire(8)
INSERT INTO REGISTER VALUES (16,2); INSERT INTO REGISTER VALUES (16,7); INSERT INTO REGISTER VALUES (16,8);

-- Lily Martin (17):    Drama(2), Team Sports(3), Movie Night(9), Campfire(8)
INSERT INTO REGISTER VALUES (17,2); INSERT INTO REGISTER VALUES (17,3); 
INSERT INTO REGISTER VALUES (17,9); INSERT INTO REGISTER VALUES (17,8);

-- Zoe Thompson (18):   Drama(2), Team Sports(3), Movie Night(9), Campfire(8)
INSERT INTO REGISTER VALUES (18,2); INSERT INTO REGISTER VALUES (18,3); 
INSERT INTO REGISTER VALUES (18,9); INSERT INTO REGISTER VALUES (18,8);

-- Amelia Davis (19):   Drama(2), Photography(5), Board Game(6)
INSERT INTO REGISTER VALUES (19,2); INSERT INTO REGISTER VALUES (19,5); INSERT INTO REGISTER VALUES (19,6);

-- Camila White (20):   Board Game(6), Movie Night(9)
-- Note: only 2 activities — intentionally left low so we can test the 5th registration rollback
INSERT INTO REGISTER VALUES (20,6); INSERT INTO REGISTER VALUES (20,9);
GO

-- MALE CHILDREN REGISTRATIONS
-- Liam Smith (21):     Drama(2), Team Sports(3), Movie Night(9)
INSERT INTO REGISTER VALUES (21,2); INSERT INTO REGISTER VALUES (21,3); INSERT INTO REGISTER VALUES (21,9);

-- Noah López (22):     Drama(2), Team Sports(3), Movie Night(9)
INSERT INTO REGISTER VALUES (22,2); INSERT INTO REGISTER VALUES (22,3); INSERT INTO REGISTER VALUES (22,9);

-- Elijah Johnson (23): Photography(5), Team Sports(3), Movie Night(9)
INSERT INTO REGISTER VALUES (23,5); INSERT INTO REGISTER VALUES (23,3); INSERT INTO REGISTER VALUES (23,9);

-- James Brown (24):    Yoga(1), Photography(5), Team Sports(3)
INSERT INTO REGISTER VALUES (24,1); INSERT INTO REGISTER VALUES (24,5); INSERT INTO REGISTER VALUES (24,3);

-- Benjamin Miller (25):Drama(2), Board Game(6), Evening Hike(7)
INSERT INTO REGISTER VALUES (25,2); INSERT INTO REGISTER VALUES (25,6); INSERT INTO REGISTER VALUES (25,7);

-- Lucas Molina (26):   Drama(2), Team Sports(3), Dance Class(4)
INSERT INTO REGISTER VALUES (26,2); INSERT INTO REGISTER VALUES (26,3); INSERT INTO REGISTER VALUES (26,4);

-- Henry Davis (27):    Board Game(6), Dance Class(4), Evening Hike(7)
INSERT INTO REGISTER VALUES (27,6); INSERT INTO REGISTER VALUES (27,4); INSERT INTO REGISTER VALUES (27,7);

-- Alexander Wilson (28):Drama(2), Team Sports(3), Dance Class(4)
INSERT INTO REGISTER VALUES (28,2); INSERT INTO REGISTER VALUES (28,3); INSERT INTO REGISTER VALUES (28,4);

-- Sebastian Anderson (29):Yoga(1), Board Game(6), Dance Class(4)
INSERT INTO REGISTER VALUES (29,1); INSERT INTO REGISTER VALUES (29,6); INSERT INTO REGISTER VALUES (29,4);

-- Jackson Morales (30):Drama(2), Team Sports(3), Evening Hike(7)
INSERT INTO REGISTER VALUES (30,2); INSERT INTO REGISTER VALUES (30,3); INSERT INTO REGISTER VALUES (30,7);

-- Mateo Martínez (31): Yoga(1), Board Game(6), Evening Hike(7)
INSERT INTO REGISTER VALUES (31,1); INSERT INTO REGISTER VALUES (31,6); INSERT INTO REGISTER VALUES (31,7);

-- Levi Moore (32):     Yoga(1), Team Sports(3), Evening Hike(7), Campfire(8)
INSERT INTO REGISTER VALUES (32,1); INSERT INTO REGISTER VALUES (32,3); 
INSERT INTO REGISTER VALUES (32,7); INSERT INTO REGISTER VALUES (32,8);

-- Daniel Taylor (33):  Yoga(1), Evening Hike(7)
-- (only 2 registered — used for rollback test cases below)
INSERT INTO REGISTER VALUES (33,1); INSERT INTO REGISTER VALUES (33,7);

-- Logan Rubio (34):    Drama(2), Team Sports(3), Evening Hike(7)
INSERT INTO REGISTER VALUES (34,2); INSERT INTO REGISTER VALUES (34,3); INSERT INTO REGISTER VALUES (34,7);

-- Jacob Jackson (35):  Yoga(1), Team Sports(3), Dance Class(4), Campfire(8)
INSERT INTO REGISTER VALUES (35,1); INSERT INTO REGISTER VALUES (35,3); 
INSERT INTO REGISTER VALUES (35,4); INSERT INTO REGISTER VALUES (35,8);

-- Ethan White (36):    Drama(2), Board Game(6), Dance Class(4)
INSERT INTO REGISTER VALUES (36,2); INSERT INTO REGISTER VALUES (36,6); INSERT INTO REGISTER VALUES (36,4);

-- David Harris (37):   Yoga(1), Team Sports(3), Dance Class(4), Campfire(8)
INSERT INTO REGISTER VALUES (37,1); INSERT INTO REGISTER VALUES (37,3); 
INSERT INTO REGISTER VALUES (37,4); INSERT INTO REGISTER VALUES (37,8);

-- Joseph Herrera (38): Drama(2), Board Game(6), Dance Class(4)
INSERT INTO REGISTER VALUES (38,2); INSERT INTO REGISTER VALUES (38,6); INSERT INTO REGISTER VALUES (38,4);

-- Samuel Martin (39):  Drama(2), Board Game(6), Dance Class(4)
INSERT INTO REGISTER VALUES (39,2); INSERT INTO REGISTER VALUES (39,6); INSERT INTO REGISTER VALUES (39,4);

-- Owen Thompson (40):  Yoga(1), Team Sports(3), Movie Night(9)
INSERT INTO REGISTER VALUES (40,1); INSERT INTO REGISTER VALUES (40,3); INSERT INTO REGISTER VALUES (40,9);
GO

