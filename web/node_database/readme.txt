#Создать образ БД

docker run --name postgresDB -p 5432:5432 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=userpass -e POSTGRES_DB=testdb -d postgres


#Подключиться к бд

psql -U user -d testdb