# Rasy Psów Flutter Dog API

Prosta aplikacja mobilna stworzona w środowisku Flutter, 
służąca do przeglądania ras psów oraz ich podras, zintegrowana 
z zewnętrznym API oraz lokalną bazą danych.

## Funkcjonalności

- **Dwa ekrany**: Lista wszystkich ras psów oraz szczegóły wybranej rasy.
- **REST API**: Pobieranie listy ras oraz losowanie zdjęć dla konkretnej rasy z serwisu [Dog CEO API](https://dog.ceo/dog-api/).
- **Tryb Offline**: Dane o rasach są zapisywane w lokalnej bazie danych Hive. Po pierwszym uruchomieniu aplikacja działa bez dostępu do Internetu.

## Wykorzystane pakiety:
- http - do komunikacji z zewnętrznym API.
- hive_ce & hive_ce_flutter - lokalna baza danych do zapisu offline.

