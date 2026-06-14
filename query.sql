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