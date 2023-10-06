select *
from yelp_review.ods.review r 
     join yelp_review.ods.temperature tmp on r.date=tmp.date_tmp
     join yelp_review.ods.precipitation p on r.date=p.date_p
     join yelp_review.ods.user u on r.user_id=u.user_id
     join yelp_review.ods.business b on r.business_id=b.business_id
     left join yelp_review.ods.checkin c on b.business_id=c.business_id
     left join yelp_review.ods.tips t on b.business_id=t.business_id
     left join yelp_review.ods.covid cv on b.business_id=cv.business_id;