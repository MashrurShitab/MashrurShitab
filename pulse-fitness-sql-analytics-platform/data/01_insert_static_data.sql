/*
Pulse Fitness SQL Analytics Platform
Script: 01_insert_static_data.sql
Purpose: Insert static reference data for locations, membership plans, and class types.
*/

USE PulseFitnessAnalytics;

INSERT INTO GymLocation (LocationID, LocationName, City, State, Postcode) VALUES
(1, 'Bankstown', 'Bankstown', 'NSW', '2200'),
(2, 'Parramatta', 'Parramatta', 'NSW', '2150'),
(3, 'Sydney CBD', 'Sydney', 'NSW', '2000'),
(4, 'Chatswood', 'Chatswood', 'NSW', '2067'),
(5, 'Liverpool', 'Liverpool', 'NSW', '2170');

INSERT INTO MembershipType (MembershipTypeID, TypeName, PricePerMonth, ClassLimitPerWeek, IncludesFreePT) VALUES
(1, 'Basic', 30.00, 2, FALSE),
(2, 'Premium', 60.00, NULL, TRUE),
(3, 'Student', 25.00, 3, FALSE);

INSERT INTO FitnessClass (ClassID, ClassName, DifficultyLevel, DefaultDurationMinutes) VALUES
(1, 'Yoga', 'Beginner', 60),
(2, 'Zumba', 'Beginner', 45),
(3, 'CrossFit', 'Advanced', 60),
(4, 'Pilates', 'Intermediate', 50),
(5, 'Spin', 'Intermediate', 45),
(6, 'HIIT', 'Advanced', 40);
