SELECT STATE,
    MAX(CASE WHEN RN_LOW=1 THEN CITY END) AS LOW_POPULATION_CITY,
    MAX(CASE WHEN RN_HIGH=1 THEN CITY END) AS HIGH_POPULATION_CITY
    FROM (SELECT STATE,CITY,POPULATION,
    ROW_NUMBER() OVER(PARTITION BY STATE ORDER BY POPULATION) AS RN_LOW,
    ROW_NUMBER() OVER(PARTITION BY STATE ORDER BY POPULATION DESC) AS RN_HIGH
    FROM CITY_POPULATION)
GROUP BY STATE;

SELECT * FROM CITY_POPULATION;
----------------------------------------------------------------------------
CREATE TABLE CITY_POPULATION (
 state VARCHAR2(100),
 city VARCHAR2(100),
 population NUMBER(38,0)
);
-- Sample data insertion
INSERT INTO city_population (state, city, population) VALUES ('Uttar Pradesh', 'Mau', 600);
INSERT INTO city_population (state, city, population) VALUES ('Uttar Pradesh', 'Lucknow', 500);
INSERT INTO city_population (state, city, population) VALUES ('Uttar Pradesh', 'Agra', 700);
INSERT INTO city_population (state, city, population) VALUES ('Bihar', 'Gaya', 700);
INSERT INTO city_population (state, city, population) VALUES ('Bihar', 'Patna', 800);
INSERT INTO city_population (state, city, population) VALUES ('Bihar', 'Samastipur', 500);
INSERT INTO city_population (state, city, population) VALUES ('Karnataka', 'Bangalore', 750);
INSERT INTO city_population (state, city, population) VALUES ('Karnataka', 'Udupi', 300);
INSERT INTO city_population (state, city, population) VALUES ('Karnataka', 'Kolar', 500);
INSERT INTO city_population (state, city, population) VALUES ('Maharashtra', 'Shirur', 300);
INSERT INTO city_population (state, city, population) VALUES ('Maharashtra', 'Pune', 500);
INSERT INTO city_population (state, city, population) VALUES ('Maharashtra', 'Mumbai', 1400);
INSERT INTO city_population (state, city, population) VALUES ('Orrisa', 'Rourkela', 100);
INSERT INTO city_population (state, city, population) VALUES ('Orrisa', 'Bhubaneshwar', 400);
INSERT INTO city_population (state, city, population) VALUES ('Orrisa', 'Cuttack', 300);
INSERT INTO city_population (state, city, population) VALUES ('Haryana', 'Gurgaon', 500);
INSERT INTO city_population (state, city, population) VALUES ('Haryana', 'Bhiwani', 300);
INSERT INTO city_population (state, city, population) VALUES ('Haryana', 'Faridabad', 400);