-- 問1
-- 国名を全て抽出してください。

SELECT name FROM countries;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。

SELECT name FROM countries WHERE Europe;

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。

SELECT name FROM countries WHERE continent = 'Europe';

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。

SELECT code,name,continent,region,surface_area,indep_year,population
    -> FROM countries
    -> WHERE population >= 100000;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。

SELECT code,name,continent,region,surface_area,indep_year,population,life_expectancy 
    -> FROM countries
    -> WHERE life_expectancy BETWEEN 56 AND 76;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。

SELECT * FROM cities 
WHERE country_code = 'NLB' 
   OR country_code = 'ALB' 
   OR country_code = 'DZA';

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。

SELECT * FROM countries 
WHERE indep_year IS NULL;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。

SELECT * FROM countries 
WHERE indep_year IS NOT NULL;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。

SELECT * FROM countries 
WHERE name LIKE '%ia';

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。

SELECT * FROM countries 
WHERE name LIKE '%st%';

-- 問11
-- 名前が「an」で始まる国を抽出してください。

SELECT * FROM countries 
WHERE name LIKE 'an%';

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。

SELECT *
    -> FROM countries
    -> WHERE indep_year < 1990
    -> OR population > 100000;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。

SELECT *
    -> FROM countries
    -> WHERE (code = 'DZA' OR code = 'ALB')
    -> AND indep_year < 1990;

-- 問14
-- 全ての地方をグループ化せずに表示してください。

SELECT region
    -> FROM countries;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」

SELECT CONCAT('\'', name, 'の人口は', population, '人です\'') AS output
    -> FROM countries;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。

SELECT *
    -> FROM countries
    -> WHERE life_expectancy IS NOT NULL
    -> ORDER BY life_expectancy ASC;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。

SELECT *
    -> FROM countries
    -> WHERE life_expectancy IS NOT NULL
    -> ORDER BY life_expectancy DESC;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。

SELECT *
    -> FROM countries
    -> WHERE life_expectancy IS NOT NULL AND indep_year IS NOT NULL
    -> ORDER BY life_expectancy DESC, indep_year DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。

SELECT SUBSTRING(code, 1, 1) AS first_character, name
    -> FROM countries;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。

SELECT name, LENGTH(name) AS name
    -> FROM countries
    -> ORDER BY name DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)

SELECT 
    -> region,
    -> AVG(life_expectancy) AS average_life_expectancy,
    -> AVG(population) AS average_population
    -> FROM countries
    -> GROUP BY region;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)

SELECT 
    ->     region,
    ->     MAX(life_expectancy) AS maximum_life_expectancy,
    ->     MAX(population) AS maximum_population
    -> FROM countries
    -> GROUP BY region
    -> ORDER BY region ASC;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください

SELECT surface_area
    -> FROM countries
    -> WHERE continent = 'Asia'
    -> ORDER BY surface_area ASC
    -> LIMIT 1;

-- 問24
-- アジア大陸の表面積の合計を表示してください。

SELECT SUM(surface_area) AS total_Asia_surface_area
FROM countries
WHERE continent = 'Asia';

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。

SELECT c.name, cl.language
FROM countries c
JOIN countrylanguages cl ON c.code = cl.country_code;

-- 問26
-- 全ての国と言語と市区町村を表示してください。

SELECT c.name AS country_name, cl.language, ci.name AS city_name
FROM countries c
JOIN countrylanguages cl ON c.code = cl.country_code
JOIN cities ci ON c.code = ci.country_code;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。

SELECT c.name AS country_name, ce.name AS celebrity_name
FROM celebrities ce
LEFT JOIN countries c ON ce.country_code = c.code;


-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。

SELECT ce.name AS celebrity_name, c.name AS country_name, cl.language AS first_language
FROM celebrities ce
LEFT JOIN countries c ON ce.country_code = c.code
LEFT JOIN countrylanguages cl ON c.code = cl.country_code AND cl.is_official = 'T';

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。

SELECT ce.name AS celebrity_name,
       (SELECT c.name FROM countries c WHERE c.code = ce.country_code) AS country_name
FROM celebrities ce;


-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。

SELECT c.code AS country_code,
       MAX(ce.age) AS `MAX(ce.age)`,
       MIN(ce.age) AS `MIN(ce.age)`
FROM countries c
JOIN celebrities ce ON c.code = ce.country_code
GROUP BY c.code
HAVING MAX(ce.age) >= 50 AND MIN(ce.age) <= 30
ORDER BY (c.code = 'USA') ASC;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。

SELECT '1991' AS birth_year, COUNT(*) AS celebrity_count
FROM celebrities
WHERE birth LIKE '1991-%'

UNION ALL

SELECT '1981' AS birth_year, COUNT(*) AS celebrity_count
FROM celebrities
WHERE birth LIKE '1981-%';


-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。

SELECT c.name AS country_name,
       AVG(ce.age) AS average_age
FROM countries c
JOIN celebrities ce ON c.code = ce.country_code
GROUP BY c.name
ORDER BY average_age DESC;

