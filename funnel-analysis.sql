-- Query 1: Validating raw user counts at each funnel stage
SELECT 
    stage,
    COUNT(DISTINCT user_id) AS unique_users
FROM 
    events
GROUP BY 
    stage
ORDER BY 
    unique_users DESC;


-- Query 2: End-to-End Funnel Conversion and Drop-off Analysis
WITH Funnel_Stages AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN stage = 'App Open' THEN user_id END) AS app_opens,
        COUNT(DISTINCT CASE WHEN stage = 'Product View' THEN user_id END) AS product_views,
        COUNT(DISTINCT CASE WHEN stage = 'Add to Cart' THEN user_id END) AS cart_adds,
        COUNT(DISTINCT CASE WHEN stage = 'Checkout' THEN user_id END) AS checkouts,
        COUNT(DISTINCT CASE WHEN stage = 'Purchase' THEN user_id END) AS purchases
    FROM 
        events
)

SELECT 
    app_opens,
    product_views,
    cart_adds,
    checkouts,
    purchases,
    ROUND((product_views * 100.0) / NULLIF(app_opens, 0), 1) AS open_to_view_pct,
    ROUND((purchases * 100.0) / NULLIF(app_opens, 0), 1) AS overall_conversion_pct
FROM 
    Funnel_Stages;


-- Query 3: to calculate the conversion rate between each stage
WITH funnel AS (

SELECT

    stage,

    COUNT(DISTINCT user_id) AS users,

    CASE

        WHEN stage='App Open' THEN 1
        WHEN stage='Product View' THEN 2
        WHEN stage='Add to Cart' THEN 3
        WHEN stage='Checkout' THEN 4
        WHEN stage='Purchase' THEN 5

    END AS stage_order

FROM events

GROUP BY stage

)

SELECT

    stage,

    users,

    LAG(users)
    OVER(ORDER BY stage_order)
    AS previous_stage_users,

    CASE

        WHEN LAG(users)
        OVER(ORDER BY stage_order)
        IS NULL

        THEN 100

        ELSE ROUND(

            users*100.0/

            LAG(users)
            OVER(ORDER BY stage_order)

        ,2)

    END AS conversion_percentage

FROM funnel

ORDER BY stage_order;
/* used CTE here, as it separates the aggregation step from the window function. 
First I calculated the number of users at each stage, then I applied LAG() to compare each stage with the previous one. 
This made the query easier to read, debug, and maintain. */


-- Query 4: to calculate the drop-off percentage
-- formula used: Drop-off % = {(Previous Stage Users − Current Users)/ Previous Stage Users}*100
WITH funnel AS (

    SELECT
        stage,
        COUNT(DISTINCT user_id) AS users,
        CASE
            WHEN stage = 'App Open' THEN 1
            WHEN stage = 'Product View' THEN 2
            WHEN stage = 'Add to Cart' THEN 3
            WHEN stage = 'Checkout' THEN 4
            WHEN stage = 'Purchase' THEN 5
        END AS stage_order
    FROM events
    GROUP BY stage
)

SELECT
    stage,
    users,
    LAG(users) OVER (ORDER BY stage_order) AS previous_stage_users,

    CASE
        WHEN LAG(users) OVER (ORDER BY stage_order) IS NULL
        THEN 0

        ELSE ROUND(
            (
                LAG(users) OVER (ORDER BY stage_order) - users
            ) * 100.0
            /
            LAG(users) OVER (ORDER BY stage_order),
            2
        )
    END AS drop_off_percentage

FROM funnel

ORDER BY stage_order;
