--
-- Nike database creation script
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: nike_sport; Type: TABLE; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE TABLE nike_sport (
    id INTEGER NOT NULL,
    sport_id INTEGER NOT NULL UNIQUE,
    name CHARACTER VARYING(256) NOT NULL
);


ALTER TABLE public.nike_sport OWNER TO nike_admin;

--
-- Name: nike_sport_id_seq; Type: SEQUENCE; Schema: public; Owner: nike_admin 
--

CREATE SEQUENCE nike_sport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nike_sport_id_seq OWNER TO nike_admin;

--
-- Name: nike_sport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nike_admin 
--

ALTER SEQUENCE nike_sport_id_seq OWNED BY nike_sport.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: nike_admin 
--

ALTER TABLE ONLY nike_sport ALTER COLUMN id SET DEFAULT nextval('nike_sport_id_seq'::regclass);

--
-- Name: nike_sport_pkey; Type: CONSTRAINT; Schema: public; Owner: nike_admin; Tablespace: 
--

ALTER TABLE ONLY nike_sport
    ADD CONSTRAINT nike_sport_pkey PRIMARY KEY (id);
    
--
-- Name: nike_betting_event; Type: TABLE; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE TABLE nike_betting_event (
    id INTEGER NOT NULL,
    betting_event_id INTEGER NOT NULL UNIQUE,
    event_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    group_id INTEGER NOT NULL,
    instance_id INTEGER NOT NULL,
    expanded BOOLEAN DEFAULT false,
    name CHARACTER VARYING(256) NOT NULL,
    number INTEGER,
    popular_tip INTEGER,
    status CHARACTER VARYING(256) NOT NULL
);


ALTER TABLE public.nike_betting_event OWNER TO nike_admin;

--
-- Name: nike_betting_event_id_seq; Type: SEQUENCE; Schema: public; Owner: nike_admin 
--

CREATE SEQUENCE nike_betting_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nike_betting_event_id_seq OWNER TO nike_admin;

--
-- Name: nike_betting_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nike_admin 
--

ALTER SEQUENCE nike_betting_event_id_seq OWNED BY nike_betting_event.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: nike_admin 
--

ALTER TABLE ONLY nike_betting_event ALTER COLUMN id SET DEFAULT nextval('nike_betting_event_id_seq'::regclass);

--
-- Name: nike_betting_event_pkey; Type: CONSTRAINT; Schema: public; Owner: nike_admin; Tablespace: 
--

ALTER TABLE ONLY nike_betting_event
    ADD CONSTRAINT nike_betting_event_pkey PRIMARY KEY (id);
    
 --
-- Name: nike_odd; Type: TABLE; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE TABLE nike_odd (
    id INTEGER NOT NULL,
    header CHARACTER VARYING(8) NOT NULL,
    odd REAL NOT NULL,
    tip CHARACTER VARYING(8) NOT NULL
);

ALTER TABLE public.nike_odd OWNER TO nike_admin;

--
-- Name: nike_odd_id_seq; Type: SEQUENCE; Schema: public; Owner: nike_admin 
--

CREATE SEQUENCE nike_odd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nike_odd_id_seq OWNER TO nike_admin;

--
-- Name: nike_odd_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nike_admin 
--

ALTER SEQUENCE nike_odd_id_seq OWNED BY nike_odd.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: nike_admin 
--

ALTER TABLE ONLY nike_odd ALTER COLUMN id SET DEFAULT nextval('nike_odd_id_seq'::regclass);

--
-- Name: nike_odd_pkey; Type: CONSTRAINT; Schema: public; Owner: nike_admin; Tablespace: 
--

ALTER TABLE ONLY nike_odd
    ADD CONSTRAINT nike_odd_pkey PRIMARY KEY (id);
    
--
-- Name: nike_betting_event_odd; Type: TABLE; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE TABLE nike_betting_event_odd (
    id INTEGER NOT NULL,
    betting_event_id INTEGER NOT NULL,
    odd_id INTEGER NOT NULL
);

ALTER TABLE public.nike_betting_event_odd OWNER TO nike_admin;

--
-- Name: nike_betting_event_odd_id_seq; Type: SEQUENCE; Schema: public; Owner: nike_admin 
--

CREATE SEQUENCE nike_betting_event_odd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nike_betting_event_odd_id_seq OWNER TO nike_admin;

--
-- Name: nike_betting_event_odd_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nike_admin 
--

ALTER SEQUENCE nike_betting_event_odd_id_seq OWNED BY nike_odd.id;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: nike_admin 
--

ALTER TABLE ONLY nike_betting_event_odd ALTER COLUMN id SET DEFAULT nextval('nike_betting_event_odd_id_seq'::regclass);

--
-- Name: nike_betting_event_odd_pkey; Type: CONSTRAINT; Schema: public; Owner: nike_admin; Tablespace: 
--

ALTER TABLE ONLY nike_betting_event_odd
    ADD CONSTRAINT nike_betting_event_odd_pkey PRIMARY KEY (id);
    
--
-- Name: nike_betting_event_odd_betting_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nike_admin
--

ALTER TABLE ONLY nike_betting_event_odd
    ADD CONSTRAINT nike_betting_event_odd_betting_event_id_fkey FOREIGN KEY (betting_event_id) REFERENCES nike_betting_event(id) DEFERRABLE INITIALLY DEFERRED;
    
--
-- Name: nike_betting_event_odd_odd_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nike_admin
--

ALTER TABLE ONLY nike_betting_event_odd
    ADD CONSTRAINT nike_betting_event_odd_odd_id_fkey FOREIGN KEY (odd_id) REFERENCES nike_odd(id) DEFERRABLE INITIALLY DEFERRED;
    
--
-- Name: nike_tournament; Type: TABLE; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE TABLE nike_tournament (
    id INTEGER NOT NULL,
    tournament_id INTEGER NOT NULL UNIQUE,
    name CHARACTER VARYING(256) NOT NULL,
    season CHARACTER VARYING(256) NOT NULL,
    top BOOLEAN DEFAULT false
);


ALTER TABLE public.nike_tournament OWNER TO nike_admin;

--
-- Name: nike_tournament_id_seq; Type: SEQUENCE; Schema: public; Owner: nike_admin 
--

CREATE SEQUENCE nike_tournament_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nike_tournament_id_seq OWNER TO nike_admin;

--
-- Name: nike_tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nike_admin 
--

ALTER SEQUENCE nike_tournament_id_seq OWNED BY nike_tournament.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: nike_admin 
--

ALTER TABLE ONLY nike_tournament ALTER COLUMN id SET DEFAULT nextval('nike_tournament_id_seq'::regclass);

--
-- Name: nike_tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: nike_admin; Tablespace: 
--

ALTER TABLE ONLY nike_tournament
    ADD CONSTRAINT nike_tournament_pkey PRIMARY KEY (id);    
   
--
-- Name: nike_bet; Type: TABLE; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE TABLE nike_bet (
    id INTEGER NOT NULL,
    bet_id INTEGER NOT NULL UNIQUE,
    live BOOLEAN DEFAULT false,
    sport_id INTEGER NOT NULL,
    betting_event_id INTEGER NOT NULL,
    tournament_id INTEGER NOT NULL,
    opponent_away  CHARACTER VARYING(256) NOT NULL,       
    opponent_home  CHARACTER VARYING(256) NOT NULL,       
    start TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    tournament_info  CHARACTER VARYING(256)
);


ALTER TABLE public.nike_bet OWNER TO nike_admin;

--
-- Name: nike_bet_id_seq; Type: SEQUENCE; Schema: public; Owner: nike_admin 
--

CREATE SEQUENCE nike_bet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nike_bet_id_seq OWNER TO nike_admin;

--
-- Name: nike_bet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nike_admin 
--

ALTER SEQUENCE nike_bet_id_seq OWNED BY nike_bet.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: nike_admin 
--

ALTER TABLE ONLY nike_bet ALTER COLUMN id SET DEFAULT nextval('nike_bet_id_seq'::regclass);

--
-- Name: shopper_seller_pkey; Type: CONSTRAINT; Schema: public; Owner: itrash; Tablespace: 
--

ALTER TABLE ONLY nike_bet
    ADD CONSTRAINT nike_bet_pkey PRIMARY KEY (id);

--
-- Name: nike_bet_sport_id; Type: INDEX; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE INDEX nike_bet_sport_id ON nike_bet USING btree (sport_id);

--
-- Name: nike_bet_sport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nike_admin
--

ALTER TABLE ONLY nike_bet
    ADD CONSTRAINT nike_bet_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES nike_sport(id) DEFERRABLE INITIALLY DEFERRED;
    
--
-- Name: nike_bet_betting_event_id; Type: INDEX; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE INDEX nike_bet_betting_event_id ON nike_bet USING btree (betting_event_id);

--
-- Name: nike_bet_betting_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nike_admin
--

ALTER TABLE ONLY nike_bet
    ADD CONSTRAINT nike_bet_betting_event_id_fkey FOREIGN KEY (betting_event_id) REFERENCES nike_betting_event(id) DEFERRABLE INITIALLY DEFERRED;
    
--
-- Name: nike_bet_tournament_id; Type: INDEX; Schema: public; Owner: nike_admin; Tablespace: 
--

CREATE INDEX nike_bet_tournament_id ON nike_bet USING btree (tournament_id);

--
-- Name: nike_bet_tournament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nike_admin
--

ALTER TABLE ONLY nike_bet
    ADD CONSTRAINT nike_bet_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES nike_tournament(id) DEFERRABLE INITIALLY DEFERRED;
