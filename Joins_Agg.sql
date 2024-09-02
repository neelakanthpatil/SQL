SELECT CONTESTS.CONTEST_ID,
CONTESTS.HACKER_ID,
CONTESTS.NAME,
SUM(SUBMISSION_STATS.TOTAL_SUBMISSIONS),
SUM(SUBMISSION_STATS.TOTAL_ACCEPTED_SUBMISSIONS),
SUM(VIEW_STATS.TOTAL_VIEWS),
SUM(VIEW_STATS.TOTAL_UNIQUE_VIEWS)
FROM CONTESTS 
LEFT OUTER JOIN COLLEGES
ON CONTESTS.CONTEST_ID = COLLEGES.CONTEST_ID
LEFT OUTER JOIN CHALLENGES 
ON CHALLENGES.COLLEGE_ID = COLLEGES.COLLEGE_ID
LEFT OUTER JOIN 
(SELECT VIEW_STATS.CHALLENGE_ID AS CHALLENGE_ID,
 SUM(VIEW_STATS.TOTAL_VIEWS) AS TOTAL_VIEWS,
 SUM(VIEW_STATS.TOTAL_UNIQUE_VIEWS) AS TOTAL_UNIQUE_VIEWS
 FROM VIEW_STATS
 GROUP BY VIEW_STATS.CHALLENGE_ID) VIEW_STATS 
ON VIEW_STATS.CHALLENGE_ID = CHALLENGES.CHALLENGE_ID
LEFT OUTER JOIN 
(SELECT SUBMISSION_STATS.CHALLENGE_ID AS CHALLENGE_ID,
SUM(SUBMISSION_STATS.TOTAL_SUBMISSIONS) AS TOTAL_SUBMISSIONS,
SUM(SUBMISSION_STATS.TOTAL_ACCEPTED_SUBMISSIONS) AS TOTAL_ACCEPTED_SUBMISSIONS
 FROM SUBMISSION_STATS
 GROUP BY SUBMISSION_STATS.CHALLENGE_ID
) SUBMISSION_STATS
ON VIEW_STATS.CHALLENGE_ID = SUBMISSION_STATS.CHALLENGE_ID 
GROUP BY CONTESTS.CONTEST_ID,CONTESTS.HACKER_ID,CONTESTS.NAME
HAVING SUM(SUBMISSION_STATS.TOTAL_SUBMISSIONS) !=0
OR SUM(SUBMISSION_STATS.TOTAL_ACCEPTED_SUBMISSIONS) !=0
OR SUM(VIEW_STATS.TOTAL_VIEWS) !=0
OR SUM(VIEW_STATS.TOTAL_UNIQUE_VIEWS) !=0;