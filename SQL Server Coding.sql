SELECT TOP (1000) [player_name]
      ,[team]
      ,[date_of_birth]
      ,[age]
      ,[marital_status]
      ,[number_of_kids]
      ,[nationality]
      ,[country_of_birth]
      ,[position]
      ,[preferred_foot]
      ,[height_cm]
      ,[weight_kg]
      ,[jersey_number]
      ,[injury_status]
      ,[agent]
      ,[matches_played]
      ,[minutes_played]
      ,[goals]
      ,[assists]
      ,[tackles]
      ,[interceptions]
      ,[saves]
      ,[clean_sheets]
      ,[yellow_cards]
      ,[red_cards]
      ,[passing_accuracy]
      ,[shot_accuracy]
      ,[previous_club]
      ,[years_at_club]
      ,[contract_end_year]
      ,[average_salary_zar]
      ,[market_value_zar]
      ,[signing_bonus_zar]
      ,[release_clause_zar]
  FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]

 --- 1. View the first 100 rows of the dataset to understand its structure.
 SELECT TOP 100 * FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]


---2. Count the total number of players in the dataset.
 SELECT  * FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
 select count(*) as Total_Players FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]

---3. List all unique teams in the league.
SELECT DISTINCT (team) as different_teams FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]

---4. Count how many players are in each team.
SELECT team,count(*) as Total_Players FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]GROUP BY team

---5. Identify the top 10 players with the most goals.
SELECT TOP (10) [player_name]
              ,SUM(CAST(goals AS INT)) as total_goals
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]GROUP BY player_name ORDER BY total_goals DESC

---6. Find the average salary for players in each team.
SELECT team
,AVG(TRY_CAST(AVERAGE_SALARY_ZAR AS FLOAT)) AS avg_salary_zar
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]GROUP BY team ORDER BY avg_salary_zar DESC

---7. Retrieve the top 10 players with the highest market value.

SELECT TOP (10) 
    player_name,
    SUM(TRY_CAST(market_value_zar AS FLOAT)) AS market_value
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY player_name
ORDER BY market_value DESC;

---8. Calculate the average passing accuracy for each position.
SELECT 
    position,
    AVG(TRY_CAST(passing_accuracy AS FLOAT)) AS avg_passing_accuracy
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY position
ORDER BY avg_passing_accuracy DESC;

---9. Compare shot accuracy with goals to find correlations.
SELECT 
    player_name,
    AVG(TRY_CAST(shot_accuracy AS FLOAT)) AS avg_shot_accuracy,
    SUM(TRY_CAST(goals AS INT)) AS total_goals
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY player_name
ORDER BY total_goals DESC;

---10. Compute total goals and assists for each team.
SELECT 
    team,
    SUM(TRY_CAST(goals AS INT)) AS total_goals,
    SUM(TRY_CAST(assists AS INT)) AS total_assists
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY team
ORDER BY total_goals DESC;

---11. Count players by their marital status.
SELECT 
    marital_status,
    COUNT(*) AS player_count
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY marital_status


--12. Count players by nationality.
SELECT 
    nationality,
    COUNT(*) AS player_count
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY nationality

--13. Find average market value grouped by nationality.
SELECT 
    nationality,
    AVG(TRY_CAST(market_value_zar AS FLOAT)) AS avg_market_value 
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY nationality
ORDER BY avg_market_value DESC;

--14. Determine how many player contracts end in each year.
SELECT 
    contract_end_year,
    COUNT(*) AS Total_contracts_ending
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
WHERE contract_end_year IS NOT NULL
GROUP BY contract_end_year
ORDER BY contract_end_year;

---15. Identify players whose contracts end next year.
SELECT 
    player_name,
    contract_end_year
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
WHERE contract_end_year = YEAR(GETDATE()) + 1
ORDER BY contract_end_year;

---16. Summarize the number of players by injury status.
SELECT 
    injury_status,
    COUNT(*) AS player_count
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY injury_status
ORDER BY player_count DESC;

---17. Calculate goals per match ratio for each player.

SELECT 
    player_name,
    SUM(TRY_CAST(goals AS INT)) AS total_goals,
    SUM(TRY_CAST(matches_played AS INT)) AS total_matches,
    CASE 
        WHEN SUM(TRY_CAST(matches_played AS INT)) = 0 THEN 0
        ELSE CAST(SUM(TRY_CAST(goals AS INT)) AS FLOAT) / SUM(TRY_CAST(matches_played AS INT))
    END AS goals_per_match_ratio
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY player_name
ORDER BY goals_per_match_ratio DESC;


---18. Count how many players are managed by each agent.
SELECT 
    agent,
    COUNT(*) AS player_count
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY agent
ORDER BY player_count DESC;

---19. Calculate average height and weight by player position.
SELECT AVG(height_cm)AS avg_height,
       AVG(weight_kg)AS avg_weight,
       position,
       COUNT(*) AS player_count
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
GROUP BY position;

---20. Identify players with the highest combined goals and assists.
SELECT MAX(goals) as combined_goals,
       assists,
       COUNT(*) AS player_count
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
ORDER BY player_count;

SELECT TOP 10
    player_name,
    (goals + assists) AS total_contributions
FROM Soccer_Analysis_Db1.dbo.ketro_sa_soccer_dataset_advanced
ORDER BY total_contributions DESC
