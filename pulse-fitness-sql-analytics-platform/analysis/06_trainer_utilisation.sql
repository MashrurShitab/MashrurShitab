/*
Query Name: Trainer Utilisation and Rating Analysis
Difficulty Level: Intermediate
Business Question: Which trainers deliver the most sessions and receive the highest average ratings?
Why This Matters: Supports trainer reward, coaching, workload allocation, and quality monitoring.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: JOIN, AVG, COUNT, HAVING, ORDER BY
Expected Output: Trainer, location, class sessions, PT sessions, total sessions, average rating
*/

USE PulseFitnessAnalytics;

SELECT
    t.TrainerID,
    t.FullName AS TrainerName,
    gl.LocationName,
    COUNT(DISTINCT cs.SessionID) AS ClassSessionCount,
    COUNT(DISTINCT pts.PTSessionID) AS PTSessionCount,
    COUNT(DISTINCT cs.SessionID) + COUNT(DISTINCT pts.PTSessionID) AS TotalDeliveredSessions,
    ROUND(AVG(pts.Rating), 2) AS AvgPTRating
FROM Trainer t
JOIN GymLocation gl ON t.LocationID = gl.LocationID
LEFT JOIN ClassSession cs
    ON t.TrainerID = cs.TrainerID
   AND cs.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
   AND cs.SessionStatus = 'Completed'
LEFT JOIN PersonalTrainingSession pts
    ON t.TrainerID = pts.TrainerID
   AND pts.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
   AND pts.SessionStatus = 'Completed'
GROUP BY t.TrainerID, t.FullName, gl.LocationName
HAVING TotalDeliveredSessions >= 5
ORDER BY TotalDeliveredSessions DESC, AvgPTRating DESC;
