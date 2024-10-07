# WEEK 2 : Intermediate SQL Tasks

# 1 Calculate the average number of beneficiaries per wellness center across all cities.

SELECT 
    AVG(TotalBeneficiaries) AS AverageBeneficiaries
FROM
    (SELECT 
        wellnessCentreName, SUM(count) AS TotalBeneficiaries
    FROM
        wellness_centre_beneficiaries
    GROUP BY wellnessCentreName) AS WellnessCenterTotals;

# 2 List the total number of 'Pensioner' and 'Serving' beneficiaries for each city.

SELECT 
    cityName,
    SUM(CASE
        WHEN card_type = 'Pensioner' THEN count
        ELSE 0
    END) AS TotalPensionerBeneficiaries,
    SUM(CASE
        WHEN card_type = 'Serving' THEN count
        ELSE 0
    END) AS TotalServingBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
ORDER BY cityName;

# 3 Show the highest numberof beneficiaries in each city.

SELECT 
    cityName, wellnessCentreName, MAX(count) AS MaxBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY cityName , wellnessCentreName
ORDER BY MaxBeneficiaries DESC;

# 4  Retrieve wellness centers in a specific city (e.g., CHENNAI)

SELECT 
    wellnessCentreName
FROM
    wellness_centre_beneficiaries
WHERE
    cityName = 'CHENNAI'
GROUP BY wellnessCentreName;

# 5 Calculate the percentage of 'Pensioner' beneficiaries in each city.

SELECT 
    cityName,
    SUM(CASE
        WHEN card_type = 'Pensioner' THEN count
        ELSE 0
    END) * 100.0 / SUM(count) AS PensionerPercentage
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
ORDER BY PensionerPercentage DESC;

# 6 Display cities where 'Pensioner' beneficiaries outnumber 'Serving' beneficiaries.

SELECT 
    cityName,
    SUM(CASE
        WHEN card_type = 'Pensioner' THEN count
        ELSE 0
    END) AS TotalPensioner,
    SUM(CASE
        WHEN card_type = 'Serving' THEN count
        ELSE 0
    END) AS TotalServing
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
HAVING TotalPensioner > TotalServing
ORDER BY TotalPensioner DESC;

# 7 Sum the total numberof 'Freedom Fighter' beneficiaries across all cities.

SELECT 
    SUM(count) AS TotalFreedomFighterBeneficiaries
FROM
    wellness_centre_beneficiaries
WHERE
    card_type = 'Freedom Fighter';

# 8 Find wellness centers whose names start with 'A' and calculate their total beneficiaries.

SELECT 
    wellnessCentreName, SUM(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
WHERE
    wellnessCentreName LIKE 'A%'
GROUP BY wellnessCentreName
ORDER BY TotalBeneficiaries DESC;

# 9 Determine the total number of unique cities and wellness centers.

SELECT 
    'Unique Cities' AS Category,
    COUNT(DISTINCT cityName) AS TotalCount
FROM
    wellness_centre_beneficiaries 
UNION ALL SELECT 
    'Unique Wellness Centers' AS Category,
    COUNT(DISTINCT wellnessCentreName) AS TotalCount
FROM
    wellness_centre_beneficiaries;

#  10 Calculate the average number of 'Serving' beneficiaries per city.

SELECT 
    cityName, AVG(TotalServing) AS AverageServingBeneficiaries
FROM
    (SELECT 
        cityName,
            SUM(CASE
                WHEN card_type = 'Serving' THEN count
                ELSE 0
            END) AS TotalServing
    FROM
        wellness_centre_beneficiaries
    GROUP BY cityName) AS ServingTotals
GROUP BY cityName;