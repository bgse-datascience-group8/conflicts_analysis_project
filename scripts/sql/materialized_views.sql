DROP TABLE IF EXISTS public_statement_events;
CREATE TABLE public_statement_events AS SELECT * FROM events WHERE EventRootCode = 1;

DROP TABLE IF EXISTS appeal_events;
CREATE TABLE appeal_events AS SELECT * FROM events WHERE EventRootCode = 2;

DROP TABLE IF EXISTS intent_to_cooperate_events;
CREATE TABLE intent_to_cooperate_events AS SELECT * FROM events WHERE EventRootCode = 3;

DROP TABLE IF EXISTS consult_events;
CREATE TABLE consult_events AS SELECT * FROM events WHERE EventRootCode = 4;

DROP TABLE IF EXISTS diplomatic_cooperation_events;
CREATE TABLE diplomatic_cooperation_events AS SELECT * FROM events WHERE EventRootCode = 5;

DROP TABLE IF EXISTS material_cooperation_events;
CREATE TABLE material_cooperation_events AS SELECT * FROM events WHERE EventRootCode = 6;

DROP TABLE IF EXISTS provide_aid_events;
CREATE TABLE provide_aid_events AS SELECT * FROM events WHERE EventRootCode = 7;

DROP TABLE IF EXISTS yield_events;
CREATE TABLE yield_events AS SELECT * FROM events WHERE EventRootCode = 8;

DROP TABLE IF EXISTS investigate_events;
CREATE TABLE investigate_events AS SELECT * FROM events WHERE EventRootCode = 9;

DROP TABLE IF EXISTS demand_events;
CREATE TABLE demand_events AS SELECT * FROM events WHERE EventRootCode = 10;

DROP TABLE IF EXISTS disapprove_events;
CREATE TABLE disapprove_events AS SELECT * FROM events WHERE EventRootCode = 11;

DROP TABLE IF EXISTS reject_events;
CREATE TABLE reject_events AS SELECT * FROM events WHERE EventRootCode = 12;

DROP TABLE IF EXISTS threaten_events;
CREATE TABLE threaten_events AS SELECT * FROM events WHERE EventRootCode = 13;

DROP TABLE IF EXISTS protest_events;
CREATE TABLE protest_events AS SELECT * FROM events WHERE EventRootCode = 14;

DROP TABLE IF EXISTS exhibit_force_events;
CREATE TABLE exhibit_force_events AS SELECT * FROM events WHERE EventRootCode = 15;

DROP TABLE IF EXISTS reduce_relations_events;
CREATE TABLE reduce_relations_events AS SELECT * FROM events WHERE EventRootCode = 16;

DROP TABLE IF EXISTS coerce_events;
CREATE TABLE coerce_events AS SELECT * FROM events WHERE EventRootCode = 17;

DROP TABLE IF EXISTS assault_events;
CREATE TABLE assault_events AS SELECT * FROM events WHERE EventRootCode = 18;

DROP TABLE IF EXISTS fight_events;
CREATE TABLE fight_events AS SELECT * FROM events WHERE EventRootCode = 19;

DROP TABLE IF EXISTS mass_violence_events;
CREATE TABLE mass_violence_events AS SELECT * FROM events WHERE EventRootCode = 20;
