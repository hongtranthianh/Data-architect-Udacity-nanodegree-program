--Dim_business
create table yelp_review.dwh.dim_business(business_id string,
                                             name string,
                                             address string,
                                             city string,
                                             state string,
                                             postal_code string,
                                             latitude float,
                                             longitude float,
                                             stars float,
                                             review_count int,
                                             is_open int,
                                             attributes object,
                                             categories array,
                                             hours object);
insert into yelp_review.dwh.dim_business select*from yelp_review.ods.business;
--Dim_user 
create table yelp_review.dwh.dim_user(user_id string,
                                        name string,
                                        review_count int,
                                        yelp_since string,
                                        friends array,
                                        useful int,
                                        funny int,
                                        cool int,
                                        fans int,
                                        elite array,
                                        average_stars float,
                                        compliment_hot int,
                                        compliment_more int,
                                        compliment_profile int,
                                        compliment_cute int,
                                        compliment_list int,
                                        compliment_note int,
                                        compliment_plain int,
                                        compliment_cool int,
                                        compliment_funny int,
                                        compliment_writer int,
                                        compliment_photos int);
insert into yelp_review.dwh.dim_user select*from yelp_review.ods.user;
--Dim_checkin
create table yelp_review.dwh.dim_checkin(business_id string,
                                        date string);
insert into yelp_review.dwh.dim_checkin select*from yelp_review.ods.checkin;
--Dim_climate
create table yelp_review.dwh.climate(date date,
                                     min_tmp float,
                                     max_tmp float,
                                     normal_min_tmp float,
                                     normal_max_tmp float,
                                     precipitation float,
                                     precipitation_normal float);
insert into yelp_review.dwh.climate
select
     t.date_tmp as date,
     t.min as min_tmp,
     t.max as max_tmp,
     t.normal_min as normal_min_tmp,
     t.normal_max as normal_max_tmp,
     p.precipitation,
     p.precipitation_normal
from yelp_review.ods.temperature t
     join yelp_review.ods.precipitation p     
     on t.date_tmp=p.date_p;
--Fact_review
create table yelp_review.dwh.fact_review(review_id string,
                                        user_id string,
                                        business_id string,
                                        stars int,
                                        date string,
                                        text string,
                                        useful int,
                                        funny int,
                                        cool int);
insert into yelp_review.dwh.fact_review
select 
     r.review_id,
     u.user_id,
     b.business_id,
     r.stars,
     r.date,
     r.text,
     r.useful,
     r.funny,
     r.cool
from yelp_review.ods.review r 
     join yelp_review.ods.temperature tmp on r.date=tmp.date_tmp
     join yelp_review.ods.precipitation p on r.date=p.date_p
     join yelp_review.ods.user u on r.user_id=u.user_id
     join yelp_review.ods.business b on r.business_id=b.business_id
     left join yelp_review.ods.checkin c on b.business_id=c.business_id;
