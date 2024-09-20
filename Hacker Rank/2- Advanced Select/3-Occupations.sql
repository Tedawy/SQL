-- Pivot the Occupation column in OCCUPATIONS so that each Name 
-- is sorted alphabetically and displayed underneath its corresponding Occupation. 
-- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
-- Note: Print NULL when there are no more names corresponding to an occupation.

select 
    max(case when occupation='Doctor' then name end) as Doctor,
    max(case when occupation='Professor' then name end) as Professor,
    max(case when occupation='Singer' then name end) as Singer,
    max(case when occupation='Actor' then name end) as Actor
from (
    select 
        name, occupation,
        row_number() over (partition by occupation order by name ) as row_num
    from 
        occupations
)as numbered_occupations
group by 
    row_num;

/*
Explanation:

	1.	The Problem:
	    •	You have data where each person’s name is associated with an occupation, and you want to arrange it so that each occupation (Doctor, Professor, Singer, Actor) becomes a column header.
	    •	Under each occupation, the names should be sorted alphabetically.
	    •	If there are fewer names for a particular occupation than others, the extra spaces should be filled with NULL.
	
    2.	Why Use ROW_NUMBER():
	    •	We need to ensure that names are sorted alphabetically for each occupation. This is where ROW_NUMBER() comes into play.
	    •	ROW_NUMBER() assigns a unique number to each row within each group of occupations (doctors, professors, etc.). 
            So, the first doctor gets row_num = 1, the second doctor gets row_num = 2, and so on. This way, we know the order of the names.
	
    3.	Why Use MAX() and GROUP BY:
	    •	The core idea is that we want to display one row per row_num with all the occupations (Doctor, Professor, Singer, Actor) in separate columns.
	    •	After we have our row_num assigned for each occupation, we need to group the rows by this row_num to get one row for each row_num.
	    •	However, when grouping, we need to “pick out” the correct name for each occupation and ignore the NULL values.
	    •	This is why we use MAX():
	    •	When we group by row_num, each occupation column will have either a name or NULL. The MAX() function helps by choosing the non-NULL name for each occupation.
	    •	MAX() picks the only available name because all other values are NULL in the row, ensuring that we get one name per occupation for each row_num.
	
    4.	Understanding the Final Query:
	    •	The subquery generates the row_num for each name based on its occupation.
	    •	The outer query groups the names by row_num and uses MAX() to select the name for each occupation.
	    •	This results in one row per row_num, with names displayed under the correct occupation column.

Key Takeaways:

	•	ROW_NUMBER(): It helps us to order the names alphabetically within each occupation.
	•	MAX(): It selects the name for each occupation when we group the rows by row_num, 
            helping us fill in the correct value in each column (Doctor, Professor, etc.) and ignore the NULL values.
	•	GROUP BY row_num: This groups the results so that we get one row for each row_num, 
            where each occupation (Doctor, Professor, Singer, Actor) fills its own column.

*/