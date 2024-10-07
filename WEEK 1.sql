# WEEK 1 : BASIC SQL TASK

# 1 count the total number of beneficiers in each city

SELECT 
    cityName, SUM(count) AS TotalBeneficiaries  
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
ORDER BY TotalBeneficiaries;

# 2 List unique wellness centers in the dataset.

SELECT DISTINCT
    (wellnessCentreName)
FROM
    wellness_centre_beneficiaries;

# 3 Retrieve the total number of beneficiaries for each wellness center

SELECT 
    wellnessCentreName, sum(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY wellnessCentreName
ORDER BY TotalBeneficiaries DESC;

# 4 Identify cities with more than 10,000 total beneficiaries

SELECT 
    cityName, SUM(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
HAVING TotalBeneficiaries > 10000
ORDER BY TotalBeneficiaries DESC;

# 5 Filter and display only the 'Serving' beneficiaries in the dataset.

SELECT 
    *
FROM
    wellness_centre_beneficiaries
WHERE
    card_type = 'Serving';

# 6 Order cities by their total beneficiary count.

SELECT 
    cityName, SUM(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY cityName
ORDER BY TotalBeneficiaries DESC;

# 7 Identify wellness centers with at least 5,000 beneficiaries.

SELECT 
    wellnessCentreName, SUM(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries
GROUP BY wellnessCentreName
HAVING SUM(count) >= 5000
ORDER BY TotalBeneficiaries DESC;

# 8 List the number of 'Pensioner' beneficiaries at each wellness center.

SELECT 
    wellnessCentreName, SUM(count) AS PensionerBeneficiaries
FROM
    wellness_centre_beneficiaries
WHERE
    card_type = 'Pensioner'
GROUP BY wellnessCentreName
ORDER BY PensionerBeneficiaries DESC;

#9 Calculate the total number of beneficiaries across all cities

SELECT 
    SUM(count) AS TotalBeneficiaries
FROM
    wellness_centre_beneficiaries;

# 10 Find cities that have no 'Freedom Fighter' beneficiaries

SELECT 
    cityName
FROM
    wellness_centre_beneficiaries
WHERE
    cityName NOT IN (SELECT 
            cityName
        FROM
            wellness_centre_beneficiaries
        WHERE
            card_type = 'Freedom Fighter');	