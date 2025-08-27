CREATE SCHEMA COLLEGE;
USE COLLEGE;

CREATE TABLE student(
Student_ID VARCHAR(50) PRIMARY KEY,
Student_Name VARCHAR(50) NOT NULL,
Age INT,
Gender VARCHAR(50),
Department VARCHAR(50),
Year_Of_Study VARCHAR(50),
CGPA INT,
City VARCHAR(50),
Country VARCHAR(50),
Scholarship_Amount INT
);

SELECT * FROM student;

SELECT Department , SUM(CGPA)
FROM student
GROUP BY Department
HAVING SUM(CGPA);

# Find the average GPA for each department. 
SELECT Department , AVG(CGPA)
FROM student
GROUP BY Department
HAVING AVG(CGPA);

#Find students who have a GPA higher than the department average. 
SELECT Student_ID , Student_Name , Department , CGPA
FROM student
WHERE CGPA > (
SELECT AVG(CGPA)
FROM student
WHERE Department = Department
);

SELECT Student_ID , Student_Name , Department , CGPA
FROM student
WHERE CGPA > 8.5;

#Identify students who have a CGPA above 8.5 but received a scholarship amount less than 
#the average scholarship amount. 
SELECT Student_ID , Student_Name , Department , CGPA , Scholarship_Amount
FROM student
WHERE (CGPA > 8.5)
AND Scholarship_Amount < (
SELECT AVG(Scholarship_Amount)
FROM student
);

#Find the gender with the highest average CGPA in each department.
SELECT Gender , Department , AVG_GPA
FROM (
SELECT Gender , Department , AVG(CGPA) AS AVG_GPA ,
RANK() OVER (PARTITION BY Department ORDER BY AVG(CGPA) ASC) AS rnk
FROM student
GROUP BY Gender , Department
) t
WHERE rnk = 1;

#Find the percentage of students receiving a scholarship in each department.
SELECT Department , COUNT(Student_Name) AS Studentcount , 
ROUND(100 * COUNT(Student_Name) / (SELECT COUNT(Student_Name) AS Studentcount) , 2) AS percentage
FROM student
GROUP BY Department;




