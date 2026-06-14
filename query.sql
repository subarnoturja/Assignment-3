-- users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    role VARCHAR(30) NOT NULL CHECK (role IN ('Football Fan', 'Ticket Manager')),
    phone_number VARCHAR(20)
)

-- matches table
create table matches(
  match_id serial primary key,
  fixture varchar(100) not null,
  tournament_category varchar(100) not null,
  base_ticket_price numeric(10, 2) not null check (base_ticket_price >= 0),
  match_status varchar(30) not null check (match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
)

-- bookings table
create table bookings (
  booking_id serial primary key,
  user_id int not null references users(user_id),
  match_id int not null references matches(match_id),
  seat_number varchar(10),
  payment_status varchar(20) check (payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
  total_cost numeric(10, 2) not null check(total_cost >= 0)
)


-- query 1
select match_id,fixture, base_ticket_price from matches where tournament_category = 'Champions League' and 
match_status = 'Available'

-- query 2
select full_name, email from users where full_name ilike 'Tanvir%' or full_name ilike '%Haque%'

-- query 3
select booking_id, user_id, match_id, coalesce(payment_status, 'Action Required') as systematic_status from bookings where payment_status is null; 

-- query 4
select booking_id, users.full_name, fixture, total_cost from bookings inner join matches on bookings.match_id = matches.match_id inner join users on bookings.user_id = users.user_id

-- query 5
select users.user_id, users.full_name, bookings.booking_id from users left join bookings on users.user_id = bookings.user_id;

-- query 6
select booking_id, match_id, total_cost from bookings where total_cost > (select avg(total_cost) from bookings);