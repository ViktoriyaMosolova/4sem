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

create TABLE post1(
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    image BYTEA,
    content VARCHAR(255),
    user_id INTEGER,
    date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES person
);