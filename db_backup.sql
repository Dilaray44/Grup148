--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-15 11:22:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 219 (class 1259 OID 24607)
-- Name:  kullanici_konusmalari; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public." kullanici_konusmalari" (
    id integer,
    kullanici_id uuid,
    prompt_id integer,
    mesaj_metni text,
    mesaj_tipi text,
    oturum_id uuid,
    created_at timestamp with time zone
);


ALTER TABLE public." kullanici_konusmalari" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24624)
-- Name: feature_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feature_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    session_id uuid NOT NULL,
    feature_name text NOT NULL,
    change_type text NOT NULL,
    prev_value text NOT NULL,
    new_value text NOT NULL,
    change_reason text NOT NULL,
    change_date timestamp with time zone NOT NULL
);


ALTER TABLE public.feature_history OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24595)
-- Name: kullanici_ilerleme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kullanici_ilerleme (
    id integer NOT NULL,
    kullanici_id uuid NOT NULL,
    toplam_prompt_sayisi integer NOT NULL,
    toplam_konusma_sayisi integer NOT NULL,
    basari_durumu text NOT NULL,
    son_giris timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.kullanici_ilerleme OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24602)
-- Name: prompt_kullanim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prompt_kullanim (
    id integer NOT NULL,
    kullanici_id uuid NOT NULL,
    prompt_id integer NOT NULL,
    kullanim_sayisi integer NOT NULL,
    son_kullanim timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.prompt_kullanim OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24619)
-- Name: users tablosu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."users tablosu" (
    id uuid NOT NULL,
    ad_soyad text NOT NULL,
    email text NOT NULL,
    sifre_hash text NOT NULL,
    aktif boolean NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public."users tablosu" OWNER TO postgres;

--
-- TOC entry 4912 (class 0 OID 24607)
-- Dependencies: 219
-- Data for Name:  kullanici_konusmalari; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public." kullanici_konusmalari" (id, kullanici_id, prompt_id, mesaj_metni, mesaj_tipi, oturum_id, created_at) FROM stdin;
1	550e8400-e29b-41d4-a716-446655440000	101	Merhaba, bugün hava nasıl?	kullanici	660e8400-e29b-41d4-a716-446655440001	2025-07-10 10:15:00+03
2	550e8400-e29b-41d4-a716-446655440000	101	Bugün İstanbul’da parçalı bulutlu bir hava bekleniyor.	llm	660e8400-e29b-41d4-a716-446655440001	2025-07-10 10:15:02+03
3	550e8400-e29b-41d4-a716-446655440000	102	Yarın sinemada ne oynuyor?	kullanici	660e8400-e29b-41d4-a716-446655440002	2025-07-12 14:00:00+03
4	550e8400-e29b-41d4-a716-446655440000	102	Yarın için önerilen film: Inception.	llm	660e8400-e29b-41d4-a716-446655440002	2025-07-12 14:00:03+03
\.


--
-- TOC entry 4914 (class 0 OID 24624)
-- Dependencies: 221
-- Data for Name: feature_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feature_history (id, user_id, session_id, feature_name, change_type, prev_value, new_value, change_reason, change_date) FROM stdin;
1	101	660e8400-e29b-41d4-a716-446655440000	giriş ekranı	güncelleme	eski tasarım	yeni tasarım	Daha kullanıcı dostu olması için	2025-07-10 09:30:00+03
2	102	660e8400-e29b-41d4-a716-446655440001	chat özelliği	ekleme		aktif edildi	Kullanıcı talebi üzerine	2025-07-12 11:45:00+03
3	103	660e8400-e29b-41d4-a716-446655440002	ayarlar menüsü	çıkarma	eski buton		 Kullanım kolaylığı için kaldırıldı	2025-07-14 16:20:00+03
\.


--
-- TOC entry 4910 (class 0 OID 24595)
-- Dependencies: 217
-- Data for Name: kullanici_ilerleme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kullanici_ilerleme (id, kullanici_id, toplam_prompt_sayisi, toplam_konusma_sayisi, basari_durumu, son_giris, created_at) FROM stdin;
1	550e8400-e29b-41d4-a716-446655440000	15	30	hedefe_ulasildi	2025-07-10 12:00:00+03	2025-07-10 12:00:00+03
2	660e8400-e29b-41d4-a716-446655440111	10	20	devam_ediyor	2025-07-12 09:15:00+03	2025-07-12 09:00:00+03
3	770e8400-e29b-41d4-a716-446655440222	5	10	hedefe_ulasildi	2025-07-14 15:45:00+03	2025-07-14 15:00:00+03
\.


--
-- TOC entry 4911 (class 0 OID 24602)
-- Dependencies: 218
-- Data for Name: prompt_kullanim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prompt_kullanim (id, kullanici_id, prompt_id, kullanim_sayisi, son_kullanim, created_at) FROM stdin;
1	550e8400-e29b-41d4-a716-446655440000	101	5	2025-07-10 14:00:00+03	2025-07-10 14:00:00+03
2	660e8400-e29b-41d4-a716-446655440111	102	3	2025-07-12 09:30:00+03	2025-07-12 09:00:00+03
3	770e8400-e29b-41d4-a716-446655440222	103	10	2025-07-14 16:45:00+03	2025-07-14 16:00:00+03
\.


--
-- TOC entry 4913 (class 0 OID 24619)
-- Dependencies: 220
-- Data for Name: users tablosu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."users tablosu" (id, ad_soyad, email, sifre_hash, aktif, created_at) FROM stdin;
550e8400-e29b-41d4-a716-446655440000	Ahmet Yılmaz	ahmet@example.com	hash123	t	2025-07-14 10:00:00+03
660e8400-e29b-41d4-a716-446655440001	Ayşe Demir	ayse@example.com	hash456	f	2025-07-14 11:00:00+03
770e8400-e29b-41d4-a716-446655440002	Mehmet Kara	mehmet@example.com	hash789	t	2025-07-14 12:00:00+03
\.


--
-- TOC entry 4764 (class 2606 OID 24630)
-- Name: feature_history feature_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_history
    ADD CONSTRAINT feature_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4758 (class 2606 OID 24601)
-- Name: kullanici_ilerleme kullanici_ilerleme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici_ilerleme
    ADD CONSTRAINT kullanici_ilerleme_pkey PRIMARY KEY (id);


--
-- TOC entry 4760 (class 2606 OID 24606)
-- Name: prompt_kullanim prompt_kullanim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prompt_kullanim
    ADD CONSTRAINT prompt_kullanim_pkey PRIMARY KEY (id);


--
-- TOC entry 4762 (class 2606 OID 24632)
-- Name: users tablosu users tablosu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."users tablosu"
    ADD CONSTRAINT "users tablosu_pkey" PRIMARY KEY (id);


-- Completed on 2025-07-15 11:22:42

--
-- PostgreSQL database dump complete
--

