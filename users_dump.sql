--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    adresse character varying(255) NOT NULL,
    telephone character varying(255) NOT NULL,
    fonction character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    photo character varying(1024) NOT NULL,
    statut character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT users_statut_check CHECK (((statut)::text = ANY ((ARRAY['Bloqué'::character varying, 'Actif'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO gestiondette;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO gestiondette;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.users (id, nom, prenom, adresse, telephone, fonction, email, photo, statut, password, role_id, created_at, updated_at) FROM stdin;
2	Langworth	Joaquin	244 Konopelski Corner Suite 303\nMartinemouth, MI 83668	+1 (757) 723-3054	omnis	delpha55@example.com	https://via.placeholder.com/640x480.png/003366?text=nostrum	Bloqué	$2y$10$E.ZpaQembHbHOHJ1lLoBOubn3zKmidXuNmiPVsED5jMgXF3h0Ccvy	2	2024-09-18 15:29:22	2024-09-18 15:29:22
9	Howe	Kari	2280 Moore Groves\nSouth Jaydestad, AZ 85134-4863	+1-360-316-4266	nam	mcglynn.tremaine@example.org	https://via.placeholder.com/640x480.png/008833?text=alias	Bloqué	$2y$10$hje.5yNHRcYSSnd3MWKMqO5lLJdDO14idba//d0mGA30ccP8iblNa	3	2024-09-18 15:29:22	2024-09-18 15:29:22
3	Collier	Heidi	18720 Bogan Mountains Apt. 852\nEast Claud, MO 10366-7864	+1-386-505-1469	quia	madaline.schmitt@example.com	https://via.placeholder.com/640x480.png/005588?text=explicabo	Bloqué	$2y$10$mEH/bYyRCs6Uz6xtMYuJlu8nyuOBbusifYB.3P3trDCj7t8iTyiRe	4	2024-09-18 15:29:22	2024-09-18 15:29:22
4	Bartell	Diamond	30134 Angie Orchard Apt. 420\nSouth Joshua, AR 54865	+1 (308) 866-8696	qui	maximillian.abshire@example.net	https://via.placeholder.com/640x480.png/00ccee?text=sunt	Actif	$2y$10$Yv9kAhgZ2qSA0PLtmbIwkO.yCCiAGZH5/UhSOo/JHvuznkzK3Wsri	1	2024-09-18 15:29:22	2024-09-18 15:29:22
5	Rodriguez	Spencer	74418 Larkin Brook Apt. 162\nKilbackbury, OH 20296-2814	480-331-2508	quia	maryse67@example.net	https://via.placeholder.com/640x480.png/0099bb?text=est	Bloqué	$2y$10$2u.W32nNdnGwBhTYIRRYaOLv.WDSHc/bkIIXoZiNmQ8kPIupKePyS	2	2024-09-18 15:29:22	2024-09-18 15:29:22
6	DuBuque	Eldridge	6458 Moriah Rapid\nSchillermouth, IN 28629-6083	+1.910.762.9533	et	chester.hoppe@example.org	https://via.placeholder.com/640x480.png/00bb33?text=totam	Actif	$2y$10$ZNYraBJMQBtbHAEwiqW7MeI8LUsp8oXiPkKq3SzvLSGaK8Eo0.NtS	3	2024-09-18 15:29:22	2024-09-18 15:29:22
7	Turcotte	Jaida	40992 Erdman Drive\nSouth Malika, NJ 52576-9833	+1.830.247.3302	natus	naomi98@example.net	https://via.placeholder.com/640x480.png/00dddd?text=corrupti	Bloqué	$2y$10$kLHvz1tulpO8KqrUVGUyhuB6k9XiSNE3A9.WLMS1Ez/tB55GkSOLC	4	2024-09-18 15:29:22	2024-09-18 15:29:22
8	Mraz	Keara	6619 Wuckert Drives Apt. 145\nNew Caitlynfurt, AR 87174-0138	+1 (520) 670-6584	fuga	rubye56@example.com	https://via.placeholder.com/640x480.png/0033ee?text=ut	Bloqué	$2y$10$ZrMrXhBL6Np0YkVmcUoa5OUvBK/IKkEV9Y.rQ3zuz1MDsSgOgjlSC	1	2024-09-18 15:29:22	2024-09-18 15:29:22
10	Muller	Verda	512 Hane Run\nElliottfort, NM 56717-2569	(508) 494-6290	accusamus	lennie33@example.net	https://via.placeholder.com/640x480.png/000099?text=saepe	Bloqué	$2y$10$2QPltWeDrOb3KHkuZVyfe.owpX9u6zWbksc9.9HN.tUoFMijwK8Fq	2	2024-09-18 15:29:22	2024-09-18 15:29:22
1	Rau	Tracy	Dakar	+1-860-543-5992	atque	libby.carter@example.net	https://via.placeholder.com/640x480.png/00dd33?text=quia	Bloqué	$2y$10$Qrguig8TV.t.TK9yVraPSuS7b8A63vWtI9WTaLF1JOu6gcpDV33Q6	1	2024-09-18 15:29:22	2024-09-20 03:14:18
14	Ndiour	awa	Paris	773450923	Manager	ndiour.awa@example.com	https://via.placeholder.com/640x480.png/00dd33?text=quia	Actif	$2y$10$63JZoqhgKl2AwvZCGrNtd.yXwn1drzgODYvX9XYIxTeP.z.GEafcm	2	2024-09-20 01:18:47	2024-09-20 01:18:47
34	Gning	Elimane	Mbour	776539812	chef	devweb@gmail.com	https://storage.googleapis.com/gestion-2f97b.appspot.com/users/OAALNLNG3fNli64ghbUJArPz8J32/flexbox.png?GoogleAccessId=firebase-adminsdk-hpwq0%40gestion-2f97b.iam.gserviceaccount.com&Expires=1758412499&Signature=pZiJ2fAT04AL0%2BgGR3oyZZfJ2MbNjR5q%2F1km28p5002ckeJa%2FDm4SEIbHxB0rocymsRk%2Fujaj3oUQW7uVDE4syDj%2BFc8hblNw1viICgPrdCQeZpR821RlmyDGdn6zkAwRfPmqjWedKUWwEFlkzA02iCdahKFWDzuxvcQbv6ghBliJY5fvQhdvf23hTCeYugZjqtWEFnXBBBRmx1Q8mW6g1HQBV4n11cJd1fwWAK5LdYiXZbhw5EFAtC%2BTQg%2FuEmVVIoeyaSSfeP8Hr9Q%2FMrV7gY6PMN5echDeFdFHfM6Q7FG5BeWRaHf34%2FE7F9W8D576kTlaoME%2Fs9oe%2FllC70TYw%3D%3D	Actif	$2y$10$OXB6v8CkA5vJbgGyeANHTeVNQt3iK2jGdfVKwE4fldBWU5ow1Z1Y6	2	2024-09-20 23:55:00	2024-09-20 23:55:00
35	Gning	Elimane	Mbour	776539812	chef	elimane@gmail.com	https://storage.googleapis.com/gestion-2f97b.appspot.com/users/8nbHrhADJONAtQ7uIoiTaZ9MZYD2/flexbox.png?GoogleAccessId=firebase-adminsdk-hpwq0%40gestion-2f97b.iam.gserviceaccount.com&Expires=1758510247&Signature=NNTbUO%2Fg95tSHHzt%2BVMRFIsDovYC4LHbvrqZA8Uu0Xgy7R4jbu7XdrhdRqiwzWeFf1pEHPUR5um3FWDiKRPIT8o7OAXZnuJLg8aXp1uXLelTwoBbKXISd50upU2h07%2BgD4%2Bdm8UwmaJGPCYhNQ0e71j6RQlLipSp51w4V%2BtkMUF2%2BUtTues8n3qDs8KlanlICO7NjOt6GuQC9A18QWfm8h1kvVR1CsZ3GPBPWtha8Ni11%2BpMWY8mWdIKsU597RV0Zba%2Bj7uNufWeXfYncGtGUc%2FWGkUuA%2FD4QWGmWaPuVA%2B0w7TFdiASCXpbvBPpDHEa16b%2F2zAR5rUmGi56sclfOw%3D%3D	Actif	$2y$10$xgawLcJF0MGN.TtnzPWLIOd7i413jhNaQOmRi6Z.7wC2usHuetStG	2	2024-09-22 03:04:08	2024-09-22 03:04:08
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.users_id_seq', 35, true);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

