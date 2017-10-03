# nike-mixer
An illustrative down-to-earth Niké smart mobile api client mashup.

# Objective
The sole goal of this project in to demonstrate a perl literacy particulary in using:

* perl's default object system 
* Moose fundamentals
* HTTP conversation
* Data transformation (XML, JSON)
* Object persistence (Postgres)
* A messaging infrastructure (RabbitMQ)

# Deployment

## Database

postgres=# CREATE USER nike_admin WITH CREATEDB PASSWORD 'XXXXXXXXX';
postgres=# CREATE DATABASE nike WITH OWNER nike_admin TEMPLATE template0 ENCODING 'utf-8';

$ psql -U nike_admin -d nike -h localhost < bin/create_tables.sql

## DB Schema

$ dbicdump etc/schema.conf

# Usage

## Fetch a bet pedigree

$ DBIX_CONFIG_DIR="`pwd`/etc" perl bin/bet_mixer.pl
about to mix bets...
Bet => {bet_id = 20001908,  live = false,  betting_event = BettingEvent => {id = 147361821,  event_id = 20001908,  game_id = 0, group_id = 147361821, instance_id = 363, expanded = true, name = "Zápas", number = 32915, odds => [Odd => {header = "1",  odd = 1,  tip = "1"}, Odd => {header = "X",  odd = 7,  tip = "X"}, Odd => {header = "2",  odd = 11,  tip = "2"}, Odd => {header = "1X",  odd = 1,  tip = "4"}, Odd => {header = "X2",  odd = 4,  tip = "5"}, Odd => {header = "12",  odd = 1,  tip = "3"}], popular_tip = 1, status = "VYPISANA"}, opponent_away = "Dinamo Riga", opponent_home = "CSKA Moskva", sport = "Sport => {sport_id = 3,  name = "Hokej"}"}
Bet => {bet_id = 20358241,  live = false,  betting_event = BettingEvent => {id = 147361832,  event_id = 20358241,  game_id = 0, group_id = 147361832, instance_id = 363, expanded = true, name = "Zápas", number = 32985, odds => [Odd => {header = "1",  odd = 3,  tip = "1"}, Odd => {header = "X",  odd = 4,  tip = "X"}, Odd => {header = "2",  odd = 1,  tip = "2"}, Odd => {header = "1X",  odd = 1,  tip = "4"}, Odd => {header = "X2",  odd = 1,  tip = "5"}, Odd => {header = "12",  odd = 1,  tip = "3"}], popular_tip = 2, status = "VYPISANA"}, opponent_away = "HC 07 Detva", opponent_home = "Slovensko 20", sport = "Sport => {sport_id = 3,  name = "Hokej"}"}
Bet => {bet_id = 20288957,  live = false,  betting_event = BettingEvent => {id = 147362013,  event_id = 20288957,  game_id = 0, group_id = 147362013, instance_id = 363, expanded = true, name = "Zápas", number = 33485, odds => [Odd => {header = "1",  odd = 1,  tip = "1"}, Odd => {header = "X",  odd = 4,  tip = "X"}, Odd => {header = "2",  odd = 3,  tip = "2"}, Odd => {header = "1X",  odd = 1,  tip = "4"}, Odd => {header = "X2",  odd = 2,  tip = "5"}, Odd => {header = "12",  odd = 1,  tip = "3"}], popular_tip = 1, status = "VYPISANA"}, opponent_away = "Iserlohn", opponent_home = "Ingolstadt", sport = "Sport => {sport_id = 3,  name = "Hokej"}"}
Bet => {bet_id = 20288958,  live = false,  betting_event = BettingEvent => {id = 147362014,  event_id = 20288958,  game_id = 0, group_id = 147362014, instance_id = 363, expanded = true, name = "Zápas", number = 33486, odds => [Odd => {header = "1",  odd = 1,  tip = "1"}, Odd => {header = "X",  odd = 4,  tip = "X"}, Odd => {header = "2",  odd = 3,  tip = "2"}, Odd => {header = "1X",  odd = 1,  tip = "4"}, Odd => {header = "X2",  odd = 2,  tip = "5"}, Odd => {header = "12",  odd = 1,  tip = "3"}], popular_tip = 1, status = "VYPISANA"}, opponent_away = "Bremerhaven", opponent_home = "Nürnberg", sport = "Sport => {sport_id = 3,  name = "Hokej"}"}
[snip]

## Publish bets

$ DBIX_CONFIG_DIR="`pwd`/etc" perl bin/bet_publisher.pl
about to publish ball sport bets...
done

## Retrieve published bets

$ DBIX_CONFIG_DIR="`pwd`/etc" perl bin/bet_subscriber.pl
<?xml version="1.0" encoding="UTF-8"?>

<Bet id="12">
  <Live>false</Live>
  <BettingEvent id="147371987">
    <Event id="20661793" />
    <Game id="0" />
    <Group id="147371987" />
    <Instance id="361" />
    <Expanded>true</Expanded>
    <Name>Zápas</Name>
    <Number>58075</Number>
    <Odds>
      <Odd>
        <Header>1</Header>
        <Odd>1.59</Odd>
        <Tip>1.59</Tip>
      </Odd>
      <Odd>
        <Header>X</Header>
        <Odd>4.02</Odd>
        <Tip>4.02</Tip>
      </Odd>
[snip]

# Disclaimer

As mentioned above this project serves an evidence purpose only and as such must not be used in anyway that would lead to exposing Niké proprietory endpoints to an unintentional usage pattern rendering them vulnerable under specifically crafted circumstances.
