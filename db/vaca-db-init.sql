--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Postgres.app)
-- Dumped by pg_dump version 16.6 (Postgres.app)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: updateifchanged(anyelement, anyelement, boolean); Type: FUNCTION; Schema: public; Owner: vaca
--

CREATE FUNCTION public.updateifchanged(newvalue anyelement, field anyelement, allownull boolean DEFAULT false) RETURNS anyelement
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF 
        (allowNull = FALSE AND newValue IS NULL) OR 
        LOWER(newValue::varchar) = 'null' OR
        LOWER(newValue::varchar) = 'undefined'
    THEN
        RETURN field;
    ELSE
        RETURN newValue;
    END IF;
END;
$$;


ALTER FUNCTION public.updateifchanged(newvalue anyelement, field anyelement, allownull boolean) OWNER TO vaca;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: vaca
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    trip_id integer NOT NULL,
    location text,
    image_url text,
    start_time timestamp without time zone,
    end_time timestamp without time zone
);


ALTER TABLE public.activities OWNER TO vaca;

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: vaca
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activities_id_seq OWNER TO vaca;

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vaca
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: flights; Type: TABLE; Schema: public; Owner: vaca
--

CREATE TABLE public.flights (
    id integer NOT NULL,
    departing_location text,
    arrival_location text,
    round_trip boolean,
    cost integer,
    trip_id integer,
    CONSTRAINT aloccheck CHECK ((char_length(arrival_location) <= 3)),
    CONSTRAINT dloccheck CHECK ((char_length(departing_location) <= 3))
);


ALTER TABLE public.flights OWNER TO vaca;

--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: vaca
--

CREATE SEQUENCE public.flights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flights_id_seq OWNER TO vaca;

--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vaca
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- Name: trips; Type: TABLE; Schema: public; Owner: vaca
--

CREATE TABLE public.trips (
    id integer NOT NULL,
    name text NOT NULL,
    destination text NOT NULL,
    cost integer NOT NULL,
    user_id integer NOT NULL,
    image_url text NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE public.trips OWNER TO vaca;

--
-- Name: trips_id_seq; Type: SEQUENCE; Schema: public; Owner: vaca
--

CREATE SEQUENCE public.trips_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trips_id_seq OWNER TO vaca;

--
-- Name: trips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vaca
--

ALTER SEQUENCE public.trips_id_seq OWNED BY public.trips.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vaca
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    salt text NOT NULL,
    hash text NOT NULL
);


ALTER TABLE public.users OWNER TO vaca;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vaca
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO vaca;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vaca
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- Name: trips id; Type: DEFAULT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.trips ALTER COLUMN id SET DEFAULT nextval('public.trips_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: vaca
--

COPY public.activities (id, name, description, trip_id, location, image_url, start_time, end_time) FROM stdin;
9	Golf	Play golf	13	The golf course	http://localhost:5173/public/a-plane.png	2024-07-04 12:30:00	2024-07-04 13:30:00
10	Blackjack on a Riverboat Casino	A low point in my life	13	Black Salley's Apple	http://localhost:5173/public/animal-booze-cruise.png	2024-07-04 12:30:00	2024-07-04 13:30:00
12	Hiking in the mountains	\N	13	\N	\N	\N	\N
13	Watching the sunset	\N	14	\N	\N	\N	\N
14	Skydiving	\N	14	\N	\N	\N	\N
15	Wine tasting at a vineyard	\N	14	\N	\N	\N	\N
16	Hiking in the mountains	\N	13	\N	\N	\N	\N
17	White-water rafting	\N	15	\N	\N	\N	\N
18	Sailin'	\N	15	\N	\N	\N	\N
19	Visiting a ghost town	\N	15	\N	\N	\N	\N
20	Visiting an ice hotel	\N	16	\N	\N	\N	\N
21	Staying in an underwater hotel	\N	16	\N	\N	\N	\N
22	Visiting an ice hotel	\N	16	\N	\N	\N	\N
23	Staying in an underwater hotel	\N	16	\N	\N	\N	\N
24	Attending a family-friendly show or performance	\N	15	\N	\N	\N	\N
25	Festivals Acadiens et Créoles	\N	13	\N	\N	\N	\N
26	Swamp Tour	\N	13	\N	\N	\N	\N
29	{"id": 4, "url": "https://whitneyplantation.com/", "icon": "museum", "title": "Whitney Plantation Tour", "category": "History", "location": "5099 LA-18, Wallace", "description": "Visit the Whitney Plantation, a historic site dedicated to telling the story of slavery in Louisiana."}	\N	13	\N	\N	\N	\N
30	{"id": 6, "url": "https://www.preservationhall.com/", "icon": "music_note", "title": "Jazz at Preservation Hall", "category": "Music", "location": "726 St Peter St, New Orleans", "description": "Experience the magic of live jazz music at Preservation Hall, a historic New Orleans venue showcasing traditional jazz performances."}	\N	13	\N	\N	\N	\N
\.


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: vaca
--

COPY public.flights (id, departing_location, arrival_location, round_trip, cost, trip_id) FROM stdin;
\.


--
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: vaca
--

COPY public.trips (id, name, destination, cost, user_id, image_url, start_time, end_time) FROM stdin;
13	Gorbalita	Louisiana	725	15	/13.png	2025-10-01 15:00:00	2025-10-29 15:00:00
14	My First Jaunt	Mar A Lago	8505	15	/14.png	2016-01-13 19:00:00	2035-03-15 16:00:00
15	Sailin the 'ol ocean blue	LaFayette	2	15	/15.png	1752-01-04 19:12:52	1752-01-05 19:12:52
16	to the moooooon	moon	25000000	15	/16.png	2024-09-04 16:00:00	2024-09-18 16:00:00
31	Spanyards	Barceloina	100	16		2024-09-08 12:00:00	2024-09-14 12:00:00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vaca
--

COPY public.users (id, username, salt, hash) FROM stdin;
15	matthew	7f7849bb887357cf6cf7f40685d421ea	09af240aa32841b5c79bc8f6c7436a47
16	connor	b1ab7f23e3016b0f6e15f00a8538cc0b	5c88acd804b7d0922595ecb8e91a71b4
\.


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vaca
--

SELECT pg_catalog.setval('public.activities_id_seq', 30, true);


--
-- Name: flights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vaca
--

SELECT pg_catalog.setval('public.flights_id_seq', 1, false);


--
-- Name: trips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vaca
--

SELECT pg_catalog.setval('public.trips_id_seq', 31, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vaca
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activity_idx; Type: INDEX; Schema: public; Owner: vaca
--

CREATE INDEX activity_idx ON public.activities USING gin (to_tsvector('english'::regconfig, ((((COALESCE(name, ''::text) || ' '::text) || COALESCE(description, ''::text)) || ' '::text) || COALESCE(location, ''::text))));


--
-- Name: activity_trgm_idx; Type: INDEX; Schema: public; Owner: vaca
--

CREATE INDEX activity_trgm_idx ON public.activities USING gin ((((name || location) || description)) public.gin_trgm_ops);


--
-- Name: activities activities_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(id) ON DELETE CASCADE;


--
-- Name: flights flights_trip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(id) ON DELETE CASCADE;


--
-- Name: trips trips_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vaca
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

