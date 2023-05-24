-- create TABLE person(
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255),
--     surname VARCHAR(255)
-- );
--
-- create TABLE post(
--     id SERIAL PRIMARY KEY,
--     title VARCHAR(255),
--     content VARCHAR(255),
--     user_id INTEGER,
--     FOREIGN KEY (user_id) REFERENCES person
-- );

create TABLE person1(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    login VARCHAR(255),
    password VARCHAR(255),
    photo BYTEA
);

CREATE TABLE post1 (
    id SERIAL PRIMARY KEY,
    title TEXT,
    image BYTEA,
    content TEXT,
    user_id INTEGER,
    date VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES person1(id)
);