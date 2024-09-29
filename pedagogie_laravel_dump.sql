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
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO gestiondette;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO gestiondette;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO gestiondette;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO gestiondette;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.oauth_access_tokens (
    id character varying(100) NOT NULL,
    user_id bigint,
    client_id bigint NOT NULL,
    name character varying(255),
    scopes text,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_access_tokens OWNER TO gestiondette;

--
-- Name: oauth_auth_codes; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.oauth_auth_codes (
    id character varying(100) NOT NULL,
    user_id bigint NOT NULL,
    client_id bigint NOT NULL,
    scopes text,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_auth_codes OWNER TO gestiondette;

--
-- Name: oauth_clients; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.oauth_clients (
    id bigint NOT NULL,
    user_id bigint,
    name character varying(255) NOT NULL,
    secret character varying(100),
    provider character varying(255),
    redirect text NOT NULL,
    personal_access_client boolean NOT NULL,
    password_client boolean NOT NULL,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_clients OWNER TO gestiondette;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.oauth_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oauth_clients_id_seq OWNER TO gestiondette;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.oauth_clients_id_seq OWNED BY public.oauth_clients.id;


--
-- Name: oauth_personal_access_clients; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.oauth_personal_access_clients (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_personal_access_clients OWNER TO gestiondette;

--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.oauth_personal_access_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oauth_personal_access_clients_id_seq OWNER TO gestiondette;

--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.oauth_personal_access_clients_id_seq OWNED BY public.oauth_personal_access_clients.id;


--
-- Name: oauth_refresh_tokens; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.oauth_refresh_tokens (
    id character varying(100) NOT NULL,
    access_token_id character varying(100) NOT NULL,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);


ALTER TABLE public.oauth_refresh_tokens OWNER TO gestiondette;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO gestiondette;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO gestiondette;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO gestiondette;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: gestiondette
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO gestiondette;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: gestiondette
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO gestiondette;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gestiondette
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


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
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: oauth_clients id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_clients_id_seq'::regclass);


--
-- Name: oauth_personal_access_clients id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_personal_access_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_personal_access_clients_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.migrations (id, migration, batch) FROM stdin;
6	2014_10_12_100000_create_password_reset_tokens_table	1
7	2019_08_19_000000_create_failed_jobs_table	1
8	2019_12_14_000001_create_personal_access_tokens_table	1
9	2024_09_18_132520_create_roles_table	1
10	2024_10_12_000000_create_users_table	1
11	2016_06_01_000001_create_oauth_auth_codes_table	2
12	2016_06_01_000002_create_oauth_access_tokens_table	2
13	2016_06_01_000003_create_oauth_refresh_tokens_table	2
14	2016_06_01_000004_create_oauth_clients_table	2
15	2016_06_01_000005_create_oauth_personal_access_clients_table	2
16	2024_09_20_130950_modify_photo_column_in_users_table	3
\.


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.oauth_access_tokens (id, user_id, client_id, name, scopes, revoked, created_at, updated_at, expires_at) FROM stdin;
381c1b3202d75ca02258938cf56fab595c7b7e0618192194e2fbca7bb8dd2c5431d0af14424a7ca7	2	3	appToken	[]	f	2024-09-18 19:51:04	2024-09-18 19:51:04	2025-09-18 19:51:04
736ad8d331bffbe537d1076cfc3f64c752618fcabb70754a5b71e6e5eafcd16bf00fba698b42e848	2	3	appToken	[]	f	2024-09-18 19:51:26	2024-09-18 19:51:26	2025-09-18 19:51:26
ac42d285da98a04951b91107a32b04a39e8feee817ab92462558cfb1410e9dc2523416e21903d6e2	2	3	refreshToken	[]	f	2024-09-18 19:51:26	2024-09-18 19:51:26	2025-09-18 19:51:26
3ecad73590825e370c3352e5879c8a3328c6e4550bbde6fa209af840249f0295be33549b8a084c0a	2	3	appToken	[]	f	2024-09-18 19:53:55	2024-09-18 19:53:55	2025-09-18 19:53:55
00ed84055a8970e8051115e9c05634dddc58f1a9a437141776655d92e83a05f0bb8844ff9fe63b89	2	3	refreshToken	[]	f	2024-09-18 19:53:55	2024-09-18 19:53:55	2025-09-18 19:53:55
8a722a8529c0372664a8c8a59d7de415b8cded4f73c8614d86a549067866bc5ee4d2929541146ec9	2	3	appToken	[]	f	2024-09-18 20:25:00	2024-09-18 20:25:00	2025-09-18 20:25:00
d7f6626c452b14902336ecb8f291698be2df4a616b32441f7778e827aef757c3524c4a0fa5659e0e	2	3	refreshToken	[]	f	2024-09-18 20:25:00	2024-09-18 20:25:00	2025-09-18 20:25:00
5d01c93db4519c30019a3ab4ff90365854b9384285e925892fef6bc88ed12c7665dbb467125ed334	2	3	appToken	[]	f	2024-09-18 20:25:01	2024-09-18 20:25:01	2025-09-18 20:25:01
c770e39f2560eaf547e7b6e9b0eea65086ad70e16c7d9f486fb897e4a6868235de7b8c36d95bc8a5	2	3	refreshToken	[]	f	2024-09-18 20:25:01	2024-09-18 20:25:02	2025-09-18 20:25:01
e1301574db195fc86d27d8d4ae9f65090df5ecf9dcd7fb58e5dfe9135ce3eafc382e4b0e5c8a9449	2	3	appToken	[]	f	2024-09-19 02:28:03	2024-09-19 02:28:03	2025-09-19 02:28:03
dea31a82ec8903907b6d135a398bc99e1e893ad1707e9b6a7699d5a03e6bffdd7d452865050f8c45	2	3	refreshToken	[]	f	2024-09-19 02:28:03	2024-09-19 02:28:03	2025-09-19 02:28:03
1c989e8af3d25e0c2b24186950dab5dca044666f58949520a9bc40345d38121c8b87d641c14b5a02	12	3	appToken	[]	f	2024-09-19 23:36:08	2024-09-19 23:36:08	2025-09-19 23:36:08
7b4104a5c332b06d794415769e78560b329268dac6670092797ef11bd9a719ebdfb1057b74e424a0	12	3	refreshToken	[]	f	2024-09-19 23:36:08	2024-09-19 23:36:08	2025-09-19 23:36:08
fe93a5ac5eb3e87098c915d015baffcd5ccc1ea3ebbba687d713108a09abd6a754f2db33aeda7361	14	3	appToken	[]	f	2024-09-20 02:04:04	2024-09-20 02:04:04	2025-09-20 02:04:04
d74ad4fb0e95478d069a6d97c7472754248aa333e6b65c03a3bc8e023dfa51d6838ca0bd2b382ddc	14	3	refreshToken	[]	f	2024-09-20 02:04:04	2024-09-20 02:04:04	2025-09-20 02:04:04
c7b49fb3afd3b83a87d421a175b6de97a54a2ac6c8246e40b3bdb2c2b2b88b2d9bb279ae44c5985a	14	3	appToken	[]	f	2024-09-20 12:53:35	2024-09-20 12:53:35	2025-09-20 12:53:35
8a19fb919507fd330c38fd5c1eb277bb0555b1181116f556da97984c0df282df6c1e9e50c48e4a8b	14	3	refreshToken	[]	f	2024-09-20 12:53:35	2024-09-20 12:53:35	2025-09-20 12:53:35
f9b726cc8d5423657272fea39926110f9e8c14ec3c9e0b3f0b2f95f56c86f77c864546086f295f2e	14	3	appToken	[]	f	2024-09-20 13:14:50	2024-09-20 13:14:50	2025-09-20 13:14:50
eba422754b805a0412081c36194e64cefd16bb649e15771462c296ed29d20554217648f87409303a	14	3	refreshToken	[]	f	2024-09-20 13:14:50	2024-09-20 13:14:50	2025-09-20 13:14:50
ac3f83430d6fac23358f62a1acaeba3d89c18ecba3062a5a0adabc72b75843bbf265879e11033fea	14	3	appToken	[]	f	2024-09-21 10:43:20	2024-09-21 10:43:20	2025-09-21 10:43:20
3276d6b0baf70146d90f3cf9a3d25bfa7cef60e7477635388ae77cbd664498dc655f08a257a395fd	14	3	refreshToken	[]	f	2024-09-21 10:43:20	2024-09-21 10:43:20	2025-09-21 10:43:20
235b18d5680c96ab45c684f8e25da818de7274db489004d22bd506f55378294943b1a32e767d7d4d	14	3	appToken	[]	f	2024-09-21 15:49:22	2024-09-21 15:49:22	2025-09-21 15:49:22
ce610f78391a138ca92dedb230fd809c8360477d36e4538b51ed633efd6158294456fa5614f92986	14	3	refreshToken	[]	f	2024-09-21 15:49:22	2024-09-21 15:49:22	2025-09-21 15:49:22
d139cc6a15ab9763a3ea60444a19f730722fa8536913620c511a65c7570553f20cf45682d124fbf9	14	3	appToken	[]	f	2024-09-21 22:50:42	2024-09-21 22:50:42	2025-09-21 22:50:42
87b46089956f94ab8afd2ff3ad03672ef8b433f393f30095bd6f9c9c0342f6fbeb353c8c1ffac201	14	3	refreshToken	[]	f	2024-09-21 22:50:42	2024-09-21 22:50:42	2025-09-21 22:50:42
155bb740b3f776cdf6474e882cf16be6db1e9e724f2de0e2ef27c5c08a6e3096b8f7b0f3818b3180	14	3	appToken	[]	f	2024-09-22 02:54:58	2024-09-22 02:54:58	2025-09-22 02:54:58
56073d97c4c119f958db11b5225e0173cc043d26bf808e39e846632b92c2997ca1adff9164b14fc8	14	3	refreshToken	[]	f	2024-09-22 02:54:58	2024-09-22 02:54:58	2025-09-22 02:54:58
883c7a081b72337bf2d7bfff78c1026e646ab26836ff32bb4ac0e447a98bc9912049f98f14828220	14	3	appToken	[]	f	2024-09-22 03:00:19	2024-09-22 03:00:19	2025-09-22 03:00:19
31af2da3c588e5fd38986708a11b9a642466ce03634338695d7ec6f151a46b429c95922acde2eb0b	14	3	refreshToken	[]	f	2024-09-22 03:00:19	2024-09-22 03:00:19	2025-09-22 03:00:19
5087f6ac12e26a2b560ba900e6530063972338bc57a5e663fa0cc3acfa185370c68240107adaa58e	14	3	appToken	[]	f	2024-09-22 03:23:00	2024-09-22 03:23:00	2025-09-22 03:23:00
f380f1b3abfebc100cacf4f2817309384cb959b07b01eaa826d8d5a963904ec647f27da35c3beeb4	14	3	refreshToken	[]	f	2024-09-22 03:23:00	2024-09-22 03:23:00	2025-09-22 03:23:00
4fd7fb7e2f62362b5348532c29f93c9238aa6316b41227856363b8e138e281564925348b45072492	14	3	appToken	[]	f	2024-09-22 03:45:38	2024-09-22 03:45:38	2025-09-22 03:45:38
cb8149488a825c30b23baf4aae7b7163679be45641e7087903f9675eaf868c9961276af8f9f67106	14	3	refreshToken	[]	f	2024-09-22 03:45:38	2024-09-22 03:45:38	2025-09-22 03:45:38
10f110a7037c65a14ef7f6181c05beeadb405fd9c1c99ddfd23d63c66c089dd55be72181480e016d	14	3	appToken	[]	f	2024-09-22 13:08:34	2024-09-22 13:08:34	2025-09-22 13:08:34
15c8639bbc4c99eaee01822df7856c178a0a489c3e6e52133f98fd4a3be9d5194eddb0e53f0de04f	14	3	refreshToken	[]	f	2024-09-22 13:08:34	2024-09-22 13:08:34	2025-09-22 13:08:34
1ab4a5d59737ef0b35a950c7707037854ea6b487dc79da95cb1a3afa952606090d19a68e29896eb3	14	3	appToken	[]	f	2024-09-22 23:16:17	2024-09-22 23:16:17	2025-09-22 23:16:17
37650dc3d81625a0e8070346061c6513cb940219fe729ee9ffe58ac23bffc5563893676571722455	14	3	refreshToken	[]	f	2024-09-22 23:16:17	2024-09-22 23:16:17	2025-09-22 23:16:17
\.


--
-- Data for Name: oauth_auth_codes; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.oauth_auth_codes (id, user_id, client_id, scopes, revoked, expires_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.oauth_clients (id, user_id, name, secret, provider, redirect, personal_access_client, password_client, revoked, created_at, updated_at) FROM stdin;
1	\N	Laravel Personal Access Client	KRdvoaxo62pFRRiYCuSkKkVTQTMNggmewDcpf0bI	\N	http://localhost	t	f	f	2024-09-18 18:48:59	2024-09-18 18:48:59
2	\N	Laravel Password Grant Client	PrJ5lnThlXOX9Cn69w0LEARA4xHr5oDSIDkdZGyw	users	http://localhost	f	t	f	2024-09-18 18:48:59	2024-09-18 18:48:59
3	\N	Laravel Personal Access Client	i9vzRKTkKeROAtYa23kytYXljwFGZfzYMfVxxVHG	\N	http://localhost	t	f	f	2024-09-18 18:49:50	2024-09-18 18:49:50
4	\N	Laravel Password Grant Client	PqhGhw1fd34pHRKYvXW31P88t2bMafkrvOB1KdSL	users	http://localhost	f	t	f	2024-09-18 18:49:50	2024-09-18 18:49:50
5	\N	Laravel Personal Access Client	Ey5lzyiG1h2voMnfFlgC850gDfLZYDRh9S12lWMW	\N	http://localhost	t	f	f	2024-09-23 16:07:19	2024-09-23 16:07:19
6	\N	Laravel Password Grant Client	jjkC0Q3AF2SQqanVZdpnJurKVe4geowDdPozgsty	users	http://localhost	f	t	f	2024-09-23 16:07:19	2024-09-23 16:07:19
7	\N	Laravel Personal Access Client	6dRlfCA5ojy8FY7Aoqtl1lwdrdaPeFR8iB7digL1	\N	http://localhost	t	f	f	2024-09-24 11:59:02	2024-09-24 11:59:02
8	\N	Laravel Password Grant Client	frtosJYOqCL9JhsuKuPPqlLMzhTzJjUajJDTk3wD	users	http://localhost	f	t	f	2024-09-24 11:59:02	2024-09-24 11:59:02
\.


--
-- Data for Name: oauth_personal_access_clients; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.oauth_personal_access_clients (id, client_id, created_at, updated_at) FROM stdin;
1	1	2024-09-18 18:48:59	2024-09-18 18:48:59
2	3	2024-09-18 18:49:50	2024-09-18 18:49:50
3	5	2024-09-23 16:07:19	2024-09-23 16:07:19
4	7	2024-09-24 11:59:02	2024-09-24 11:59:02
\.


--
-- Data for Name: oauth_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.oauth_refresh_tokens (id, access_token_id, revoked, expires_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
1	App\\Models\\User	2	appToken	8f084c1a93e95622da1731f7ff1f3b57a33da13a99aaf3442091535d793abdbe	["*"]	\N	\N	2024-09-18 18:30:20	2024-09-18 18:30:20
2	App\\Models\\User	2	refreshToken	49c5d49a14297ae7eaa22b855e42435f6cd9865b7ab2b06a660ce6407b334589	["*"]	\N	\N	2024-09-18 18:30:20	2024-09-18 18:30:20
3	App\\Models\\User	2	appToken	2b55caf35338810fa433eca1c05331b32178879f0e14c9f06b963163e9e86603	["*"]	\N	\N	2024-09-18 18:36:23	2024-09-18 18:36:23
4	App\\Models\\User	2	refreshToken	bae12fb5a50cbb61eae6a711b39277555c5056ba4f066eb76c3e727a8e76489f	["*"]	\N	\N	2024-09-18 18:36:23	2024-09-18 18:36:23
5	App\\Models\\User	2	appToken	4fc72d77d615cee37f0b26226c48162f4e0e7bad1eface79626fb255ec16dac5	["*"]	\N	\N	2024-09-18 18:38:48	2024-09-18 18:38:48
6	App\\Models\\User	2	refreshToken	79c15f920ffbab415a750542f59445d2a60f5464480c7867684947fe2e2f7c03	["*"]	\N	\N	2024-09-18 18:38:48	2024-09-18 18:38:48
7	App\\Models\\User	2	appToken	56a1562c01290be6f6c26f738b46d3f97499a1a87cb0a13cb2ddbb778b8240aa	["*"]	\N	\N	2024-09-18 18:44:22	2024-09-18 18:44:22
8	App\\Models\\User	2	appToken	bfd4d9b41a583a3a70ea536d17cdb5b59da0d49a603226576496811718fae510	["*"]	\N	\N	2024-09-18 18:47:05	2024-09-18 18:47:05
9	App\\Models\\User	2	appToken	a0d6b241323079c5ec4090c16cb9dfdf5189ae8bfdd0f93e6c91d7caf3fec0b1	["*"]	\N	\N	2024-09-18 18:49:09	2024-09-18 18:49:09
10	App\\Models\\User	2	appToken	2d56c5584d400ac67d20fc8accc0d9c51ff57e557e96624338dc069d170dbc07	["*"]	\N	\N	2024-09-18 18:52:32	2024-09-18 18:52:32
11	App\\Models\\User	2	appToken	b0c087b4d4166782d3c11beaeecb8f18ad9087a29caee44cd039d297e85117f6	["*"]	\N	\N	2024-09-18 18:52:46	2024-09-18 18:52:46
12	App\\Models\\User	2	refreshToken	4396df7d14372db9ab6d3f8fd4bf282722a2f992427cd79797f8eb14364aacc5	["*"]	\N	\N	2024-09-18 18:52:46	2024-09-18 18:52:46
13	App\\Models\\User	2	appToken	b573b6204c866dd1891ba891ecbc042a92379e2894dcfc4bdca53004941253d5	["*"]	\N	\N	2024-09-18 18:54:17	2024-09-18 18:54:17
14	App\\Models\\User	2	refreshToken	c75095bfc7a503a9fe4ada45a1549ca6af90ae183c1fe863e8a7b7f59042b9a2	["*"]	\N	\N	2024-09-18 18:54:17	2024-09-18 18:54:17
15	App\\Models\\User	2	appToken	2270473f2e433ca6eec47e365f6bf70773635ff558600ddb64ab494d2b63dc36	["*"]	\N	\N	2024-09-18 18:59:58	2024-09-18 18:59:58
16	App\\Models\\User	2	appToken	d4a07a7cd7452416695a74f0f53dc82d929e60c45be51b651615b6f4c217db36	["*"]	\N	\N	2024-09-18 19:08:40	2024-09-18 19:08:40
17	App\\Models\\User	2	refreshToken	9a718f2ac3425a0a951ad51a9a70ddc82c50aba420a64dc2e26a4434c9b1170a	["*"]	\N	\N	2024-09-18 19:08:40	2024-09-18 19:08:40
18	App\\Models\\User	2	appToken	e42fc272f857c92ca0ff91cdc99f8bfa0d20b3bc3aecc83c79cad1f8679c117d	["*"]	\N	\N	2024-09-18 19:18:45	2024-09-18 19:18:45
19	App\\Models\\User	2	refreshToken	13ad11f186f0f73826ecf9b53fae1ed2d4539208810bb9d932d510b7c8928e58	["*"]	\N	\N	2024-09-18 19:18:45	2024-09-18 19:18:45
20	App\\Models\\User	2	appToken	be0022e4a3692c5f70561ab4ac7bd54f42bdc839a92eaf55360535a295879e22	["*"]	\N	\N	2024-09-18 19:19:35	2024-09-18 19:19:35
21	App\\Models\\User	2	refreshToken	801547f9761956f96ffbc2b337ebc9d66732d960ba8dbbb3e57a6f368449db77	["*"]	\N	\N	2024-09-18 19:19:35	2024-09-18 19:19:35
22	App\\Models\\User	2	appToken	74e4c87a0afae45c9fccdeaf79cdb913a6e0a120d0d977d3587ba491eb4f9e96	["*"]	\N	\N	2024-09-18 19:20:37	2024-09-18 19:20:37
23	App\\Models\\User	2	refreshToken	977918ac8d516ec64d351820a0822e95fe3dd555114ff9688e5abfffc44eb6e3	["*"]	\N	\N	2024-09-18 19:20:37	2024-09-18 19:20:37
24	App\\Models\\User	2	appToken	381f1835937f1b001fb70e2eebe774931f2bb50d33fa4709a83abc4ef05229c4	["*"]	\N	\N	2024-09-18 19:25:44	2024-09-18 19:25:44
25	App\\Models\\User	2	refreshToken	614d39b538f812913380546354cd12ea984e2143e3e6c86d3d2b842cf23ec2e2	["*"]	\N	\N	2024-09-18 19:25:44	2024-09-18 19:25:44
26	App\\Models\\User	2	appToken	d9375c861bace1830281c9e0592b7cd6c28eb88a44f5cfc16e734ed7775ebf9f	["*"]	\N	\N	2024-09-18 19:26:11	2024-09-18 19:26:11
27	App\\Models\\User	2	refreshToken	45ab385865b9517fc098a10123e327e0813dcc376167744728219bab647f10f1	["*"]	\N	\N	2024-09-18 19:26:11	2024-09-18 19:26:11
28	App\\Models\\User	2	appToken	85575b37f94d0455de6fd34db584c16a002372455d83ba08c3d088470455b15a	["*"]	\N	\N	2024-09-18 19:48:44	2024-09-18 19:48:44
29	App\\Models\\User	2	refreshToken	4f081ae844798e4d06cf2230b3967dd2ba8cf7776545f63ca5d376875264a3ef	["*"]	\N	\N	2024-09-18 19:48:44	2024-09-18 19:48:44
30	App\\Models\\User	2	appToken	f8f7468c84db2750899f271891487c9a43cc77ba070168769d977d582c94cd40	["*"]	\N	\N	2024-09-18 19:49:25	2024-09-18 19:49:25
31	App\\Models\\User	2	appToken	837a17c4878d989c09a8fa5cdabac5c38d1b27a449dd06b1acef3d2e0fdaf254	["*"]	\N	\N	2024-09-18 19:49:49	2024-09-18 19:49:49
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: gestiondette
--

COPY public.roles (id, name, created_at, updated_at) FROM stdin;
1	Admin	\N	\N
2	Manager	\N	\N
3	CM	\N	\N
4	Coach	\N	\N
5	Apprenant	2024-09-18 15:29:21	2024-09-18 15:29:21
\.


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
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.oauth_clients_id_seq', 8, true);


--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.oauth_personal_access_clients_id_seq', 4, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 31, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.roles_id_seq', 14, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gestiondette
--

SELECT pg_catalog.setval('public.users_id_seq', 35, true);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_auth_codes oauth_auth_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_auth_codes
    ADD CONSTRAINT oauth_auth_codes_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_personal_access_clients oauth_personal_access_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_personal_access_clients
    ADD CONSTRAINT oauth_personal_access_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_refresh_tokens oauth_refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.oauth_refresh_tokens
    ADD CONSTRAINT oauth_refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: roles roles_name_unique; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_unique UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


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
-- Name: oauth_access_tokens_user_id_index; Type: INDEX; Schema: public; Owner: gestiondette
--

CREATE INDEX oauth_access_tokens_user_id_index ON public.oauth_access_tokens USING btree (user_id);


--
-- Name: oauth_auth_codes_user_id_index; Type: INDEX; Schema: public; Owner: gestiondette
--

CREATE INDEX oauth_auth_codes_user_id_index ON public.oauth_auth_codes USING btree (user_id);


--
-- Name: oauth_clients_user_id_index; Type: INDEX; Schema: public; Owner: gestiondette
--

CREATE INDEX oauth_clients_user_id_index ON public.oauth_clients USING btree (user_id);


--
-- Name: oauth_refresh_tokens_access_token_id_index; Type: INDEX; Schema: public; Owner: gestiondette
--

CREATE INDEX oauth_refresh_tokens_access_token_id_index ON public.oauth_refresh_tokens USING btree (access_token_id);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: gestiondette
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: users users_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: gestiondette
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

