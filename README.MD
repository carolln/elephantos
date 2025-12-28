## Description
This repository contains a PostgreSQL schema developed through the 2025.2 semester as the final project for the _Banco de Dados_ subject at UFRN.

This schema refers to the system of a delivery focused restaurant called Elephanto's (the name comes from the elephant being Postgres' mascot! hehe) and wishes to help said restaurant manage clients, deliveries, regular queries and food in storage.

The database is populated with made-up data.

## Requirements
- PostgreSQL 15+

## Usage
createdb mydb
psql -d mydb -f schema.sql

psql -d mydb -f seed.sql

psql -d mydb -f queries.sql > results.txt


## Credits
Carolina Nunes, Leandro Andrade, Diego Luan, Luisa Ferreira