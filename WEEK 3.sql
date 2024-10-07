# WEEK 3 ADVANCED SQL TASK :

# 1 Identify cities where the total number of 'Pensioner' & 'Serving' beneficiaries combined exceeds 20,000.

SELECT 
    cityName,
    SUM(CASE
        WHEN card_type = 'Pensioner' THEN count
        ELSE 0
    END) + SUM(CASE
        WHEN card_type = 'Serving' THEN count
        ELSE 0
    END) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
HAVING TotalBeneficiaries > 20000
ORDER BY TotalBeneficiaries DESC;

# 2 List wellness centers in cities with the lowest average number of beneficiaries

WITH CityAverage AS (
    SELECT cityName,
           AVG(TotalBeneficiaries) AS AvgBeneficiaries
    FROM (
        SELECT cityName,
               SUM(count) AS TotalBeneficiaries
        FROM wellness_centre_beneficiaries
        GROUP BY cityName
    ) AS CityTotals
    GROUP BY cityName
)

SELECT DISTINCT(w.wellnessCentreName)
FROM wellness_centre_beneficiaries w
JOIN CityAverage c ON w.cityName = c.cityName
WHERE c.AvgBeneficiaries = (SELECT MIN(AvgBeneficiaries) FROM CityAverage);

# 3 Find the city with the highest number of 'Serving' beneficiaries using subqueries.

SELECT cityName
FROM wellness_centre_beneficiaries
WHERE cityName = (
    SELECT cityName
    FROM wellness_centre_beneficiaries
    WHERE card_type = 'Serving'
    GROUP BY cityName
    ORDER BY SUM(count) DESC
    LIMIT 1
);


# 4 Identify wellness centers with a higher-than-average number of beneficiaries compared to all other centers.


WITH AverageBeneficiaries AS (
    SELECT AVG(TotalBeneficiaries) AS AvgBeneficiaries
    FROM (
        SELECT wellnessCentreName, SUM(count) AS TotalBeneficiaries
        FROM wellness_centre_beneficiaries
        GROUP BY wellnessCentreName
    ) AS CenterTotals
)

SELECT wellnessCentreName, SUM(count) AS TotalBeneficiaries
FROM wellness_centre_beneficiaries
GROUP BY wellnessCentreName
HAVING TotalBeneficiaries > (SELECT AvgBeneficiaries FROM AverageBeneficiaries)
ORDER BY TotalBeneficiaries DESC;

# 5 calculate the total number of beneficiaries in all cities, grouped by card type.

SELECT 
    card_type, SUM(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY card_type
ORDER BY TotalBeneficiaries DESC;

# 6 Findwellness centers that have fewer beneficiaries than the average city total.

WITH CityAverages AS (
    SELECT cityName, 
           AVG(TotalBeneficiaries) AS AvgBeneficiaries
    FROM (
        SELECT cityName, 
               SUM(count) AS TotalBeneficiaries
        FROM wellness_centre_beneficiaries
        GROUP BY cityName
    ) AS CityTotals
    GROUP BY cityName
)

SELECT wellnessCentreName, SUM(count) AS TotalBeneficiaries
FROM wellness_centre_beneficiaries
GROUP BY wellnessCentreName
HAVING TotalBeneficiaries < (SELECT AVG(AvgBeneficiaries) FROM CityAverages)
ORDER BY TotalBeneficiaries ASC;

# 7  Determine the difference between the highest and lowest beneficiary count in each city.

SELECT 
    cityName, MAX(count) - MIN(count) AS Difference
FROM
    wellness_centre_beneficiaries
GROUP BY cityName;

# 8 Identify the top 3 cities with the most 'Pensioner' beneficiaries using subqueries.

SELECT 
    cityName
FROM
    wellness_centre_beneficiaries
WHERE
    card_type = 'Pensioner'
GROUP BY cityName
ORDER BY SUM(count) DESC
LIMIT 3;

# 9  Comparethenumberof'FreedomFighter' beneficiaries to 'Pensioner' beneficiaries in each city

SELECT 
    cityName,
    SUM(CASE
        WHEN card_type = 'Freedom Fighter' THEN count
        ELSE 0
    END) AS TotalFreedomFighters,
    SUM(CASE
        WHEN card_type = 'Pensioner' THEN count
        ELSE 0
    END) AS TotalPensioners
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
ORDER BY cityName;

# 10. Calculate the percentage of 'Pensioner' beneficiaries compared to all beneficiaries in each city

SELECT 
    cityName,
    SUM(CASE
        WHEN card_type = 'Pensioner' THEN count
        ELSE 0
    END) * 100.0 / SUM(count) AS PensionerPercentage
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
HAVING SUM(count) > 0
ORDER BY PensionerPercentage DESC;


