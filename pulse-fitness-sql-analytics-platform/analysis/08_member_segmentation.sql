/*
Query Name: Member Engagement Segmentation
Difficulty Level: Advanced
Business Question: How can members be segmented based on facility visits, class attendance, and personal training usage?
Why This Matters: Supports targeted campaigns for highly engaged, moderately active, low-engagement, and at-risk members.
Analysis Period: 2025-01-01 to 2025-06-30
SQL Concepts Used: CTEs, CASE, aggregation, multiple joins
Expected Output: Member, membership type, visits, attended classes, PT sessions, engagement segment
*/

USE PulseFitnessAnalytics;

WITH visit_counts AS (
    SELECT
        MemberID,
        COUNT(*) AS VisitCount
    FROM FacilityVisit
    WHERE CheckInTime BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    GROUP BY MemberID
),
class_counts AS (
    SELECT
        ce.MemberID,
        COUNT(*) AS ClassesAttended
    FROM ClassEnrollment ce
    JOIN ClassAttendance ca ON ce.EnrollmentID = ca.EnrollmentID
    JOIN ClassSession cs ON ce.SessionID = cs.SessionID
    WHERE ca.AttendanceStatus IN ('Present', 'Late')
      AND cs.SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    GROUP BY ce.MemberID
),
pt_counts AS (
    SELECT
        MemberID,
        COUNT(*) AS PTSessionCount
    FROM PersonalTrainingSession
    WHERE SessionStatus = 'Completed'
      AND SessionStart BETWEEN '2025-01-01' AND '2025-06-30 23:59:59'
    GROUP BY MemberID
)
SELECT
    m.MemberID,
    m.FullName,
    mt.TypeName AS MembershipType,
    COALESCE(vc.VisitCount, 0) AS VisitCount,
    COALESCE(cc.ClassesAttended, 0) AS ClassesAttended,
    COALESCE(pc.PTSessionCount, 0) AS PTSessionCount,
    CASE
        WHEN COALESCE(vc.VisitCount, 0) >= 8
          AND COALESCE(cc.ClassesAttended, 0) >= 8 THEN 'Highly Engaged'
        WHEN COALESCE(vc.VisitCount, 0) >= 4
          OR COALESCE(cc.ClassesAttended, 0) >= 4
          OR COALESCE(pc.PTSessionCount, 0) >= 1 THEN 'Moderately Active'
        WHEN COALESCE(vc.VisitCount, 0) BETWEEN 1 AND 3
          OR COALESCE(cc.ClassesAttended, 0) BETWEEN 1 AND 3 THEN 'Low Engagement'
        ELSE 'At Risk'
    END AS EngagementSegment
FROM `Member` m
JOIN MembershipType mt ON m.MembershipTypeID = mt.MembershipTypeID
LEFT JOIN visit_counts vc ON m.MemberID = vc.MemberID
LEFT JOIN class_counts cc ON m.MemberID = cc.MemberID
LEFT JOIN pt_counts pc ON m.MemberID = pc.MemberID
WHERE m.MemberStatus = 'Active'
ORDER BY EngagementSegment, VisitCount DESC, ClassesAttended DESC;
