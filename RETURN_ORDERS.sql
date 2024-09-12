select orders.customer_name,
    count(orders.order_id) as total_orders,
    count(returns.order_id) as total_returns,
    ROUND((count(returns.order_id)/count(orders.order_id))*100,2) as return_percentage
    from orders
    left join returns on orders.order_id = returns.order_id
group by orders.customer_name having ROUND((count(returns.order_id)/count(orders.order_id))*100,2) > 50;
--------------------------------------------------------------------------------------------
create table orders(
order_id NUMBER,
order_date date,
customer_name varchar2(20),
sales NUMBER)

insert into orders values(1,TO_DATE('2024-01-01','YYYY-MM-DD'),'Akhil',100);
insert into orders values(2,TO_DATE('2024-01-02','YYYY-MM-DD'),'Akhil',200);
insert into orders values(3,TO_DATE('2024-01-03','YYYY-MM-DD'),'Akhil',300);
insert into orders values(4,TO_DATE('2024-01-03','YYYY-MM-DD'),'Akhil',400);
insert into orders values(5,TO_DATE('2024-01-01','YYYY-MM-DD'),'Ajay',500);
insert into orders values(6,TO_DATE('2024-01-02','YYYY-MM-DD'),'Ajay',600);
insert into orders values(7,TO_DATE('2024-01-03','YYYY-MM-DD'),'Ajay',700);
insert into orders values(8,TO_DATE('2024-01-03','YYYY-MM-DD'),'Neha',800);
insert into orders values(9,TO_DATE('2024-01-03','YYYY-MM-DD'),'Ankit',800);
insert into orders values(10,TO_DATE('2024-01-04','YYYY-MM-DD'),'Ankit',900);

create table returns(
order_id number,
return_date date)

insert into returns values(1,TO_DATE('2023-01-02','YYYY-MM-DD'));
insert into returns values(2,TO_DATE('2023-01-04','YYYY-MM-DD'));
insert into returns values(3,TO_DATE('2023-01-05','YYYY-MM-DD'));
insert into returns values(7,TO_DATE('2023-01-06','YYYY-MM-DD'));
insert into returns values(9,TO_DATE('2023-01-06','YYYY-MM-DD'));
insert into returns values(10,TO_DATE('2023-01-07','YYYY-MM-DD'));