select 
    c.company_code, c.founder,
    count(distinct l.lead_manager_code),
    count(distinct s.senior_manager_code),
    count(distinct m.manager_code),
    count(distinct e.employee_code)

from 
    company as c
join 
    lead_manager as l on c.company_code = l.company_code
join 
    senior_manager as s on s.company_code = l.company_code
join 
    manager as m on  l.company_code = m.company_code
join 
    employee as e on m.company_code = e.company_code
group by 
    c.company_code, c.founder 
order by 
    c.company_code;