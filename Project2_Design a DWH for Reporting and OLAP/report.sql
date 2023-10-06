--Report business name, temperature, precipitation, and ratings
select
    b.name as business_name,
    c.min_tmp,c.max_tmp,c.normal_min_tmp,c.normal_max_tmp,c.precipitation,c.precipitation_normal,
    f.stars
from yelp_review.dwh.fact_review f
    join yelp_review.dwh.dim_business b on f.business_id=b.business_id
    join yelp_review.dwh.climate c on f.date=c.date;