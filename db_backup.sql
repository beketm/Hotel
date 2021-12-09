--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

-- Started on 2021-12-09 22:35:09

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

DROP DATABASE hotel;
--
-- TOC entry 2888 (class 1262 OID 82254)
-- Name: hotel; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE hotel WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Kazakhstan.1251' LC_CTYPE = 'Russian_Kazakhstan.1251';


\connect hotel

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

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 90549)
-- Name: booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    hotel_id integer,
    room_number integer,
    email character varying(50),
    booking_date date DEFAULT CURRENT_DATE NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    number_people integer NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 90547)
-- Name: booking_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 209
-- Name: booking_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_booking_id_seq OWNED BY public.booking.booking_id;


--
-- TOC entry 213 (class 1259 OID 90587)
-- Name: clean_room; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clean_room (
    hotel_id integer NOT NULL,
    room_number integer NOT NULL,
    clean boolean NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 90479)
-- Name: guests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guests (
    guest_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    passport_number character varying(50),
    address character varying(50),
    home_phone_number character varying(50),
    mobile_phone_number character varying(50),
    email character varying(50) NOT NULL,
    password character varying(50)
);


--
-- TOC entry 202 (class 1259 OID 90477)
-- Name: guests_guest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.guests_guest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 202
-- Name: guests_guest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.guests_guest_id_seq OWNED BY public.guests.guest_id;


--
-- TOC entry 205 (class 1259 OID 90487)
-- Name: hotels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hotels (
    hotel_id integer NOT NULL,
    name character varying(50),
    address character varying(50),
    city character varying(50),
    country character varying(50),
    phone_number_1 character varying(50),
    phone_number_2 character varying(50)
);


--
-- TOC entry 204 (class 1259 OID 90485)
-- Name: hotels_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hotels_hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 204
-- Name: hotels_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hotels_hotel_id_seq OWNED BY public.hotels.hotel_id;


--
-- TOC entry 207 (class 1259 OID 90495)
-- Name: room_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_type (
    room_type_id integer NOT NULL,
    name character varying(50),
    size integer,
    capacity integer,
    balcony boolean
);


--
-- TOC entry 206 (class 1259 OID 90493)
-- Name: room_type_room_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_type_room_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 206
-- Name: room_type_room_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_type_room_type_id_seq OWNED BY public.room_type.room_type_id;


--
-- TOC entry 208 (class 1259 OID 90517)
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms (
    hotel_id integer NOT NULL,
    room_number integer NOT NULL,
    room_type_id integer,
    floor integer,
    is_free boolean DEFAULT true
);


--
-- TOC entry 212 (class 1259 OID 90573)
-- Name: stuff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stuff (
    stuff_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    "position" character varying(50),
    email character varying(50) NOT NULL,
    password character varying(50),
    hotel_id integer
);


--
-- TOC entry 211 (class 1259 OID 90571)
-- Name: stuff_stuff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stuff_stuff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 211
-- Name: stuff_stuff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stuff_stuff_id_seq OWNED BY public.stuff.stuff_id;


--
-- TOC entry 2723 (class 2604 OID 90552)
-- Name: booking booking_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_booking_id_seq'::regclass);


--
-- TOC entry 2719 (class 2604 OID 90482)
-- Name: guests guest_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guests ALTER COLUMN guest_id SET DEFAULT nextval('public.guests_guest_id_seq'::regclass);


--
-- TOC entry 2720 (class 2604 OID 90490)
-- Name: hotels hotel_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotels ALTER COLUMN hotel_id SET DEFAULT nextval('public.hotels_hotel_id_seq'::regclass);


--
-- TOC entry 2721 (class 2604 OID 90498)
-- Name: room_type room_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type ALTER COLUMN room_type_id SET DEFAULT nextval('public.room_type_room_type_id_seq'::regclass);


--
-- TOC entry 2725 (class 2604 OID 90576)
-- Name: stuff stuff_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuff ALTER COLUMN stuff_id SET DEFAULT nextval('public.stuff_stuff_id_seq'::regclass);


--
-- TOC entry 2879 (class 0 OID 90549)
-- Dependencies: 210
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking (booking_id, hotel_id, room_number, email, booking_date, check_in_date, check_out_date, number_people) VALUES (3, 2, 404, 'beket0101@gmail.com', '2021-12-08', '2021-12-21', '2021-12-24', 2);
INSERT INTO public.booking (booking_id, hotel_id, room_number, email, booking_date, check_in_date, check_out_date, number_people) VALUES (4, 2, 303, 'marat@nu.edu.kz', '2021-12-08', '2021-12-13', '2021-12-17', 1);
INSERT INTO public.booking (booking_id, hotel_id, room_number, email, booking_date, check_in_date, check_out_date, number_people) VALUES (6, 1, 403, 'tom@gmail.com', '2021-12-09', '2021-12-10', '2021-12-17', 2);


--
-- TOC entry 2882 (class 0 OID 90587)
-- Dependencies: 213
-- Data for Name: clean_room; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.clean_room (hotel_id, room_number, clean) VALUES (1, 201, true);
INSERT INTO public.clean_room (hotel_id, room_number, clean) VALUES (1, 202, false);
INSERT INTO public.clean_room (hotel_id, room_number, clean) VALUES (2, 201, false);


--
-- TOC entry 2872 (class 0 OID 90479)
-- Dependencies: 203
-- Data for Name: guests; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.guests (guest_id, first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES (1, 'Beket', 'Myrzanov', '147896', 'Aktau city, Lenina 23', '87415289966', '87774604486', 'beket0101@gmail.com', '123456');
INSERT INTO public.guests (guest_id, first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES (2, 'Aibat', 'Tileuaiuly', '789654', 'Astana street 45', '87415289966', '87774604486', 'aibat.09@gmail.com', '123456');
INSERT INTO public.guests (guest_id, first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES (3, 'Marat', 'Nsanbayev', '98561234', 'Kunaeva 27', '87479658899', '87471234455', 'marat@nu.edu.kz', 'qwerty');
INSERT INTO public.guests (guest_id, first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES (4, 'Anuar', 'Nauryzbayev', '09578541', 'Tinkova 25', '87075698841', '87471257896', 'anuar2001@gmail.com', '147');
INSERT INTO public.guests (guest_id, first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES (5, 'Ilnara', 'Kuimbetova', '963258', 'Stroitelny 90', '87074556655', '874752147765', 'ilnara@mail.ru', '987987');
INSERT INTO public.guests (guest_id, first_name, last_name, passport_number, address, home_phone_number, mobile_phone_number, email, password) VALUES (7, 'Tom', 'Johnson', '265487', '62 Broadway, NY', '19456287321', '15248963745', 'tom@gmail.com', '123456Tom');


--
-- TOC entry 2874 (class 0 OID 90487)
-- Dependencies: 205
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hotels (hotel_id, name, address, city, country, phone_number_1, phone_number_2) VALUES (1, 'NP Nursultan', 'Uly Dala 54', 'Nursultan', 'Kazakhstan', '87774501496', '87053698524');
INSERT INTO public.hotels (hotel_id, name, address, city, country, phone_number_1, phone_number_2) VALUES (2, 'NP Almaty', 'Zhibek Zholy 123', 'Almaty', 'Kazakhstan', '87004445885', '87476985223');


--
-- TOC entry 2876 (class 0 OID 90495)
-- Dependencies: 207
-- Data for Name: room_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.room_type (room_type_id, name, size, capacity, balcony) VALUES (1, 'single', 25, 2, false);
INSERT INTO public.room_type (room_type_id, name, size, capacity, balcony) VALUES (2, 'single', 35, 3, true);
INSERT INTO public.room_type (room_type_id, name, size, capacity, balcony) VALUES (3, 'double', 40, 4, true);
INSERT INTO public.room_type (room_type_id, name, size, capacity, balcony) VALUES (4, 'double', 45, 5, true);


--
-- TOC entry 2877 (class 0 OID 90517)
-- Dependencies: 208
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 201, 1, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 202, 3, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 203, 1, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 204, 3, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 301, 1, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 302, 3, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 303, 1, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 304, 3, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 401, 1, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 402, 3, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 403, 1, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (1, 404, 3, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 201, 2, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 202, 4, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 203, 2, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 204, 4, 2, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 301, 2, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 302, 4, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 303, 2, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 304, 4, 3, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 401, 2, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 402, 4, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 403, 2, 4, true);
INSERT INTO public.rooms (hotel_id, room_number, room_type_id, floor, is_free) VALUES (2, 404, 4, 4, true);


--
-- TOC entry 2881 (class 0 OID 90573)
-- Dependencies: 212
-- Data for Name: stuff; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.stuff (stuff_id, first_name, last_name, "position", email, password, hotel_id) VALUES (1, 'Beket', 'Myrzanov', 'clerk', 'ilnara@np.kz', '123', 1);
INSERT INTO public.stuff (stuff_id, first_name, last_name, "position", email, password, hotel_id) VALUES (2, 'Anastasia', 'Kim', 'cleaner', 'nastya@np.kz', 'thehotgirl', 1);
INSERT INTO public.stuff (stuff_id, first_name, last_name, "position", email, password, hotel_id) VALUES (3, 'Sabit', 'Maratov', 'manager', 'sabit@np.kz', 'sasa', 1);
INSERT INTO public.stuff (stuff_id, first_name, last_name, "position", email, password, hotel_id) VALUES (4, 'jotaro', 'kujou', 'clerk', 'jojo@np.kz', 'jotaro01', 1);


--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 209
-- Name: booking_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_booking_id_seq', 6, true);


--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 202
-- Name: guests_guest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.guests_guest_id_seq', 7, true);


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 204
-- Name: hotels_hotel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.hotels_hotel_id_seq', 2, true);


--
-- TOC entry 2897 (class 0 OID 0)
-- Dependencies: 206
-- Name: room_type_room_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.room_type_room_type_id_seq', 4, true);


--
-- TOC entry 2898 (class 0 OID 0)
-- Dependencies: 211
-- Name: stuff_stuff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stuff_stuff_id_seq', 4, true);


--
-- TOC entry 2735 (class 2606 OID 90555)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 2739 (class 2606 OID 90591)
-- Name: clean_room clean_room_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clean_room
    ADD CONSTRAINT clean_room_pkey PRIMARY KEY (hotel_id, room_number);


--
-- TOC entry 2727 (class 2606 OID 90484)
-- Name: guests guests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guests
    ADD CONSTRAINT guests_pkey PRIMARY KEY (email);


--
-- TOC entry 2729 (class 2606 OID 90492)
-- Name: hotels hotels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (hotel_id);


--
-- TOC entry 2731 (class 2606 OID 90500)
-- Name: room_type room_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_type
    ADD CONSTRAINT room_type_pkey PRIMARY KEY (room_type_id);


--
-- TOC entry 2733 (class 2606 OID 90522)
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (hotel_id, room_number);


--
-- TOC entry 2737 (class 2606 OID 90578)
-- Name: stuff stuff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuff
    ADD CONSTRAINT stuff_pkey PRIMARY KEY (stuff_id);


--
-- TOC entry 2743 (class 2606 OID 90561)
-- Name: booking booking_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_email_fkey FOREIGN KEY (email) REFERENCES public.guests(email);


--
-- TOC entry 2742 (class 2606 OID 90556)
-- Name: booking booking_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id);


--
-- TOC entry 2740 (class 2606 OID 90523)
-- Name: rooms rooms_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id);


--
-- TOC entry 2741 (class 2606 OID 90528)
-- Name: rooms rooms_room_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_room_type_id_fkey FOREIGN KEY (room_type_id) REFERENCES public.room_type(room_type_id);


--
-- TOC entry 2744 (class 2606 OID 90579)
-- Name: stuff stuff_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stuff
    ADD CONSTRAINT stuff_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id);


-- Completed on 2021-12-09 22:35:09

--
-- PostgreSQL database dump complete
--

