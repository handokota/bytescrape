--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.2

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
-- Name: instagram; Type: SCHEMA; Schema: -; Owner: avnadmin
--

CREATE SCHEMA instagram;


ALTER SCHEMA instagram OWNER TO avnadmin;

--
-- Name: twitter; Type: SCHEMA; Schema: -; Owner: avnadmin
--

CREATE SCHEMA twitter;


ALTER SCHEMA twitter OWNER TO avnadmin;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_history_login_private; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.account_history_login_private (
    ah_lp_id integer NOT NULL,
    user_id integer,
    "timestamp" timestamp with time zone,
    ip_address character varying(50)
);


ALTER TABLE instagram.account_history_login_private OWNER TO avnadmin;

--
-- Name: account_history_login_private_ah_lp_id_seq; Type: SEQUENCE; Schema: instagram; Owner: avnadmin
--

CREATE SEQUENCE instagram.account_history_login_private_ah_lp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE instagram.account_history_login_private_ah_lp_id_seq OWNER TO avnadmin;

--
-- Name: account_history_login_private_ah_lp_id_seq; Type: SEQUENCE OWNED BY; Schema: instagram; Owner: avnadmin
--

ALTER SEQUENCE instagram.account_history_login_private_ah_lp_id_seq OWNED BY instagram.account_history_login_private.ah_lp_id;


--
-- Name: followers_private; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.followers_private (
    fs_id integer NOT NULL,
    user_id integer,
    user_name character varying(30),
    user_link character varying(255)
);


ALTER TABLE instagram.followers_private OWNER TO avnadmin;

--
-- Name: followers_private_fs_id_seq; Type: SEQUENCE; Schema: instagram; Owner: avnadmin
--

CREATE SEQUENCE instagram.followers_private_fs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE instagram.followers_private_fs_id_seq OWNER TO avnadmin;

--
-- Name: followers_private_fs_id_seq; Type: SEQUENCE OWNED BY; Schema: instagram; Owner: avnadmin
--

ALTER SEQUENCE instagram.followers_private_fs_id_seq OWNED BY instagram.followers_private.fs_id;


--
-- Name: following_private; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.following_private (
    fg_id integer NOT NULL,
    user_id integer,
    user_name character varying(30),
    user_link character varying(255)
);


ALTER TABLE instagram.following_private OWNER TO avnadmin;

--
-- Name: following_private_fg_id_seq; Type: SEQUENCE; Schema: instagram; Owner: avnadmin
--

CREATE SEQUENCE instagram.following_private_fg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE instagram.following_private_fg_id_seq OWNER TO avnadmin;

--
-- Name: following_private_fg_id_seq; Type: SEQUENCE OWNED BY; Schema: instagram; Owner: avnadmin
--

ALTER SEQUENCE instagram.following_private_fg_id_seq OWNED BY instagram.following_private.fg_id;


--
-- Name: hashtags; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.hashtags (
    hashtag_id integer NOT NULL,
    hashtag character varying(15)
);


ALTER TABLE instagram.hashtags OWNER TO avnadmin;

--
-- Name: posts_private; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.posts_private (
    post_id integer NOT NULL,
    user_id integer,
    media_uri_1 character varying(255),
    media_uri_2 character varying(255),
    "timestamp" timestamp with time zone,
    caption character varying(255)
);


ALTER TABLE instagram.posts_private OWNER TO avnadmin;

--
-- Name: user_private; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.user_private (
    user_id integer NOT NULL,
    user_name character varying(30),
    name character varying(50),
    followers integer,
    following integer,
    biography character varying(150),
    profile_pic_uri character varying,
    location character varying(255),
    created_at timestamp with time zone,
    user_creation_ip character varying(50),
    email character varying(255),
    phone_number character varying(50),
    birth_date timestamp with time zone,
    gender character varying(15)
);


ALTER TABLE instagram.user_private OWNER TO avnadmin;

--
-- Name: instagram_private; Type: VIEW; Schema: instagram; Owner: avnadmin
--

CREATE VIEW instagram.instagram_private AS
 SELECT up.user_id,
    up.user_name,
    up.name,
    up.followers,
    up.following,
    up.biography,
    up.profile_pic_uri,
    up.phone_number,
    up.user_creation_ip,
    up.email,
    up.birth_date,
    up.gender,
    up.location,
    up.created_at AS user_created_at,
    pospr.post_id,
    pospr.media_uri_1,
    pospr.media_uri_2,
    pospr.caption,
    pospr."timestamp" AS timestamp_private
   FROM (instagram.posts_private pospr
     JOIN instagram.user_private up ON ((pospr.user_id = up.user_id)));


ALTER VIEW instagram.instagram_private OWNER TO avnadmin;

--
-- Name: post_hashtag; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.post_hashtag (
    ph_id integer NOT NULL,
    post_id integer,
    hashtag_id integer
);


ALTER TABLE instagram.post_hashtag OWNER TO avnadmin;

--
-- Name: post_sentiment; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.post_sentiment (
    ps_id integer NOT NULL,
    post_id integer,
    sentiment_analysis character varying(50)
);


ALTER TABLE instagram.post_sentiment OWNER TO avnadmin;

--
-- Name: post_type; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.post_type (
    pt_id integer NOT NULL,
    post_id integer,
    content_type character varying(50)
);


ALTER TABLE instagram.post_type OWNER TO avnadmin;

--
-- Name: posts; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.posts (
    post_id integer NOT NULL,
    user_id integer,
    post_url character varying(255),
    "timestamp" timestamp with time zone,
    caption character varying(2200),
    comments_count integer,
    likes_count integer
);


ALTER TABLE instagram.posts OWNER TO avnadmin;

--
-- Name: users; Type: TABLE; Schema: instagram; Owner: avnadmin
--

CREATE TABLE instagram.users (
    user_id integer NOT NULL,
    user_name character varying(30),
    id bigint,
    name character varying(50),
    followers integer,
    following integer,
    biography character varying(150),
    profile_picture character varying
);


ALTER TABLE instagram.users OWNER TO avnadmin;

--
-- Name: instagram_public; Type: VIEW; Schema: instagram; Owner: avnadmin
--

CREATE VIEW instagram.instagram_public AS
 SELECT u.user_id,
    u.id,
    u.user_name,
    u.name,
    u.followers,
    u.following,
    u.biography,
    u.profile_picture,
    pos.post_id,
    pos.post_url,
    pos.caption,
    pos.likes_count,
    pos.comments_count,
    ps.ps_id AS sentiment_analysis_id,
    ps.sentiment_analysis,
    poshg.hashtag_id,
    hg.hashtag,
    posty.pt_id AS content_type_id,
    posty.content_type,
    pos."timestamp" AS timestamp_public
   FROM (((((instagram.posts pos
     JOIN instagram.users u ON ((pos.user_id = u.user_id)))
     JOIN instagram.post_sentiment ps ON ((ps.post_id = pos.post_id)))
     JOIN instagram.post_hashtag poshg ON ((poshg.post_id = pos.post_id)))
     JOIN instagram.hashtags hg ON ((hg.hashtag_id = poshg.hashtag_id)))
     JOIN instagram.post_type posty ON ((posty.post_id = pos.post_id)));


ALTER VIEW instagram.instagram_public OWNER TO avnadmin;

--
-- Name: followers_private; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.followers_private (
    fs_id integer NOT NULL,
    user_id integer,
    id bigint,
    user_link character varying(255)
);


ALTER TABLE twitter.followers_private OWNER TO avnadmin;

--
-- Name: followers_private_fs_id_seq; Type: SEQUENCE; Schema: twitter; Owner: avnadmin
--

CREATE SEQUENCE twitter.followers_private_fs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE twitter.followers_private_fs_id_seq OWNER TO avnadmin;

--
-- Name: followers_private_fs_id_seq; Type: SEQUENCE OWNED BY; Schema: twitter; Owner: avnadmin
--

ALTER SEQUENCE twitter.followers_private_fs_id_seq OWNED BY twitter.followers_private.fs_id;


--
-- Name: following_private; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.following_private (
    fg_id integer NOT NULL,
    user_id integer,
    id bigint,
    user_link character varying(255)
);


ALTER TABLE twitter.following_private OWNER TO avnadmin;

--
-- Name: following_private_fg_id_seq; Type: SEQUENCE; Schema: twitter; Owner: avnadmin
--

CREATE SEQUENCE twitter.following_private_fg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE twitter.following_private_fg_id_seq OWNER TO avnadmin;

--
-- Name: following_private_fg_id_seq; Type: SEQUENCE OWNED BY; Schema: twitter; Owner: avnadmin
--

ALTER SEQUENCE twitter.following_private_fg_id_seq OWNED BY twitter.following_private.fg_id;


--
-- Name: ip_audit_private; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.ip_audit_private (
    ip_ap_id integer NOT NULL,
    user_id integer,
    created_at timestamp with time zone,
    login_ip character varying(50)
);


ALTER TABLE twitter.ip_audit_private OWNER TO avnadmin;

--
-- Name: ip_audit_private_ip_ap_id_seq; Type: SEQUENCE; Schema: twitter; Owner: avnadmin
--

CREATE SEQUENCE twitter.ip_audit_private_ip_ap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE twitter.ip_audit_private_ip_ap_id_seq OWNER TO avnadmin;

--
-- Name: ip_audit_private_ip_ap_id_seq; Type: SEQUENCE OWNED BY; Schema: twitter; Owner: avnadmin
--

ALTER SEQUENCE twitter.ip_audit_private_ip_ap_id_seq OWNED BY twitter.ip_audit_private.ip_ap_id;


--
-- Name: keywords; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.keywords (
    keyword_id integer NOT NULL,
    keyword character varying(15)
);


ALTER TABLE twitter.keywords OWNER TO avnadmin;

--
-- Name: tweet_keyword; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.tweet_keyword (
    tk_id integer NOT NULL,
    tweet_id integer,
    keyword_id integer
);


ALTER TABLE twitter.tweet_keyword OWNER TO avnadmin;

--
-- Name: tweet_sentiment; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.tweet_sentiment (
    ts_id integer NOT NULL,
    tweet_id integer,
    sentiment_analysis character varying(50)
);


ALTER TABLE twitter.tweet_sentiment OWNER TO avnadmin;

--
-- Name: tweet_type; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.tweet_type (
    tt_id integer NOT NULL,
    tweet_id integer,
    content_type character varying(50)
);


ALTER TABLE twitter.tweet_type OWNER TO avnadmin;

--
-- Name: tweets; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.tweets (
    tweet_id integer NOT NULL,
    user_id integer,
    twitter_url character varying(255),
    entry_id bigint,
    created_at timestamp with time zone,
    full_text character varying,
    media_url character varying(255),
    retweet_count integer,
    reply_count integer,
    like_count integer,
    quote_count integer
);


ALTER TABLE twitter.tweets OWNER TO avnadmin;

--
-- Name: tweets_private; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.tweets_private (
    tweet_id integer NOT NULL,
    user_id integer,
    twitter_url character varying(255),
    entry_id bigint,
    created_at timestamp with time zone,
    full_text character varying(255),
    media_url character varying(255),
    retweet_count integer,
    like_count integer
);


ALTER TABLE twitter.tweets_private OWNER TO avnadmin;

--
-- Name: user_private; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.user_private (
    user_id integer NOT NULL,
    user_name character varying(15),
    id bigint,
    name character varying(50),
    followers integer,
    following integer,
    description character varying(200),
    profile_picture character varying(255),
    cover_picture character varying(255),
    location character varying(255),
    created_at timestamp with time zone,
    timezone character varying(15),
    user_creation_ip character varying(50),
    email character varying(255),
    phone_number character varying(50),
    birth_date timestamp with time zone
);


ALTER TABLE twitter.user_private OWNER TO avnadmin;

--
-- Name: twitter_private; Type: VIEW; Schema: twitter; Owner: avnadmin
--

CREATE VIEW twitter.twitter_private AS
 SELECT up.user_id,
    up.id,
    up.name,
    up.user_name,
    up.followers,
    up.following,
    up.description,
    up.profile_picture,
    up.cover_picture,
    up.location,
    up.timezone,
    up.email,
    up.phone_number,
    up.birth_date,
    up.user_creation_ip,
    up.created_at AS user_created_at,
    tp.entry_id,
    tp.twitter_url,
    tp.full_text,
    tp.media_url,
    tp.retweet_count,
    tp.like_count,
    tp.created_at AS tweet_created_at
   FROM (twitter.tweets_private tp
     JOIN twitter.user_private up ON ((up.user_id = tp.user_id)));


ALTER VIEW twitter.twitter_private OWNER TO avnadmin;

--
-- Name: users; Type: TABLE; Schema: twitter; Owner: avnadmin
--

CREATE TABLE twitter.users (
    user_id integer NOT NULL,
    user_name character varying(15),
    id bigint,
    name character varying(50),
    followers integer,
    following integer,
    description character varying(200),
    profile_picture character varying(255),
    cover_picture character varying(255),
    location character varying(255),
    created_at timestamp with time zone
);


ALTER TABLE twitter.users OWNER TO avnadmin;

--
-- Name: twitter_public; Type: VIEW; Schema: twitter; Owner: avnadmin
--

CREATE VIEW twitter.twitter_public AS
 SELECT u.user_id,
    u.id,
    u.name,
    u.user_name,
    u.followers,
    u.following,
    u.description,
    u.profile_picture,
    u.cover_picture,
    u.location,
    u.created_at AS user_created_at,
    t.entry_id,
    t.twitter_url,
    t.full_text,
    t.media_url,
    k.keyword,
    ts.ts_id AS sentiment_analysis_id,
    ts.sentiment_analysis,
    tt.tt_id AS content_type_id,
    tt.content_type,
    t.retweet_count,
    t.reply_count,
    t.like_count,
    t.quote_count,
    t.created_at AS tweet_created_at
   FROM (((((twitter.tweets t
     JOIN twitter.tweet_keyword tk ON ((tk.tweet_id = t.tweet_id)))
     JOIN twitter.keywords k ON ((k.keyword_id = tk.keyword_id)))
     JOIN twitter.tweet_sentiment ts ON ((ts.tweet_id = t.tweet_id)))
     JOIN twitter.tweet_type tt ON ((tt.tweet_id = t.tweet_id)))
     JOIN twitter.users u ON ((u.user_id = t.user_id)));


ALTER VIEW twitter.twitter_public OWNER TO avnadmin;

--
-- Name: account_history_login_private ah_lp_id; Type: DEFAULT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.account_history_login_private ALTER COLUMN ah_lp_id SET DEFAULT nextval('instagram.account_history_login_private_ah_lp_id_seq'::regclass);


--
-- Name: followers_private fs_id; Type: DEFAULT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.followers_private ALTER COLUMN fs_id SET DEFAULT nextval('instagram.followers_private_fs_id_seq'::regclass);


--
-- Name: following_private fg_id; Type: DEFAULT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.following_private ALTER COLUMN fg_id SET DEFAULT nextval('instagram.following_private_fg_id_seq'::regclass);


--
-- Name: followers_private fs_id; Type: DEFAULT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.followers_private ALTER COLUMN fs_id SET DEFAULT nextval('twitter.followers_private_fs_id_seq'::regclass);


--
-- Name: following_private fg_id; Type: DEFAULT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.following_private ALTER COLUMN fg_id SET DEFAULT nextval('twitter.following_private_fg_id_seq'::regclass);


--
-- Name: ip_audit_private ip_ap_id; Type: DEFAULT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.ip_audit_private ALTER COLUMN ip_ap_id SET DEFAULT nextval('twitter.ip_audit_private_ip_ap_id_seq'::regclass);


--
-- Data for Name: account_history_login_private; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.account_history_login_private (ah_lp_id, user_id, "timestamp", ip_address) FROM stdin;
1	1001	2024-05-15 13:48:37+00	182.253.158.38
2	1001	2024-04-23 07:05:25+00	182.253.158.44
3	1001	2024-01-03 11:15:03+00	103.195.59.133
4	1001	2024-01-03 10:35:44+00	103.195.59.133
5	1001	2024-01-03 10:33:00+00	103.195.59.133
6	1001	2024-01-03 10:21:43+00	103.195.59.133
7	1001	2023-11-24 20:40:57+00	103.195.59.6
8	1001	2023-10-26 02:41:20+00	103.195.59.65
9	1001	2023-10-22 14:22:29+00	113.11.176.40
10	1001	2023-09-28 07:11:52+00	182.253.158.230
11	1001	2023-08-16 22:11:47+00	103.144.170.160
12	1001	2023-08-16 07:11:37+00	103.144.170.157
13	1001	2023-08-14 13:39:48+00	103.144.170.182
14	1001	2023-07-28 06:13:22+00	182.253.159.179
15	1001	2023-07-24 12:56:30+00	182.253.136.214
16	1001	2023-07-06 05:37:47+00	182.253.159.237
17	1001	2023-07-06 05:37:10+00	182.253.159.237
18	1001	2023-06-30 11:51:39+00	182.253.159.237
19	1001	2022-12-26 13:12:07+00	103.194.175.22
20	1001	2022-12-26 02:53:27+00	103.194.175.22
21	1001	2022-11-05 00:51:52+00	103.233.100.232
22	1001	2022-10-14 02:31:28+00	103.233.100.228
23	1001	2022-10-09 04:47:36+00	103.194.173.134
24	1001	2022-09-23 01:23:16+00	103.194.175.70
25	1001	2022-09-13 19:55:54+00	103.194.175.22
26	1001	2022-09-01 14:07:27+00	114.122.106.69
27	1001	2022-08-13 16:20:17+00	182.1.92.117
28	1001	2022-08-08 07:06:42+00	182.1.122.29
29	1001	2022-08-06 14:35:08+00	182.1.68.49
30	1001	2022-08-03 16:45:47+00	182.1.72.123
31	1001	2022-07-21 13:15:01+00	114.122.105.242
32	1001	2022-07-07 11:01:28+00	103.194.173.70
33	1001	2022-06-01 05:55:57+00	103.194.173.70
34	1001	2022-06-01 05:45:16+00	103.194.173.70
35	1001	2022-06-01 05:37:39+00	103.194.173.70
36	1001	2022-05-31 09:21:45+00	103.194.173.70
37	1001	2022-05-31 09:16:32+00	103.194.173.70
38	1001	2022-05-31 09:09:03+00	103.194.173.70
39	1001	2022-05-02 01:32:36+00	182.2.73.79
40	1001	2022-04-16 15:53:13+00	103.194.175.22
41	1001	2022-03-29 05:43:35+00	103.194.175.22
42	1001	2022-02-21 07:59:51+00	114.122.74.187
43	1001	2022-02-16 10:11:25+00	103.194.172.70
44	1001	2022-02-16 10:08:19+00	103.194.172.70
45	1001	2022-02-16 10:03:03+00	103.194.172.70
46	1001	2022-02-13 16:01:07+00	103.194.172.70
47	1001	2022-02-08 14:48:17+00	124.158.181.98
48	1001	2022-02-05 23:29:01+00	124.158.181.98
49	1001	2022-01-30 15:26:26+00	182.2.135.167
50	1001	2022-01-13 15:26:02+00	182.1.114.79
51	1001	2022-01-12 16:10:28+00	182.1.70.9
52	1001	2022-01-07 15:48:42+00	182.1.111.253
53	1001	2021-12-17 01:18:54+00	182.1.126.139
54	1001	2021-12-09 17:02:25+00	114.125.76.232
55	1001	2021-12-09 16:58:58+00	114.125.76.232
56	1001	2021-12-09 16:54:00+00	114.125.76.232
57	1001	2021-12-06 14:31:34+00	182.1.75.160
58	1001	2021-12-02 11:23:17+00	182.1.86.182
59	1001	2021-11-17 13:02:22+00	182.1.124.5
60	1001	2021-11-11 16:43:00+00	114.125.77.205
61	1001	2021-09-29 15:37:07+00	182.1.127.202
62	1001	2021-09-28 16:16:43+00	182.1.105.30
63	1001	2021-04-07 10:19:45+00	114.125.94.237
64	1001	2021-03-30 14:38:55+00	114.124.209.201
65	1001	2021-02-22 01:42:23+00	114.124.213.200
66	1001	2021-01-31 14:58:08+00	114.124.136.255
67	1001	2021-01-31 12:14:59+00	114.124.167.111
68	1001	2021-01-31 08:16:24+00	114.124.167.111
69	1001	2021-01-20 15:18:41+00	114.124.181.212
70	1001	2021-01-20 14:59:25+00	114.124.181.212
71	1001	2021-01-20 14:16:37+00	114.124.181.212
72	1001	2021-01-20 13:56:46+00	114.124.181.212
73	1001	2021-01-18 09:26:36+00	114.124.172.116
74	1001	2021-01-14 14:26:10+00	114.124.142.229
75	1001	2021-01-09 03:22:57+00	114.124.151.190
76	1001	2021-01-08 13:42:03+00	114.124.166.31
77	1001	2021-01-08 13:40:35+00	114.124.166.31
78	1001	2020-12-17 12:31:05+00	114.124.235.63
79	1001	2020-12-13 02:38:32+00	114.124.202.76
80	1001	2020-12-13 01:02:05+00	114.124.207.109
81	1001	2020-12-01 08:33:34+00	114.124.197.4
82	1001	2020-10-30 12:26:21+00	182.2.69.194
83	1001	2020-10-29 13:45:18+00	182.2.73.222
84	1001	2020-10-24 04:52:48+00	114.124.174.45
85	1001	2020-10-24 04:51:18+00	182.1.71.126
86	1001	2020-10-07 04:06:23+00	114.125.92.87
87	1001	2020-09-28 16:46:10+00	114.125.118.59
88	1001	2020-09-18 02:26:13+00	182.1.98.115
89	1001	2020-09-11 16:26:02+00	182.1.126.119
90	1001	2020-09-02 12:40:01+00	114.124.214.73
91	1001	2020-08-10 16:36:48+00	114.124.130.34
92	1001	2020-08-02 17:41:07+00	114.124.133.11
93	1001	2020-05-27 09:52:15+00	103.28.74.20
94	1001	2020-05-27 09:44:44+00	103.28.74.20
95	1001	2020-05-17 09:07:08+00	103.227.254.59
96	1001	2020-05-10 12:26:00+00	139.180.212.107
97	1001	2020-05-10 11:53:44+00	139.180.212.107
98	1001	2020-05-10 11:40:40+00	139.180.212.107
99	1001	2020-05-10 11:37:50+00	139.180.212.107
100	1001	2020-05-09 06:21:36+00	103.227.254.55
101	1001	2020-02-07 10:04:16+00	114.124.204.24
102	1001	2020-01-01 14:36:40+00	114.79.47.230
103	1001	2019-12-29 16:12:16+00	182.1.117.115
104	1001	2019-12-26 04:19:10+00	114.79.46.120
105	1001	2019-11-12 09:54:55+00	182.1.91.136
106	1001	2019-10-25 13:46:27+00	182.1.90.53
107	1001	2019-06-08 17:09:07+00	182.1.122.63
108	1001	2019-05-22 14:11:48+00	108.59.1.204
109	1001	2018-10-15 11:22:51+00	182.0.199.218
110	1001	2018-07-25 05:57:17+00	182.0.208.254
111	1001	2018-07-25 05:56:56+00	182.0.208.254
112	1001	2018-07-25 05:56:31+00	182.0.208.254
113	1001	2018-05-17 18:39:47+00	114.124.211.215
114	1001	2018-05-17 16:10:01+00	182.0.229.65
115	1001	2018-05-10 09:59:43+00	182.0.164.5
116	1001	2018-05-09 04:54:27+00	114.124.144.91
117	1001	2018-05-09 04:48:21+00	114.124.144.91
118	1001	2018-05-09 04:19:57+00	114.124.150.107
119	1001	2018-05-09 04:09:28+00	114.124.134.123
120	1001	2017-10-29 13:37:08+00	114.124.175.222
121	1001	2017-10-29 13:24:21+00	114.124.167.101
122	1001	2017-10-29 13:20:01+00	114.124.180.197
123	1001	2017-09-05 08:36:32+00	114.124.144.160
124	1001	2017-09-05 08:36:24+00	114.124.144.160
125	1001	2017-07-20 23:41:43+00	114.124.201.116
\.


--
-- Data for Name: followers_private; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.followers_private (fs_id, user_id, user_name, user_link) FROM stdin;
1	1001	ke_yla1123	https://www.instagram.com/ke_yla1123
2	1001	ynapadux	https://www.instagram.com/ynapadux
3	1001	salskypiea	https://www.instagram.com/salskypiea
4	1001	nazwaanila	https://www.instagram.com/nazwaanila
5	1001	yannriani	https://www.instagram.com/yannriani
6	1001	fadhillahapriliyani	https://www.instagram.com/fadhillahapriliyani
7	1001	adrnadpr	https://www.instagram.com/adrnadpr
8	1001	rahmalyy__	https://www.instagram.com/rahmalyy__
9	1001	willyocton	https://www.instagram.com/willyocton
10	1001	j.jr257	https://www.instagram.com/j.jr257
11	1001	ra.studio___	https://www.instagram.com/ra.studio___
12	1001	anak.telyu	https://www.instagram.com/anak.telyu
13	1001	yogiputra33	https://www.instagram.com/yogiputra33
14	1001	ferdiyusuf_10	https://www.instagram.com/ferdiyusuf_10
15	1001	gibbor_28	https://www.instagram.com/gibbor_28
16	1001	urlove.ws	https://www.instagram.com/urlove.ws
17	1001	anitarhmlia	https://www.instagram.com/anitarhmlia
18	1001	heylla.urent	https://www.instagram.com/heylla.urent
19	1001	dedesetiawan29	https://www.instagram.com/dedesetiawan29
20	1001	dindayysf	https://www.instagram.com/dindayysf
21	1001	diianms	https://www.instagram.com/diianms
22	1001	rhnathala	https://www.instagram.com/rhnathala
23	1001	aldito_wahyu06	https://www.instagram.com/aldito_wahyu06
24	1001	aliyanuraini94	https://www.instagram.com/aliyanuraini94
25	1001	podomoroparkbandung_info	https://www.instagram.com/podomoroparkbandung_info
26	1001	raymonddiks2	https://www.instagram.com/raymonddiks2
27	1001	putrierrsy	https://www.instagram.com/putrierrsy
28	1001	kikiyaaaki	https://www.instagram.com/kikiyaaaki
29	1001	deborantlyaa	https://www.instagram.com/deborantlyaa
30	1001	ferdiansyusuff_	https://www.instagram.com/ferdiansyusuff_
31	1001	shidqify	https://www.instagram.com/shidqify
32	1001	felixtpsrb	https://www.instagram.com/felixtpsrb
33	1001	geniza_ghilda	https://www.instagram.com/geniza_ghilda
34	1001	sun_vy_02	https://www.instagram.com/sun_vy_02
35	1001	mfx.da	https://www.instagram.com/mfx.da
36	1001	yuaiu_	https://www.instagram.com/yuaiu_
37	1001	faizalaer	https://www.instagram.com/faizalaer
38	1001	_aris.afriyanto	https://www.instagram.com/_aris.afriyanto
39	1001	kinantyadeh	https://www.instagram.com/kinantyadeh
40	1001	ataca_ana	https://www.instagram.com/ataca_ana
41	1001	farhan15r	https://www.instagram.com/farhan15r
42	1001	amaliaaanh_	https://www.instagram.com/amaliaaanh_
43	1001	elangpermana_	https://www.instagram.com/elangpermana_
44	1001	upiyxjt_	https://www.instagram.com/upiyxjt_
45	1001	refkisyakii	https://www.instagram.com/refkisyakii
46	1001	nanelss_	https://www.instagram.com/nanelss_
47	1001	leonardhorante_08	https://www.instagram.com/leonardhorante_08
48	1001	diskeyyyy	https://www.instagram.com/diskeyyyy
49	1001	x_stwn29	https://www.instagram.com/x_stwn29
50	1001	deuskaaa	https://www.instagram.com/deuskaaa
51	1001	nisa_ech	https://www.instagram.com/nisa_ech
52	1001	ek_siw	https://www.instagram.com/ek_siw
53	1001	nnisaervff	https://www.instagram.com/nnisaervff
54	1001	devidfrnkln	https://www.instagram.com/devidfrnkln
55	1001	rendyyfiliang	https://www.instagram.com/rendyyfiliang
56	1001	arkhanfzn	https://www.instagram.com/arkhanfzn
57	1001	reyhanpanja.13	https://www.instagram.com/reyhanpanja.13
58	1001	s.nabilas	https://www.instagram.com/s.nabilas
59	1001	vanicaprillia	https://www.instagram.com/vanicaprillia
60	1001	andreassuranta	https://www.instagram.com/andreassuranta
61	1001	sa.maharanip	https://www.instagram.com/sa.maharanip
62	1001	unlogicalhuman	https://www.instagram.com/unlogicalhuman
63	1001	alxndrdista	https://www.instagram.com/alxndrdista
64	1001	iiichaaaaa._	https://www.instagram.com/iiichaaaaa._
65	1001	bchfrlpov	https://www.instagram.com/bchfrlpov
66	1001	dimaswnugrh	https://www.instagram.com/dimaswnugrh
67	1001	dindaamirap	https://www.instagram.com/dindaamirap
68	1001	fitrimuslim11_	https://www.instagram.com/fitrimuslim11_
69	1001	derryl.r	https://www.instagram.com/derryl.r
70	1001	1peace__	https://www.instagram.com/1peace__
71	1001	rashidag_	https://www.instagram.com/rashidag_
72	1001	alifiaayndn	https://www.instagram.com/alifiaayndn
73	1001	grainrfi__	https://www.instagram.com/grainrfi__
74	1001	lugipratama17	https://www.instagram.com/lugipratama17
75	1001	tantrisepp1994	https://www.instagram.com/tantrisepp1994
76	1001	arllnaa	https://www.instagram.com/arllnaa
77	1001	iminsecret_	https://www.instagram.com/iminsecret_
78	1001	ri_dho_o	https://www.instagram.com/ri_dho_o
79	1001	virafynr	https://www.instagram.com/virafynr
80	1001	avicenavn	https://www.instagram.com/avicenavn
81	1001	gitamileniap	https://www.instagram.com/gitamileniap
82	1001	ikhbalst_	https://www.instagram.com/ikhbalst_
83	1001	evasyffra	https://www.instagram.com/evasyffra
84	1001	ikhdactsa	https://www.instagram.com/ikhdactsa
85	1001	gitaakk__	https://www.instagram.com/gitaakk__
86	1001	yusenkkk	https://www.instagram.com/yusenkkk
87	1001	waahyuj	https://www.instagram.com/waahyuj
88	1001	ridzkachitra_	https://www.instagram.com/ridzkachitra_
89	1001	jauharri_	https://www.instagram.com/jauharri_
90	1001	gassryd	https://www.instagram.com/gassryd
91	1001	avfsdy	https://www.instagram.com/avfsdy
92	1001	arzaqiadmaa	https://www.instagram.com/arzaqiadmaa
93	1001	mhaikalls	https://www.instagram.com/mhaikalls
94	1001	rif_faqih	https://www.instagram.com/rif_faqih
95	1001	rafli.putra	https://www.instagram.com/rafli.putra
96	1001	rohmahnur__	https://www.instagram.com/rohmahnur__
97	1001	rayhanmuhammad02	https://www.instagram.com/rayhanmuhammad02
98	1001	lutfihdytt_	https://www.instagram.com/lutfihdytt_
99	1001	jessica_rhmn	https://www.instagram.com/jessica_rhmn
100	1001	dewiilmir	https://www.instagram.com/dewiilmir
101	1001	adeelyana	https://www.instagram.com/adeelyana
102	1001	d.ndraa	https://www.instagram.com/d.ndraa
103	1001	regitap__	https://www.instagram.com/regitap__
104	1001	ghari_synz	https://www.instagram.com/ghari_synz
105	1001	rizmauls_	https://www.instagram.com/rizmauls_
106	1001	__mayangp	https://www.instagram.com/__mayangp
107	1001	hawa.ihsani	https://www.instagram.com/hawa.ihsani
108	1001	xcobiii	https://www.instagram.com/xcobiii
109	1001	bulan.ayu_	https://www.instagram.com/bulan.ayu_
110	1001	khoirulazkiya_	https://www.instagram.com/khoirulazkiya_
111	1001	fyan_syach	https://www.instagram.com/fyan_syach
112	1001	afif_frcn16	https://www.instagram.com/afif_frcn16
113	1001	wanisaaasw_	https://www.instagram.com/wanisaaasw_
114	1001	argapalaska	https://www.instagram.com/argapalaska
115	1001	pram_ps	https://www.instagram.com/pram_ps
116	1001	fahryyw	https://www.instagram.com/fahryyw
117	1001	maghrizal_putra	https://www.instagram.com/maghrizal_putra
118	1001	andrewdarmaa	https://www.instagram.com/andrewdarmaa
119	1001	zrraraxyy._	https://www.instagram.com/zrraraxyy._
120	1001	jeksilaen	https://www.instagram.com/jeksilaen
121	1001	farizqiiaditya	https://www.instagram.com/farizqiiaditya
122	1001	laniinbbn__	https://www.instagram.com/laniinbbn__
123	1001	riko_rumengan	https://www.instagram.com/riko_rumengan
124	1001	stelamarissk	https://www.instagram.com/stelamarissk
125	1001	saeyaz.baghiz	https://www.instagram.com/saeyaz.baghiz
126	1001	andez_hd	https://www.instagram.com/andez_hd
127	1001	anggachristians	https://www.instagram.com/anggachristians
128	1001	devinatts	https://www.instagram.com/devinatts
129	1001	alifahmad.14	https://www.instagram.com/alifahmad.14
130	1001	yasmiinaurra	https://www.instagram.com/yasmiinaurra
131	1001	nicknatha	https://www.instagram.com/nicknatha
132	1001	darissalamfauzi	https://www.instagram.com/darissalamfauzi
133	1001	okaadabi	https://www.instagram.com/okaadabi
134	1001	venuslidzikri	https://www.instagram.com/venuslidzikri
135	1001	ridhnfirdaus	https://www.instagram.com/ridhnfirdaus
136	1001	rasyid.ridho	https://www.instagram.com/rasyid.ridho
137	1001	mnfaal_	https://www.instagram.com/mnfaal_
138	1001	reniwynt._	https://www.instagram.com/reniwynt._
139	1001	hafizhjhr	https://www.instagram.com/hafizhjhr
140	1001	rahadiarkaa	https://www.instagram.com/rahadiarkaa
141	1001	muhhanif667	https://www.instagram.com/muhhanif667
142	1001	bagirr_	https://www.instagram.com/bagirr_
143	1001	iizennnn	https://www.instagram.com/iizennnn
144	1001	nnilarl	https://www.instagram.com/nnilarl
145	1001	hanifjatmiko_	https://www.instagram.com/hanifjatmiko_
146	1001	aksan_oss	https://www.instagram.com/aksan_oss
147	1001	_azizm15	https://www.instagram.com/_azizm15
148	1001	septiaaditia	https://www.instagram.com/septiaaditia
149	1001	dotsqwerty	https://www.instagram.com/dotsqwerty
150	1001	icaalh_	https://www.instagram.com/icaalh_
151	1001	gifariilhm	https://www.instagram.com/gifariilhm
152	1001	faizahnnn	https://www.instagram.com/faizahnnn
153	1001	fakhriias	https://www.instagram.com/fakhriias
154	1001	syhreza_satria	https://www.instagram.com/syhreza_satria
155	1001	paglaks	https://www.instagram.com/paglaks
156	1001	rakiindwikii	https://www.instagram.com/rakiindwikii
157	1001	rezareynalditarigan	https://www.instagram.com/rezareynalditarigan
158	1001	a.zsyip_	https://www.instagram.com/a.zsyip_
159	1001	marchristiness	https://www.instagram.com/marchristiness
160	1001	irda_rsft_	https://www.instagram.com/irda_rsft_
161	1001	fakhriharun_	https://www.instagram.com/fakhriharun_
162	1001	amalia.rizkif	https://www.instagram.com/amalia.rizkif
163	1001	miharufikriansyah	https://www.instagram.com/miharufikriansyah
164	1001	zraarsta	https://www.instagram.com/zraarsta
165	1001	agliskusuma	https://www.instagram.com/agliskusuma
166	1001	adiyatmapw	https://www.instagram.com/adiyatmapw
167	1001	vannkristian	https://www.instagram.com/vannkristian
168	1001	fhribahtiar	https://www.instagram.com/fhribahtiar
169	1001	awalrmdhaan	https://www.instagram.com/awalrmdhaan
170	1001	theoarevan	https://www.instagram.com/theoarevan
171	1001	alisyayolandaa	https://www.instagram.com/alisyayolandaa
172	1001	putriiiic	https://www.instagram.com/putriiiic
173	1001	yulianpramesti	https://www.instagram.com/yulianpramesti
174	1001	cuthayfasyfiaa	https://www.instagram.com/cuthayfasyfiaa
175	1001	daffi.raka	https://www.instagram.com/daffi.raka
176	1001	k_toook	https://www.instagram.com/k_toook
177	1001	rezmulk_	https://www.instagram.com/rezmulk_
178	1001	elizaaryn	https://www.instagram.com/elizaaryn
179	1001	zalfa.r01	https://www.instagram.com/zalfa.r01
180	1001	anjargamekyu_	https://www.instagram.com/anjargamekyu_
181	1001	rrzta	https://www.instagram.com/rrzta
182	1001	idandenim	https://www.instagram.com/idandenim
183	1001	alghifrrr	https://www.instagram.com/alghifrrr
184	1001	izyslstyo	https://www.instagram.com/izyslstyo
185	1001	f.isdianto	https://www.instagram.com/f.isdianto
186	1001	raihaanrr	https://www.instagram.com/raihaanrr
187	1001	ajmal.yzd	https://www.instagram.com/ajmal.yzd
188	1001	romadhonafn	https://www.instagram.com/romadhonafn
189	1001	yoy_sptr	https://www.instagram.com/yoy_sptr
190	1001	kembali.esok	https://www.instagram.com/kembali.esok
191	1001	ardhii_art	https://www.instagram.com/ardhii_art
192	1001	priyaak___	https://www.instagram.com/priyaak___
193	1001	umam_syarief	https://www.instagram.com/umam_syarief
194	1001	stefanus_d	https://www.instagram.com/stefanus_d
195	1001	intansriayuni.17	https://www.instagram.com/intansriayuni.17
196	1001	tegartrisptro_al40	https://www.instagram.com/tegartrisptro_al40
197	1001	annisaervanifitrii	https://www.instagram.com/annisaervanifitrii
198	1001	ahmadimam__	https://www.instagram.com/ahmadimam__
199	1001	mukhlisamn	https://www.instagram.com/mukhlisamn
200	1001	hubert_igor	https://www.instagram.com/hubert_igor
201	1001	gregorio_alvito	https://www.instagram.com/gregorio_alvito
202	1001	avika.rzy	https://www.instagram.com/avika.rzy
203	1001	fajarbrlyn_	https://www.instagram.com/fajarbrlyn_
204	1001	habib.filahas	https://www.instagram.com/habib.filahas
205	1001	mryblng	https://www.instagram.com/mryblng
206	1001	arif.f_rachman	https://www.instagram.com/arif.f_rachman
207	1001	azmima_	https://www.instagram.com/azmima_
208	1001	odiiwoody	https://www.instagram.com/odiiwoody
209	1001	annisaas._	https://www.instagram.com/annisaas._
210	1001	nikennnambrr	https://www.instagram.com/nikennnambrr
211	1001	rizkygumelarr_	https://www.instagram.com/rizkygumelarr_
212	1001	elsaptryn	https://www.instagram.com/elsaptryn
213	1001	gusta.veno	https://www.instagram.com/gusta.veno
214	1001	dityailmir	https://www.instagram.com/dityailmir
215	1001	adityasyafamahendra	https://www.instagram.com/adityasyafamahendra
216	1001	chkps_	https://www.instagram.com/chkps_
217	1001	muh_rassya	https://www.instagram.com/muh_rassya
218	1001	fal_bagas	https://www.instagram.com/fal_bagas
219	1001	farasputraaa	https://www.instagram.com/farasputraaa
220	1001	noaldy_thio	https://www.instagram.com/noaldy_thio
221	1001	reinaldy.al_18	https://www.instagram.com/reinaldy.al_18
222	1001	kazarach	https://www.instagram.com/kazarach
223	1001	venus.mrngstar	https://www.instagram.com/venus.mrngstar
224	1001	taniakwee	https://www.instagram.com/taniakwee
225	1001	bima.ngr	https://www.instagram.com/bima.ngr
226	1001	jonathan_arya.w	https://www.instagram.com/jonathan_arya.w
227	1001	richieta_	https://www.instagram.com/richieta_
228	1001	alifiamutiaaa	https://www.instagram.com/alifiamutiaaa
229	1001	adrian.arman	https://www.instagram.com/adrian.arman
230	1001	kikyyykyrizzz	https://www.instagram.com/kikyyykyrizzz
231	1001	miyaatrg	https://www.instagram.com/miyaatrg
232	1001	nabila.rdyn	https://www.instagram.com/nabila.rdyn
233	1001	islahihyaa	https://www.instagram.com/islahihyaa
234	1001	ilhambakri._	https://www.instagram.com/ilhambakri._
235	1001	raihan_abim	https://www.instagram.com/raihan_abim
236	1001	_sylvialstr	https://www.instagram.com/_sylvialstr
237	1001	kid1ver	https://www.instagram.com/kid1ver
238	1001	daffa_satriarga	https://www.instagram.com/daffa_satriarga
239	1001	alfarobiii	https://www.instagram.com/alfarobiii
240	1001	dienqonitaa_	https://www.instagram.com/dienqonitaa_
241	1001	rhnnsp	https://www.instagram.com/rhnnsp
242	1001	retnofai_	https://www.instagram.com/retnofai_
243	1001	yusmasv	https://www.instagram.com/yusmasv
244	1001	rakamahendrraa	https://www.instagram.com/rakamahendrraa
245	1001	ign_aryaw	https://www.instagram.com/ign_aryaw
246	1001	soo.fii22	https://www.instagram.com/soo.fii22
247	1001	ellizapatt	https://www.instagram.com/ellizapatt
248	1001	nayakatalitha	https://www.instagram.com/nayakatalitha
249	1001	marissasyfn_	https://www.instagram.com/marissasyfn_
250	1001	haris_axl	https://www.instagram.com/haris_axl
251	1001	reihan_akmal	https://www.instagram.com/reihan_akmal
252	1001	nabilbull	https://www.instagram.com/nabilbull
253	1001	yafinh	https://www.instagram.com/yafinh
254	1001	aliffarrass_	https://www.instagram.com/aliffarrass_
255	1001	jidan.kh	https://www.instagram.com/jidan.kh
256	1001	ichsanalf_	https://www.instagram.com/ichsanalf_
257	1001	rikirenggana	https://www.instagram.com/rikirenggana
258	1001	fitriasalsabilaah	https://www.instagram.com/fitriasalsabilaah
259	1001	agustinvinda	https://www.instagram.com/agustinvinda
260	1001	lolyta_decoration_kebumen	https://www.instagram.com/lolyta_decoration_kebumen
261	1001	nasywaraudatul._	https://www.instagram.com/nasywaraudatul._
262	1001	andhika_puth	https://www.instagram.com/andhika_puth
263	1001	sitimukholifaah	https://www.instagram.com/sitimukholifaah
264	1001	arianinra	https://www.instagram.com/arianinra
265	1001	dani.n.anie	https://www.instagram.com/dani.n.anie
266	1001	dew.tl	https://www.instagram.com/dew.tl
267	1001	aziizhata_	https://www.instagram.com/aziizhata_
268	1001	nurulh1k_	https://www.instagram.com/nurulh1k_
269	1001	amaliasuciati_	https://www.instagram.com/amaliasuciati_
270	1001	imam_sult	https://www.instagram.com/imam_sult
271	1001	anggunmeliaaa	https://www.instagram.com/anggunmeliaaa
272	1001	tangabut_	https://www.instagram.com/tangabut_
273	1001	pildumps	https://www.instagram.com/pildumps
274	1001	dienqonitayuliana	https://www.instagram.com/dienqonitayuliana
275	1001	tessaerls	https://www.instagram.com/tessaerls
276	1001	sheina.js	https://www.instagram.com/sheina.js
277	1001	uli_hutagaol	https://www.instagram.com/uli_hutagaol
278	1001	belinda.linggi	https://www.instagram.com/belinda.linggi
279	1001	parabuayaa	https://www.instagram.com/parabuayaa
280	1001	rexaligra	https://www.instagram.com/rexaligra
281	1001	mdknu	https://www.instagram.com/mdknu
282	1001	sabilaadnn	https://www.instagram.com/sabilaadnn
283	1001	muhamadrizqiabdillah	https://www.instagram.com/muhamadrizqiabdillah
284	1001	royyanfauzi_	https://www.instagram.com/royyanfauzi_
285	1001	valentsatriaa	https://www.instagram.com/valentsatriaa
286	1001	xavierpilyai	https://www.instagram.com/xavierpilyai
287	1001	artalumbanrajaaa	https://www.instagram.com/artalumbanrajaaa
288	1001	rivellaramadhani	https://www.instagram.com/rivellaramadhani
289	1001	raihandanadyaksa	https://www.instagram.com/raihandanadyaksa
290	1001	vikkadwi_	https://www.instagram.com/vikkadwi_
291	1001	alfinaa.rm	https://www.instagram.com/alfinaa.rm
292	1001	adzfck	https://www.instagram.com/adzfck
293	1001	xenosians.exe	https://www.instagram.com/xenosians.exe
294	1001	shalsabilayr_03	https://www.instagram.com/shalsabilayr_03
295	1001	syafafahreza	https://www.instagram.com/syafafahreza
296	1001	zalf.aa	https://www.instagram.com/zalf.aa
297	1001	n.ggggge	https://www.instagram.com/n.ggggge
298	1001	apinn.al	https://www.instagram.com/apinn.al
299	1001	julskyli	https://www.instagram.com/julskyli
300	1001	aisyaahdliya	https://www.instagram.com/aisyaahdliya
301	1001	hanamnfth	https://www.instagram.com/hanamnfth
302	1001	ijal8163	https://www.instagram.com/ijal8163
303	1001	namakuciga	https://www.instagram.com/namakuciga
304	1001	dinaanm	https://www.instagram.com/dinaanm
305	1001	arrauft	https://www.instagram.com/arrauft
306	1001	aufaalst	https://www.instagram.com/aufaalst
307	1001	carlosrvb	https://www.instagram.com/carlosrvb
308	1001	fawwaz_zidan	https://www.instagram.com/fawwaz_zidan
309	1001	hafidh_fattah	https://www.instagram.com/hafidh_fattah
310	1001	salsa_zky	https://www.instagram.com/salsa_zky
311	1001	ttkwhyu	https://www.instagram.com/ttkwhyu
312	1001	rikreg_	https://www.instagram.com/rikreg_
313	1001	ratandi_ahmad	https://www.instagram.com/ratandi_ahmad
314	1001	darrelljohan	https://www.instagram.com/darrelljohan
315	1001	firmanade_17	https://www.instagram.com/firmanade_17
316	1001	fadhilib	https://www.instagram.com/fadhilib
317	1001	rahajengpp	https://www.instagram.com/rahajengpp
318	1001	wwanikmal	https://www.instagram.com/wwanikmal
319	1001	edghrdwjy	https://www.instagram.com/edghrdwjy
320	1001	arzznaa	https://www.instagram.com/arzznaa
321	1001	nsyylnny	https://www.instagram.com/nsyylnny
322	1001	hns_ar	https://www.instagram.com/hns_ar
323	1001	triananiaa	https://www.instagram.com/triananiaa
324	1001	kikikun_27	https://www.instagram.com/kikikun_27
325	1001	muhammadrafi__08	https://www.instagram.com/muhammadrafi__08
326	1001	avrilangelina_	https://www.instagram.com/avrilangelina_
327	1001	tiaferonica	https://www.instagram.com/tiaferonica
328	1001	afrlfrnd	https://www.instagram.com/afrlfrnd
329	1001	rizmaangr	https://www.instagram.com/rizmaangr
330	1001	farahfhrz	https://www.instagram.com/farahfhrz
331	1001	ayub.prtma	https://www.instagram.com/ayub.prtma
332	1001	tiaafrs_	https://www.instagram.com/tiaafrs_
333	1001	nggiittaa_	https://www.instagram.com/nggiittaa_
334	1001	nabilaazil	https://www.instagram.com/nabilaazil
335	1001	ekafb_	https://www.instagram.com/ekafb_
336	1001	diyahsafitrii_	https://www.instagram.com/diyahsafitrii_
337	1001	tegarpp_	https://www.instagram.com/tegarpp_
338	1001	mr.ferimanik_	https://www.instagram.com/mr.ferimanik_
339	1001	efhaaan	https://www.instagram.com/efhaaan
340	1001	klarairna_	https://www.instagram.com/klarairna_
341	1001	nailanadya_	https://www.instagram.com/nailanadya_
342	1001	amelsafff	https://www.instagram.com/amelsafff
343	1001	_fdllkh	https://www.instagram.com/_fdllkh
344	1001	_fzllaa	https://www.instagram.com/_fzllaa
345	1001	regiihamsyah	https://www.instagram.com/regiihamsyah
346	1001	syhfrmnn_	https://www.instagram.com/syhfrmnn_
347	1001	bagindamn9	https://www.instagram.com/bagindamn9
348	1001	danuindrap12	https://www.instagram.com/danuindrap12
349	1001	farhanibnup	https://www.instagram.com/farhanibnup
350	1001	lucymutf_	https://www.instagram.com/lucymutf_
351	1001	rakhaspratama	https://www.instagram.com/rakhaspratama
352	1001	mauddyyy__	https://www.instagram.com/mauddyyy__
353	1001	ferdyzs_31	https://www.instagram.com/ferdyzs_31
354	1001	atuy__	https://www.instagram.com/atuy__
355	1001	yudhaaptra__	https://www.instagram.com/yudhaaptra__
356	1001	nooradhi.asshiddiqie	https://www.instagram.com/nooradhi.asshiddiqie
357	1001	ag.gagah	https://www.instagram.com/ag.gagah
358	1001	faldienn	https://www.instagram.com/faldienn
359	1001	irsyxdfrds	https://www.instagram.com/irsyxdfrds
360	1001	diennur_	https://www.instagram.com/diennur_
361	1001	levolve_	https://www.instagram.com/levolve_
362	1001	irfanarf	https://www.instagram.com/irfanarf
363	1001	sshafamutia	https://www.instagram.com/sshafamutia
364	1001	atletvocal	https://www.instagram.com/atletvocal
365	1001	rhmtrynld_	https://www.instagram.com/rhmtrynld_
366	1001	nailaluthfiani_	https://www.instagram.com/nailaluthfiani_
367	1001	shintaamalia.r__	https://www.instagram.com/shintaamalia.r__
368	1001	chika_anggi	https://www.instagram.com/chika_anggi
369	1001	navifadila	https://www.instagram.com/navifadila
370	1001	ayu_ambr	https://www.instagram.com/ayu_ambr
371	1001	rrrrstu	https://www.instagram.com/rrrrstu
372	1001	frida_cf_	https://www.instagram.com/frida_cf_
373	1001	siiimuttt_	https://www.instagram.com/siiimuttt_
374	1001	samhilaf_	https://www.instagram.com/samhilaf_
375	1001	biliantobayu	https://www.instagram.com/biliantobayu
376	1001	rizanur8	https://www.instagram.com/rizanur8
377	1001	laattifahh	https://www.instagram.com/laattifahh
378	1001	ekadpermatasari	https://www.instagram.com/ekadpermatasari
379	1001	___di.pri	https://www.instagram.com/___di.pri
380	1001	nasyaadelia._	https://www.instagram.com/nasyaadelia._
381	1001	bis.dianto	https://www.instagram.com/bis.dianto
382	1001	rzkmeyl_	https://www.instagram.com/rzkmeyl_
383	1001	_meetgian	https://www.instagram.com/_meetgian
384	1001	ptriiarlin	https://www.instagram.com/ptriiarlin
385	1001	azizaaawafiz	https://www.instagram.com/azizaaawafiz
386	1001	alfa_yusuf_adriano	https://www.instagram.com/alfa_yusuf_adriano
387	1001	lolyta.weddingkebumen	https://www.instagram.com/lolyta.weddingkebumen
388	1001	trisepti_rahayu	https://www.instagram.com/trisepti_rahayu
389	1001	_verdiawan	https://www.instagram.com/_verdiawan
390	1001	aufaderman	https://www.instagram.com/aufaderman
391	1001	aninditavarentia___	https://www.instagram.com/aninditavarentia___
392	1001	hartanty_54	https://www.instagram.com/hartanty_54
393	1001	dwinandamutiarani	https://www.instagram.com/dwinandamutiarani
394	1001	panducoco	https://www.instagram.com/panducoco
395	1001	andriyastnm_	https://www.instagram.com/andriyastnm_
396	1001	nafafillah	https://www.instagram.com/nafafillah
397	1001	304prianwar_	https://www.instagram.com/304prianwar_
398	1001	itss_viisusanti04	https://www.instagram.com/itss_viisusanti04
399	1001	omegadianafrisa__	https://www.instagram.com/omegadianafrisa__
400	1001	rhaswhy	https://www.instagram.com/rhaswhy
401	1001	nilampsdw_	https://www.instagram.com/nilampsdw_
402	1001	prayss__	https://www.instagram.com/prayss__
403	1001	st_stewart	https://www.instagram.com/st_stewart
404	1001	seni_stemsago	https://www.instagram.com/seni_stemsago
405	1001	_fh.rizal	https://www.instagram.com/_fh.rizal
406	1001	oisina_	https://www.instagram.com/oisina_
407	1001	osis_stemsago	https://www.instagram.com/osis_stemsago
408	1001	maay_ny_	https://www.instagram.com/maay_ny_
409	1001	nandasulisti__	https://www.instagram.com/nandasulisti__
410	1001	salfanadiaa	https://www.instagram.com/salfanadiaa
411	1001	vi_ssanti	https://www.instagram.com/vi_ssanti
412	1001	icaannis_	https://www.instagram.com/icaannis_
413	1001	agnesindina	https://www.instagram.com/agnesindina
414	1001	ylnarenn	https://www.instagram.com/ylnarenn
415	1001	nobiiito	https://www.instagram.com/nobiiito
416	1001	angginandaa_	https://www.instagram.com/angginandaa_
417	1001	nanatcha_nat	https://www.instagram.com/nanatcha_nat
418	1001	kikiiiumayy	https://www.instagram.com/kikiiiumayy
419	1001	wijimurningsih_	https://www.instagram.com/wijimurningsih_
420	1001	heronimusagung	https://www.instagram.com/heronimusagung
421	1001	pstar_17	https://www.instagram.com/pstar_17
422	1001	farah_liaa	https://www.instagram.com/farah_liaa
423	1001	novitapil	https://www.instagram.com/novitapil
424	1001	apr.iida	https://www.instagram.com/apr.iida
425	1001	dwndsf__	https://www.instagram.com/dwndsf__
426	1001	tkjc_stemsago	https://www.instagram.com/tkjc_stemsago
427	1001	rttnad_	https://www.instagram.com/rttnad_
428	1001	_zain.ul	https://www.instagram.com/_zain.ul
429	1001	niftaseptiana	https://www.instagram.com/niftaseptiana
430	1001	milaftrnn	https://www.instagram.com/milaftrnn
431	1001	nywiji_	https://www.instagram.com/nywiji_
432	1001	prast.dwh	https://www.instagram.com/prast.dwh
433	1001	aris.setia_	https://www.instagram.com/aris.setia_
434	1001	puspitaaasar	https://www.instagram.com/puspitaaasar
435	1001	saldiramdaniii	https://www.instagram.com/saldiramdaniii
436	1001	jazzadventure_06	https://www.instagram.com/jazzadventure_06
437	1001	bimonh_	https://www.instagram.com/bimonh_
438	1001	masj_rfkm23	https://www.instagram.com/masj_rfkm23
439	1001	ungguldk_	https://www.instagram.com/ungguldk_
440	1001	bagus.prstyo__	https://www.instagram.com/bagus.prstyo__
\.


--
-- Data for Name: following_private; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.following_private (fg_id, user_id, user_name, user_link) FROM stdin;
1	1001	c.verdonk	https://www.instagram.com/c.verdonk
2	1001	jensraven9	https://www.instagram.com/jensraven9
3	1001	soo.fii22	https://www.instagram.com/soo.fii22
4	1001	shanayaraisya	https://www.instagram.com/shanayaraisya
5	1001	shintaeyong7777	https://www.instagram.com/shintaeyong7777
6	1001	marselinoferdinan10	https://www.instagram.com/marselinoferdinan10
7	1001	ayam_kampos	https://www.instagram.com/ayam_kampos
8	1001	jkt48.lily_	https://www.instagram.com/jkt48.lily_
9	1001	salskypiea	https://www.instagram.com/salskypiea
10	1001	jkt48.nachia.t	https://www.instagram.com/jkt48.nachia.t
11	1001	jkt48.delynn	https://www.instagram.com/jkt48.delynn
12	1001	queenyzrln	https://www.instagram.com/queenyzrln
13	1001	dinarnurdani_	https://www.instagram.com/dinarnurdani_
14	1001	angeliimn	https://www.instagram.com/angeliimn
15	1001	t4ngled__	https://www.instagram.com/t4ngled__
16	1001	yannriani	https://www.instagram.com/yannriani
17	1001	fadhillahapriliyani	https://www.instagram.com/fadhillahapriliyani
18	1001	jin_a_nana	https://www.instagram.com/jin_a_nana
19	1001	arvanzach	https://www.instagram.com/arvanzach
20	1001	daisyedgarjones	https://www.instagram.com/daisyedgarjones
21	1001	jkt48.amanda.s	https://www.instagram.com/jkt48.amanda.s
22	1001	laurabas	https://www.instagram.com/laurabas
23	1001	nuradatau	https://www.instagram.com/nuradatau
24	1001	dewinensii	https://www.instagram.com/dewinensii
25	1001	patriciaptrr	https://www.instagram.com/patriciaptrr
26	1001	mckennagraceful	https://www.instagram.com/mckennagraceful
27	1001	mawar_eva	https://www.instagram.com/mawar_eva
28	1001	jkt48.zee	https://www.instagram.com/jkt48.zee
29	1001	adrnadpr	https://www.instagram.com/adrnadpr
30	1001	astrocat.official	https://www.instagram.com/astrocat.official
31	1001	rahmalyy__	https://www.instagram.com/rahmalyy__
32	1001	playlistlivefestival	https://www.instagram.com/playlistlivefestival
33	1001	willyocton	https://www.instagram.com/willyocton
34	1001	j.jr257	https://www.instagram.com/j.jr257
35	1001	julstelle	https://www.instagram.com/julstelle
36	1001	xeesoxee	https://www.instagram.com/xeesoxee
37	1001	prabowo	https://www.instagram.com/prabowo
38	1001	dakotajohnson	https://www.instagram.com/dakotajohnson
39	1001	anak.telyu	https://www.instagram.com/anak.telyu
40	1001	nadafadilaaa	https://www.instagram.com/nadafadilaaa
41	1001	shannashannonsiswanto	https://www.instagram.com/shannashannonsiswanto
42	1001	tomholland2013	https://www.instagram.com/tomholland2013
43	1001	qizzaagln	https://www.instagram.com/qizzaagln
44	1001	maartenpaes	https://www.instagram.com/maartenpaes
45	1001	milliebobbybrown	https://www.instagram.com/milliebobbybrown
46	1001	thomhaye	https://www.instagram.com/thomhaye
47	1001	oliviarodrigo	https://www.instagram.com/oliviarodrigo
48	1001	taylorswift	https://www.instagram.com/taylorswift
49	1001	ulyanadya3	https://www.instagram.com/ulyanadya3
50	1001	sydney_sweeney	https://www.instagram.com/sydney_sweeney
51	1001	putrimarino	https://www.instagram.com/putrimarino
52	1001	therealdisastr	https://www.instagram.com/therealdisastr
53	1001	0ratmangoen	https://www.instagram.com/0ratmangoen
54	1001	keishaakr	https://www.instagram.com/keishaakr
55	1001	ferdiyusuf_10	https://www.instagram.com/ferdiyusuf_10
56	1001	normanelat	https://www.instagram.com/normanelat
57	1001	elizabethlail	https://www.instagram.com/elizabethlail
58	1001	justinhubner5	https://www.instagram.com/justinhubner5
59	1001	jayidzes	https://www.instagram.com/jayidzes
60	1001	nathantjoeaon	https://www.instagram.com/nathantjoeaon
61	1001	rafaelstruick	https://www.instagram.com/rafaelstruick
62	1001	ivarjnr	https://www.instagram.com/ivarjnr
63	1001	s.pattynama	https://www.instagram.com/s.pattynama
64	1001	jordiamat5	https://www.instagram.com/jordiamat5
65	1001	sandywalsh	https://www.instagram.com/sandywalsh
66	1001	elkanbaggott	https://www.instagram.com/elkanbaggott
67	1001	bpw_clean	https://www.instagram.com/bpw_clean
68	1001	telyufood	https://www.instagram.com/telyufood
69	1001	chelle.draft	https://www.instagram.com/chelle.draft
70	1001	gdsc.telkomunivbdg	https://www.instagram.com/gdsc.telkomunivbdg
71	1001	theredsindo	https://www.instagram.com/theredsindo
72	1001	gibbor_28	https://www.instagram.com/gibbor_28
73	1001	heylla.urent	https://www.instagram.com/heylla.urent
74	1001	anitarhmlia	https://www.instagram.com/anitarhmlia
75	1001	dindayysf	https://www.instagram.com/dindayysf
76	1001	dedesetiawan29	https://www.instagram.com/dedesetiawan29
77	1001	diianms	https://www.instagram.com/diianms
78	1001	motogp	https://www.instagram.com/motogp
79	1001	rhnathala	https://www.instagram.com/rhnathala
80	1001	sophiasidae	https://www.instagram.com/sophiasidae
81	1001	kikikun_27	https://www.instagram.com/kikikun_27
82	1001	aldito_wahyu06	https://www.instagram.com/aldito_wahyu06
83	1001	sneakers_dept	https://www.instagram.com/sneakers_dept
84	1001	mimikeene3	https://www.instagram.com/mimikeene3
85	1001	prefacewearhouse	https://www.instagram.com/prefacewearhouse
86	1001	hypebeastid	https://www.instagram.com/hypebeastid
87	1001	adidasfootball	https://www.instagram.com/adidasfootball
88	1001	premierleague	https://www.instagram.com/premierleague
89	1001	zendaya	https://www.instagram.com/zendaya
90	1001	ganjar_pranowo	https://www.instagram.com/ganjar_pranowo
91	1001	kathrynnewton	https://www.instagram.com/kathrynnewton
92	1001	dinanensi_	https://www.instagram.com/dinanensi_
93	1001	goyounjung	https://www.instagram.com/goyounjung
94	1001	timnas.indonesia	https://www.instagram.com/timnas.indonesia
95	1001	dualipa	https://www.instagram.com/dualipa
96	1001	breakdown.universe	https://www.instagram.com/breakdown.universe
97	1001	keretacepat_id	https://www.instagram.com/keretacepat_id
98	1001	jkt48.freya	https://www.instagram.com/jkt48.freya
99	1001	putrierrsy	https://www.instagram.com/putrierrsy
100	1001	kincirdotcom	https://www.instagram.com/kincirdotcom
101	1001	catherineealicia	https://www.instagram.com/catherineealicia
102	1001	deborantlyaa	https://www.instagram.com/deborantlyaa
103	1001	ferdiansyusuff_	https://www.instagram.com/ferdiansyusuff_
104	1001	risingballers	https://www.instagram.com/risingballers
105	1001	silver_rain.__	https://www.instagram.com/silver_rain.__
106	1001	shidqify	https://www.instagram.com/shidqify
107	1001	artisabunga	https://www.instagram.com/artisabunga
108	1001	brielarson	https://www.instagram.com/brielarson
109	1001	felixtpsrb	https://www.instagram.com/felixtpsrb
110	1001	ardithasintya	https://www.instagram.com/ardithasintya
111	1001	geniza_ghilda	https://www.instagram.com/geniza_ghilda
112	1001	sun_vy_02	https://www.instagram.com/sun_vy_02
113	1001	mfx.da	https://www.instagram.com/mfx.da
114	1001	yuaiu_	https://www.instagram.com/yuaiu_
115	1001	hogwartslegacy	https://www.instagram.com/hogwartslegacy
116	1001	wizardingworld	https://www.instagram.com/wizardingworld
117	1001	rrq_syalma	https://www.instagram.com/rrq_syalma
118	1001	faizalaer	https://www.instagram.com/faizalaer
119	1001	_aris.afriyanto	https://www.instagram.com/_aris.afriyanto
120	1001	kinantyadeh	https://www.instagram.com/kinantyadeh
121	1001	emmawatson	https://www.instagram.com/emmawatson
122	1001	saya_kucing04	https://www.instagram.com/saya_kucing04
123	1001	kai121_	https://www.instagram.com/kai121_
124	1001	ataca_ana	https://www.instagram.com/ataca_ana
125	1001	fiersabesari	https://www.instagram.com/fiersabesari
126	1001	digistarclub	https://www.instagram.com/digistarclub
127	1001	livingintelkom	https://www.instagram.com/livingintelkom
128	1001	gdscindonesia	https://www.instagram.com/gdscindonesia
129	1001	farhan15r	https://www.instagram.com/farhan15r
130	1001	leomessi	https://www.instagram.com/leomessi
131	1001	mavenwifey	https://www.instagram.com/mavenwifey
132	1001	erickthohir	https://www.instagram.com/erickthohir
133	1001	direktoratputi	https://www.instagram.com/direktoratputi
134	1001	bpa_telkomuniversity	https://www.instagram.com/bpa_telkomuniversity
135	1001	upiyxjt_	https://www.instagram.com/upiyxjt_
136	1001	amaliaaanh_	https://www.instagram.com/amaliaaanh_
137	1001	thefilmzone	https://www.instagram.com/thefilmzone
138	1001	elangpermana_	https://www.instagram.com/elangpermana_
139	1001	sheiladaisha	https://www.instagram.com/sheiladaisha
140	1001	ememyers	https://www.instagram.com/ememyers
141	1001	bellaramsey	https://www.instagram.com/bellaramsey
142	1001	plforindonesia	https://www.instagram.com/plforindonesia
143	1001	refkisyakii	https://www.instagram.com/refkisyakii
144	1001	leonardhorante_08	https://www.instagram.com/leonardhorante_08
145	1001	diskeyyyy	https://www.instagram.com/diskeyyyy
146	1001	nanelss_	https://www.instagram.com/nanelss_
147	1001	nisa_ech	https://www.instagram.com/nisa_ech
148	1001	marvel.indo	https://www.instagram.com/marvel.indo
149	1001	nnisaervff	https://www.instagram.com/nnisaervff
150	1001	kilau.u3x	https://www.instagram.com/kilau.u3x
151	1001	adityasyafamahendra	https://www.instagram.com/adityasyafamahendra
152	1001	devidfrnkln	https://www.instagram.com/devidfrnkln
153	1001	arkhanfzn	https://www.instagram.com/arkhanfzn
154	1001	s.nabilas	https://www.instagram.com/s.nabilas
155	1001	rendyyfiliang	https://www.instagram.com/rendyyfiliang
156	1001	reyhanpanja.13	https://www.instagram.com/reyhanpanja.13
157	1001	vanicaprillia	https://www.instagram.com/vanicaprillia
158	1001	alxndrdista	https://www.instagram.com/alxndrdista
159	1001	sa.maharanip	https://www.instagram.com/sa.maharanip
160	1001	unlogicalhuman	https://www.instagram.com/unlogicalhuman
161	1001	andreassuranta	https://www.instagram.com/andreassuranta
162	1001	iiichaaaaa._	https://www.instagram.com/iiichaaaaa._
163	1001	bchfrlpov	https://www.instagram.com/bchfrlpov
164	1001	dimaswnugrh	https://www.instagram.com/dimaswnugrh
165	1001	fitrimuslim11_	https://www.instagram.com/fitrimuslim11_
166	1001	dindaamirap	https://www.instagram.com/dindaamirap
167	1001	1peace__	https://www.instagram.com/1peace__
168	1001	rashidag_	https://www.instagram.com/rashidag_
169	1001	galvinaa	https://www.instagram.com/galvinaa
170	1001	alifiaayndn	https://www.instagram.com/alifiaayndn
171	1001	yasalamfcb	https://www.instagram.com/yasalamfcb
172	1001	lugipratama17	https://www.instagram.com/lugipratama17
173	1001	tantrisepp1994	https://www.instagram.com/tantrisepp1994
174	1001	iminsecret_	https://www.instagram.com/iminsecret_
175	1001	marvel	https://www.instagram.com/marvel
176	1001	_zyozyo	https://www.instagram.com/_zyozyo
177	1001	vi_ssanti	https://www.instagram.com/vi_ssanti
178	1001	virafynr	https://www.instagram.com/virafynr
179	1001	avicenavn	https://www.instagram.com/avicenavn
180	1001	ri_dho_o	https://www.instagram.com/ri_dho_o
181	1001	gitamileniap	https://www.instagram.com/gitamileniap
182	1001	arllnaa	https://www.instagram.com/arllnaa
183	1001	belia.azzahra	https://www.instagram.com/belia.azzahra
184	1001	ikhbalst_	https://www.instagram.com/ikhbalst_
185	1001	evasyffra	https://www.instagram.com/evasyffra
186	1001	ikhdactsa	https://www.instagram.com/ikhdactsa
187	1001	gitaakk__	https://www.instagram.com/gitaakk__
188	1001	yusenkkk	https://www.instagram.com/yusenkkk
189	1001	waahyuj	https://www.instagram.com/waahyuj
190	1001	frejaklinge	https://www.instagram.com/frejaklinge
191	1001	jauharri_	https://www.instagram.com/jauharri_
192	1001	gassryd	https://www.instagram.com/gassryd
193	1001	deuskaaa	https://www.instagram.com/deuskaaa
194	1001	avfsdy	https://www.instagram.com/avfsdy
195	1001	remamuliana_	https://www.instagram.com/remamuliana_
196	1001	syavinanzhr	https://www.instagram.com/syavinanzhr
197	1001	kick.avenue	https://www.instagram.com/kick.avenue
198	1001	arzaqiadmaa	https://www.instagram.com/arzaqiadmaa
199	1001	mhaikalls	https://www.instagram.com/mhaikalls
200	1001	rif_faqih	https://www.instagram.com/rif_faqih
201	1001	rafli.putra	https://www.instagram.com/rafli.putra
202	1001	marvelindonesia	https://www.instagram.com/marvelindonesia
203	1001	rohmahnur__	https://www.instagram.com/rohmahnur__
204	1001	rayhanmuhammad02	https://www.instagram.com/rayhanmuhammad02
205	1001	lutfihdytt_	https://www.instagram.com/lutfihdytt_
206	1001	argapalaska	https://www.instagram.com/argapalaska
207	1001	dewiilmir	https://www.instagram.com/dewiilmir
208	1001	adeelyana	https://www.instagram.com/adeelyana
209	1001	d.ndraa	https://www.instagram.com/d.ndraa
210	1001	kikiyaaaki	https://www.instagram.com/kikiyaaaki
211	1001	regitap__	https://www.instagram.com/regitap__
212	1001	raraapr___	https://www.instagram.com/raraapr___
213	1001	ghari_synz	https://www.instagram.com/ghari_synz
214	1001	rizmauls_	https://www.instagram.com/rizmauls_
215	1001	__mayangp	https://www.instagram.com/__mayangp
216	1001	grainrfi__	https://www.instagram.com/grainrfi__
217	1001	hawa.ihsani	https://www.instagram.com/hawa.ihsani
218	1001	kaliasland	https://www.instagram.com/kaliasland
219	1001	jessica_rhmn	https://www.instagram.com/jessica_rhmn
220	1001	xcobiii	https://www.instagram.com/xcobiii
221	1001	bulan.ayu_	https://www.instagram.com/bulan.ayu_
222	1001	fyan_syach	https://www.instagram.com/fyan_syach
223	1001	khoirulazkiya_	https://www.instagram.com/khoirulazkiya_
224	1001	wanisaaasw_	https://www.instagram.com/wanisaaasw_
225	1001	afif_frcn16	https://www.instagram.com/afif_frcn16
226	1001	pram_ps	https://www.instagram.com/pram_ps
227	1001	maghrizal_putra	https://www.instagram.com/maghrizal_putra
228	1001	fahryyw	https://www.instagram.com/fahryyw
229	1001	victoriarewah	https://www.instagram.com/victoriarewah
230	1001	jeksilaen	https://www.instagram.com/jeksilaen
231	1001	zrraraxyy._	https://www.instagram.com/zrraraxyy._
232	1001	andrewdarmaa	https://www.instagram.com/andrewdarmaa
233	1001	transfermarkt.co.id	https://www.instagram.com/transfermarkt.co.id
234	1001	farizqiiaditya	https://www.instagram.com/farizqiiaditya
235	1001	laniinbbn__	https://www.instagram.com/laniinbbn__
236	1001	masiwolf	https://www.instagram.com/masiwolf
237	1001	riko_rumengan	https://www.instagram.com/riko_rumengan
238	1001	rintiksedu	https://www.instagram.com/rintiksedu
239	1001	nike	https://www.instagram.com/nike
240	1001	stelamarissk	https://www.instagram.com/stelamarissk
241	1001	tel_u_career	https://www.instagram.com/tel_u_career
242	1001	anggachristians	https://www.instagram.com/anggachristians
243	1001	saeyaz.baghiz	https://www.instagram.com/saeyaz.baghiz
244	1001	andez_hd	https://www.instagram.com/andez_hd
245	1001	devinatts	https://www.instagram.com/devinatts
246	1001	derryl.r	https://www.instagram.com/derryl.r
247	1001	alifahmad.14	https://www.instagram.com/alifahmad.14
248	1001	yasmiinaurra	https://www.instagram.com/yasmiinaurra
249	1001	nicknatha	https://www.instagram.com/nicknatha
250	1001	darissalamfauzi	https://www.instagram.com/darissalamfauzi
251	1001	okaadabi	https://www.instagram.com/okaadabi
252	1001	_zain.ul	https://www.instagram.com/_zain.ul
253	1001	ridhnfirdaus	https://www.instagram.com/ridhnfirdaus
254	1001	venuslidzikri	https://www.instagram.com/venuslidzikri
255	1001	rasyid.ridho	https://www.instagram.com/rasyid.ridho
256	1001	mnfaal_	https://www.instagram.com/mnfaal_
257	1001	reniwynt._	https://www.instagram.com/reniwynt._
258	1001	hafizhjhr	https://www.instagram.com/hafizhjhr
259	1001	rahadiarkaa	https://www.instagram.com/rahadiarkaa
260	1001	bagirr_	https://www.instagram.com/bagirr_
261	1001	nnilarl	https://www.instagram.com/nnilarl
262	1001	muhhanif667	https://www.instagram.com/muhhanif667
263	1001	hanifjatmiko_	https://www.instagram.com/hanifjatmiko_
264	1001	aksan_oss	https://www.instagram.com/aksan_oss
265	1001	aisyahicaaa_	https://www.instagram.com/aisyahicaaa_
266	1001	septiaaditia	https://www.instagram.com/septiaaditia
267	1001	fakhriias	https://www.instagram.com/fakhriias
268	1001	_azizm15	https://www.instagram.com/_azizm15
269	1001	gifariilhm	https://www.instagram.com/gifariilhm
270	1001	icaalh_	https://www.instagram.com/icaalh_
271	1001	faizahnnn	https://www.instagram.com/faizahnnn
272	1001	zifau_fauzi	https://www.instagram.com/zifau_fauzi
273	1001	rolldepan	https://www.instagram.com/rolldepan
274	1001	syhreza_satria	https://www.instagram.com/syhreza_satria
275	1001	paglaks	https://www.instagram.com/paglaks
276	1001	rakiindwikii	https://www.instagram.com/rakiindwikii
277	1001	rezareynalditarigan	https://www.instagram.com/rezareynalditarigan
278	1001	a.zsyip_	https://www.instagram.com/a.zsyip_
279	1001	marchristiness	https://www.instagram.com/marchristiness
280	1001	amalia.rizkif	https://www.instagram.com/amalia.rizkif
281	1001	larassaam	https://www.instagram.com/larassaam
282	1001	miharufikriansyah	https://www.instagram.com/miharufikriansyah
283	1001	azizahft_	https://www.instagram.com/azizahft_
284	1001	zraarsta	https://www.instagram.com/zraarsta
285	1001	agliskusuma	https://www.instagram.com/agliskusuma
286	1001	iizennnn	https://www.instagram.com/iizennnn
287	1001	adiyatmapw	https://www.instagram.com/adiyatmapw
288	1001	pazors_official	https://www.instagram.com/pazors_official
289	1001	vannkristian	https://www.instagram.com/vannkristian
290	1001	fhribahtiar	https://www.instagram.com/fhribahtiar
291	1001	awalrmdhaan	https://www.instagram.com/awalrmdhaan
292	1001	supergaande	https://www.instagram.com/supergaande
293	1001	alisyayolandaa	https://www.instagram.com/alisyayolandaa
294	1001	theoarevan	https://www.instagram.com/theoarevan
295	1001	putriiiic	https://www.instagram.com/putriiiic
296	1001	yulianpramesti	https://www.instagram.com/yulianpramesti
297	1001	bitch	https://www.instagram.com/bitch
298	1001	captaineast	https://www.instagram.com/captaineast
299	1001	cuthayfasyfiaa	https://www.instagram.com/cuthayfasyfiaa
300	1001	daffi.raka	https://www.instagram.com/daffi.raka
301	1001	rezmulk_	https://www.instagram.com/rezmulk_
302	1001	elizaaryn	https://www.instagram.com/elizaaryn
303	1001	zalfa.r01	https://www.instagram.com/zalfa.r01
304	1001	rrzta	https://www.instagram.com/rrzta
305	1001	anjargamekyu_	https://www.instagram.com/anjargamekyu_
306	1001	idandenim	https://www.instagram.com/idandenim
307	1001	izyslstyo	https://www.instagram.com/izyslstyo
308	1001	f.isdianto	https://www.instagram.com/f.isdianto
309	1001	alghifrrr	https://www.instagram.com/alghifrrr
310	1001	ajmal.yzd	https://www.instagram.com/ajmal.yzd
311	1001	romadhonafn	https://www.instagram.com/romadhonafn
312	1001	raditya_dika	https://www.instagram.com/raditya_dika
313	1001	adipati	https://www.instagram.com/adipati
314	1001	friskapp	https://www.instagram.com/friskapp
315	1001	yoy_sptr	https://www.instagram.com/yoy_sptr
316	1001	raihaanrr	https://www.instagram.com/raihaanrr
317	1001	cretivox	https://www.instagram.com/cretivox
318	1001	kembali.esok	https://www.instagram.com/kembali.esok
319	1001	sulisaputro_	https://www.instagram.com/sulisaputro_
320	1001	irda_rsft_	https://www.instagram.com/irda_rsft_
321	1001	umam_syarief	https://www.instagram.com/umam_syarief
322	1001	ditmawa_univtelkom	https://www.instagram.com/ditmawa_univtelkom
323	1001	openlibrary.telu	https://www.instagram.com/openlibrary.telu
324	1001	ardhii_art	https://www.instagram.com/ardhii_art
325	1001	intansriayuni.17	https://www.instagram.com/intansriayuni.17
326	1001	ahmadimam__	https://www.instagram.com/ahmadimam__
327	1001	mukhlisamn	https://www.instagram.com/mukhlisamn
328	1001	hubert_igor	https://www.instagram.com/hubert_igor
329	1001	stefanus_d	https://www.instagram.com/stefanus_d
330	1001	ridzkachitra_	https://www.instagram.com/ridzkachitra_
331	1001	gregorio_alvito	https://www.instagram.com/gregorio_alvito
332	1001	avika.rzy	https://www.instagram.com/avika.rzy
333	1001	fajarbrlyn_	https://www.instagram.com/fajarbrlyn_
334	1001	mryblng	https://www.instagram.com/mryblng
335	1001	habib.filahas	https://www.instagram.com/habib.filahas
336	1001	arif.f_rachman	https://www.instagram.com/arif.f_rachman
337	1001	tegartrisptro_al40	https://www.instagram.com/tegartrisptro_al40
338	1001	smbtelkom	https://www.instagram.com/smbtelkom
339	1001	rizkygumelarr_	https://www.instagram.com/rizkygumelarr_
340	1001	elsaptryn	https://www.instagram.com/elsaptryn
341	1001	puspitaaasar	https://www.instagram.com/puspitaaasar
342	1001	dityailmir	https://www.instagram.com/dityailmir
343	1001	priyaak___	https://www.instagram.com/priyaak___
344	1001	muh_rassya	https://www.instagram.com/muh_rassya
345	1001	gusta.veno	https://www.instagram.com/gusta.veno
346	1001	chkps_	https://www.instagram.com/chkps_
347	1001	nikennnambrr	https://www.instagram.com/nikennnambrr
348	1001	annisaas._	https://www.instagram.com/annisaas._
349	1001	fal_bagas	https://www.instagram.com/fal_bagas
350	1001	odiiwoody	https://www.instagram.com/odiiwoody
351	1001	farasputraaa	https://www.instagram.com/farasputraaa
352	1001	fif.telkomuniversity	https://www.instagram.com/fif.telkomuniversity
353	1001	azmima_	https://www.instagram.com/azmima_
354	1001	noaldy_thio	https://www.instagram.com/noaldy_thio
355	1001	reinaldy.al_18	https://www.instagram.com/reinaldy.al_18
356	1001	salsabillataf	https://www.instagram.com/salsabillataf
357	1001	yogiputra33	https://www.instagram.com/yogiputra33
358	1001	fakhriharun_	https://www.instagram.com/fakhriharun_
359	1001	kazarach	https://www.instagram.com/kazarach
360	1001	venus.mrngstar	https://www.instagram.com/venus.mrngstar
361	1001	taniakwee	https://www.instagram.com/taniakwee
362	1001	bima.ngr	https://www.instagram.com/bima.ngr
363	1001	jonathan_arya.w	https://www.instagram.com/jonathan_arya.w
364	1001	richieta_	https://www.instagram.com/richieta_
365	1001	alifiamutiaaa	https://www.instagram.com/alifiamutiaaa
366	1001	adrian.arman	https://www.instagram.com/adrian.arman
367	1001	dekaanggra	https://www.instagram.com/dekaanggra
368	1001	miyaatrg	https://www.instagram.com/miyaatrg
369	1001	kikyyykyrizzz	https://www.instagram.com/kikyyykyrizzz
370	1001	nabila.rdyn	https://www.instagram.com/nabila.rdyn
371	1001	islahihyaa	https://www.instagram.com/islahihyaa
372	1001	ainunrosdianaa	https://www.instagram.com/ainunrosdianaa
373	1001	naaaayyyy__	https://www.instagram.com/naaaayyyy__
374	1001	ilhambakri._	https://www.instagram.com/ilhambakri._
375	1001	telu.coffee	https://www.instagram.com/telu.coffee
376	1001	pssi	https://www.instagram.com/pssi
377	1001	volix.media	https://www.instagram.com/volix.media
378	1001	wormholestore	https://www.instagram.com/wormholestore
379	1001	urbansneakersociety	https://www.instagram.com/urbansneakersociety
380	1001	raihan_abim	https://www.instagram.com/raihan_abim
381	1001	oxfoord	https://www.instagram.com/oxfoord
382	1001	oxfordsociety	https://www.instagram.com/oxfordsociety
383	1001	off____white	https://www.instagram.com/off____white
384	1001	placesplusfaces	https://www.instagram.com/placesplusfaces
385	1001	807garage.id	https://www.instagram.com/807garage.id
386	1001	kaurinazwa	https://www.instagram.com/kaurinazwa
387	1001	itss_viisusanti04	https://www.instagram.com/itss_viisusanti04
388	1001	indonesiatillidie	https://www.instagram.com/indonesiatillidie
389	1001	_sylvialstr	https://www.instagram.com/_sylvialstr
390	1001	kid1ver	https://www.instagram.com/kid1ver
391	1001	daffa_satriarga	https://www.instagram.com/daffa_satriarga
392	1001	alfarobiii	https://www.instagram.com/alfarobiii
393	1001	transfermarkt_official	https://www.instagram.com/transfermarkt_official
394	1001	dienqonitaa_	https://www.instagram.com/dienqonitaa_
395	1001	rhnnsp	https://www.instagram.com/rhnnsp
396	1001	fitriasalsabilaah	https://www.instagram.com/fitriasalsabilaah
397	1001	yusmasv	https://www.instagram.com/yusmasv
398	1001	rakamahendrraa	https://www.instagram.com/rakamahendrraa
399	1001	ellizapatt	https://www.instagram.com/ellizapatt
400	1001	ign_aryaw	https://www.instagram.com/ign_aryaw
401	1001	brianimanuel	https://www.instagram.com/brianimanuel
402	1001	nayakatalitha	https://www.instagram.com/nayakatalitha
403	1001	fandomizes	https://www.instagram.com/fandomizes
404	1001	liverpoolfc	https://www.instagram.com/liverpoolfc
405	1001	najwashihab	https://www.instagram.com/najwashihab
406	1001	reihan_akmal	https://www.instagram.com/reihan_akmal
407	1001	haris_axl	https://www.instagram.com/haris_axl
408	1001	marissasyfn_	https://www.instagram.com/marissasyfn_
409	1001	nabilbull	https://www.instagram.com/nabilbull
410	1001	yafinh	https://www.instagram.com/yafinh
411	1001	aliffarrass_	https://www.instagram.com/aliffarrass_
412	1001	jidan.kh	https://www.instagram.com/jidan.kh
413	1001	ichsanalf_	https://www.instagram.com/ichsanalf_
414	1001	baa_univtelkom	https://www.instagram.com/baa_univtelkom
415	1001	rikirenggana	https://www.instagram.com/rikirenggana
416	1001	billieeilish	https://www.instagram.com/billieeilish
417	1001	badmintalk_com	https://www.instagram.com/badmintalk_com
418	1001	kpmhmittelu	https://www.instagram.com/kpmhmittelu
419	1001	nrullazzh_	https://www.instagram.com/nrullazzh_
420	1001	fabriziorom	https://www.instagram.com/fabriziorom
421	1001	433	https://www.instagram.com/433
422	1001	miichelletania	https://www.instagram.com/miichelletania
423	1001	ussfeeds	https://www.instagram.com/ussfeeds
424	1001	footballtalentnesia	https://www.instagram.com/footballtalentnesia
425	1001	jennierubyjane	https://www.instagram.com/jennierubyjane
426	1001	roses_are_rosie	https://www.instagram.com/roses_are_rosie
427	1001	sooyaaa__	https://www.instagram.com/sooyaaa__
428	1001	lalalalisa_m	https://www.instagram.com/lalalalisa_m
429	1001	retnofai_	https://www.instagram.com/retnofai_
430	1001	victoriafredlina	https://www.instagram.com/victoriafredlina
431	1001	lolyta_decoration_kebumen	https://www.instagram.com/lolyta_decoration_kebumen
432	1001	andhika_puth	https://www.instagram.com/andhika_puth
433	1001	agneesf	https://www.instagram.com/agneesf
434	1001	intanxk_	https://www.instagram.com/intanxk_
435	1001	bwf.official	https://www.instagram.com/bwf.official
436	1001	arianinra	https://www.instagram.com/arianinra
437	1001	nasywaraudatul._	https://www.instagram.com/nasywaraudatul._
438	1001	indozonegame	https://www.instagram.com/indozonegame
439	1001	angelinadanilova	https://www.instagram.com/angelinadanilova
440	1001	nauraulfaaaaa._	https://www.instagram.com/nauraulfaaaaa._
441	1001	dagelan	https://www.instagram.com/dagelan
442	1001	annisaervanifitrii	https://www.instagram.com/annisaervanifitrii
443	1001	septianazma	https://www.instagram.com/septianazma
444	1001	imtekbdg	https://www.instagram.com/imtekbdg
445	1001	imam_sult	https://www.instagram.com/imam_sult
446	1001	desitarllyw	https://www.instagram.com/desitarllyw
447	1001	s.gitasa	https://www.instagram.com/s.gitasa
448	1001	christinachan3	https://www.instagram.com/christinachan3
449	1001	alsaaql	https://www.instagram.com/alsaaql
450	1001	anggunmeliaaa	https://www.instagram.com/anggunmeliaaa
451	1001	pildumps	https://www.instagram.com/pildumps
452	1001	viaatrista	https://www.instagram.com/viaatrista
453	1001	aura_vadella	https://www.instagram.com/aura_vadella
454	1001	dienqonitayuliana	https://www.instagram.com/dienqonitayuliana
455	1001	tessaerls	https://www.instagram.com/tessaerls
456	1001	sheina.js	https://www.instagram.com/sheina.js
457	1001	reemar.official18	https://www.instagram.com/reemar.official18
458	1001	uli_hutagaol	https://www.instagram.com/uli_hutagaol
459	1001	parabuayaa	https://www.instagram.com/parabuayaa
460	1001	belinda.linggi	https://www.instagram.com/belinda.linggi
461	1001	rexaligra	https://www.instagram.com/rexaligra
462	1001	mdknu	https://www.instagram.com/mdknu
463	1001	nsyylnny	https://www.instagram.com/nsyylnny
464	1001	teluesports	https://www.instagram.com/teluesports
465	1001	valentsatriaa	https://www.instagram.com/valentsatriaa
466	1001	muhamadrizqiabdillah	https://www.instagram.com/muhamadrizqiabdillah
467	1001	royyanfauzi_	https://www.instagram.com/royyanfauzi_
468	1001	xavierpilyai	https://www.instagram.com/xavierpilyai
469	1001	artalumbanrajaaa	https://www.instagram.com/artalumbanrajaaa
470	1001	raihandanadyaksa	https://www.instagram.com/raihandanadyaksa
471	1001	rivellaramadhani	https://www.instagram.com/rivellaramadhani
472	1001	vikkadwi_	https://www.instagram.com/vikkadwi_
473	1001	telkom_cantik	https://www.instagram.com/telkom_cantik
474	1001	alfinaa.rm	https://www.instagram.com/alfinaa.rm
475	1001	adzfck	https://www.instagram.com/adzfck
476	1001	xenosians.exe	https://www.instagram.com/xenosians.exe
477	1001	shalsabilayr_03	https://www.instagram.com/shalsabilayr_03
478	1001	zalf.aa	https://www.instagram.com/zalf.aa
479	1001	syafafahreza	https://www.instagram.com/syafafahreza
480	1001	julskyli	https://www.instagram.com/julskyli
481	1001	n.ggggge	https://www.instagram.com/n.ggggge
482	1001	apinn.al	https://www.instagram.com/apinn.al
483	1001	arrauft	https://www.instagram.com/arrauft
484	1001	dinaanm	https://www.instagram.com/dinaanm
485	1001	namakuciga	https://www.instagram.com/namakuciga
486	1001	hanamnfth	https://www.instagram.com/hanamnfth
487	1001	aisyaahdliya	https://www.instagram.com/aisyaahdliya
488	1001	aufaalst	https://www.instagram.com/aufaalst
489	1001	hafidh_fattah	https://www.instagram.com/hafidh_fattah
490	1001	fawwaz_zidan	https://www.instagram.com/fawwaz_zidan
491	1001	rikreg_	https://www.instagram.com/rikreg_
492	1001	ratandi_ahmad	https://www.instagram.com/ratandi_ahmad
493	1001	firmanade_17	https://www.instagram.com/firmanade_17
494	1001	fadhilib	https://www.instagram.com/fadhilib
495	1001	edghrdwjy	https://www.instagram.com/edghrdwjy
496	1001	ttkwhyu	https://www.instagram.com/ttkwhyu
497	1001	rahajengpp	https://www.instagram.com/rahajengpp
498	1001	darrelljohan	https://www.instagram.com/darrelljohan
499	1001	wwanikmal	https://www.instagram.com/wwanikmal
500	1001	salsa_zky	https://www.instagram.com/salsa_zky
501	1001	arzznaa	https://www.instagram.com/arzznaa
502	1001	k_toook	https://www.instagram.com/k_toook
503	1001	zaraadhsty	https://www.instagram.com/zaraadhsty
504	1001	arif.setiaji_	https://www.instagram.com/arif.setiaji_
505	1001	folkative	https://www.instagram.com/folkative
506	1001	sukamenduga	https://www.instagram.com/sukamenduga
507	1001	apr.iida	https://www.instagram.com/apr.iida
508	1001	fitrianvynt._	https://www.instagram.com/fitrianvynt._
509	1001	muhammadrafi__08	https://www.instagram.com/muhammadrafi__08
510	1001	_fh.rizal	https://www.instagram.com/_fh.rizal
511	1001	indozone.id	https://www.instagram.com/indozone.id
512	1001	afrlfrnd	https://www.instagram.com/afrlfrnd
513	1001	danniasalsabilla	https://www.instagram.com/danniasalsabilla
514	1001	aris.setia_	https://www.instagram.com/aris.setia_
515	1001	jazzadventure_06	https://www.instagram.com/jazzadventure_06
516	1001	ayub.prtma	https://www.instagram.com/ayub.prtma
517	1001	nggiittaa_	https://www.instagram.com/nggiittaa_
518	1001	_channdd	https://www.instagram.com/_channdd
519	1001	tegarpp_	https://www.instagram.com/tegarpp_
520	1001	nabilaazil	https://www.instagram.com/nabilaazil
521	1001	avrilangelina_	https://www.instagram.com/avrilangelina_
522	1001	diyahsafitrii_	https://www.instagram.com/diyahsafitrii_
523	1001	khzqq_	https://www.instagram.com/khzqq_
524	1001	ersarizmaya	https://www.instagram.com/ersarizmaya
525	1001	rizmaangr	https://www.instagram.com/rizmaangr
526	1001	mr.ferimanik_	https://www.instagram.com/mr.ferimanik_
527	1001	efhaaan	https://www.instagram.com/efhaaan
528	1001	sabil_s12	https://www.instagram.com/sabil_s12
529	1001	andriyastnm_	https://www.instagram.com/andriyastnm_
530	1001	dani.n.anie	https://www.instagram.com/dani.n.anie
531	1001	klarairna_	https://www.instagram.com/klarairna_
532	1001	nailanadya_	https://www.instagram.com/nailanadya_
533	1001	amelsafff	https://www.instagram.com/amelsafff
534	1001	salvarmdn	https://www.instagram.com/salvarmdn
535	1001	_fdllkh	https://www.instagram.com/_fdllkh
536	1001	sabila.nf	https://www.instagram.com/sabila.nf
537	1001	annisamak	https://www.instagram.com/annisamak
538	1001	tiaafrs_	https://www.instagram.com/tiaafrs_
539	1001	bagus.prstyo__	https://www.instagram.com/bagus.prstyo__
540	1001	omegadianafrisa__	https://www.instagram.com/omegadianafrisa__
541	1001	tiaferonica	https://www.instagram.com/tiaferonica
542	1001	pstar_17	https://www.instagram.com/pstar_17
543	1001	wijimurningsih_	https://www.instagram.com/wijimurningsih_
544	1001	nanatcha_nat	https://www.instagram.com/nanatcha_nat
545	1001	_fzllaa	https://www.instagram.com/_fzllaa
546	1001	ekafb_	https://www.instagram.com/ekafb_
547	1001	regiihamsyah	https://www.instagram.com/regiihamsyah
548	1001	syhfrmnn_	https://www.instagram.com/syhfrmnn_
549	1001	bagindamn9	https://www.instagram.com/bagindamn9
550	1001	sabilaadnn	https://www.instagram.com/sabilaadnn
551	1001	lucymutf_	https://www.instagram.com/lucymutf_
552	1001	danuindrap12	https://www.instagram.com/danuindrap12
553	1001	hns_ar	https://www.instagram.com/hns_ar
554	1001	dwndsf__	https://www.instagram.com/dwndsf__
555	1001	aziizhata_	https://www.instagram.com/aziizhata_
556	1001	rakhaspratama	https://www.instagram.com/rakhaspratama
557	1001	farhanibnup	https://www.instagram.com/farhanibnup
558	1001	mauddyyy__	https://www.instagram.com/mauddyyy__
559	1001	ferdyzs_31	https://www.instagram.com/ferdyzs_31
560	1001	atuy__	https://www.instagram.com/atuy__
561	1001	bemtelu	https://www.instagram.com/bemtelu
562	1001	ansellmaputri	https://www.instagram.com/ansellmaputri
563	1001	triananiaa	https://www.instagram.com/triananiaa
564	1001	indozonetech	https://www.instagram.com/indozonetech
565	1001	jostheshoota	https://www.instagram.com/jostheshoota
566	1001	viceind	https://www.instagram.com/viceind
567	1001	kekreyes	https://www.instagram.com/kekreyes
568	1001	hmit_telu	https://www.instagram.com/hmit_telu
569	1001	ag.gagah	https://www.instagram.com/ag.gagah
570	1001	faldienn	https://www.instagram.com/faldienn
571	1001	chelseaislan	https://www.instagram.com/chelseaislan
572	1001	irsyxdfrds	https://www.instagram.com/irsyxdfrds
573	1001	diennur_	https://www.instagram.com/diennur_
574	1001	prast.dwh	https://www.instagram.com/prast.dwh
575	1001	nooradhi.asshiddiqie	https://www.instagram.com/nooradhi.asshiddiqie
576	1001	irfanarf	https://www.instagram.com/irfanarf
577	1001	sshafamutia	https://www.instagram.com/sshafamutia
578	1001	levolve_	https://www.instagram.com/levolve_
579	1001	yudhaaptra__	https://www.instagram.com/yudhaaptra__
580	1001	anyageraldine	https://www.instagram.com/anyageraldine
581	1001	drama.telyu	https://www.instagram.com/drama.telyu
582	1001	telkomuniversity	https://www.instagram.com/telkomuniversity
583	1001	rhmtrynld_	https://www.instagram.com/rhmtrynld_
584	1001	nashwaaaz	https://www.instagram.com/nashwaaaz
585	1001	nailaluthfiani_	https://www.instagram.com/nailaluthfiani_
586	1001	shintaamalia.r__	https://www.instagram.com/shintaamalia.r__
587	1001	chika_anggi	https://www.instagram.com/chika_anggi
588	1001	asabopp	https://www.instagram.com/asabopp
589	1001	jokowi	https://www.instagram.com/jokowi
590	1001	kevin_sanjaya	https://www.instagram.com/kevin_sanjaya
591	1001	ayu_ambr	https://www.instagram.com/ayu_ambr
592	1001	rrrrstu	https://www.instagram.com/rrrrstu
593	1001	frida_cf_	https://www.instagram.com/frida_cf_
594	1001	innamarmdhn	https://www.instagram.com/innamarmdhn
595	1001	siiimuttt_	https://www.instagram.com/siiimuttt_
596	1001	samhilaf_	https://www.instagram.com/samhilaf_
597	1001	fadilaaaa._	https://www.instagram.com/fadilaaaa._
598	1001	biliantobayu	https://www.instagram.com/biliantobayu
599	1001	rizanur8	https://www.instagram.com/rizanur8
600	1001	9gag	https://www.instagram.com/9gag
601	1001	ekadpermatasari	https://www.instagram.com/ekadpermatasari
602	1001	laattifahh	https://www.instagram.com/laattifahh
603	1001	nisrinamuf	https://www.instagram.com/nisrinamuf
604	1001	nasyaadelia._	https://www.instagram.com/nasyaadelia._
605	1001	unexplnd	https://www.instagram.com/unexplnd
606	1001	gadgetins	https://www.instagram.com/gadgetins
607	1001	netflixid	https://www.instagram.com/netflixid
608	1001	amaliasuciati_	https://www.instagram.com/amaliasuciati_
609	1001	rzkmeyl_	https://www.instagram.com/rzkmeyl_
610	1001	_meetgian	https://www.instagram.com/_meetgian
611	1001	ptriiarlin	https://www.instagram.com/ptriiarlin
612	1001	nandasulisti__	https://www.instagram.com/nandasulisti__
613	1001	misellia_	https://www.instagram.com/misellia_
614	1001	trisepti_rahayu	https://www.instagram.com/trisepti_rahayu
615	1001	farahfhrz	https://www.instagram.com/farahfhrz
616	1001	fcbarcelona	https://www.instagram.com/fcbarcelona
617	1001	azizaaawafiz	https://www.instagram.com/azizaaawafiz
618	1001	alfa_yusuf_adriano	https://www.instagram.com/alfa_yusuf_adriano
619	1001	lolyta.weddingkebumen	https://www.instagram.com/lolyta.weddingkebumen
620	1001	_verdiawan	https://www.instagram.com/_verdiawan
621	1001	aufaderman	https://www.instagram.com/aufaderman
622	1001	hartanty_54	https://www.instagram.com/hartanty_54
623	1001	rttnad_	https://www.instagram.com/rttnad_
624	1001	dwinandamutiarani	https://www.instagram.com/dwinandamutiarani
625	1001	panducoco	https://www.instagram.com/panducoco
626	1001	304prianwar_	https://www.instagram.com/304prianwar_
627	1001	rhaswhy	https://www.instagram.com/rhaswhy
628	1001	prayss__	https://www.instagram.com/prayss__
629	1001	nilampsdw_	https://www.instagram.com/nilampsdw_
630	1001	atletvocal	https://www.instagram.com/atletvocal
631	1001	indafiqrizki	https://www.instagram.com/indafiqrizki
632	1001	st_stewart	https://www.instagram.com/st_stewart
633	1001	oisina_	https://www.instagram.com/oisina_
634	1001	masj_rfkm23	https://www.instagram.com/masj_rfkm23
635	1001	ungguldk_	https://www.instagram.com/ungguldk_
636	1001	sitimukholifaah	https://www.instagram.com/sitimukholifaah
637	1001	maay_ny_	https://www.instagram.com/maay_ny_
638	1001	salfanadiaa	https://www.instagram.com/salfanadiaa
639	1001	ylnarenn	https://www.instagram.com/ylnarenn
640	1001	zahrasoff_	https://www.instagram.com/zahrasoff_
641	1001	icaannis_	https://www.instagram.com/icaannis_
642	1001	agnesindina	https://www.instagram.com/agnesindina
643	1001	nobiiito	https://www.instagram.com/nobiiito
644	1001	dew.tl	https://www.instagram.com/dew.tl
645	1001	angginandaa_	https://www.instagram.com/angginandaa_
646	1001	heronimusagung	https://www.instagram.com/heronimusagung
647	1001	kikiiiumayy	https://www.instagram.com/kikiiiumayy
648	1001	annisarchmwti_	https://www.instagram.com/annisarchmwti_
649	1001	farah_liaa	https://www.instagram.com/farah_liaa
650	1001	novitapil	https://www.instagram.com/novitapil
651	1001	osis_stemsago	https://www.instagram.com/osis_stemsago
652	1001	niftaseptiana	https://www.instagram.com/niftaseptiana
653	1001	milaftrnn	https://www.instagram.com/milaftrnn
654	1001	nywiji_	https://www.instagram.com/nywiji_
655	1001	persib	https://www.instagram.com/persib
656	1001	saldiramdaniii	https://www.instagram.com/saldiramdaniii
657	1001	bimonh_	https://www.instagram.com/bimonh_
658	1001	keretaapikita	https://www.instagram.com/keretaapikita
\.


--
-- Data for Name: hashtags; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.hashtags (hashtag_id, hashtag) FROM stdin;
201	pemilu
202	pilpres
\.


--
-- Data for Name: post_hashtag; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.post_hashtag (ph_id, post_id, hashtag_id) FROM stdin;
301	101	201
302	102	201
303	103	201
304	104	201
305	105	201
306	106	201
307	107	201
308	108	201
309	109	201
310	110	201
311	111	201
312	112	201
313	113	201
314	114	201
315	115	201
316	116	201
317	117	201
318	118	201
319	119	201
320	120	201
321	121	201
322	122	201
323	123	201
324	124	201
325	125	201
326	126	201
327	127	201
328	128	201
329	129	201
330	130	201
331	131	201
332	132	201
333	133	201
334	134	201
335	135	201
336	136	202
337	137	201
338	138	201
339	139	201
340	140	202
341	141	201
342	142	201
343	143	201
344	144	201
345	145	201
346	146	202
347	147	202
348	148	202
349	149	202
350	150	202
351	151	201
352	152	201
353	153	202
354	154	202
355	155	202
356	156	202
357	157	202
358	158	202
359	159	202
360	160	202
361	161	202
362	162	202
363	163	202
364	164	202
365	165	201
366	166	202
367	167	202
368	168	202
369	169	202
370	170	202
371	171	202
372	172	202
373	173	202
374	174	202
375	175	202
376	176	202
377	177	202
378	178	202
379	179	202
380	180	202
381	181	202
382	182	202
383	183	202
384	184	202
385	185	201
386	186	202
387	187	202
388	188	201
389	189	202
390	190	201
391	191	202
392	192	202
393	193	202
394	194	202
395	195	202
396	196	201
397	197	202
398	198	202
399	199	202
400	200	202
\.


--
-- Data for Name: post_sentiment; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.post_sentiment (ps_id, post_id, sentiment_analysis) FROM stdin;
401	101	neutral
402	102	neutral
403	103	neutral
404	104	positive
405	105	neutral
406	106	neutral
407	107	neutral
408	108	neutral
409	109	neutral
410	110	neutral
411	111	neutral
412	112	neutral
413	113	neutral
414	114	neutral
415	115	neutral
416	116	neutral
417	117	neutral
418	118	neutral
419	119	neutral
420	120	neutral
421	121	neutral
422	122	positive
423	123	neutral
424	124	positive
425	125	neutral
426	126	neutral
427	127	neutral
428	128	neutral
429	129	neutral
430	130	neutral
431	131	neutral
432	132	neutral
433	133	neutral
434	134	positive
435	135	neutral
436	136	positive
437	137	positive
438	138	neutral
439	139	neutral
440	140	neutral
441	141	neutral
442	142	negative
443	143	neutral
444	144	positive
445	145	neutral
446	146	positive
447	147	neutral
448	148	positive
449	149	positive
450	150	neutral
451	151	negative
452	152	neutral
453	153	neutral
454	154	neutral
455	155	neutral
456	156	neutral
457	157	neutral
458	158	neutral
459	159	neutral
460	160	neutral
461	161	positive
462	162	neutral
463	163	neutral
464	164	negative
465	165	neutral
466	166	neutral
467	167	neutral
468	168	positive
469	169	neutral
470	170	neutral
471	171	neutral
472	172	neutral
473	173	neutral
474	174	neutral
475	175	neutral
476	176	neutral
477	177	neutral
478	178	neutral
479	179	neutral
480	180	neutral
481	181	positive
482	182	positive
483	183	neutral
484	184	positive
485	185	neutral
486	186	neutral
487	187	neutral
488	188	neutral
489	189	positive
490	190	positive
491	191	positive
492	192	positive
493	193	neutral
494	194	negative
495	195	neutral
496	196	neutral
497	197	positive
498	198	neutral
499	199	neutral
500	200	neutral
\.


--
-- Data for Name: post_type; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.post_type (pt_id, post_id, content_type) FROM stdin;
501	101	promotion
502	102	news
503	103	news
504	104	promotion
505	105	opinion
506	106	news
507	107	opinion
508	108	opinion
509	109	news
510	110	news
511	111	opinion
512	112	promotion
513	113	news
514	114	news
515	115	opinion
516	116	news
517	117	opinion
518	118	opinion
519	119	opinion
520	120	opinion
521	121	opinion
522	122	opinion
523	123	opinion
524	124	news
525	125	promotion
526	126	promotion
527	127	promotion
528	128	opinion
529	129	news
530	130	news
531	131	news
532	132	news
533	133	opinion
534	134	news
535	135	news
536	136	opinion
537	137	news
538	138	opinion
539	139	news
540	140	opinion
541	141	news
542	142	opinion
543	143	opinion
544	144	opinion
545	145	opinion
546	146	news
547	147	news
548	148	news
549	149	news
550	150	promotion
551	151	opinion
552	152	opinion
553	153	opinion
554	154	promotion
555	155	promotion
556	156	news
557	157	news
558	158	promotion
559	159	news
560	160	news
561	161	news
562	162	promotion
563	163	news
564	164	news
565	165	news
566	166	promotion
567	167	opinion
568	168	news
569	169	promotion
570	170	promotion
571	171	promotion
572	172	promotion
573	173	promotion
574	174	news
575	175	promotion
576	176	promotion
577	177	news
578	178	promotion
579	179	news
580	180	news
581	181	news
582	182	news
583	183	news
584	184	promotion
585	185	opinion
586	186	promotion
587	187	promotion
588	188	opinion
589	189	opinion
590	190	news
591	191	news
592	192	opinion
593	193	news
594	194	news
595	195	news
596	196	promotion
597	197	opinion
598	198	news
599	199	news
600	200	promotion
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.posts (post_id, user_id, post_url, "timestamp", caption, comments_count, likes_count) FROM stdin;
101	1	https://www.instagram.com/p/C7lnZiPPMzH/	2024-05-30 09:33:54+00	Besok yukkk.. Dialog Luar Studio Pasca Pemilu RRI Makassar dengan topik "Refleksi Pendidikan Demokrasi Pasca Pemilu"\n#rrimakassar \n#pendidikandemokrasi\n#demokrasi\n#pemilu	0	7
102	2	https://www.instagram.com/p/C7lmLtyxhsr/	2024-05-30 09:23:16+00	Rapat Evaluasi Pemetaan TPS oleh PPK dan KPU Lampung Selatan divisi Data & Informasi untuk Pilkada Serentak 2024.\n\n#kpu #kpumelayani  #pilkadaserentak2024\n#kpujangancurang\n#kpuri #kpulampung #kpuprovinsilampung #kpukablampungselatan #pemilu2024 #pemilu #pilkada2024 #pilkada #lampung #lampungselatan #ppkjatiagung #ppk #jatiagunglampungselatan	0	2
103	3	https://www.instagram.com/p/C7ltyL9Jxba/	2024-05-30 10:29:42+00	“Menteri Pertahanan Prabowo Subianto menyambut kunjungan Kepala Staf pertahanan Inggris, Laksamana Sir Antony David Radakin. Prabowo langsung menyambut kedatangan Radakin di kantornya.“\n\n@laskarprabowo_08\nSBr:20detik\n#LaskarPrabowo08 #PrabowoSubianto #Berita \n#LaskarPrabowo08 \n#Djojohadikusumo #Hashim #HashimDjojohadikusumo #Prabowo #PrabowoSubianto #PrabowoPresiden #PrabowoPresiden2024 #PrabowoGibran #Gibran #Rakabumingraka #GibranWakilPresiden #GibranWakilPresiden2024 #Presiden2024 #Jakarta #MarkasLaskarPrabowo #Like #Instagram #Follow #Pemilu #Info #Fyp #fyptiktok	0	4
104	4	https://www.instagram.com/p/C7lnT61xDby/	2024-05-30 09:33:08+00	Wahyu Nurjamil mantap mencalonkan diri sebagai Calon Wali Kota Serang untuk periode 2024-2029. Salah satu program unggulannya adalah menjadikan Kota Serang sebagai kota kreatif pada tahun 2029 guna meningkatkan Pendapatan Asli Daerah (PAD) Kota Serang. Bagaimana langkah @wahyu_nurjamil untuk mendapatkan atensi masyarakat Kota Serang dalam kontestasi Pilkot Serang? Saksikan hanya di Program Siapa Dia yang tayang di YouTube Chanel Sultantv.\n\n#siapdia #beranitampil #beranimaju #untukkotaserang #pilkot #pilkada #pilkada2024 #pemilu #pemilu2024 #calonkepaladaerah #cawalkot #wahyunurjamil #bacalona	2	14
105	5	https://www.instagram.com/p/C7ltztnPGO0/	2024-05-30 10:29:54+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	1
106	6	https://www.instagram.com/p/C7ljoadP0cC/	2024-05-30 09:00:59+00	Mahkamah Agung (MA) mengabulkan permohonan Partai Garuda terkait aturan syarat batas minimal usia calon kepala daerah.\n\nAtas dasar itu, MA meminta KPU untuk mencabut Pasal 4 Ayat (1) huruf d PKPU Nomor 9 tentang Pencalonan Pemilihan Gubernur dan Wakil Gubernur, Bupati dan Wakil Bupati, dan/atau Wali kota dan Wakil Wali Kota.\n\nTemukan informasi menarik lainnya di @ifess.me dan saatnya kita #ngobrolasik di kolom komentar. 😉\n\n#pilkada #pemilu #coblos #kpu #ma	13	-1
107	7	https://www.instagram.com/p/C7lt0mWv8zD/	2024-05-30 10:30:01+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	1
108	8	https://www.instagram.com/p/C7ltzFZPPFr/	2024-05-30 10:29:49+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	1
109	9	https://www.instagram.com/p/C7ld_blhkH4/	2024-05-30 08:11:41+00	TPS 3 SEKARAN \nPilpres 2024\n#pilpres2024\n#pemilu2024\n#pemilu	0	0
110	10	https://www.instagram.com/p/C7lfswghU09/	2024-05-30 08:26:37+00	Selamat dan sukses atas pelantikan Panitia Pemungutan Suara(PPS) se-kacamatan sangatta selatan\n\n---------\nBersama Rakyat Awasi Pemilu Bersama Bawaslu Tegakkan Keadilan Pemilu.\n---------\n✉️ Panwassangattaselatan@gmail.com\n🏛️ Jl. Pelajar No 13 RT. 21 Kelurahan Singa Geweh\n---------------\nInstagram : Panwascam_Sangattaselatan\nFacebook : Panwascam Sangattaselatan\nTwetter : Panwascam_Sangattaselatan\nYoutube : Panwaslu Sangatta Selatan\n---------\n#sangatta #bawasluri #bawaslu #panwaslusangattaselatan #bawaslukutim #pemilu2024 #BawasluMengawasi #pemilu #sahabatbawaslu #awasipemilu #bersamarakyatawasipemilu #bersamabawaslutegakkankeadilanpemilu	0	7
111	11	https://www.instagram.com/p/C7lceT2SiIz/	2024-05-30 07:58:26+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
112	12	https://www.instagram.com/p/C7li519RlJi/	2024-05-30 08:54:37+00	#PPSDESAPULO #pemilu	0	1
113	13	https://www.instagram.com/p/C7lniBJycVH/	2024-05-30 09:35:03+00	Mahkamah Agung (MA) kabulkan permohonan yang diajukan oleh Ahmad Ridha Sabana dari Partai Garuda terkait aturan batas minimal usia calon kepala daerah. Partai Garuda meminta penghapusan syarat usia minimal 30 tahun sebagai calon gubernur dan wakil gubernur.\n\n"Mengabulkan permohonan keberatan hak uji materiil dari Pemohon: PARTAI GARDA REPUBLIK INDONESIA (PARTAI GARUDA)," demikian bunyi Putusan Nomor 23 P/HUM/2024. Putusan ini diambil majelis hakim yang diketuai oleh Yulius dan anggota majelis Cerah Bangun pada Rabu (29/5/2024).\n\nDengan putusan itu, MA memerintahkan KPU RI untuk mencabut Pasal 4 ayat (1) huruf d PKPU Nomor 9 tahun 2020 tentang Pencalonan Pemilihan Gubernur dan Wakil Gubernur, Bupati dari Wakil Bupati, dan/atau Walikota dan Wakil Walikota.\n\n#pilkada #pemilu #walikota #gubernur #wakil #rakyat #viral #news #media	0	21
114	14	https://www.instagram.com/p/C7ld6uRvc-s/	2024-05-30 08:11:03+00	[WAWANCARA CALON PKD]\n\nTelah terlaksana kegiatan Wawancara PKD se-Kecamatan Depok pada hari Selasa tanggal 28 Mei 2024 bertempat di Kapanewon Depok Kabupaten Sleman.\n\n#pemilu\n#pemiluserentak2024 \n#panwascam \n#bawaslu \n#bawaslumengawasi \n#pilkada2024	0	8
115	15	https://www.instagram.com/p/C7lcQpqS1ve/	2024-05-30 07:56:34+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
116	16	https://www.instagram.com/p/C7lr2xnNzCM/	2024-05-30 10:12:51+00	Mahkamah Agung (MA) mengabulkan permohonan Ketua Umum Partai Garuda terkait peraturan batas usia kepala daerah minimal 30 tahun untuk dicabut.\n\nDari putusan tersebut, MA telah mengubah yang awalnya Cagub dan Cawagub minimal berusia 30 tahun, yang terhitung sejak penetapan calon menjadi setelah pelantikan.\n\n(Sumber : SINDO News)\n#MahkamahAgung #Pilkada #Pemilu #BeritaNasional	2	11
117	17	https://www.instagram.com/p/C7lcP_9y_sU/	2024-05-30 07:56:29+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
118	18	https://www.instagram.com/p/C7lcMNWyc4Z/	2024-05-30 07:55:57+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
119	19	https://www.instagram.com/p/C7lcPDfyG0f/	2024-05-30 07:56:21+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
120	20	https://www.instagram.com/p/C7lcPb9S4JI/	2024-05-30 07:56:24+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
121	21	https://www.instagram.com/p/C7lcNMiSaKd/	2024-05-30 07:56:06+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
122	22	https://www.instagram.com/p/C7mQYbsJoii/	2024-05-30 15:32:01+00	Pembangunan IKN terus melaju tinggi....\n\nGroundbreaking IKN tahap 6 akan segera dilakukan. OIKN kasih bocoran sektor yang akan difokuskan kali ini adalah pendidikan. Misalnya, Al Azhar akan melakukan groundbreaking, ada Sekolah Bina Bangsa, ada universitas dari Malaysia.\n\nNggak kerasa yaa, pembangunan IKN sudah sampai tahap ke 6 saja.\n\nOptimis banget nih, IKN bakal rampung tepat waktu!\n\nCoba komen, bagaimana pendapat kalian tentang IKN ini!?\n\n#prabowo #prabowogibran #prabowopresiden #prabowosubianto #pemilu2024 #pemiludamai #pemilu #kpu #indonesiaku #indonesia #republikindonesia #jokowi #jokowipresidenku #jokowidodo #jokowiprabowo #jokowilagi #gibran #gibranrakabumingraka #jakarta #merahputih #merdeka #prabowogibran2024 #indonesiajaya #gemoy #jendral #prabowopresiden2024 #jokowikerjanyata	0	0
123	23	https://www.instagram.com/p/C7lcOdqyzXH/	2024-05-30 07:56:16+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
124	24	https://www.instagram.com/p/C7mEs1FPbvG/	2024-05-30 13:49:56+00	.\nRapat koordinasi PPK dan PPS se-Kecamatan malangbong, dalam rangka tahap lanjut persiapan pelaksanaan Pilkada 2024. \n\n"Gemilang; Gembira Memilih Langsung"\n__________\n#pps #ppkmalangbong #malangbong #pemilu #pilkada #2024 #garut #kabupatengarut #jawabarat	0	2
125	25	https://www.instagram.com/p/C7mEKP7ROQ6/	2024-05-30 13:45:13+00	SOLDOUT !! Laptop Asus BABY ROG X550IK AMD FX Ram 24gb/ssd 256gb vga 4gb ! #laptopmaster #konser #traveling #monalisa #konserblackpink #muncak #idulfitri #black #travelista #france #pilpres2024 #tokyo #savepalestine #masterlaptop #foryourpage #starbucks #zoo #europe #travel #skyfall #rajalaptop #cr7 #travelling #pestademokrasi #funnybaby #bandung #bali #lisa #lampung #pemilu	0	0
126	26	https://www.instagram.com/p/C7mH0ULx48I/	2024-05-30 14:17:10+00	SOLDOUT !! Laptop HP Victus i5-12500 Ram 16gb/ssd 512gb vga Nvidia RTX 3050 Garansi Resmi ! #laptopmaster #konser #traveling #monalisa #konserblackpink #muncak #idulfitri #black #travelista #france #pilpres2024 #tokyo #savepalestine #masterlaptop #foryourpage #starbucks #zoo #europe #travel #skyfall #rajalaptop #cr7 #travelling #pestademokrasi #funnybaby #bandung #bali #lisa #lampung #pemilu	0	0
127	27	https://www.instagram.com/p/C7mF6iURvzg/	2024-05-30 14:00:33+00	SOLDOUT !! Laptop Lenovo X1 Carbon i5 Haswell Ram 8Gb/Ssd 256Gb slim ! #laptopmaster #konser #traveling #monalisa #konserblackpink #muncak #idulfitri #black #travelista #france #pilpres2024 #tokyo #savepalestine #masterlaptop #foryourpage #starbucks #zoo #europe #travel #skyfall #rajalaptop #cr7 #travelling #pestademokrasi #funnybaby #bandung #bali #lisa #lampung #pemilu	0	0
128	28	https://www.instagram.com/p/C7mDgzaRwYC/	2024-05-30 13:39:33+00	oke gas kita otewe..\n#PrabowoGibran #OkeGas #PrabowoPresiden #Presidenku #indonesiamaju #indonesiahebat #prabowo #pilkada2024 #pemilu #gemoyimutlucu #gemoy	0	1
129	29	https://www.instagram.com/p/C7l8bklhCKJ/	2024-05-30 12:37:41+00	Panwaslu Kec. Sangatta Selatan  melaksanakan rapat persiapan pelantikan panwaslu kelurahan/desa(PKD)\n\n---------\nBersama Rakyat Awasi Pemilu Bersama Bawaslu Tegakkan Keadilan Pemilu.\n---------\n✉️ Panwassangattaselatan@gmail.com\n🏛️ Jl. Pelajar No 13 RT. 21 Kelurahan Singa Geweh\n---------------\nInstagram : Panwascam_Sangattaselatan\nFacebook : Panwascam Sangattaselatan\nTwetter : Panwascam_Sangattaselatan\nYoutube : Panwaslu Sangatta Selatan\n---------\n#sangatta #bawasluri #bawaslu #panwaslusangattaselatan #bawaslukutim #pemilu2024 #BawasluMengawasi #pemilu #sahabatbawaslu #awasipemilu #bersamarakyatawasipemilu #bersamabawaslutegakkankeadilanpemilu	0	4
130	30	https://www.instagram.com/p/C7mDRL1vlRW/	2024-05-30 13:37:25+00	Rapat pembentukan Sekretariat PPS Desa Pungangan Limpung Batang bersama KPU Batang dan PPK Kecamatan Limpung \n\n#jateng #jatenggayeng #pemilu\n#pilgub #pilgubjateng #kpu #kpumelayani #dailypost #savethedate #batang #batanghits #pekalongan #batik #batikpekalongan #batikbatang #magelang #solo #semarang #kendal #demak #pati #kudus #rembang #grobogan #blora	0	6
131	31	https://www.instagram.com/p/C7l5tc2RyQE/	2024-05-30 12:13:54+00	Kepolisian Daerah (Polda) Kepulauan Riau menggagalkan penyelundupan 52 ekor anak buaya jenis Muara yang akan dikirim ke Thailand.\n\nDirektorat Reserse Kriminal Khusus (Ditreskrimsus) Polda Kepri Kombes Pol Putu Yudha Prawira menyebut, 52 ekor anak buaya diamankan di Pelabuhan Tanjung Riau pada Sabtu 25 Mei 2024.\n\n“52 anak buaya Muara datang dari Tembilahan rencana akan dikirim ke luar negeri Thailand,” ujarnya didampingi Kabid Humas Polda Kepri Kombes Pol Zahwani Pandra Arsyad, dalam jumpa pers di Polda Kepri, Kamis (30/5/2024).\n\nIa menjelaskan pengungkapan satwa yang dilindungi berkat dari laporan masyarakat hingga ditindaklanjuti.\n\n“Tim Subdit Tipiter berhasil menangkap 2 pelaku inisial Mr dan Ir bersama dengan barang bukti,” ujarnya.\n\nDari hasil pemeriksaan pelaku mengaku baru pertama mengirim buaya tersebut dari Tembilahan Riau melalui Kota Batam menuju Malaysia dan Thailand.\n\n📷 Dok: Zal/matapedia\n\nBaca selengkapnya di matapedia6.com. Jangan lupa follow instagram matapedia6com and Facebook, YouTube, Tiktok untuk berita menarik lainnya! \n\n#focus #beritaterkini #kepri #pemilu #pilgub\n#bpbatam #kepri #batam #bandara hangnadim #terminal	0	0
132	32	https://www.instagram.com/p/C7l5Eg0xHrw/	2024-05-30 12:08:19+00	Direktorat Reserse Kriminal Khusus (Ditreskrimsus) sita sepasang musang jenis Binturang dari warga Sekupang, Kota Batam, Provinsi Kepri.\n\nPenyiataan sepasang musang benturang tersebut, karena hewan tersebut merupakan hewan yang masuk dalam satwa yang dilindungi.\n\nSaat konferensi Pers di Polda Kepri, Kamis (30/5/2024) Direktur Reserse Kriminal Khusus (Dirreskrimsus) Polda Kepri Kombes Pol Putu Yudha Prawira menjelaskan sepasang Binturang tersebut di sita dari warga setelah ada informasi dari masyarakat.\n\n“Sepasang Binturang ini kita sita dari RS warga Sekupang pada Selasa (21/5) lalu, setelah ada informasi dari warga,” kata Putu.\n\nDia menjelaskan pemilik hewan tersebut tidak diproses secara hukum, karena hewan tersebut akhirnya diserahkan kepada instansi berwenang secara sukarela.\n\n“Hasil penyidikan kita diketahui pemilik hewan ini sudah memelihara sepasang binturang tersebut sejak kecil, sampai saat ini berumur 10 tahun,” kata Putu.\n\n📷 Dok: Lucia/matapedia\n\nBaca selengkapnya di matapedia6.com. Jangan lupa follow instagram matapedia6com and Facebook, YouTube, Tiktok untuk berita menarik lainnya! \n\n#focus #beritaterkini #kepri #pemilu #pilgub\n#bpbatam #kepri #batam #bandara hangnadim #terminal	0	0
133	33	https://www.instagram.com/p/C7l5N4OS0e2/	2024-05-30 12:09:35+00	Wujudkan pilkada 2024 dengan damai dan tentram\n#pilkada #fyp #bantufollow #pemilu  @kpukuburaya @kpukalbarprov @ppk_telukpakedai	0	1
134	34	https://www.instagram.com/p/C7l4TdYv-L9/	2024-05-30 12:01:37+00	.\nRakor PPS dan Kepala Desa Cikarag untuk mencapai sinergi dalam mensukseskan Pilkada tahun 2024, sekaligus pembentukan dan pengangkatan sekretariat Panitia Pemungutan Suara.\n\n"Gemilang; Gembira Memilih Langsung"\n\n_________\n#pps #pilkada2024 #pemilu #garut #jawabarat #gemilang #kabupatengarut	2	4
155	55	https://www.instagram.com/p/C7jxU7zvolP/	2024-05-29 16:22:10+00	Komen dong mas kurangnya apa?!\n.\nFollow: @audi.genki @april.genki @bella.genki @tania.genki\n.\n.\n#pilpres2024 #repost #vscocam #idol #beautiful #gym #bigo #reels #tiktok #pacar #prabowo #cewe #2024#reelsinstagram #selfie #tiktokindonesia #vsco #viral #model #pilpres #love #artist #okegas #instagood #cute	0	0
135	35	https://www.instagram.com/p/C7l4jWDR-_U/	2024-05-30 12:03:47+00	Ketua DPRD Kota Batam Nuryanto didampingi Wakil Ketua III Muhammad Yunus Muda, pimpin rapat paripurna agenda mendengarkan jawaban Wali Kota Batam atas pandangan umum fraksi terhadap Ranperda Pertanggungjawaban Pelaksanaan APBD Kota Batam tahun anggaran 2023.\n\nRapat paripurna yang digelar di ruang Sidang Utama (@dprd.kotabatam )DPRD Kota Batam, dihadiri 26 orang dari 50 anggota dewan, Rabu (29/5/2024).\n\nJawaban Walikota Batam atas pandangan umum fraksi terhadap Ranperda Pertanggungjawaban Pelaksanaan APBD Kota Batam tahun anggaran 2023 yang disampaikan Sekretaris Daerah Kota Batam Jefridin Hamid mewakili Wali Kota Muhammad Rudi.\n\nJefridin, mengucapkan terima kasih dan apresiasi yang disampaikan Dewan terkait opini Wajar Tanpa Pengecualian (WTP) ke-12 yang diperoleh Pemko Batam atas pemeriksaan keuangan oleh BPK RI.\n\nJefridin menyampaikan sejumlah kendala yang mengakibatkan sektor pendapatan daerah tersebut tidak mencapai target 100 persen.\n\nKetua DPRD Kota Batam Nuryanto melanjutkan agenda rapat berikutnya yakni Pandangan Umum Fraksi-fraksi tentang Rencana Pembangunan Jangka Panjang Daerah (RPJPD) Kota Batam tahun 2025-2045.\n\n📷 Dok: Dhe/matapedia\n\nBaca selengkapnya di matapedia6.com. Jangan lupa follow instagram matapedia6com and Facebook, YouTube, Tiktok untuk berita menarik lainnya! \n\n#focus #beritaterkini #kepri #pemilu #pilgub\n#bpbatam #kepri #batam #bandara hangnadim #terminal	0	0
136	36	https://www.instagram.com/p/C7mQO9xPHFG/	2024-05-30 15:30:43+00	Siapa nih yang takjub dengan IKN...?\n\nPerlu kita ketahui nih, keberadaan Ibu Kota Nusantara akan menjadi showcase atau ajang pamer bagi Indonesia ke dunia. Dimana IKN diimpikan akan berdiri sebagai kota pengguna energi baru terbarukan (EBT) yang ramah lingkungan.\n\nJadi, bisa dikatakan IKN itu akan menjadi zona yang nol alias bebas emisi. Bangsa Indonesia akan sangat bangga jika suatu ketika nanti IKN sudah beroperasi secara penuh. \n\nTak ketinggalan, IKN bisa dijadikan contoh bagi negara-negara dunia untuk mengembangkan green city, green capital, sebagai mana halnya IKN nanti.\n\nMakin takjub deh sama IKN. Kota masa depan KITA!\n\nCoba komen, bagaimana pendapat kamu soal ini!?\n\n#prabowosubianto #prabowosubiantopresiden2024 #prabowosubiantopresiden #prabowosubiantoforri1 #prabowosubiantopresidenri2024 #prabowosubiantodjojohadikusumo #jokowi #politik #indonesiamaju #prabowo #nkri #viralindonesia #gerindra #pilpres #jokowidodo #politikindonesia #gibranrakabumingraka #pemilu #prabowopresiden #pilpres2024 #pemilu2024 #presiden #capres #irianajokowidodo #capres2024 #gibran #calonpresiden #irianajokowi #kaesangpangarep #gibranrakabuming	0	0
137	37	https://www.instagram.com/p/C7l23I_Pedz/	2024-05-30 11:49:01+00	.\nPelantikan, Pengambilan Sumpah/Janji, dan Penandatanganan Pakta Integritas CPPS se-Kabupaten Garut. \n\nLok.; Hotel Harmoni Garut, Jl. Cipanas Baru, No. 7, Tarogong Kaler.\n\n"Gemilang; Gembira Memilih Langsung"\n\n_______\n#pilkada #2024 #pps #pemilu #kabupatengarut #garut #jawabarat	0	0
138	38	https://www.instagram.com/p/C7l9Ur5JHEJ/	2024-05-30 12:45:28+00	Sah Kan UU perampasan Aset Biar Seru 😎\n\nFollow | Like | Komen | Share \n\n#pemilu #mahfudmd  #Ganjarpranowo #PDIP #Gibran #Jokowi #Jokowidodo #Indonesia  #prabowo #anies #Presiden  #menlu #Jakarta #Bandung #Banten #bali #viral #fyp	5	78
139	39	https://www.instagram.com/p/C7l2p3_x1pP/	2024-05-30 11:47:12+00	Komisi Pemilihan Umum (KPU) Kota Batam secara resmi menetapkan 50 nama calon terpilih anggota DPRD Kota Batam pada rapat pleno terbuka penetapan perolehan kursi di Hotel Artotel, Penuin, Kota Batam, Selasa (28/5/2024).\n\n50 kursi dihiasi dengan wajah yang baru untuk periode 2024-2029 di DPRD Kota Batam, Kepulauan Riau.\n\nBerdasarkan penetapan KPU Partai Nasdem memperoleh tempat terbanyak 10 kursi.\n\nKetua KPU Kota Batam, Mawardi, menyebut hasil penetapan merupakan ketentuan dari Mahkamah Konstitusi (MK) pasca keluarnya putusan atas sengketa Pemilu di Batam.\n\n📷 Dok: Istimewa\n\nBaca selengkapnya di matapedia6.com. Jangan lupa follow instagram matapedia6com and Facebook, YouTube, Tiktok untuk berita menarik lainnya! \n\n#focus #beritaterkini #kepri #pemilu #pilgub\n#bpbatam #kepri #batam	0	0
140	40	https://www.instagram.com/p/C7l8IYNSo1K/	2024-05-30 12:35:38+00	Bangun kontrak politik yang kuat dengan strategi yang tepat. Dalam konten ini, kita akan membahas bagaimana membuat kontrak politik yang efektif dan membantu membangun kepercayaan dengan masyarakat.  #Politik #KontrakPolitik" #PILKADA2024 #pilpres #pemilu #jokowi #prabowo  #KONSULTANPOLITIK #politicianacademy	0	9
141	41	https://www.instagram.com/p/C7lzgHRypcz/	2024-05-30 11:19:39+00	Selamat untuk @bawaslu_karawang atas diraihnya piagam penghargaan katagori pencegahan pelanggaran Pemilu 2024...\n.\n.\n#karawangtimur #karawang #pemiluserentak2024 #pemilu #pemilu2024 #panwascamkarawangtimur #panwascam2024 #sahabatbawaslu #pengawasanpilkada #ayoawasibersama	0	5
142	42	https://www.instagram.com/p/C7lyjRMR02Y/	2024-05-30 11:11:21+00	wkwk gk pernah juara sayembara2 lokal apalagi dari instansi2, bukan soal kalahnya ini lho ya.. tapi penyelenggaran yg agak2 dan keanehan2nya ternyata juga terjadi di daerah2 lain dan cukup ramai diperbincangkan teman2 Design juga ilustrator, gk lazim sebagaimana proses sayembara2 umumnya yg biasa kita ikut ( pura2 kaget ! ),banyak klw saya tulis disini,maless....! mungkin dari teman2 yg sempat ikut taulah ya...😄\n\nOk sedikit cerita pemilihan maskot sayembara sy kali ini " si Kawung ",pertama sengaja gk pakai sebuah nama dari akronim kata2 seputar pemilu seperti peserta lainnya,selain gk ada dlm syarat ,klw dipaksa paksa gk enak juga diucapkan dan pasti ada banyak kemiripan dgn peserta lainnya ya karena kata2nya itu2 aja, nama dan jargon sy buat berbeda\n\nkedua, maskot seperti pisang dan jaran kencak sudah sering muncul di maskot2 instansi,cinderamata dll di Lumajang, apalagi pisang yg menurut sy sudah overuse penggunaanya,bisa diganti potensi2 lain yg belum banyak diangkat,sy pilihlah topeng Kaliwungu yg kemudian sy singkat "Kawung" untuk maskot IP ,imajinasi sy bocah yg memakai topeng Kaliwungu, apalagi topeng Kaliwungu sudah dikategorikan warisan budaya tak benda, perlu diexplore dan disosialisasikan lagi gitu kan\n\nawalnya sudah ragu untuk ikut sayembara kali ini, cuma masih kusnudzon kali aja sudah berbeda dan lebih profesional,tapi eeeh ya gitu dech...overall gk ngarep apa2 ,cuma spik ap dan sambat aja..hehe\n\nini bisa jadi yg terakhir ikutan haha.\n\nbtw sekalian saya jual desain maskot karakter  si Kawung ini barangkali ada yg minat? bisa untuk keperluan brand wisata dll..hihihi😁\n\n#lumajang#jawatimur#pemilu#maskot#pilkada#sayembara#kpu#mascot#karikatur#lumajanghits#pilkadalumajang	15	22
143	43	https://www.instagram.com/p/C7lt1FGvl__/	2024-05-30 10:30:05+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	1
144	44	https://www.instagram.com/p/C7l7vZip82x/	2024-05-30 12:31:39+00	Millenials untuk DKI 👏🇮🇩\n\nCalon Gubernur DKI @budidjiwandono dengan Calon Wakil Gubernur DKI @kaesangp \n\nCocokkah? 😎\n\n#gubernurdki \n#dki\n#wagubdki\n#pilgubdki \n#pilgub\n#pemilu	0	11
145	45	https://www.instagram.com/p/C7lZ7EASY0q/	2024-05-30 07:36:08+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
146	46	https://www.instagram.com/p/C7mCxRMPtPz/	2024-05-30 13:33:04+00	"Menteri Koordinator Perekonomian, Airlangga Hartarto memimta masyarakat ikut mengkaji manfaat dari penerapan Tabungan Perumahan Rakyat (Tapera). Kebijakan Tapera akan memotong gaji karyawan sebesar 3 persen di mana 0,5 ditanggung perusahaan dan 2,5 persen ditanggung pekerja.\n\nMenurut Airlangga, Tapera memiliki banyak manfaat yang memudahkan masyarakat dalam memiliki rumah hingga merenovasi. ""Tapera perlu dilihat mungkin benefitnya, dan tentu dikaji manfaat apa yang bisa diperoleh oleh para pekerja terkait dengan perolehan perumahan maupun untuk renovasi perumahan,"" ujar Airlangga saat ditemui selepas Rakortas di kantor Kemenko Perekonomian, Rabu (29/5/2024)."\n\n#ganjar_pranowo #ganjar #ganjaryasin #pilpres #gibranrakabumingraka #pemudajateng #ganjarpilihanjokowi #ganjarajasudahpokokeoraonoliane #ganjarbersamarakyat #ganjarcapres2024 #ganjardihati #ganjarforindonesia #ganjarfans #ganjaryasin #rockygerungofficial #kaesang #srikandiganjar #makganjar #orangmudaganjar #jokowi #titokarnavian	0	0
147	47	https://www.instagram.com/p/C7mAyU7P-X5/	2024-05-30 13:15:44+00	"Pemerintah menjanjikan gaji utuh tanpa potongan pajak penghasilan (PPh) 21 bagi karyawan yang bekerja di Ibu Kota Nusantara karyawan akan mendapat fasilitas bebas pajak hingga 2035. \n\nMenteri Keuangan, Sri Mulyani Indrawati telah menerbitkan Peraturan Menteri Keuangan (PMK) Nomor 28 Tahun 2024 tentang Fasilitas Perpajakan dan Kepabeanan di Ibu Kota Nusantara (IKN). "\n\n#ganjar_pranowo #ganjar #ganjaryasin #pilpres #gibranrakabumingraka #pemudajateng #ganjarpilihanjokowi #ganjarajasudahpokokeoraonoliane #ganjarbersamarakyat #ganjarcapres2024 #ganjardihati #ganjarforindonesia #ganjarfans #ganjaryasin #rockygerungofficial #kaesang #srikandiganjar #makganjar #orangmudaganjar #jokowi #titokarnavian	0	0
148	48	https://www.instagram.com/p/C7mBFoRyMXC/	2024-05-30 13:18:22+00	"Badan Riset dan Inovasi Nasional (BRIN) merekomendasikan dari tiga kebun raya yang akan dibangun di Ibu Kota Nusantara (IKN) salah satunya dapat menjadi pusat penelitian untuk tumbuhan terancam punah di Indonesia.\n\nDalam diskusi International Conference on Forest City dipantau daring dari Jakarta, Rabu, Deputi Bidang Pemanfaatan Riset dan Inovasi BRIN R. Hendrian mengatakan kebun raya yang berada di dekat Istana Kepresidenan dapat menjadi lokasi menjamu tamu negara untuk memperlihatkan keberagaman flora Nusantara, termasuk yang memiliki nilai konservasi."\n\n#jokowi #indonesia #prabowo #jokowidodo #indonesiamaju #jakarta #covid #aniesbaswedan #jokowilagi #jokowipresidenku #corona #segi #presidenjokowi #dirumahaja #viral #like #lfl #jokowiamin #sandiagauno #pancasila #periode #rockygerung #pilpres #tetapjokowi #bandung #politik #marufamin #surabaya #hariantikorupsisedunia #Kaesang	0	0
149	49	https://www.instagram.com/p/C7mBX7fxE_R/	2024-05-30 13:20:52+00	"Ketua Umum Persatuan Sepakbola Seluruh Indonesia (PSSI) Erick Thohir mengemukakan pembangunan fasilitas pusat latihan (training center) tahap pertama di Ibu Kota Nusantara, Pulau Kalimantan, sudah hampir tuntas dengan progres di atas 90 persen. ""Alhamdulillah, progres training center PSSI tahap 1 di IKN sudah hampir rampung,"" imbuh Erick melalui akun instagram pribadi: @erickthohir yang dipantau di Jakarta, Rabu.\n\nMelalui aku instagram pribadi, Erick mengunggah sebuah video berisi proses pembangunan fasilitas pusat latihan di IKN disertai narasi yang menyebutkan progres pencapaian. Sejumlah fasilitas yang dibangun seperti asrama pemain mencapai 92 persen, lapangan natural 90 persen, dan lapangan sintesis 89 persen."\n\n#indonesiamaju #ganjar #jokowiamin #optimisindonesiamaju #ganjarpranowo #ganjarist #pranowo #jatenggayeng #sahabatganjar #jokowi #indonesiatangguhindonesiatumbuh #basukitjahajapurnama #adiannapitupulu #temanganjar #kabinetindonesiamaju #basukibtp #menujuindonesiamaju #jokowipresidenku #lapakganjar #marufamin #presidenjokowi #jokowidodo #jokowipresidenri #jokowimembangunindonesia #gubernurjateng #ganjaristindonesia #pemprovjateng #capres #pilpres #jateng	0	0
150	50	https://www.instagram.com/p/C7lzJXxpAiZ/	2024-05-30 11:16:33+00	Datang untuk yang kedua kalinya, tapi dengan versi yang berbeda 🥰\n\nVisit our lab\nJl. Ranugrati no.25/26 Sawojajar Malang 🏢\n081351316644 ☎️\n\n#dishcaven #jerseysatuan #jerseysatuanmalang #sablonmalang #sablontimbul #vendorsablon #sablonkaos #sablonkaossatuan #sablonplastisol #screenprinting #localpride #localbusiness #konveksimalang #sablondtf  #embossablon #vendorclothing #silkscreen #sablonsatuanmalang #vendormalang #sablonembos #silkscreenprinting #sablonfoom #sablontimbul #pilpres #screenprinting #sablonsatuan	0	-1
151	51	https://www.instagram.com/p/C7lzEJvpx1s/	2024-05-30 11:15:50+00	Di era digital ini, setiap orang punya kesempatan “merumuskan kebenaran.” Kita pun mesti pandai membedakan hoaks, kabar burung, informasi, dan data.\n\nLantas, bagaimana cara membedakannya? Kang Eep mengajak kita untuk tak jadi bagian dari penyebaran fitnah, berita bohong, atau hoaks.\n\nSelengkapnya dalam Kang Eep Bicara, “’Kebenaran Baru’ di Era Medsos”, hanya di YouTube Keep Talking.\n\n#KeepTalking #EepSaefullohFatah #Kebenaran #KebenaranMediaSosial #PolitikIndonesia #Indonesia #PendidikanPolitik #Fakta #Pemilu2024 #Prabowo #Gibran #Pemilu #MuchtarPakpahan #DahlanIskan #Hoaks #Berita #KecuranganPemilu #KejahatanPemilu #KebohonganPublik #Buzzer #Netizen #PostTruth	1	5
152	52	https://www.instagram.com/p/C7lRPRDSX0J/	2024-05-30 06:20:15+00	Situasi negeri belakangan ini telah memberikan gambaran yang jelas soal ambruknya keadaban publik kita. Keadaban publik yang sejatinya mengutamakan akal sehat, moralitas, dan etika dasar tak lagi menjadi prioritas para pejabat publik. Semuanya dilanggar untuk memenangkan kepentingan pribadi dan kroninya.\n\nSimak ulasan selengkapnya di kanal YouTube NALAR episode 142: Ambruknya Keadaban Publik Kita.\n\nEpisode ini merupakan versi audio visual dari publikasi tulisan Yanuar Nugroho di kolom Opini Harian Kompas edisi 6 Maret 2024 halaman 7 berjudul “Ambruknya Keadaban Publik Kita”.\n\n#NALAR #NalarInstitute #Pemilu2024 #Pemilu #Pilpres #Pileg #demokrasi #keadaban #keadabanpublik #kewargaan	0	33
153	53	https://www.instagram.com/p/C7k9tgzJmsQ/	2024-05-30 03:29:37+00	Penyelenggara Pemilu tumbuhkan Profesionalisme. Sikap Potensi Pelanggaran Pasca Demokrasi 2024.\n\n#pemilu2024 #pilkada #indonesia #pilpres #tapera #indonesiaviral #indonesiahits #KPU #Bawaslu	0	1
154	54	https://www.instagram.com/p/C7mCuY5SPou/	2024-05-30 13:32:40+00	TIPS POSITIF HAMIL DALAM 3 BULAN\n==============================\nBuat Bunda yang belum positif hamil & belum dikaruniai momongan\nHayo, siapa yang mau dapat TIPS GRATIS cara "TEPAT & BENAR" dalam menentukan PROSES KEHAMILAN??? Bagi yg ingin dapat TIPS GRATIS silahkan Komen *SAYA MAU TIPSNYA* di kolom komentar ya!\n\nTIPS GRATIS ini akan kami berikan bagi 200 komen yg masuk lebih dulu!\n\nYuK! Tuliskan komen dari sekarang juga ya Bund\nKarna waktu terbatas hanya 2 Minggu ke depan\n\nKami juga punya "PROGRAM HAMIL dengan harga terjangkau bagi bunda yg mau ikut dengan PROMIL kami.\nDan sudah banyak TESTIMONI dari para Bunda yg sudah BERHASIL membuktikannya.\n\nBagi yg mau ikut PROMIL bersama kami segera hubungi kontak kami\nWhatsAap: 088232943658📲\n\n#kondanganhijab #kondangan #gamiscantik #bajuolshop #kebayawedding #ootdkondangan #fashionwanita #bajuwanita #duahijabtrans7 #bajulebaran #kebayajakarta #tutorialhijabsegiempat #weddingsyari #tumblrcinta #hitamputihtrans7 #matanajwa  #pilpres #promil #kehamilan #hariraya	0	0
156	56	https://www.instagram.com/p/C7mBO_vRfHt/	2024-05-30 13:19:39+00	"Pj Gubernur DKI Jakarta Heru Budi Hartono memastikan ibu kota negara sudah resmi pindah dari Jakarta ke Nusantara di Kalimantan saat HUT ke-79 RI pada 17 Agustus mendatang. Dia yang juga Kepala Sekretariat Presiden (Kasetpres) Jokowi itu mengatakan saat ini dirinya tengah mempersiapkan acara HUT ke-79 RI di Ibu Kota Negara (IKN) Nusantara.\n\nIa menyebut pemerintah pusat akan segera menerbitkan peraturan presiden (Perpres) terkait pemindahan ibu kota dari Jakarta ke Nusantara. ""Ya kira-kira seperti itu (17 Agustus ibu kota sudah resmi pindah). Sudah menjadi komitmen pemerintah pusat bahwa sesegera mungkin Perpres itu dikeluarkan, sehingga waktunya tepat untuk beralih menjadi DKJ,"" ujarnya di Hotel Langham, Jakarta, Rabu (29/5)."\n\n#beritaaktual #buruh #yudir #berbagiinfo #aba #sekilasinfo #z #koruptor #beritapolitikindonesia #masyarakat #jiwasrayagate #rockygerungreport #kataanies #korupsi #suara #jokowidodo #tawon #kebijakananies #corona #pemerintah #ridwankamil #news #indonesiamaju #beritaterkini #presiden #gubernurdki #abw #kpk #pilpres #jktinfo	0	0
157	57	https://www.instagram.com/p/C7lzdkMPVJs/	2024-05-30 11:19:18+00	Angka stunting di Kota Bontang turun. Meski turun, presentasinya masih terbilang tinggi.\nStaf Ahli Bidang Ekonomi dan Keuangan Kota Bontang, Bahauddin, hasil operasi timbang yang dilakukan pada bulan November, presentase stunting turun dari 22,02% menjadi 19,65%.\n“Tapi angka ini masih tergolong tinggi walaupun telah mengalami penurunan,” ujar Bahauddin ditemui di Kawasan Jalan Awang Long, Kamis (30/5/2024).\n\n.\n.\n.baca berita selengkapnya di instastory @bekesah.co\n.\n Update informasi menarik lainnya di www.bekesah.co\n__\nJangan lupa follow media sosial kami\nIG @bekesahdotco\nYt Bekesah Channel\nFB Bekesah.co\nKasih Like, Comment dan Subscribe\n#bekesahdotco #bekesahnew #bangkesah #bekesahhariini #beritabontang  #bontang #kaltim #samarinda #sangatta #berita #viral #beritaterkini #indonesia #news #info #beritaviral #pilpres #beritaindonesia #infoterkini #informasi #trending #beritaupdate  #videoviral  #beritaharian #trendingtopic	0	17
158	58	https://www.instagram.com/p/C7jxy_IPOkZ/	2024-05-29 16:26:16+00	Komen dong mas kurangnya apa?!\n.\nFollow: @audi.genki @april.genki @bella.genki @tania.genki\n.\n.\n#pilpres2024 #repost #vscocam #idol #beautiful #gym #bigo #reels #tiktok #pacar #prabowo #cewe #2024#reelsinstagram #selfie #tiktokindonesia #vsco #viral #model #pilpres #love #artist #okegas #instagood #cute	0	1
159	59	https://www.instagram.com/p/C7jpTzbvQkz/	2024-05-29 15:12:07+00	"Wakil Ketua Komisi VII DPR RI Eddy Soeparno mengungkapkan bahwa keberadaan Ibu Kota Nusantara (IKN) di Pulau Kalimantan akan menjadi showcase atau ajang pamer bagi Indonesia ke dunia. Dimana IKN diimpikan akan berdiri sebagai kota pengguna energi baru terbarukan yang ramah lingkungan.\n\n“Kalau IKN memang salah satu showcase kita, karena sepenuhnya akan menggunakan energi terbarukan. Bahkan di sana pun kendaraan yang akan digunakan adalah kendaraan listrik,” ujar Eddy saat menerima audiensi Mahasiswa Universitas Jenderal Ahmad Yani di ruang rapat Komisi VII DPR RI, Senayan, Jakarta, Senin (27/5/2024)."\n\n#beritaaktual #buruh #yudir #berbagiinfo #aba #sekilasinfo #z #koruptor #beritapolitikindonesia #masyarakat #jiwasrayagate #rockygerungreport #kataanies #korupsi #suara #jokowidodo #tawon #kebijakananies #corona #pemerintah #ridwankamil #news #indonesiamaju #beritaterkini #presiden #gubernurdki #abw #kpk #pilpres #jktinfo	0	12
160	60	https://www.instagram.com/p/C7jqpzkPj9g/	2024-05-29 15:23:51+00	"Pengamat ekonomi Universitas Indonesia (UI) Fithra Faisal mengatakan Peraturan Pemerintah (PP) Nomor 21 Tahun 2024 tentang Perubahan Atas PP Nomor 25 Tahun 2020 tentang Penyelenggaraan Tabungan Perumahan Rakyat (Tapera) menjadi solusi persoalan masyarakat yang tidak punya rumah.\n\nTapera, lanjut dia, akan menjadi solusi atas permasalahan gap antara masyarakat yang tidak memiliki hunian tetap karena miliki pemasukan atau pendapatan yang terbatas. ""Sehingga akan sedikit memaksa mereka ya dengan sistem iuran untuk memudahkan mereka mendapatkan rumah. Ya karena pada akhirnya juga iuran ini juga subsidi silang ya bentuknya,"" ujar Fithra kepada ANTARA di Jakarta, Selasa."\n\n#ganjar_pranowo #ganjar #ganjaryasin #pilpres #gibranrakabumingraka #pemudajateng #ganjarpilihanjokowi #ganjarajasudahpokokeoraonoliane #ganjarbersamarakyat #ganjarcapres2024 #ganjardihati #ganjarforindonesia #ganjarfans #ganjaryasin #rockygerungofficial #kaesang #srikandiganjar #makganjar #orangmudaganjar #jokowi #titokarnavian	0	18
161	61	https://www.instagram.com/p/C7jpY-jPLgd/	2024-05-29 15:12:49+00	"Wakil Presiden (Wapres) Ma'ruf Amin mengatakan bahwa Ibu Kota Nusantara (IKN) di Kabupaten Penajam Paser Utara, Kalimantan Timur (Kaltim) dapat menjadi pionir kota berbasis transportasi cerdas dan berkelanjutan.\n\nWapres mengatakan pemerintah saat ini tengah memadukan desain sistem transportasi cerdas dan kota pintar ke dalam pembangunan nusantara sebagai ibu kota negara Indonesia yang baru. ""Ibu Kota Nusantara diharapkan menjadi pionir kota berbasis transportasi cerdas dan berkelanjutan yang dapat menginspirasi pembangunan serupa di kota-kota lain,"" kata Wapres memberi sambutan pada pembukaan The 19th Intelligent Transport System (ITS) Asia Pacific Forum 2024 atau Forum Sistem Transportasi Cerdas Asia Pasifik Ke-19 Tahun 2024 di Balai Sidang Jakarta (JCC), Jakarta, Selasa."\n\n#indonesiamaju #ganjar #jokowiamin #optimisindonesiamaju #ganjarpranowo #ganjarist #pranowo #jatenggayeng #sahabatganjar #jokowi #indonesiatangguhindonesiatumbuh #basukitjahajapurnama #adiannapitupulu #temanganjar #kabinetindonesiamaju #basukibtp #menujuindonesiamaju #jokowipresidenku #lapakganjar #marufamin #presidenjokowi #jokowidodo #jokowipresidenri #jokowimembangunindonesia #gubernurjateng #ganjaristindonesia #pemprovjateng #capres #pilpres #jateng	0	13
162	62	https://www.instagram.com/p/C7k7MLgPbyg/	2024-05-30 03:07:36+00	READY MOM, CUS SEWA SEKARANG😍😍\n.\n.\n.\n\n#fyp\n#tantrum\n#pilpres\n#ndxaka \n#rsewaplaygroundsemarang\n#sewaplaygroundkudus\n#sewaplaygroundsalatiga\n#ayunananak\n#sewamainananaksemarang\n#mainanmurahsemarang\n#sepedaanak\n#sewaplayhouse\n#sewaperlengkapanbayi\n#momstory\n#strongmom\n#indonesia\n#rans\n#nagitaslavina\n#rentalmainansemarang\n#sewaperlengkapanbayikudus\n#babyspa\n#sewamainananaksemarang\n#mainanmurahsemarang\n#semaranghits\n#exploresemarang\n#explorekudus\n#exploresalatiga\n#lfl\n#sewaplayhouse\n#sewaperlengkapanbayi\n#sewamainansemarang \n#strongmom\n#sewamainansalatiga\n#sewamainankudus\n#sewamainansemarangmurah	0	0
163	63	https://www.instagram.com/p/C7jo_ESvDBv/	2024-05-29 15:09:17+00	"Lembaga Penjamin Simpanan (LPS) menyiapkan dana kurang lebih Rp1 triliun untuk membangun gedung kantor di Ibu Kota Nusantara (IKN) di Kalimantan Timur. ""Tadinya kami anggarkan Rp891 miliar mungkin akan lebih besar daripada itu nanti. Kurang lebih kemungkinan Rp1 triliun karena kita melakukan penguatan di sana sini,"" kata Ketua Dewan Komisioner LPS Purbaya Yudhi Sadewa dalam konferensi pers di Kantor LPS Jakarta, Selasa.\n \nPurbaya menuturkan, pihaknya menargetkan pembangunan Kantor LPS di IKN akan selesai pada April 2025. ""Kami targetkan nanti semuanya siap tiga tahap itu sampai April tahun depan sudah siap,"" ujarnya."\n\n#ganjar_pranowo #ganjar #ganjaryasin #pilpres #gibranrakabumingraka #pemudajateng #ganjarpilihanjokowi #ganjarajasudahpokokeoraonoliane #ganjarbersamarakyat #ganjarcapres2024 #ganjardihati #ganjarforindonesia #ganjarfans #ganjaryasin #rockygerungofficial #kaesang #srikandiganjar #makganjar #orangmudaganjar #jokowi #titokarnavian	0	24
164	64	https://www.instagram.com/p/C7jQo2ryxOT/	2024-05-29 11:36:32+00	Permohonan Perselisihan Hasil Pemilihan Umum (PHPU) yang diajukan PPP ditolak Mahkamah Konstitusi (MK).\n\nMeski tidak puas atas putusan tersebut, PPP menghormati putusan MK sebagai bagian dari proses tahapan Pemilu 2024.\n\nKetua Dewan Syuro SPP Kabupaten Pangandaran, Arif Budiman mendengar kabar tersebut merasa kecewa terhadap keputusan MK.\n\n“Tidak lolosnya partai PPP ke Senayan ya saya kecewa. Apalagi PPP sudah jauh lebih lama di dunia politik dibandingkan partai lain,” katanya kepada inakor.id via WA, Selasa (28/05/2024).\n\nBaca selengkapnya di : https://inakor.id/mk-tolak-phpu-spp-ikut-kecewa-ppp-tidak-lolos-ke-senayan/\n\n@inakor.id\n@inakor.id_pangandaran\n#pilpres #pemilu2024 #pilkadapangandaran #pers #news #warganetpangandaranchannel #WarganetPangandaran #inakor #inakorid #joernalinakor #CitizenJournalism #kontenkreator #pangandaran #indonesia #agitwong	0	3
165	65	https://www.instagram.com/p/C7lvIHap6n8/	2024-05-30 10:41:25+00	Prof. Dr. Soemitro Djojohadikoesoemo (EYD: Sumitro Joyohadikusumo; 29 Mei 1917 – 9 Maret 2001) merupakan seorang ekonom dan politikus Indonesia. Sebagai salah satu ekonom Indonesia paling terkemuka selama masanya, Soemitro pernah menjabat sebagai Menteri Perdagangan dan Industri, Menteri Keuangan, dan Menteri Riset baik selama era Orde Lama maupun Orde Baru. Dia juga pernah menjadi Dekan Fakultas Ekonomi Universitas Indonesia dari 1951 hingga 1957. Anaknya, Prabowo Subianto, akan menjabat sebagai Presiden Indonesia terpilih ke-8…\n\n@laskarprabowo_08\n\n#LaskarPrabowo08 #PrabowoSubianto #Berita \n#LaskarPrabowo08 \n#Djojohadikusumo #Hashim #HashimDjojohadikusumo #Prabowo #PrabowoSubianto #PrabowoPresiden #PrabowoPresiden2024 #PrabowoGibran #Gibran #Rakabumingraka #GibranWakilPresiden #GibranWakilPresiden2024 #Presiden2024 #Jakarta #MarkasLaskarPrabowo #Like #Instagram #Follow #Pemilu #Info #Fyp #fyptiktok	0	6
166	66	https://www.instagram.com/p/C7jDz5OJuUP/	2024-05-29 09:44:27+00	Hai Sahabat FOE!!\nSharp Car Air Purifier IG-GC2Y-N\n\n*Untuk pembelian Online bisa dibeli di Tokopedia FOE Surabaya\n\n*Untuk pembelian Offline bisa langsung datang ke Toko FOE Surabaya\n- Jl. Raya Dukuh Kupang No.96, Dukuh Kupang, Kec. Dukuhpakis, Surabaya, Jawa Timur 60225..\n\nSharp IG-GC2Y-N\nAir Purifier New High Density for Car\n\nFitur Utama :\n\nColor : Graphite Black Metallic [B] / Silky Gold [N] / Sexy Pink [P]\nHigh Density 25,000 Ions/cm3 Plasmacluster\nTurbo mode (30% faster cleaning)\nDual USB Port\nDual Air Inlet\nDual Usage\nMicro particle Pre-Filter\nCoanda Effect\nLarge Coverage Area\n\n#carairpurifier #airpurifiersharp #airpurifiermurah #sharp #airpurifier #foe #foesurabaya #happyshopping #waktunyabelanja #elektronikmurah #surabaya #sidoarjo #elektronik #elektronikmurahsurabaya #elektroniksurabaya #happyshopping #waktunyabelanja #februari #payday #gajian #flashsale #sale #murah #promo #foe #foesurabaya #terik #pilpres #pemilu #hujan	0	0
167	67	https://www.instagram.com/p/C7i9a5pyKIT/	2024-05-29 08:48:36+00	Laksanakan jendral\n\n#politikkongkalikong \n#politikindonesia \n#jokowidodo #prabowo \n#poliklitik #indonesia \n#president #pilpres #tni	0	3
168	68	https://www.instagram.com/p/C7jge-fyiyI/	2024-05-29 13:55:00+00	Daerah penyangga IKN dukung pembangunan IKN...\n\nPemprov Kaltim bersama Otorita IKN merencanakan melakukan penandatanganan MoU bidang pembangunan. Di antaranya, untuk penguatan kontribusi Kaltim buat IKN.\n\nPenandatanganan MoU di IKN sebagai bukti komitmen bersama akan menjadi lebih kuat. Dia juga menambahkan, di dalam kerja sama ada beberapa poin yang dapat mendukung Pemprov Kaltim agar bisa berkontribusi untuk IKN.\n\nSelain itu juga, sudah melakukan kesepakatan terkait pengadaan lahan. Sedangkan kesepakatan kali ini terkait perencanaan dan pembangunan.\n\nCoba komen, bagaimana pendapat kamu tentang ini?!\n\n#prabowosubianto #prabowosubiantopresiden2024 #prabowosubiantopresiden #prabowosubiantoforri1 #prabowosubiantopresidenri2024 #prabowosubiantodjojohadikusumo #jokowi #politik #indonesiamaju #prabowo #nkri #viralindonesia #gerindra #pilpres #jokowidodo #politikindonesia #gibranrakabumingraka #pemilu #prabowopresiden #pilpres2024 #pemilu2024 #presiden #capres #irianajokowidodo #capres2024 #gibran #calonpresiden #irianajokowi #kaesangpangarep #gibranrakabuming	2	41
169	69	https://www.instagram.com/p/C7jdwciyPUh/	2024-05-29 13:31:10+00	TIPS POSITIF HAMIL DALAM 3 BULAN\n==============================\nBuat Bunda yang belum positif hamil & belum dikaruniai momongan\nHayo, siapa yang mau dapat TIPS GRATIS cara "TEPAT & BENAR" dalam menentukan PROSES KEHAMILAN??? Bagi yg ingin dapat TIPS GRATIS silahkan Komen *SAYA MAU TIPSNYA* di kolom komentar ya!\n\nTIPS GRATIS ini akan kami berikan bagi 200 komen yg masuk lebih dulu!\n\nYuK! Tuliskan komen dari sekarang juga ya Bund\nKarna waktu terbatas hanya 2 Minggu ke depan\n\nKami juga punya "PROGRAM HAMIL dengan harga terjangkau bagi bunda yg mau ikut dengan PROMIL kami.\nDan sudah banyak TESTIMONI dari para Bunda yg sudah BERHASIL membuktikannya.\n\nBagi yg mau ikut PROMIL bersama kami segera hubungi kontak kami\nWhatsAap: 088232943658\n\n#kondanganhijab #kondangan #gamiscantik #bajuolshop #kebayawedding #ootdkondangan #fashionwanita #bajuwanita #duahijabtrans7 #bajulebaran #kebayajakarta #tutorialhijabsegiempat #weddingsyari #tumblrcinta #hitamputihtrans7 #matanajwa  #pilpres #promil #kehamilan #hariraya	0	6
170	70	https://www.instagram.com/p/C7iiU6HPpie/	2024-05-29 04:51:51+00	❌SOLD OUT KILATS🔥🚀❌\n\nSize : 43 - 27.5 cm\nKondisi : 90%\nHarga : -\nDetail : Slide Foto\n\nOrder Hanya Ke Whatsapp dan Hanya Melayani Fix Order!\nInfo Kontak Whatsapp ke DM ya Kak!\n\nADA HARGA , ADA KONDISI\n\nBarang Second No Box, No Return/Refund \n\n#adidassamba #pilpres #adidassecond #nikesecondoriginal #adidascasual  #airjordan #sepatuairmax #nikesbdunk #nikerunning #afc #sepatuadidas  #nikeairforcesecond #adidassamba  #fyp #sepatuviral #sepatuoriginalsecond #sepatusecondbekasi #sepatusecondjakarta #viral \n#sepatusecondoriginal #pemiluserentak2024 #ultras \n#sepatubekasoriginal \n#adidassecond #adidasoriginals #sepatuoriginal	0	-1
171	71	https://www.instagram.com/p/C7iiriJvgAg/	2024-05-29 04:54:57+00	✅READY KAKAK✅ #anzmasihada \n\nSize : 42 - 26,5 cm\nKondisi : 95%\nHarga : -\nDetail : Slide Foto\n\nOrder Hanya Ke Whatsapp dan Hanya Melayani Fix Order!\nInfo Kontak Whatsapp ke DM ya Kak!\n\nADA HARGA , ADA KONDISI\n\nBarang Second No Box, No Return/Refund \n\n#adidassamba #pilpres #adidassecond #nikesecondoriginal #adidascasual  #airjordan #sepatuairmax #nikesbdunk #nikerunning #afc #sepatuadidas  #nikeairforcesecond #adidassamba  #fyp #sepatuviral #sepatuoriginalsecond #sepatusecondbekasi #sepatusecondjakarta #viral \n#sepatusecondoriginal #pemiluserentak2024 #ultras \n#sepatubekasoriginal \n#adidassecond #adidasoriginals #sepatuoriginal	0	-1
172	72	https://www.instagram.com/p/C7iiePIvvEm/	2024-05-29 04:53:08+00	❌SOLD OUT KILATS🔥🚀❌\n\nSize : 41 - 26 cm\nKondisi : 95%\nHarga : -\nDetail : Slide Foto\n\nOrder Hanya Ke Whatsapp dan Hanya Melayani Fix Order!\nInfo Kontak Whatsapp ke DM ya Kak!\n\nADA HARGA , ADA KONDISI\n\nBarang Second No Box, No Return/Refund \n\n#adidassamba #pilpres #adidassecond #nikesecondoriginal #adidascasual  #airjordan #sepatuairmax #nikesbdunk #nikerunning #afc #sepatuadidas  #nikeairforcesecond #adidassamba  #fyp #sepatuviral #sepatuoriginalsecond #sepatusecondbekasi #sepatusecondjakarta #viral \n#sepatusecondoriginal #pemiluserentak2024 #ultras \n#sepatubekasoriginal \n#adidassecond #adidasoriginals #sepatuoriginal	3	-1
173	73	https://www.instagram.com/p/C7jfEBVyPDV/	2024-05-29 13:42:34+00	Halo sobat Gen-Z dan Milenials!👋🏻\n\nKali ini, IDN Times akan menggelar diskusi menarik nih bersama dengan Total Politik dengan tema “Bicara yang Paten-Paten Aja” bersama dengan Bapak Luhut Binsar Pandjaitan, M.P.A (Menteri Koordinator Bidang Kemaritiman dan Investasi RI)\n\nJangan lewatkan kesempatan buat ikut di dalam acara ini ya:\n\n🗓: Selasa, 4 Juni 2024\n⏰: 15.30 WIB - selesai\n📍: IDN Media HQ - The Plaza, 3rd Floor\n\nBagi kamu yang tertarik, dapat mendaftarkan diri melalui link ini ya:\nhttps://bit.ly/TalkshowIDNxTotalPolitik\n\nKamu yang beruntung akan dihubungi lebih lanjut oleh admin IDN Times ya, see you✨\n\nIkuti perkembangan politik tanah air di Youtube Total Politik  \n..........................     \n#TotalPolitik #AduPerspektif #Pilpres #pemilu2024 #IDNTimes #demokrasi #Jokowi #PresidenJokowi  #PrabowoSubianto #UniLubis #GibranRakabumingRaka #LuhutBinsarPandjaitan #PrabowoGibran	28	1069
174	74	https://www.instagram.com/p/C7jEzjrSWm7/	2024-05-29 09:53:08+00	Direktur The Wahid Institute, Zannuba Ariffah Chafsoh atau yang akrab disapa Yenny Wahid menyoroti kebijakan pemerintah terkait potongan gaji pekerja sebanyak 3% untuk iuran Tabungan Perumahan Rakyat (Tapera). Hal ini disampaikan Yenny dalam unggahan di akun Instagram pribadinya pada Selasa (28/5) lalu.\n\nPutri kedua Presiden Ke-5 RI Abdurrahman Wahid atau Gus Dur itu menyebut saat ini masyarakat kesulitan mendapat pekerjaan. Sekalinya dapat kerja, banyak potongan yang harus dibebankan kepada para pekerja tersebut.\n\nYenny sampai membuat simulasi iuran Tapera yang menyebut pekerja yang mendapat gaji Rp7 juta/bulan saja membutuhkan 285 tahun agar mampu membeli rumah seharga Rp600 juta.\n\nSebelumnya, iuran Tabungan Perumahan Rakyat (Tapera) menjadi sorotan publik lantaran akan memotong gaji pekerja baik PNS maupun swasta sebesar 3%. Kebijakan ini lalu mendapatkan kritik dari berbagai pihak.\n\nSimpanan peserta ditetapkan sebesar 3% dari gaji atau upah peserta, atau penghasilan untuk peserta pekerja mandiri. Selanjutnya bagi peserta pekerja ditanggung bersama pemberi kerja sebesar 0,5% dan pekerja sebesar 2,5%. Sementara itu, untuk peserta pekerja mandiri seluruh simpanan ditanggung oleh pekerja itu.\n\nSumber:\nhttps://www.instagram.com/p/C7hERa9vWPl/?igsh=MXdzN2ZpaTAyMXM3cw==\n\nhttps://news.detik.com/berita/d-7362663/kritik-mencuat-buntut-gaji-karyawan-dipotong-iuran-tapera\n\nIkuti perkembangan politik tanah air di Youtube Total Politik  \n..........................     \n#TotalPolitik #AduPerspektif #Pilpres #pemilu2024 #Capres #Cawapres #demokrasi #Jokowi #PresidenJokowi #PrabowoSubianto #Projo #BudiArieSetiadi #BambangPacul #GibranRakabumingRaka  #PrabowoGibran #YennyWahid #Tapera #GusDur	254	2327
175	75	https://www.instagram.com/p/C7h7lNDPWO3/	2024-05-28 23:13:17+00	#sold\n\nConverse Yang Nambah Level Kegantenganmu🤩\n\n___________________________________________\nCONVERSE CT DOUBLEZIP LEATHER Hitam\n\nSize: 44 (28cm)\n\nKondisi : Second\n\nHarga : ❌❌sold❌❌\n\n( 𝐒𝐭𝐨𝐤 𝐉𝐯 𝐣𝐮𝐠𝐚 𝐛𝐚𝐧𝐲𝐚𝐤, 𝐉𝐚𝐥𝐮𝐫 𝐁𝐞𝐥𝐚𝐤𝐚𝐧𝐠 𝐒𝐚𝐣𝐚)\n\n❤🤣🤣❤\n\n𝙐𝙖𝙣𝙜 𝘽𝙞𝙨𝙖 𝘿𝙞𝙘𝙖𝙧𝙞, 𝘽𝙖𝙧𝙖𝙣𝙜 𝘽𝙚𝙡𝙪𝙢 𝙏𝙚𝙣𝙩𝙪 𝙍𝙚𝙖𝙙𝙮 𝙆𝙚𝙢𝙗𝙖𝙡𝙞 😊😁😃\n\nAmankan, Bisa Dp Suka-Suka, Pelunasan Jangka Suka-Suka\n___________________________________________\n\n🌟Nyari Sepatu Converse atau Merk Lainnya? Jika Tak Ada, Kami Bantu Carikan\n___________________________________________\n\n#conversebekas #converseseken  #conversegorillaz #converseonestar #converserare #conversejackpurcell #converseheadindonesia #conversethedoors #conversejohnvarvatos #conversemetallica #converseacdc #converseseries #conversepinkfloyd  #conversemusic #conversejakarta #conversesurabaya #conversesolo #conversemedan #conversebandung #conversebali \n #converseoriginal #conversesecond  #conversevelcro #vanssecond\n#pilpres #insta #lfl #ootd	0	19
176	76	https://www.instagram.com/p/C7iS2_JvMAe/	2024-05-29 02:36:42+00	Berbagai varian Roster minimalis .. \n\n𝒀𝒐 𝒈𝒖𝒚𝒔.. 𝒔𝒊𝒂𝒑𝒂 𝒚𝒂𝒏𝒈 𝒔𝒅𝒂𝒏𝒈 𝒎𝒆𝒏𝒄𝒂𝒓𝒊 bata / 𝒓𝒐𝒔𝒕𝒆𝒓2 𝒌𝒖𝒂𝒍𝒊𝒕𝒂𝒔 𝒏𝒐 1.. 𝒅𝒊 𝒔𝒊𝒏𝒊 𝒕𝒎𝒑𝒂𝒕 𝒏𝒚𝒂.. \n𝑫𝒊𝒔𝒊𝒏𝒊 𝑻𝒆𝒓𝒔𝒆𝒅𝒊𝒂 𝒓𝒐𝒔𝒕𝒆𝒓/𝒍𝒐𝒔𝒕𝒆𝒓. 𝑫𝒆𝒏𝒈𝒂𝒏 𝒃𝒆𝒓𝒃𝒂𝒈𝒂𝒊 𝒎𝒐𝒕𝒊𝒇. \n𝑻𝒆𝒓𝒔𝒆𝒅𝒊𝒂 3 𝒑𝒂𝒓𝒊𝒂𝒏 𝒘𝒂𝒓𝒏𝒂.. \n1. 𝑨𝒃𝒖 𝒂𝒃𝒖.\n2. 𝑴𝒆𝒓𝒂𝒉\n3. 𝑷𝒖𝒕𝒊𝒉.... \n𝑯𝒂𝒓𝒈𝒂 𝒔𝒂𝒏𝒈𝒂𝒕 𝒕𝒆𝒓𝒋𝒂𝒏𝒈𝒌𝒂𝒖. 𝑺𝒆𝒍𝒂𝒍𝒖 𝒎𝒆𝒏𝒈𝒖𝒕𝒂𝒎𝒂𝒌𝒂𝒏 𝒌𝒖𝒂𝒍𝒊𝒕𝒂𝒔\n𝑳𝒂𝒏𝒈𝒔𝒖𝒏𝒈 𝒅𝒂𝒓𝒊 𝒑𝒂𝒃𝒓𝒊𝒌..\n𝑻𝒆𝒓𝒔𝒆𝒅𝒊𝒂 𝒍𝒆𝒃𝒊𝒉 𝒅𝒂𝒓𝒊 300 𝒎𝒐𝒕𝒊𝒇 𝒓𝒐𝒔𝒕𝒆𝒓\n𝑺𝒊𝒂𝒑 𝒌𝒊𝒓𝒊𝒎 𝒌𝒆 𝒔𝒆𝒍𝒖𝒓𝒖𝒉 𝒘𝒊𝒍𝒂𝒚𝒂𝒉 𝒏𝒖𝒔𝒂𝒏𝒕𝒂𝒓𝒂.\n𝑺𝒊𝒑𝒂 𝒕𝒆𝒓𝒊𝒎𝒂 𝒑𝒆𝒔𝒂𝒏𝒂𝒏 𝒎𝒐𝒕𝒊𝒇 𝒃𝒂𝒓𝒖 (𝑪𝑼𝑺𝑻𝑶𝑴)\n𝑩𝒂𝒓𝒂𝒏𝒈 𝒑𝒆𝒄𝒂𝒉 𝒔𝒊𝒂𝒑 𝒈𝒂𝒏𝒕𝒊 𝒅𝒏𝒈𝒂𝒏 𝒚𝒏𝒈 𝒃𝒂𝒓𝒖\n\n𝑰𝒏𝒇𝒐  𝒓𝒐𝒔𝒕𝒆𝒓 .\n𝑭𝒐𝒍𝒍𝒐𝒘 @pg.putry_roster\n𝑭𝒐𝒍𝒍𝒐𝒘 @pg.putry_roster\n𝑭𝒐𝒍𝒍𝒐𝒘 @pg.putry_roster\n𝑭𝒐𝒍𝒍𝒐𝒘 @pg.putry_roster\n𝑭𝒂𝒄𝒆𝒃𝒐𝒐𝒌 @𝒑𝒈.𝒑𝒖𝒕𝒓𝒚 𝒓𝒐𝒔𝒕𝒆𝒓\n𝑻𝒊𝒌𝒕𝒐𝒌 @𝑷𝑮 𝑷𝑼𝑻𝑹𝒀 𝑹𝑶𝑺𝑻𝑬𝑹\n\n𝑰𝑵𝑭𝑶 𝑷𝑬𝑴𝑬𝑺𝑨𝑵𝑨𝑵. 082115108366/081386334433\n. .\n.\n#rosterbeton \n#rosterbetonminimalis \n#insfirasirumahcantik \n#designrumahminimalis \n#designdeinteriores\n#rumahminimalis \n#arsitekindonesia \n#jasaarsitek \n#arsitekmuda \n#arsitekjakarta \n#arsitekbandung \n#arsitekbali \n#arsitekjawa \n#arsiteksemarang\n#facade \n#jasainteriordesign\n#jakartainternationalstadium \n#jasaarsitek\n#artisindonesia\n#architecturedesign \n#architecture \n#desigen \n#architect \n#binusschoolsemarang\n#arsiteklampung\n#waskitakarya \n#pilpres\n#designarchitecture\n#bataexpose #batamerah	0	1
177	77	https://www.instagram.com/p/C7hNuA7SUWA/	2024-05-28 16:32:32+00	"Presiden Joko Widodo menegaskan bahwa komitmen pemerintah terhadap pemberantasan korupsi tidak pernah surut. Menurutnya, upaya pencegahan juga terus dilakukan dengan membangun sistem pemerintahan dan pelayanan publik yang transparan dan akuntabel.\n \n""Pemerintah terus mengembangkan sistem pemerintahan berbasis elektronik. Kemudian perizinan Online Single Submission (OSS) dan pengadaan barang dan jasa melalui e-Katalog,"" ujar Presiden dalam keterangan pers di Istana Merdeka, Jakarta, pada Selasa, 7 Februari 2023."\n\n#jokowi #indonesia #prabowo #jokowidodo #indonesiamaju #jakarta #covid #aniesbaswedan #jokowilagi #jokowipresidenku #corona #segi #presidenjokowi #dirumahaja #viral #like #lfl #jokowiamin #sandiagauno #pancasila #periode #rockygerung #pilpres #tetapjokowi #bandung #politik #marufamin #surabaya #hariantikorupsisedunia #Kaesang	2	15
178	78	https://www.instagram.com/p/C7iRaJXPjIw/	2024-05-29 02:24:01+00	READY MOM, CUS SEWA SEKARANG😍😍\n.\n.\n.\n\n#fyp\n#tantrum\n#pilpres\n#ndxaka \n#rsewaplaygroundsemarang\n#sewaplaygroundkudus\n#sewaplaygroundsalatiga\n#ayunananak\n#sewamainananaksemarang\n#mainanmurahsemarang\n#sepedaanak\n#sewaplayhouse\n#sewaperlengkapanbayi\n#momstory\n#strongmom\n#indonesia\n#rans\n#nagitaslavina\n#rentalmainansemarang\n#sewaperlengkapanbayikudus\n#babyspa\n#sewamainananaksemarang\n#mainanmurahsemarang\n#semaranghits\n#exploresemarang\n#explorekudus\n#exploresalatiga\n#lfl\n#sewaplayhouse\n#sewaperlengkapanbayi\n#sewamainansemarang \n#strongmom\n#sewamainansalatiga\n#sewamainankudus\n#sewamainansemarang	0	0
179	79	https://www.instagram.com/p/C7hNcEQPg8S/	2024-05-28 16:30:05+00	"Kisruh naiknya uang kuliah tunggal (UKT) di berbagai perguruan tinggi negeri (PTN) menemui babak akhir usai Menteri Pendidikan, Kebudayaan, Riset, dan Teknologi (Mendikbudristek), Nadiem Anwar Makarim bertemu dengan Presiden Joko Widodo (Jokowi) di Istana Negara, Senin (27/5/2024) kemarin. Pertemuan itu menghasilkan keputusan pembatalan kenaikan uang kuliah tunggal (UKT) di berbagai PTN. Ia juga meminta perguruan tinggi 'jemput bola' ke calon mahasiswa baru.\n\n""PTN perlu merangkul calon mahasiswa baru yang belum daftar ulang atau mengundurkan diri akibat UKT yang tinggi,"" tuturnya dikutip dari rilis yang diterima detikEdu ditulis Selasa (28/5/2024)."\n\n#ganjar_pranowo #ganjar #ganjaryasin #pilpres #gibranrakabumingraka #pemudajateng #ganjarpilihanjokowi #ganjarajasudahpokokeoraonoliane #ganjarbersamarakyat #ganjarcapres2024 #ganjardihati #ganjarforindonesia #ganjarfans #ganjaryasin #rockygerungofficial #kaesang #srikandiganjar #makganjar #orangmudaganjar #jokowi #titokarnavian	0	17
180	80	https://www.instagram.com/p/C7hLVsgva3p/	2024-05-28 16:11:45+00	"Menteri Keuangan Sri Mulyani Indrawati telah menerbitkan Peraturan Menteri Keuangan (PMK) Nomor 28 Tahun 2024 tentang Fasilitas Perpajakan dan Kepabeanan di Ibu Kota Nusantara (IKN). Aturan tersebut salah satunya memberikan fasilitas kepada pegawai swasta berupa Pajak Penghasilan (PPh) Pasal 21 ditanggung pemerintah (DTP). ""Pajak Penghasilan Pasal 21 ditanggung Pemerintah dan bersifat final,"" seperti dikutip dari Pasal 2 Ayat (2) huruf g PMK 28/2024, Senin, (27/5/2024).\n\nLebih lanjut Pasal 123 Ayat (3) dan (4) PMK itu menjabarkan mengenai kriteria pegawai yang berhak mendapatkan fasilitas PPh 21 DTP. Para pegawai itu adalah mereka yang menerima penghasilan dari pemberi kerja tertentu; bertempat tinggal di wilayah IKN; dan memiliki Nomor Pokok Wajib Pajak (NPWP) yang terdaftar di kantor pelayanan pajak yang wilayah kerjanya meliputi wilayah IKN."\n\n#beritaaktual #buruh #yudir #berbagiinfo #aba #sekilasinfo #z #koruptor #beritapolitikindonesia #masyarakat #jiwasrayagate #rockygerungreport #kataanies #korupsi #suara #jokowidodo #tawon #kebijakananies #corona #pemerintah #ridwankamil #news #indonesiamaju #beritaterkini #presiden #gubernurdki #abw #kpk #pilpres #jktinfo	0	13
181	81	https://www.instagram.com/p/C7hLa3WPK8F/	2024-05-28 16:12:27+00	"Asian Development Bank (ADB) mengatakan pembangunan Ibu Kota Nusantara merangsang pertumbuhan ekonomi dan mempercepat pembangunan di Indonesia Timur. ""ADB mengapresiasi salah satu justifikasi Pemerintah Indonesia atas pemindahan Ibu Kota Indonesia ke Kalimantan Timur adalah untuk merangsang pertumbuhan ekonomi dan pembangunan di Indonesia Timur,” kata Direktur ADB untuk Indonesia Jiro Tominaga, Senin (27/5/2024).\n\nJiro menuturkan Ibu Kota Nusantara menghadirkan peluang unik untuk memanfaatkan praktik terbaik internasional dalam perencanaan, pembangunan, dan pembiayaan kota, serta memberikan kontribusi bagi pembangunan ekonomi. Namun, pihaknya mencatat bahwa Nusantara tidak akan dibangun dalam satu hari. Banyak hal yang harus dilakukan untuk menjadikan sebuah kota layak huni dan menarik orang untuk pindah ke Nusantara."\n\n#indonesiamaju #ganjar #jokowiamin #optimisindonesiamaju #ganjarpranowo #ganjarist #pranowo #jatenggayeng #sahabatganjar #jokowi #indonesiatangguhindonesiatumbuh #basukitjahajapurnama #adiannapitupulu #temanganjar #kabinetindonesiamaju #basukibtp #menujuindonesiamaju #jokowipresidenku #lapakganjar #marufamin #presidenjokowi #jokowidodo #jokowipresidenri #jokowimembangunindonesia #gubernurjateng #ganjaristindonesia #pemprovjateng #capres #pilpres #jateng	0	12
182	82	https://www.instagram.com/p/C7hLBH2Pagj/	2024-05-28 16:08:56+00	"Ibu Kota Nusantara (IKN) di Provinsi Kalimantan Timur (Kaltim) diharapkan menjadi pionir kota berbasis transportasi cerdas, terintegrasi dan berkelanjutan. Ini diterapkan melalui sistem Area Traffic Control, Electronic Toll Collection, Bus Rapid Transit, dan Autonomous-Rail Rapid Transit. \n\nHal inilah yang nantinya akan ditampilkan dalam Forum Sistem Transportasi Cerdas Asia Pasifik atau The 19th Intelligent Transport System (ITS) Asia Pacific Forum pada 28 hingga 30 Mei 2024. Berlokasi di Jakarta Convention Center (JCC), forum dua tahunan tersebut mengambil tema “Transformation Towards A Sustainable and Intelligent Urban Mobility”."\n\n#ganjar_pranowo #ganjar #ganjaryasin #pilpres #gibranrakabumingraka #pemudajateng #ganjarpilihanjokowi #ganjarajasudahpokokeoraonoliane #ganjarbersamarakyat #ganjarcapres2024 #ganjardihati #ganjarforindonesia #ganjarfans #ganjaryasin #rockygerungofficial #kaesang #srikandiganjar #makganjar #orangmudaganjar #jokowi #titokarnavian	0	20
183	83	https://www.instagram.com/p/C7hLQjAyQRL/	2024-05-28 16:11:02+00	"Ibu Kota Nusantara (IKN) akan memiliki platform mobilitas pintar berbentuk CCTV yang mampu menghitung emisi kendaraan di suatu kawasan. Hal ini sebagaimana disampaikan oleh Deputi Transformasi Hijau dan Digital Otorita IKN (OIKN) Mohammed Ali Berawi dalam konferensi pers di JW Marriott Hotel Jakarta, Senin (27/5/2024). Ali Berawi menjelaskan, baru saja selesai dilakukan Proof of Concept (PoC) atau uji coba platform mobilitas pintar milik perusahaan asal Kazakhstan Sergek Projects Ltd sejak 30 Januari 2024-30 April 2024 di Kota Balikpapan, Kalimantan Timur.\n\nPenghitungan keluaran karbon dioksida dari kendaraan bermotor bisa dilakukan dengan menggunakan kecerdasan buatan atau Artificial Intelligence (AI). Nantinya, data tersebut juga bisa digunakan untuk melakukan rekayasa lalu lintas di ruas jalan dengan kadar karbon dioksida sudah melebihi batas, sehingga tidak terjadi penumpukan kendaraan."\n\n#jokowi #indonesia #prabowo #jokowidodo #indonesiamaju #jakarta #covid #aniesbaswedan #jokowilagi #jokowipresidenku #corona #segi #presidenjokowi #dirumahaja #viral #like #lfl #jokowiamin #sandiagauno #pancasila #periode #rockygerung #pilpres #tetapjokowi #bandung #politik #marufamin #surabaya #hariantikorupsisedunia #Kaesang	0	13
184	84	https://www.instagram.com/p/C7jKXWAp95A/	2024-05-29 10:41:43+00	Meskipun cuma lem, tetapi ini sangat berperan penting dalam dunia persablonan 😂\n\nBiar semakin rapat & erat yakan 🤗\n\nVisit our lab\nJl. Ranugrati no.25/26 Sawojajar Malang 🏢\n081351316644 ☎️\n\n#dishcaven #jerseysatuan #jerseysatuanmalang #sablonmalang #sablontimbul #vendorsablon #sablonkaos #sablonkaossatuan #sablonplastisol #screenprinting #localpride #localbusiness #konveksimalang #sablondtf  #embossablon #vendorclothing #silkscreen #sablonsatuanmalang #vendormalang #sablonembos #silkscreenprinting #sablonfoom #sablontimbul #pilpres #screenprinting #sablonsatuan	0	-1
185	85	https://www.instagram.com/p/C7lcNv-SWvy/	2024-05-30 07:56:10+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
186	86	https://www.instagram.com/p/C7iYlmnS4FS/	2024-05-29 03:26:45+00	#Repost @fiqihwanita_ \n——\n.Hamil Dapat Menghapus Dosa\n\nSyaikh Al-Utsaimin rahimahullah berkata:\n\nأن ما يصيبها من أذى وألم في حال الحمل أو عند الوضع أو في الحضانة بعد ذلك فأنما هو رفعة في درجاتها وكفارة لسيئاتها إذا احتسبت هذا على الله سبحانه وتعالى\n\n"Bahwa apa yang menimpa dirinya berupa derita dan sakit ketika hamil atau ketika bersalin atau di masa menyusui setelah itu, maka itu semata-mata sebagai pengangkat derajatnya dan penghapus dosa-dosanya jika dia mengharap pahala dari Allah Subhanahu wa Ta'ala". (Fatawa Nur Aladdarb 11/280)\n.\n.\n____\nSemoga yang like dan 👉 mengikuti promil kami bisa hamil di thn ini آمِيّنْ... آمِيّنْ... يَ رَ بَّلْ عَلَمِيّنْ. ================================\nApapun penghambat kehamilannya akan tertuntaskan, Kista, Miom, Pcos, Torch, Varikokel, diabet, kanker, masalah sperma dll.\nFollow:\n\n🏥Untuk mendapatkan info kesehatan, medis, Program hamil & hiburan bayi\n️✔ contact person :\n✔ W/A : 085927441300\n\n#kondanganhijab #kondangan #gamiscantik #bajuolshop #kebayawedding #ootdkondangan #fashionwanita #bajuwanita #duahijabtrans7 #bajulebaran #kebayajakarta #tutorialhijabsegiempat #weddingsyari #tumblrcinta #hitamputihtrans7 #matanajwa  #pilpres #promil	2	11
187	87	https://www.instagram.com/p/C7govQoJ6Y8/	2024-05-28 11:09:24+00	❌️SOUL-OUD❌️ 1 Unit Pajero Sport Dakar CVT Putih untuk Tante & keluarga 😎 Enjoy your New Pajero 🤩\n\nBUTUH MOBIL CEPAT? PILIH SAYA!📌 \n✨ Membantu mendapatkan promo yang TEPAT dan proses CEPAT✨\n\nDengan program :\n✅ Program DP Minim\n✅ Program Bunga Ringan\n✅ Program Bunga 0% (Tenor 2Thn)\n✅ Program Tenor Panjang Hingga 7-8Thn\n✅ Program Kredit Syariah\n✅ Program Tukar Tambah (Semua Merk Dibantu Jual)\n\nProgram Khusus Mitsubishi Xforce :\n✨ Gratis Plat Sementara\n✨ Gratis Asuransi Allrisk 1Thn\n✨ Gratis Nano Coating\n✨ Gratis Antikarat\n✨ Gratis Aksesoris\n\nPilih yang sudah terbukti :\n👉🏻 Free Jasa Service, Part & Oli s/d 50.000km/4thn\n👉🏻 Garansi 100.000km/3thn\n\nTagih janji saya di :\n📲 0813 8847 4447\n📍 Dealer Mitsubishi Sun Star Prima Motor Caman Kalimalang  Bekasi\n\n#Mitsubishi #Mitsubishipajero #mitsubishixpander #promomitsubishi #newxpander #newxpandercross #mitsubishicikarang #mobilcikarang #mobilmurah #mobilmurahcikarang #mobilmitsubishi #infocikarang #infomobil #infomitsubishi #mitsubishijakarta #mitsubishijabodetabek #dealermitsubishi #mitsubishilippocikarang #infokarawang #infobekasi #infobogor #infojawabarat #infojakarta #pilpres #viral #caleg #capres #xforce #mitsubishixforce #hargamitsubishi	0	-1
188	88	https://www.instagram.com/p/C7lcLk8y93u/	2024-05-30 07:55:52+00	Pemilu telah usai, mari rajut kembali Persatuan dan kesatuan sesama bangsa menuju Indonesia maju.\n\n#Pemilu2024 #Pemilu2024AmanDamai #Pemilu #PemiluDamai	0	0
189	89	https://www.instagram.com/p/C7k34RLhrIG/	2024-05-30 02:38:40+00	Lho, emang boleh se canggih ini?\n\nJalan Tol Ibu Kota Nusantara langsung menerapkan sistem transaksi jalan tol non-tunai nirsentuh nirhenti atau Multi Lane Free Flow (MLFF).\n\nIni bukti kalau IKN bakal jadi kota modern tercanggih di Indonesia. IKN beneran bakal jadi kota yang selalu terdepan pokoknya....\n\nCoba komen, bagaimana pendapat kamu tentang ini?!\n\n#prabowosubianto #prabowosubiantopresiden2024 #prabowosubiantopresiden #prabowosubiantoforri1 #prabowosubiantopresidenri2024 #prabowosubiantodjojohadikusumo #jokowi #politik #indonesiamaju #prabowo #nkri #viralindonesia #gerindra #pilpres #jokowidodo #politikindonesia #gibranrakabumingraka #pemilu #prabowopresiden #pilpres2024 #pemilu2024 #presiden #capres #irianajokowidodo #capres2024 #gibran #calonpresiden #irianajokowi #kaesangpangarep #gibranrakabuming	0	1
190	90	https://www.instagram.com/p/C7l3Prqxj6S/	2024-05-30 11:52:22+00	Terminal 2 Bandara Internasional Hang Nadim Batam secara resmi dibangun, Kamis (30/5/2024) sekitar pukul 9.30 WIB. Ditargetkan 9,6 juta penumpang ditampung dalam kawasan tersebut.\n\nPembangunan diawali Groundbreaking yang ditandai acara seremonial groundbreaking. Mulai dari pemukulan beduk, potong pita, penekanan serinai, hingga seremonial sekop seman menandakan pembangunan dimulai.\n\n(@h.muhammadrudi )Kepala BP Batam Muhammad Rudi, mengatakan pembangunan ini menjadi tonggak sejarah bagi pengembangan Bandara Hang Nadim sebagai bandara bertaraf internasional yang maju dan modern.\n\n“Pembangunan Terminal II ini menjadi kebangkitan Bandara Hang Nadim yang kita cintai, mari kita dukung, sehingga Batam kota baru bisa sama-sama kita capai.” Kata Muhammad Rudi pada wartawan.\n\nTerminal II Bandara Hang Nadim Batam merupakan salah satu proyek infrastruktur strategis di Indonesia yang diharapkan dapat meningkatkan kapasitas bandara dan menarik lebih banyak wisatawan dan investor ke Batam.\n\n“Dengan beroperasinya terminal ini nantinya, diharapkan konektivitas udara di Batam semakin meningkat dan dapat mendukung pertumbuhan ekonomi di wilayah ini.” terangnya. \n\n📷 Dok: Zal/matapedia\n\nBaca selengkapnya di matapedia6.com. Jangan lupa follow instagram matapedia6com and Facebook, YouTube, Tiktok untuk berita menarik lainnya! \n\n#focus #beritaterkini #kepri #pemilu #pilgub\n#bpbatam #kepri #batam #bandara hangnadim #terminal	0	0
191	91	https://www.instagram.com/p/C7g_mz7vNfP/	2024-05-28 14:29:13+00	Politikus PDI Perjuangan, Ansy Lema maju sebagai bakal calon gubernur NTT setelah banyaknya dorongan dari masyarakat, khususnya relawan milenial di seluruh kabupaten/kota se-NTT. Ansy memantapkan langkahnya tersebut dengan mendaftar di tiga partai sekaligus, pada Sabtu (4/5).\n\nPartai yang ia daftar adalah PDI Perjuangan, PAN dan PKB. Menurutnya, PAN sebagai kaum islam modernis dalam konteks nasional, PKB adalah kelompok nahdiyin tradisional dan PDI Perjuangan adalah rumah kebangsaan dan kebhinekaan. Apabila ketiganya menyatu, maka inilah warna kebhinekaan Indonesia dan juga NTT.\n\nUntuk PAN sendiri, lanjutnya, sudah ada komunikasi dengan Ketua DPW PAN NTT, Ahmad Yohan. Sehingga, proses di PAN akan ia ikuti sesuai mekanisme dan aturan yang berlaku.\n\nAnsy menyebut, ada aspirasi dari akar rumput untuk mendorong dirinya maju sudah lama berkembang. Bahkan, banyak juga politisi PDI Perjuangan yang menginginkan dirinya untuk maju. “Karena jujur mereka omong terbuka dengan saya," kata Ansy.\n\nKarena itu, dirinya pun memantapkan hati untuk maju ke Pilgub mendatang. \n\nSementara itu, Sekwil DPW PAN NTT, Marthen Lenggu mengatakan, keputusan yang diambil Ansy Lema tentu berat apalagi soal perjuangan membangun NTT lewat jalur eksekutif. PAN memang memiliki semangat membicarakan persoalan kemiskinan, pendidikan dan kesehatan. Karena itu, menurutnya, slogan Nelayan Tani Ternak yang diusung Ansy Lema menjadi ciri khas tersendiri.\n\nSumber:\nhttps://www.gesuri.id/pemilu/pilgub-ntt-ansy-lema-banyak-politisi-pdi-perjuangan-ingin-saya-pimpin-ntt-b2k6AZNn1\n            \nIkuti perkembangan politik tanah air di youtube Total Politik                         \n.................................................                  \n#TotalPolitik #AduPerspektif #Pilpres #pemilu2024 #PilkadaSerentak2024 \n#Koalisi #politik #Jokowi #JokoWidodo #PrabowoSubianto #GibranRakabumingRaka #PrabowoGibran #PDIPerjuangan #GubernurNTT #NTT #AnsyLema #PAN	9	616
192	92	https://www.instagram.com/p/C7g4TlmyQvI/	2024-05-28 13:25:26+00	Wih... Bos Burj Khalifa mau investasi di IKN nih?\n\nPemilik Burj Khalifa berkunjung ke IKN. Sesampainya disana dirinya dibuat takjub oleh wujud IKN sebuah kota besar yang hijau. Bahkan dirinya berniat ingin berkontribusi besar terhadap pembangunan IKN.\n\nApakah IKN bakal disulap lebih bagus dari Dubai? Wah keren sih...\n\n#prabowosubianto #prabowosubiantopresiden2024 #prabowosubiantopresiden #prabowosubiantoforri1 #prabowosubiantopresidenri2024 #prabowosubiantodjojohadikusumo #jokowi #politik #indonesiamaju #prabowo #nkri #viralindonesia #gerindra #pilpres #jokowidodo #politikindonesia #gibranrakabumingraka #pemilu #prabowopresiden #pilpres2024 #pemilu2024 #presiden #capres #irianajokowidodo #capres2024 #gibran #calonpresiden #irianajokowi #kaesangpangarep #gibranrakabuming	0	33
200	100	https://www.instagram.com/p/C7g4QPuSacg/	2024-05-28 13:24:58+00	TIPS POSITIF HAMIL DALAM 3 BULAN\n==============================\nBuat Bunda yang belum positif hamil & belum dikaruniai momongan\nHayo, siapa yang mau dapat TIPS GRATIS cara "TEPAT & BENAR" dalam menentukan PROSES KEHAMILAN??? Bagi yg ingin dapat TIPS GRATIS silahkan Komen *SAYA MAU TIPSNYA* di kolom komentar ya!\n\nTIPS GRATIS ini akan kami berikan bagi 200 komen yg masuk lebih dulu!\n\nYuK! Tuliskan komen dari sekarang juga ya Bund\nKarna waktu terbatas hanya 2 Minggu ke depan\n\nKami juga punya "PROGRAM HAMIL dengan harga terjangkau bagi bunda yg mau ikut dengan PROMIL kami.\nDan sudah banyak TESTIMONI dari para Bunda yg sudah BERHASIL membuktikannya.\n\nBagi yg mau ikut PROMIL bersama kami segera hubungi kontak kami\nWhatsAap: 088232943658📲\n\n#kondanganhijab #kondangan #gamiscantik #bajuolshop #kebayawedding #ootdkondangan #fashionwanita #bajuwanita #duahijabtrans7 #bajulebaran #kebayajakarta #tutorialhijabsegiempat #weddingsyari #tumblrcinta #hitamputihtrans7 #matanajwa  #pilpres #promil #kehamilan #hariraya	0	4
193	93	https://www.instagram.com/p/C7g2puSSbc2/	2024-05-28 13:10:59+00	Dewan Pimpinan Pusat (DPP) PDIP hingga saat ini belum memutuskan sosok yang akan mereka usung untuk maju di pemilihan kepala daerah (pilkada) wilayah Sumatera Utara (Sumut).\n\nKetua DPP PDIP Djarot Saiful Hidayat mengatakan partainya masih menjaring nama-nama potensial sebelum nantinya akan diputuskan oleh Ketua Umum Megawati Soekarnoputri. Namun, Djarot mengatakan pihaknya ingin Sumut memiliki pemimpin yang merakyat, bukan bos yang hanya ingin disanjung hanya karena menjadi menantu orang besar.\n\nHingga saat ini, kata Djarot, ada beberapa nama potensial yang masuk bursa calon gubernur yang akan diusung PDIP. Mereka berasal dari internal maupun eksternal partai.\n\nDari internal, lanjut Djarot, beberapa nama potensial seperti Nikson Nababan, Sutarto, Basuki Tjahaja Purnama alias Ahok. Sementara, dari eksternal ada Eddy Rahmayadi hingga Musa Rajekshah alias Ijeck.\n\nDi sisi lain, Djarot juga memastikan partainya akan bekerja sama atau berkoalisi dengan partai lain untuk mengusung pasangan cagub dan cawagub di Sumut. Komunikasi dengan partai lain juga sudah dilakukan PDIP terkait peluang mengusung Ijeck.\n\nSumber:\nhttps://www.cnnindonesia.com/nasional/20240528155049-32-1102908/pdip-cari-sosok-cagub-sumut-bukan-bos-menantunya-orang-besar\n            \nIkuti perkembangan politik tanah air di youtube Total Politik                         \n.................................................                  \n#TotalPolitik #AduPerspektif #Pilpres #pemilu2024 #PilkadaSerentak2024 #Koalisi #politik #Jokowi #JokoWidodo #PrabowoSubianto #GibranRakabumingRaka #PrabowoGibran #PDIPerjuangan #GubernurSumateraUtara #BasukiTjahajaPurnama #BobbyNasution #EddyRahmayadi #MusaRajekshah	180	1252
194	94	https://www.instagram.com/p/C7mDDKYv73H/	2024-05-30 13:35:31+00	"Presiden Jokowi bersyukur karena rasio utang pemerintah Indonesia lebih rendah dibandingkan negara lain. Menurut Jokowi, rasio utang pemerintah terhadap produk domestik bruto (PDB) masih berada di kisaran 39%. Padahal negara lain ada yang mencapai 130% hingga 220%. \n\nHal itu disampaikan Jokowi saat menjelaskan soal bunga utang sebagai salah satu hal yang ditakuti banyak negara dunia. ""Kemudian yang ketiga yang ditakuti oleh semua negara yang namanya bunga pinjaman. Karena semua negara itu memiliki pinjaman, ada yang sampai 220%, nggak usah saya sebutkan negara mana bapak ibu saya kira sudah tahu. Ada yang 130% yang dekat kita, saya kita bapak-ibu juga sudah tahu,"" kata Jokowi dalam sambutannya di acara Inaugurasi GP Ansor, di Istora Senayan, Jakarta Pusat, Senin (27/5). ""Dan kita pada tataran kalau dibandingkan dengan negara-negara lain, kita berada di 39%,"" tambah dia."\n\n#jokowi #indonesia #prabowo #jokowidodo #indonesiamaju #jakarta #covid #aniesbaswedan #jokowilagi #jokowipresidenku #corona #segi #presidenjokowi #dirumahaja #viral #like #lfl #jokowiamin #sandiagauno #pancasila #periode #rockygerung #pilpres #tetapjokowi #bandung #politik #marufamin #surabaya #hariantikorupsisedunia #Kaesang	0	0
195	95	https://www.instagram.com/p/C7lzCT5voQi/	2024-05-30 11:15:35+00	Para pedagang Pasar Taman Citra Lok Tuan Keluhkan sepinya pengunjung.\nPara pedagang pasar menuntut untuk kembali ke pasar lama. Pasalnya pasar baru hingga kini belum membawa keuntungan yang sesuai kemauan para pedagang.\n“Solusinya cuma kembali ke pasar lama,” kata Ketua Forum Pedagang Pasar Taman Citra Loktuan Abdul Aziz.\nMenanggapi itu, Wali Kota Bontang Basri Rase mengatakan, sepinya pasar itu dipengaruhi beberapa hal. Salah satunya perkembangan masyarakat yang kini menuju ke transaksi online.\n.\n.\n.baca berita selengkapnya di instastory @bekesah.co\n.\n Update informasi menarik lainnya di www.bekesah.co\n__\nJangan lupa follow media sosial kami\nIG @bekesahdotco\nYt Bekesah Channel\nFB Bekesah.co\nKasih Like, Comment dan Subscribe\n#bekesahdotco #bekesahnew #bangkesah #bekesahhariini #beritabontang  #bontang #kaltim #samarinda #sangatta #berita #viral #beritaterkini #indonesia #news #info #beritaviral #pilpres #beritaindonesia #infoterkini #informasi #trending #beritaupdate  #videoviral  #beritaharian #trendingtopic	9	114
196	96	https://www.instagram.com/p/C7lkMyfJOyl/	2024-05-30 09:05:57+00	Haiii sobat pemilih pantau terus akun @pps.tanahkongkong\nKami ada untuk melayani masyarakat di Pilkada 2024.\n\n#ppstanahkongkong\n#kpu #kpumelayani #kpubulukumba #pps #ujungbulu #tanahkongkong #bulukumba #pilkada #pilkada2024 #pemilu #story #moment #jangangolput	0	6
197	97	https://www.instagram.com/p/C7iqy2lBOhS/	2024-05-29 06:05:51+00	Taksi Terbang cuma ada di IKN....\n\nIbu Kota Nusantara didesain untuk menjadi kota canggih sekaligus berkelanjutan. Kabarnya, dari IKN ke Balikpapan atau Palu masyarakat bisa menggunakan taksi terbang.\n\nInfrastruktur di IKN emang didesain se canggih itu. IKN layak jadi kota terbaik di Indonesia!\n\nCoba komen deh, emangnya boleh se canggih ini?\n\n#prabowosubianto #prabowosubiantopresiden2024 #prabowosubiantopresiden #prabowosubiantoforri1 #prabowosubiantopresidenri2024 #prabowosubiantodjojohadikusumo #jokowi #politik #indonesiamaju #prabowo #nkri #viralindonesia #gerindra #pilpres #jokowidodo #politikindonesia #gibranrakabumingraka #pemilu #prabowopresiden #pilpres2024 #pemilu2024 #presiden #capres #irianajokowidodo #capres2024 #gibran #calonpresiden #irianajokowi #kaesangpangarep #gibranrakabuming	0	1
198	98	https://www.instagram.com/p/C7jq7BHyAQM/	2024-05-29 15:26:12+00	"Mahasiwa di Makassar menyambut gembira batalnya kenaikan Uang Kuliah Tunggal (UKT). Pembatalan tersebut setelah Menteri Pendidikan, Kebudayaan, Riset, dan Teknologi (Mendikbudristek), Nadiem Makarim dipanggil oleh Presiden Joko Widodo (Jokowi) di Istana Kepresidenan, Jakarta, Senin (27/5). ""Kami Kemendikbudristek telah mengambil keputusan untuk membatalkan kenaikan UKT di tahun ini dan kami akan merevaluasi semua permintaan peningkatan UKT dari PTN,"" kata Nadiem.\n\nNadiem mengatakan tidak akan ada kenaikan UKT buat semua mahasiswa pada tahun ini. Kemendikbud akan mengevaluasi permintaan UKT yang diajukan perguruan tinggi. ""Jadi untuk tahun ini tidak ada mahasiswa yang akan terdampak dengan kenaikan UKT tersebut dan kami akan mengevaluasi satu per satu permintaan atau permohonan perguruan tinggi untuk peningkatan UKT tapi itu pun untuk tahun berikutnya,"" katanya."\n\n#jokowi #indonesia #prabowo #jokowidodo #indonesiamaju #jakarta #covid #aniesbaswedan #jokowilagi #jokowipresidenku #corona #segi #presidenjokowi #dirumahaja #viral #like #lfl #jokowiamin #sandiagauno #pancasila #periode #rockygerung #pilpres #tetapjokowi #bandung #politik #marufamin #surabaya #hariantikorupsisedunia #Kaesang	0	23
199	99	https://www.instagram.com/p/C7jpOqMSl3C/	2024-05-29 15:11:24+00	"Pembangunan Rumah Sakit Umum Pusat (RSUP) Ibu Kota Nusantara (IKN) saat ini menunjukkan perkembangan signifikan. Executive Vice President (EVP) Corporate Secretary PT Hutama Karya (Persero) Adjib Al Hakim mengungkapkan, pekerjaan struktur konstruksi RSUP ini terus berlanjut. ""Hingga kini telah mencapai level 34,01 persen,"" ujar Adjib kepada Kompas.com, Jumat (24/5/2024).\n\nPeletakan batu pertama pembangunan RSUP ini diresmikan Presiden RI Joko Widodo (Jokowi) pada Rabu (20/12/2023). RSUP merupakan rumah sakit keempat di IKN yang sudah dimulai pembangunannya. Rumah sakit ini khusus menangani masalah jantung dan stroke. "\n\n#jokowi #indonesia #prabowo #jokowidodo #indonesiamaju #jakarta #covid #aniesbaswedan #jokowilagi #jokowipresidenku #corona #segi #presidenjokowi #dirumahaja #viral #like #lfl #jokowiamin #sandiagauno #pancasila #periode #rockygerung #pilpres #tetapjokowi #bandung #politik #marufamin #surabaya #hariantikorupsisedunia #Kaesang	0	16
\.


--
-- Data for Name: posts_private; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.posts_private (post_id, user_id, media_uri_1, media_uri_2, "timestamp", caption) FROM stdin;
1101	1001	media/posts/202405/441231633_6636741696429457_9125934838639662559_n_18049042846651398.webp		2024-05-05 11:14:07+00	days in the west
1102	1001	media/posts/202209/307885856_198522612606400_8754778410968927017_n_18247754077139737.webp	media/posts/202209/308546903_157810103593910_8137905426401279341_n_17936661413277485.webp	2022-09-21 22:13:07+00	apparition
\.


--
-- Data for Name: user_private; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.user_private (user_id, user_name, name, followers, following, biography, profile_pic_uri, location, created_at, user_creation_ip, email, phone_number, birth_date, gender) FROM stdin;
1001	handokota	Handoko Tejo Atmoko	440	658		media/profile/202402/428225917_2610354065809004_1477134114930424770_n_18004660751368324.jpg	Bojongsoang, Jawa Barat, Indonesia	2016-06-27 11:13:31+00	114.79.29.32	handokota@protonmail.com	+628122222419	2002-04-19 00:00:00+00	male
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: instagram; Owner: avnadmin
--

COPY instagram.users (user_id, user_name, id, name, followers, following, biography, profile_picture) FROM stdin;
1	andifauziahastrid	6660486251	Af Astrid	1004	536	Lecturer Journalistic Dept. at UIN Alauddin Makassar,  Mafindo Makassar, JAPELIDI, AJI Makassar, Pemuda ICMI Sulsel, PDRI Sulsel	https://scontent-waw2-2.cdninstagram.com/v/t51.2885-19/268245708_650958652708471_7894459668381738235_n.jpg?_nc_ht=scontent-waw2-2.cdninstagram.com&_nc_cat=107&_nc_ohc=p5Sp548VuYkQ7kNvgHK7iIV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCN5HpI0flqoqUtgJX5ag_EaKN1Gg3jU2VUScHAeELf1Q&oe=665E7614&_nc_sid=1e20d2
2	ppkjatiagung_	66964211291	PPK Jati Agung	64	106	Panitia Pemilihan Kecamatan Jati Agung\nKabupaten Lampung Selatan	https://instagram.ffln4-1.fna.fbcdn.net/v/t51.2885-19/444776481_297413593424755_989097083850464863_n.jpg?_nc_ht=instagram.ffln4-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=9XHXO7xGDB0Q7kNvgH3pRD5&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDhy6rvGFLiyx_Yed1_wj1Yod5RnKFq3g1jNQ1AMAWwYQ&oe=665E8F52&_nc_sid=1e20d2
3	laskarprabowo_08	60792559243	Laskar Prabowo 08	509	82	DPP Laskar Prabowo 08 Nasional\nPresiden Terpilih @prabowo \nWakil Presiden Terpilih @gibran_rakabuming \nPeriode 2024-2029\n#LaskarPrabowo08	https://instagram.fqcj1-1.fna.fbcdn.net/v/t51.2885-19/361228937_947610469836954_3717275578706093379_n.jpg?_nc_ht=instagram.fqcj1-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=AxrJ1oVd_nYQ7kNvgG04Wt6&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCc3-JfdiL5Fi3jW0fVNFayfX3CPKK10bW33XwE8_gudg&oe=665E7256&_nc_sid=1e20d2
4	sultantv.co	3627626468	SultanTV.co	15692	253	Official Instagram account of SULTANTV	https://instagram.ffru6-1.fna.fbcdn.net/v/t51.2885-19/399020742_268909992775405_5675060726990924482_n.jpg?_nc_ht=instagram.ffru6-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=PN373QFWUJwQ7kNvgEZNjQ7&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBnbwwq2-bK_imF2nYThK66u0z0NWSBX9lo0LScR2TLFA&oe=665EA3DB&_nc_sid=1e20d2
5	kuruih_maibo	53589556305	Kuruih Maibo	0	25	Kuruih Maibo	https://instagram.fccs10-1.fna.fbcdn.net/v/t51.2885-19/285531516_438020961423965_2458540951915366403_n.jpg?_nc_ht=instagram.fccs10-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=2lnA-DWsKi8Q7kNvgE04S-w&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAloAxWZRtq9gfQnJ3Gfb00zfkI4kKn6PrFxZ7GYvpBYg&oe=665E7E90&_nc_sid=1e20d2
6	ifess.me	64280628361	iFess Media	9999	18	The Face of Gen Z and Milenials	https://instagram.frec10-1.fna.fbcdn.net/v/t51.2885-19/422728317_756141893245636_8860810542718152452_n.jpg?_nc_ht=instagram.frec10-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=qp_QikgCC2kQ7kNvgEQ-HqV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC1pNIlmnhwt8SHpPcUz0p1XeEYk3nB08NqU3PdwdtxIg&oe=665E8134&_nc_sid=1e20d2
7	asoitabang87	53551128484	Asoy Tabang	4	14	Asoy Tabang (AT)	https://scontent-gig4-2.cdninstagram.com/v/t51.2885-19/280434402_156381306879861_4288411074841873008_n.jpg?_nc_ht=scontent-gig4-2.cdninstagram.com&_nc_cat=109&_nc_ohc=UCJxx3_GBcYQ7kNvgE60W6L&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBwB-4l-W5di-H66VIVAwoYnyBAc0BXvAjpu-pv4IrpQg&oe=665E8BD6&_nc_sid=1e20d2
8	asoitabang87	53551128484	Asoy Tabang	4	14	Asoy Tabang (AT)	https://scontent-gig4-2.cdninstagram.com/v/t51.2885-19/280434402_156381306879861_4288411074841873008_n.jpg?_nc_ht=scontent-gig4-2.cdninstagram.com&_nc_cat=109&_nc_ohc=UCJxx3_GBcYQ7kNvgE60W6L&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBwB-4l-W5di-H66VIVAwoYnyBAc0BXvAjpu-pv4IrpQg&oe=665E8BD6&_nc_sid=1e20d2
9	pps_sekaran_2024	66961215648	PPS KELURAHAN SEKARAN	10	12		https://instagram.fver2-1.fna.fbcdn.net/v/t51.2885-19/446193388_1582746436009314_6876228368851824858_n.jpg?_nc_ht=instagram.fver2-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=BHqRQkDQChgQ7kNvgEjEDAD&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC1RHBcMU-EjZyynnR5W5YG_C54L1CC5oKVDW8yCOa5HA&oe=665E84F9&_nc_sid=1e20d2
10	panwascam_sangattaselatan	27306962193	Panwascam Sangatta Selatan	848	846	Akun Resmi.\n✉️ Panwassangattaselatan@gmail.com\n🏛️ Jl. Pelajar No 13 RT. 21 Kelurahan Singa Geweh	https://scontent-dus1-1.cdninstagram.com/v/t51.2885-19/324701910_553028480061870_2094266207853088588_n.jpg?_nc_ht=scontent-dus1-1.cdninstagram.com&_nc_cat=106&_nc_ohc=N9Cko2CqB04Q7kNvgFH9pR4&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCDs79L1Dpm1KxrFcbz4M6y2HAL7hM2-XnqVt4Cf543EA&oe=665E7B04&_nc_sid=1e20d2
11	rezahandika455	45717333620	Reza Handika	124	14	Dunia yang cerah	https://instagram.fcgy2-1.fna.fbcdn.net/v/t51.2885-19/148740435_706750016689808_4726903767370386245_n.jpg?_nc_ht=instagram.fcgy2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=pQwHdaJCqLsQ7kNvgG2mryV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBmksv41-bLMBBVF1OgHlI03kPRXQJKTZ4GFJ377Xq8RA&oe=665E7A57&_nc_sid=1e20d2
12	pps_pulo.pilkada2024	66987261781		6	15		https://instagram.fakx4-2.fna.fbcdn.net/v/t51.2885-19/446129584_344580468348005_7240443211138499616_n.jpg?_nc_ht=instagram.fakx4-2.fna.fbcdn.net&_nc_cat=105&_nc_ohc=XEOTEbHNChgQ7kNvgE7sqli&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCCpuAgFOtW02XtZSF1L4mH-NIVVPsH7ityyT2UNXjZIQ&oe=665E764C&_nc_sid=1e20d2
13	ensiklopediabebas	2304316201	Media Bebas	103038	21	Akun shitpost berkedok media gen-z yang fokus pada media informasi. Menyediakan konten unik, edukasi, dan kata bijak.\nManaged By : @pickme.management	https://instagram.ftpe9-1.fna.fbcdn.net/v/t51.2885-19/434174391_716130910401280_6846974775523336063_n.jpg?_nc_ht=instagram.ftpe9-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=TmGGmRtIXU0Q7kNvgEcTAxZ&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYA2qaYjXMIsFXds6SeUCytbED3EDre0eknBDFD9DD29DA&oe=665E81C4&_nc_sid=1e20d2
14	panwascamdepok.pilkada2024	67053008622	PANWASCAM DEPOK SLEMAN	18	5	Cp : 085293437797 \nKompleks Kapanewon Depok Jl. Pajajaran Condongcatur Depok Sleman Yogyakarta.	https://instagram.fcgh10-1.fna.fbcdn.net/v/t51.2885-19/446784713_1290174998373188_4211218036508507292_n.jpg?_nc_ht=instagram.fcgh10-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=FayK613IMaYQ7kNvgFq2vHp&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBPN_-7CVGgf0CzRFuufKCxliNPW0xmPy2F-_pw1xVNfA&oe=665E889B&_nc_sid=1e20d2
15	sarimayangrita	45551536810	ritamayangsari	273	42	Tetap semangat	https://instagram.fgyn8-1.fna.fbcdn.net/v/t51.2885-19/277077337_653311439060482_4538584599153747103_n.jpg?_nc_ht=instagram.fgyn8-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=1bO_RWaobeMQ7kNvgGm2_Er&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAdVJEHssbKo0eBZWHyW66wJ5jM7gdX4hq6QV8es6p7rA&oe=665E6BB5&_nc_sid=1e20d2
16	aditya876fm	214761386	Radio Aditya 87.6 FM Pekanbaru	6861	254	Aditya Hits Music Station!\n📞0761-34411 \n📱0811 754 3000 (WA)	https://instagram.fbsb2-1.fna.fbcdn.net/v/t51.2885-19/426230975_1981742108893106_8191867149113633662_n.jpg?_nc_ht=instagram.fbsb2-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=uU_UuoTUeB8Q7kNvgH3292X&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD5fLeL9apcu4GhB7ojIRDpRu2vB-_VRJaQe0yxYd3h4w&oe=665E7942&_nc_sid=1e20d2
17	rezahandika455	45717333620	Reza Handika	124	14	Dunia yang cerah	https://instagram.fcgy2-1.fna.fbcdn.net/v/t51.2885-19/148740435_706750016689808_4726903767370386245_n.jpg?_nc_ht=instagram.fcgy2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=pQwHdaJCqLsQ7kNvgG2mryV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBmksv41-bLMBBVF1OgHlI03kPRXQJKTZ4GFJ377Xq8RA&oe=665E7A57&_nc_sid=1e20d2
18	rezahandika455	45717333620	Reza Handika	124	14	Dunia yang cerah	https://instagram.fcgy2-1.fna.fbcdn.net/v/t51.2885-19/148740435_706750016689808_4726903767370386245_n.jpg?_nc_ht=instagram.fcgy2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=pQwHdaJCqLsQ7kNvgG2mryV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBmksv41-bLMBBVF1OgHlI03kPRXQJKTZ4GFJ377Xq8RA&oe=665E7A57&_nc_sid=1e20d2
19	rezahandika455	45717333620	Reza Handika	124	14	Dunia yang cerah	https://instagram.fcgy2-1.fna.fbcdn.net/v/t51.2885-19/148740435_706750016689808_4726903767370386245_n.jpg?_nc_ht=instagram.fcgy2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=pQwHdaJCqLsQ7kNvgG2mryV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBmksv41-bLMBBVF1OgHlI03kPRXQJKTZ4GFJ377Xq8RA&oe=665E7A57&_nc_sid=1e20d2
20	sarimayangrita	45551536810	ritamayangsari	273	42	Tetap semangat	https://instagram.fgyn8-1.fna.fbcdn.net/v/t51.2885-19/277077337_653311439060482_4538584599153747103_n.jpg?_nc_ht=instagram.fgyn8-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=1bO_RWaobeMQ7kNvgGm2_Er&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAdVJEHssbKo0eBZWHyW66wJ5jM7gdX4hq6QV8es6p7rA&oe=665E6BB5&_nc_sid=1e20d2
21	sarimayangrita	45551536810	ritamayangsari	273	42	Tetap semangat	https://instagram.fgyn8-1.fna.fbcdn.net/v/t51.2885-19/277077337_653311439060482_4538584599153747103_n.jpg?_nc_ht=instagram.fgyn8-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=1bO_RWaobeMQ7kNvgGm2_Er&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAdVJEHssbKo0eBZWHyW66wJ5jM7gdX4hq6QV8es6p7rA&oe=665E6BB5&_nc_sid=1e20d2
22	ini_jambi_	56141207831	𝐈𝐍𝐈 𝐉𝐀𝐌𝐁𝐈	369	1256	𝖎𝖓𝖎 𝖏𝖆𝖒𝖇𝖎\nSitus Web Berita & Media\nOfficial account 𝖎𝖓𝖎 𝖏𝖆𝖒𝖇𝖎\n|info| repost | update\nhelo: 𝖎𝖓𝖎 𝖏𝖆𝖒𝖇𝖎\nJAMBI, SUMATERA	https://scontent-jnb2-1.cdninstagram.com/v/t51.2885-19/359382157_1253166092013423_6364834889626798619_n.jpg?_nc_ht=scontent-jnb2-1.cdninstagram.com&_nc_cat=103&_nc_ohc=N-ctr4j1AKoQ7kNvgEB_7nZ&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDVDB3c5lRvy8e8qR9kr6fQkgVDaEHHfLoUl4pQjyB63Q&oe=665E6EF3&_nc_sid=1e20d2
23	sarimayangrita	45551536810	ritamayangsari	273	42	Tetap semangat	https://instagram.fgyn8-1.fna.fbcdn.net/v/t51.2885-19/277077337_653311439060482_4538584599153747103_n.jpg?_nc_ht=instagram.fgyn8-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=1bO_RWaobeMQ7kNvgGm2_Er&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAdVJEHssbKo0eBZWHyW66wJ5jM7gdX4hq6QV8es6p7rA&oe=665E6BB5&_nc_sid=1e20d2
24	ppscikarag	67031211056	PPS DESA CIKARAG	7	6	Publikasi Persiapan Pemungutan Suara PILKADA 2024\n_______\nDIVSDM @adi_23007\nDIVTEKNIS @sitisaidah\nDIVDATIN @ddnabdlmjd	https://instagram.fpoa33-1.fna.fbcdn.net/v/t51.2885-19/447146590_335809739323598_537307985691673884_n.jpg?_nc_ht=instagram.fpoa33-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=cS0w9jlf0o8Q7kNvgE-Y526&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC3w_Ll83WKiB_1oUvCd9uHJy-FsZgbYsEAqMGlYXsLHQ&oe=665E7049&_nc_sid=1e20d2
25	masterlaptop	7522486753	Laptop Master	182534	2	TRUSTED SELLER !! 💻 💯%\nDAFTAR LAPTOP READY KLIK @masterlaptop_store 🏆\n🏅 Diutamakan COD gann !\nLebih lengkap dtg ke workshop 📩\nFOLLOW US 🏅	https://scontent-tpe1-1.cdninstagram.com/v/t51.2885-19/291515927_573962114115089_6472248077166144159_n.jpg?_nc_ht=scontent-tpe1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=UROm-bQClxQQ7kNvgFhFZPy&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCjfudOJX1qzEMOSpJfpNbu85OIswP30Gj2Rf7NF9hK0w&oe=665E754C&_nc_sid=1e20d2
26	masterlaptop	7522486753	Laptop Master	182534	2	TRUSTED SELLER !! 💻 💯%\nDAFTAR LAPTOP READY KLIK @masterlaptop_store 🏆\n🏅 Diutamakan COD gann !\nLebih lengkap dtg ke workshop 📩\nFOLLOW US 🏅	https://scontent-tpe1-1.cdninstagram.com/v/t51.2885-19/291515927_573962114115089_6472248077166144159_n.jpg?_nc_ht=scontent-tpe1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=UROm-bQClxQQ7kNvgFhFZPy&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCjfudOJX1qzEMOSpJfpNbu85OIswP30Gj2Rf7NF9hK0w&oe=665E754C&_nc_sid=1e20d2
27	masterlaptop	7522486753	Laptop Master	182534	2	TRUSTED SELLER !! 💻 💯%\nDAFTAR LAPTOP READY KLIK @masterlaptop_store 🏆\n🏅 Diutamakan COD gann !\nLebih lengkap dtg ke workshop 📩\nFOLLOW US 🏅	https://scontent-tpe1-1.cdninstagram.com/v/t51.2885-19/291515927_573962114115089_6472248077166144159_n.jpg?_nc_ht=scontent-tpe1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=UROm-bQClxQQ7kNvgFhFZPy&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCjfudOJX1qzEMOSpJfpNbu85OIswP30Gj2Rf7NF9hK0w&oe=665E754C&_nc_sid=1e20d2
28	depokambyar	22190681043	Margonda	436	1465		https://instagram.ffru6-1.fna.fbcdn.net/v/t51.2885-19/446967587_1412583796109891_790310271142899227_n.jpg?_nc_ht=instagram.ffru6-1.fna.fbcdn.net&_nc_cat=111&_nc_ohc=ABRQJ5HwqVMQ7kNvgERPKNh&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC2qr-hJ9_5-galLiRRlFfinclAj58sSgkDQqCXiXK7lQ&oe=665E9496&_nc_sid=1e20d2
29	panwascam_sangattaselatan	27306962193	Panwascam Sangatta Selatan	848	846	Akun Resmi.\n✉️ Panwassangattaselatan@gmail.com\n🏛️ Jl. Pelajar No 13 RT. 21 Kelurahan Singa Geweh	https://scontent-dus1-1.cdninstagram.com/v/t51.2885-19/324701910_553028480061870_2094266207853088588_n.jpg?_nc_ht=scontent-dus1-1.cdninstagram.com&_nc_cat=106&_nc_ohc=N9Cko2CqB04Q7kNvgFH9pR4&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCDs79L1Dpm1KxrFcbz4M6y2HAL7hM2-XnqVt4Cf543EA&oe=665E7B04&_nc_sid=1e20d2
30	pps_pungangan_batang	59665197249	PPS Pungangan	64	82		https://scontent-cpt1-1.cdninstagram.com/v/t51.2885-19/355445238_1908813569488968_6710430692732466128_n.jpg?_nc_ht=scontent-cpt1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=g90ROX2yteUQ7kNvgFLUM2S&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBl9B9MMmme8rnqynsYDN9azz5WPio3xWXgZGCkAFMk2w&oe=665E8ACC&_nc_sid=1e20d2
31	matapedia6com	63979287110	matapedia6.com	38	149	Perusahaan Media/Berita\nMengabarkan informasi tercepat, aktual dan verifikasi dengan valid.	https://instagram.faqa1-1.fna.fbcdn.net/v/t51.2885-19/417105803_664079409001601_7647163466701071746_n.jpg?_nc_ht=instagram.faqa1-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=ccdyvuxy470Q7kNvgEsycwz&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD4L_OnoJNMVjUAONy9hEFaPeseH0-u4Y6LmPxTbskmUQ&oe=665E814F&_nc_sid=1e20d2
32	matapedia6com	63979287110	matapedia6.com	38	149	Perusahaan Media/Berita\nMengabarkan informasi tercepat, aktual dan verifikasi dengan valid.	https://instagram.faqa1-1.fna.fbcdn.net/v/t51.2885-19/417105803_664079409001601_7647163466701071746_n.jpg?_nc_ht=instagram.faqa1-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=ccdyvuxy470Q7kNvgEsycwz&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD4L_OnoJNMVjUAONy9hEFaPeseH0-u4Y6LmPxTbskmUQ&oe=665E814F&_nc_sid=1e20d2
33	ppsdesamaduratelukpakedai	67005308118	Pps Madura Teluk Pakedai	3	13	Akun Resmi Media Sosial Panitia Pemungutan Suara (PPS) 2024...	https://instagram.fmex12-1.fna.fbcdn.net/v/t51.2885-19/446221842_1430015231011519_5519921628732995998_n.jpg?_nc_ht=instagram.fmex12-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=FRPrGJyZblwQ7kNvgE8lCIU&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAOh0I8IrL7ObE6RzmUCROe0oc-2F99FcDx233iB33AyA&oe=665E66C6&_nc_sid=1e20d2
34	ppscikarag	67031211056	PPS DESA CIKARAG	7	6	Publikasi Persiapan Pemungutan Suara PILKADA 2024\n_______\nDIVSDM @adi_23007\nDIVTEKNIS @sitisaidah\nDIVDATIN @ddnabdlmjd	https://instagram.fpoa33-1.fna.fbcdn.net/v/t51.2885-19/447146590_335809739323598_537307985691673884_n.jpg?_nc_ht=instagram.fpoa33-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=cS0w9jlf0o8Q7kNvgE-Y526&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC3w_Ll83WKiB_1oUvCd9uHJy-FsZgbYsEAqMGlYXsLHQ&oe=665E7049&_nc_sid=1e20d2
35	matapedia6com	63979287110	matapedia6.com	38	149	Perusahaan Media/Berita\nMengabarkan informasi tercepat, aktual dan verifikasi dengan valid.	https://instagram.faqa1-1.fna.fbcdn.net/v/t51.2885-19/417105803_664079409001601_7647163466701071746_n.jpg?_nc_ht=instagram.faqa1-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=ccdyvuxy470Q7kNvgEsycwz&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD4L_OnoJNMVjUAONy9hEFaPeseH0-u4Y6LmPxTbskmUQ&oe=665E814F&_nc_sid=1e20d2
36	info_nusantara4	53786383079	Info Nusantara	2522	2941	JKT	https://instagram.fvcp4-1.fna.fbcdn.net/v/t51.2885-19/427066394_798726645414506_791269595025824042_n.jpg?_nc_ht=instagram.fvcp4-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=7_GcyQ4X2uMQ7kNvgEwEvsC&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBQ04Q4OH83y9XRt5qx6utDDbnpWdDd01e5Aji575-wnQ&oe=665E7D8A&_nc_sid=1e20d2
37	ppscikarag	67031211056	PPS DESA CIKARAG	7	6	Publikasi Persiapan Pemungutan Suara PILKADA 2024\n_______\nDIVSDM @adi_23007\nDIVTEKNIS @sitisaidah\nDIVDATIN @ddnabdlmjd	https://instagram.fpoa33-1.fna.fbcdn.net/v/t51.2885-19/447146590_335809739323598_537307985691673884_n.jpg?_nc_ht=instagram.fpoa33-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=cS0w9jlf0o8Q7kNvgE-Y526&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC3w_Ll83WKiB_1oUvCd9uHJy-FsZgbYsEAqMGlYXsLHQ&oe=665E7049&_nc_sid=1e20d2
38	kabar_istana	51462270225	Kabar Istana	46250	7460	Kabar Istana Negara 🇮🇩	https://instagram.fsaw1-11.fna.fbcdn.net/v/t51.2885-19/428956426_1740685006410720_5120831589277649098_n.jpg?_nc_ht=instagram.fsaw1-11.fna.fbcdn.net&_nc_cat=100&_nc_ohc=x0a1rGsB73sQ7kNvgGec4Fo&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAaPQh3qFUb-m4xow_lyUhnpgcvBlBy-4Ec9kee50be8Q&oe=665E9ACA&_nc_sid=1e20d2
39	matapedia6com	63979287110	matapedia6.com	38	149	Perusahaan Media/Berita\nMengabarkan informasi tercepat, aktual dan verifikasi dengan valid.	https://instagram.faqa1-1.fna.fbcdn.net/v/t51.2885-19/417105803_664079409001601_7647163466701071746_n.jpg?_nc_ht=instagram.faqa1-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=ccdyvuxy470Q7kNvgEsycwz&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD4L_OnoJNMVjUAONy9hEFaPeseH0-u4Y6LmPxTbskmUQ&oe=665E814F&_nc_sid=1e20d2
40	politician_academy	4265985592	Politician Academy	12452	6827	Info Politician Academy : \n⬇️ ⬇️ ⬇️	https://instagram.fjed4-3.fna.fbcdn.net/v/t51.2885-19/74363901_799985627110925_1229814153783279616_n.jpg?_nc_ht=instagram.fjed4-3.fna.fbcdn.net&_nc_cat=105&_nc_ohc=oygG139tqN4Q7kNvgGsDZQM&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCXxy6D4MFkuuWpOYUNGHBTtUL2heRsv-qrobLRIpuN5A&oe=665E96B5&_nc_sid=1e20d2
41	panwascam_kartim_official	28895035985	Panwascam Karawang Timur	546	298	Akun Panwaslu Kecamatan Karawang Timur Pemilu 2024\nhttps://karawangkab.bawaslu.go.id/	https://scontent-ist1-1.cdninstagram.com/v/t51.2885-19/412714211_1575862576151296_2940273783005429825_n.jpg?_nc_ht=scontent-ist1-1.cdninstagram.com&_nc_cat=104&_nc_ohc=tg85z9ap9OAQ7kNvgF-JaFV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBi-9di-r5z8nrEQWuQIona-EeV1vL3co-TBd6aI0vjuw&oe=665E8F76&_nc_sid=1e20d2
42	bondan_kartun	5922818135	BIJONK	629	767	Komik | Karikatur | Ilustrasi ,etc\n📱➡WA : 085258534153 \nEmail : bondanart@gmail.com	https://instagram.fala4-1.fna.fbcdn.net/v/t51.2885-19/403042119_2074802449533005_3940734562972836980_n.jpg?_nc_ht=instagram.fala4-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=Kz4F8hBl1h8Q7kNvgEXN3e6&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYANtWbhyqiRgAtnyNp99f2mCPvzDzMANPQP_VNzyV3gVw&oe=665E82DD&_nc_sid=1e20d2
43	kuruih_maibo	53589556305	Kuruih Maibo	0	25	Kuruih Maibo	https://instagram.fccs10-1.fna.fbcdn.net/v/t51.2885-19/285531516_438020961423965_2458540951915366403_n.jpg?_nc_ht=instagram.fccs10-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=2lnA-DWsKi8Q7kNvgE04S-w&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAloAxWZRtq9gfQnJ3Gfb00zfkI4kKn6PrFxZ7GYvpBYg&oe=665E7E90&_nc_sid=1e20d2
44	maju.indonesia.ku	7453702212	Indonesia 2023	74448	2552	🇮🇩	https://instagram.fkiv9-1.fna.fbcdn.net/v/t51.2885-19/293516016_119743917437886_1738482777461426575_n.jpg?_nc_ht=instagram.fkiv9-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=zLs6tFLSehkQ7kNvgHLpeBx&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBEaoGIhK2ekEr-IkLpHUyvmdT3beOGVAjI0k6LW8Glzg&oe=665E6A09&_nc_sid=1e20d2
45	reysha.rey	53242606178	Reysha Rey	57	13		https://scontent-dus1-1.cdninstagram.com/v/t51.2885-19/286198735_729955811789052_1163006262232016385_n.jpg?_nc_ht=scontent-dus1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=n_aVBaWcozcQ7kNvgHllYR1&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYATZOzz519wjhlsHATrnmd4F2NkDliok_01xilpM2sVsw&oe=665E8162&_nc_sid=1e20d2
46	yonathan.braulio	66332658170		6	16	malang	https://instagram.fbma6-1.fna.fbcdn.net/v/t51.2885-19/441209671_464791366213015_4462646416131507707_n.jpg?_nc_ht=instagram.fbma6-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=bxKZKq6KyQUQ7kNvgF4lWL5&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDAaEygSalDhDBMULzhXKiHSvm5EZj9UumPJKKTbMxiZg&oe=665E96B1&_nc_sid=1e20d2
47	amelindamarwah5	57233295995	Amelinda Marwah	2	53	WONOGIRI	https://instagram.fotp3-2.fna.fbcdn.net/v/t51.2885-19/323701603_1505733566585381_7400421722589565588_n.jpg?_nc_ht=instagram.fotp3-2.fna.fbcdn.net&_nc_cat=105&_nc_ohc=mrKs2BOFVBwQ7kNvgFHLlix&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCJQqekpagQkumxwuRa7R26PcCM_0RtriEi6Yfb3vOvRg&oe=665E8788&_nc_sid=1e20d2
48	mercywikenoor	57261237046	Mercy Wike Noor	48	36	KEDIRI	https://instagram.facc9-1.fna.fbcdn.net/v/t51.2885-19/322554268_161919626579619_8581477808357451210_n.jpg?_nc_ht=instagram.facc9-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=bY6CbOESnjAQ7kNvgFcz1KP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBH45vdpuekqBgqe_xiBHZLJ23o07n1uzwjN1aVGOv1iA&oe=665E6F1C&_nc_sid=1e20d2
49	septichairinnisa	57608173580	Septi Chairinnisa	60	26	WONOGIRI	https://instagram.fbkk22-6.fna.fbcdn.net/v/t51.2885-19/323540747_492095259705652_4872710780466545377_n.jpg?_nc_ht=instagram.fbkk22-6.fna.fbcdn.net&_nc_cat=104&_nc_ohc=z-83ls710hcQ7kNvgFfL2aP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAUZpQ2vEz7Xi1GmDCcEw07UKey1ev2FQaJslsJExaqPw&oe=665E9CA5&_nc_sid=1e20d2
50	dishcavenlab	12031123863	Dishcaven Lab	2458	41	Konveksi (Premium)\nOUR STORE: @dishcavenstore \nKliklink⬇️\n-	https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/118470179_141262191003619_5181614039035528945_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=107&_nc_ohc=YZ7jAAHSvH4Q7kNvgGs4IIK&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAvdjnY0D0_ZioR8s2EZszXPH5KjCQDfbU8SZ9y7a_UQA&oe=665E93A8&_nc_sid=1e20d2
51	k.eeptalking	64436168026	K\\EEP TALKING	3965	0	Kritis berpikir, bijak bicara, dan sadar berperan untuk merawat kebugaran demokrasi.	https://instagram.fpat2-3.fna.fbcdn.net/v/t51.2885-19/420134715_737128354739166_254462712266791040_n.jpg?_nc_ht=instagram.fpat2-3.fna.fbcdn.net&_nc_cat=106&_nc_ohc=Xppm_XTOqlEQ7kNvgEpDAZe&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD4135Axv1lg_i-HJ_iV-HpF9Y4pqTok_O7tjnfNMKdhw&oe=665E6C35&_nc_sid=1e20d2
52	nalarinstitute.official	45704690163	Nalar Institute	3537	96	Untuk sektor publik yang lebih baik. \nKELAS ONLINE FORESIGHT	https://instagram.fesb7-1.fna.fbcdn.net/v/t51.2885-19/262660988_600681624593701_8384702875632571996_n.jpg?_nc_ht=instagram.fesb7-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=DrDMPfeked8Q7kNvgF8aVXs&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAlSEVImkSrhs70Jv3fEUq6oJxu70Fmt-RatDZ2-C6y8Q&oe=665E64FF&_nc_sid=1e20d2
53	tinta_mayaa	53617379252		8	49		https://scontent-fra3-1.cdninstagram.com/v/t51.2885-19/397310422_736534151635899_436541359418063931_n.jpg?_nc_ht=scontent-fra3-1.cdninstagram.com&_nc_cat=103&_nc_ohc=qDW49iVvmrIQ7kNvgFRpW4f&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCtxL8oHj73Xb4QVTaueLr6ZPLm79D0h1L3goeyUzDKjA&oe=665E9445&_nc_sid=1e20d2
88	sarimayangrita	45551536810	ritamayangsari	273	42	Tetap semangat	https://instagram.fgyn8-1.fna.fbcdn.net/v/t51.2885-19/277077337_653311439060482_4538584599153747103_n.jpg?_nc_ht=instagram.fgyn8-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=1bO_RWaobeMQ7kNvgGm2_Er&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAdVJEHssbKo0eBZWHyW66wJ5jM7gdX4hq6QV8es6p7rA&oe=665E6BB5&_nc_sid=1e20d2
54	toko_promilcepat	6162397075	carahamilcepat4🔵	27780	3984	🔖🅜🅔🅛🅐🅨🅐🅝🅘\n👉 KONSULTASI MASALAH KEHAMILAN DAN PROMIL\n👉BIMBINGAN DAN PANDUAN PROMIL💯\nPromil Holistik Natural.\n@toko_promilcepat\nInfo wa.088232943658	https://scontent-hel3-1.cdninstagram.com/v/t51.2885-19/434023655_1443331619605138_4500063315995371505_n.jpg?_nc_ht=scontent-hel3-1.cdninstagram.com&_nc_cat=1&_nc_ohc=AokejFgMgy4Q7kNvgGD8uMi&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBX3w3KYskmltP7QYK-8jm2w2kjyMIKbfPgBRnMZrAipA&oe=665E8B47&_nc_sid=1e20d2
55	tania.genki	50288450105	tania	26422	211	Dm for post take down	https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-19/253622480_260373246058965_8294963087233701167_n.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&_nc_cat=109&_nc_ohc=XPITGA8_r2gQ7kNvgEwSbMg&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDY4qXP8Vn-iPz0fNveDuQ297y44HY-tUpZl5pgftVKnA&oe=665E6822&_nc_sid=1e20d2
56	septichairinnisa	57608173580	Septi Chairinnisa	60	26	WONOGIRI	https://instagram.fbkk22-6.fna.fbcdn.net/v/t51.2885-19/323540747_492095259705652_4872710780466545377_n.jpg?_nc_ht=instagram.fbkk22-6.fna.fbcdn.net&_nc_cat=104&_nc_ohc=z-83ls710hcQ7kNvgFfL2aP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAUZpQ2vEz7Xi1GmDCcEw07UKey1ev2FQaJslsJExaqPw&oe=665E9CA5&_nc_sid=1e20d2
57	bekesahdotco	16591843574	Bekesah.co	9278	71	Bekesah.co merupakan platform media massa yang mengusup konsep Jurnalisme yang mendalam. Update Berita Bekesah, dengan Klik link di Bawah Sini 🔽	https://instagram.frec15-1.fna.fbcdn.net/v/t51.2885-19/66844545_2896123027125464_4925605895351566336_n.jpg?_nc_ht=instagram.frec15-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=g861InIhX2wQ7kNvgEw19cA&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBUybvH1TPcsRx1a7QUWtITw1OySj0XEj4ck63tSebyIw&oe=665E955B&_nc_sid=1e20d2
58	tania.genki	50288450105	tania	26422	211	Dm for post take down	https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-19/253622480_260373246058965_8294963087233701167_n.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&_nc_cat=109&_nc_ohc=XPITGA8_r2gQ7kNvgEwSbMg&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDY4qXP8Vn-iPz0fNveDuQ297y44HY-tUpZl5pgftVKnA&oe=665E6822&_nc_sid=1e20d2
59	septichairinnisa	57608173580	Septi Chairinnisa	60	26	WONOGIRI	https://instagram.fbkk22-6.fna.fbcdn.net/v/t51.2885-19/323540747_492095259705652_4872710780466545377_n.jpg?_nc_ht=instagram.fbkk22-6.fna.fbcdn.net&_nc_cat=104&_nc_ohc=z-83ls710hcQ7kNvgFfL2aP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAUZpQ2vEz7Xi1GmDCcEw07UKey1ev2FQaJslsJExaqPw&oe=665E9CA5&_nc_sid=1e20d2
60	yonathan.braulio	66332658170		6	16	malang	https://instagram.fbma6-1.fna.fbcdn.net/v/t51.2885-19/441209671_464791366213015_4462646416131507707_n.jpg?_nc_ht=instagram.fbma6-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=bxKZKq6KyQUQ7kNvgF4lWL5&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDAaEygSalDhDBMULzhXKiHSvm5EZj9UumPJKKTbMxiZg&oe=665E96B1&_nc_sid=1e20d2
61	septichairinnisa	57608173580	Septi Chairinnisa	60	26	WONOGIRI	https://instagram.fbkk22-6.fna.fbcdn.net/v/t51.2885-19/323540747_492095259705652_4872710780466545377_n.jpg?_nc_ht=instagram.fbkk22-6.fna.fbcdn.net&_nc_cat=104&_nc_ohc=z-83ls710hcQ7kNvgFfL2aP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAUZpQ2vEz7Xi1GmDCcEw07UKey1ev2FQaJslsJExaqPw&oe=665E9CA5&_nc_sid=1e20d2
62	jaydenrentalmainan	1586132343	Sewa Mainan Semarang	16830	7504	Menyewakan Perlengkapan Bayi & Mainan Anak\n.\n• Jl. Kemuning 28 Semarang\nHP/WA: 081703438998\n.\nADA CABANG KUDUS DAN SALATIGA	https://instagram.fcpq10-1.fna.fbcdn.net/v/t51.2885-19/217569032_900307517363132_9160496446269508479_n.jpg?_nc_ht=instagram.fcpq10-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=A3Z-gAOH8WcQ7kNvgEG-pIg&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDkB_jLhRHSZsYOEh0a3dFP_FZ4I1YV9fYE7YnVlkkbxg&oe=665E75C0&_nc_sid=1e20d2
63	amelindamarwah5	57233295995	Amelinda Marwah	2	53	WONOGIRI	https://instagram.fotp3-2.fna.fbcdn.net/v/t51.2885-19/323701603_1505733566585381_7400421722589565588_n.jpg?_nc_ht=instagram.fotp3-2.fna.fbcdn.net&_nc_cat=105&_nc_ohc=mrKs2BOFVBwQ7kNvgFHLlix&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCJQqekpagQkumxwuRa7R26PcCM_0RtriEi6Yfb3vOvRg&oe=665E8788&_nc_sid=1e20d2
64	warganet.pangandaran_official	2255928725	Warganet Pangandaran	1956	433	Konten Berita, Hiburan & Promosi\nFollow : @inakor.id_pangandaran\nPT. MJI\nSubscribe :	https://instagram.fcpq3-1.fna.fbcdn.net/v/t51.2885-19/432112512_1521872331993868_1778571032950394599_n.jpg?_nc_ht=instagram.fcpq3-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=I_Nl8R362X4Q7kNvgHoQ8X-&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYA-xYI-OZCt7cofspbRVi6Uh12NN_1kFb1bOpUzp2QpkQ&oe=665E6967&_nc_sid=1e20d2
65	laskarprabowo_08	60792559243	Laskar Prabowo 08	509	82	DPP Laskar Prabowo 08 Nasional\nPresiden Terpilih @prabowo \nWakil Presiden Terpilih @gibran_rakabuming \nPeriode 2024-2029\n#LaskarPrabowo08	https://instagram.fqcj1-1.fna.fbcdn.net/v/t51.2885-19/361228937_947610469836954_3717275578706093379_n.jpg?_nc_ht=instagram.fqcj1-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=AxrJ1oVd_nYQ7kNvgG04Wt6&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCc3-JfdiL5Fi3jW0fVNFayfX3CPKK10bW33XwE8_gudg&oe=665E7256&_nc_sid=1e20d2
66	foe_sby	6655134822	Factory Outlet Electronic	2169	624	Toko Elektronik murah & Bergaransi\nReady Stock \nJl.Raya Dukuh Kupang no.96 Surabaya\nTlp.031.5682290	https://scontent-lhr6-2.cdninstagram.com/v/t51.2885-19/102980721_263305328418904_619574346577001590_n.jpg?_nc_ht=scontent-lhr6-2.cdninstagram.com&_nc_cat=104&_nc_ohc=HjdGNDZiOLEQ7kNvgHCdV9t&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAFaV65GhP7rCU649hk5GH3gwWeAzrDro_WsyWw9z6daw&oe=665E79AF&_nc_sid=1e20d2
67	tampolpolitik	61920032358	Tampol Idn	14	83	#politikindonesia	https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=111&_nc_ohc=h-KSk8iXlHIQ7kNvgFnrfS5&edm=AC_AnYUBAAAA&ccb=7-5&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2-ccb7-5&oh=00_AYAB0X9OcVMfmMgkf7oS4S19buw6AIBK6eKO5ouZ6SHy2g&oe=665E788F&_nc_sid=bfadfc
68	jokowipresidenku5	53259364535	Jokowi Presidenku	15629	2706	Kami yakin bersama Jokowi	https://instagram.fayt3-1.fna.fbcdn.net/v/t51.2885-19/290363001_138012455534060_8913170220384762872_n.jpg?_nc_ht=instagram.fayt3-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=BLRo2RCsIjsQ7kNvgF4xirR&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDTBlU3FW21iptLq8BvA4-C1629wiAm-tIx_1wNGK28kQ&oe=665E9881&_nc_sid=1e20d2
69	toko_promilcepat	6162397075	carahamilcepat4🔵	27780	3984	🔖🅜🅔🅛🅐🅨🅐🅝🅘\n👉 KONSULTASI MASALAH KEHAMILAN DAN PROMIL\n👉BIMBINGAN DAN PANDUAN PROMIL💯\nPromil Holistik Natural.\n@toko_promilcepat\nInfo wa.088232943658	https://scontent-hel3-1.cdninstagram.com/v/t51.2885-19/434023655_1443331619605138_4500063315995371505_n.jpg?_nc_ht=scontent-hel3-1.cdninstagram.com&_nc_cat=1&_nc_ohc=AokejFgMgy4Q7kNvgGD8uMi&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBX3w3KYskmltP7QYK-8jm2w2kjyMIKbfPgBRnMZrAipA&oe=665E8B47&_nc_sid=1e20d2
70	anz_shoes	3665706927	Anz's	22460	51	@anzshoesid \nBCA 0662768942\nANNAZMA GHAZALBA\n.\nCara Order Di Sorotan!\n.\nSILAKAN CEK SEPUASNYA DI LOKASI KITA👇	https://scontent-gru1-1.cdninstagram.com/v/t51.2885-19/363756652_1353587938561240_109848860418031172_n.jpg?_nc_ht=scontent-gru1-1.cdninstagram.com&_nc_cat=104&_nc_ohc=fu49Gtv6hJgQ7kNvgGuE6XN&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAuESdBotduIlgufT5Ezg4X_22GFDmSc0LAeGKGBmjIYg&oe=665E9ABC&_nc_sid=1e20d2
71	anz_shoes	3665706927	Anz's	22460	51	@anzshoesid \nBCA 0662768942\nANNAZMA GHAZALBA\n.\nCara Order Di Sorotan!\n.\nSILAKAN CEK SEPUASNYA DI LOKASI KITA👇	https://scontent-gru1-1.cdninstagram.com/v/t51.2885-19/363756652_1353587938561240_109848860418031172_n.jpg?_nc_ht=scontent-gru1-1.cdninstagram.com&_nc_cat=104&_nc_ohc=fu49Gtv6hJgQ7kNvgGuE6XN&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAuESdBotduIlgufT5Ezg4X_22GFDmSc0LAeGKGBmjIYg&oe=665E9ABC&_nc_sid=1e20d2
72	anz_shoes	3665706927	Anz's	22460	51	@anzshoesid \nBCA 0662768942\nANNAZMA GHAZALBA\n.\nCara Order Di Sorotan!\n.\nSILAKAN CEK SEPUASNYA DI LOKASI KITA👇	https://scontent-gru1-1.cdninstagram.com/v/t51.2885-19/363756652_1353587938561240_109848860418031172_n.jpg?_nc_ht=scontent-gru1-1.cdninstagram.com&_nc_cat=104&_nc_ohc=fu49Gtv6hJgQ7kNvgGuE6XN&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAuESdBotduIlgufT5Ezg4X_22GFDmSc0LAeGKGBmjIYg&oe=665E9ABC&_nc_sid=1e20d2
73	totalpolitikcom	4061615535	Total Politik	274677	18	Ingin Bicara Politik? Temukan Perspektif!\nDapatkan informasi politik menarik lainnya di : https://totalpolitik.com\nEmail: totalpolitikid@gmail.com	https://scontent-los2-1.cdninstagram.com/v/t51.2885-19/398673356_1549174855909198_2191962861747238167_n.jpg?_nc_ht=scontent-los2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=HUgJ9EYc9v8Q7kNvgFzam84&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYASSVPTGRHd50SsOkZf68YzK9cJ9bIB4R6A1AtJ8gLjDA&oe=665E825C&_nc_sid=1e20d2
74	totalpolitikcom	4061615535	Total Politik	274677	18	Ingin Bicara Politik? Temukan Perspektif!\nDapatkan informasi politik menarik lainnya di : https://totalpolitik.com\nEmail: totalpolitikid@gmail.com	https://scontent-los2-1.cdninstagram.com/v/t51.2885-19/398673356_1549174855909198_2191962861747238167_n.jpg?_nc_ht=scontent-los2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=HUgJ9EYc9v8Q7kNvgFzam84&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYASSVPTGRHd50SsOkZf68YzK9cJ9bIB4R6A1AtJ8gLjDA&oe=665E825C&_nc_sid=1e20d2
75	laststokstore	22409530282	Last Stok Store	7210	848	Ponorogo\n𝙎𝙩𝙤𝙠 𝙍𝙚𝙖𝙙𝙮 #𝙨𝙩𝙤𝙠𝙧𝙚𝙖𝙙𝙮𝙡𝙖𝙨𝙩𝙨𝙩𝙤𝙠𝙨𝙩𝙤𝙧𝙚\n𝗖𝗼𝗻𝘃𝗲𝗿𝘀𝗲\n💠\nOrder\n🔽🔽🔽	https://instagram.fbog11-1.fna.fbcdn.net/v/t51.2885-19/366406059_250077874641647_6957918327586835992_n.jpg?_nc_ht=instagram.fbog11-1.fna.fbcdn.net&_nc_cat=111&_nc_ohc=9T4Bn3TPwAQQ7kNvgFkCHqP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDGoX1fG6i2JloyDm5lK8RTKOuEekZqbLULQRe1f0pQ9g&oe=665E8A31&_nc_sid=1e20d2
76	pg.putry_roster	30028162200	PG.PUTRY ROSTER 🌏	14568	7206	➡️ PRODUSEN 𝐑𝐎𝐒𝐓𝐄𝐑 𝐁𝐄𝐓𝐎𝐍 👍\n➡️𝐁𝐀𝐓𝐀 𝐄𝐗𝐏𝐎𝐒𝐄. 𝐁𝐀𝐓𝐀 𝐓𝐄𝐌𝐏𝐄𝐋 👍\n➡️PESAN MOTIF BARU (𝐂𝐔𝐒𝐓𝐎𝐌)👍\n⬇️🅃🄻🄿 ➡️ 082115108366	https://instagram.fsdu2-1.fna.fbcdn.net/v/t51.2885-19/440347237_1856871454826719_2150933546025279311_n.jpg?_nc_ht=instagram.fsdu2-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=eeeXxHzZhTAQ7kNvgGcRQ-b&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAKd64Os0WQ3Yj4chlbF8Wq7vbuaGWbMT8JvYdEj_hTaQ&oe=665E674F&_nc_sid=1e20d2
77	zaine.paysen	66335657779		8	19	bandung	https://instagram.fbeg4-1.fna.fbcdn.net/v/t51.2885-19/441027530_412325608431933_6049340968108115787_n.jpg?_nc_ht=instagram.fbeg4-1.fna.fbcdn.net&_nc_cat=109&_nc_ohc=nZgJZnejlD8Q7kNvgEfsaUM&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC0AnFUDbQMsnl_v06M014iZlmFy6NRrnY_nzei_7148Q&oe=665E6ABF&_nc_sid=1e20d2
78	jaydenrentalmainan	1586132343	Sewa Mainan Semarang	16830	7504	Menyewakan Perlengkapan Bayi & Mainan Anak\n.\n• Jl. Kemuning 28 Semarang\nHP/WA: 081703438998\n.\nADA CABANG KUDUS DAN SALATIGA	https://instagram.fcpq10-1.fna.fbcdn.net/v/t51.2885-19/217569032_900307517363132_9160496446269508479_n.jpg?_nc_ht=instagram.fcpq10-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=A3Z-gAOH8WcQ7kNvgEG-pIg&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDkB_jLhRHSZsYOEh0a3dFP_FZ4I1YV9fYE7YnVlkkbxg&oe=665E75C0&_nc_sid=1e20d2
79	yonathan.braulio	66332658170		6	16	malang	https://instagram.fbma6-1.fna.fbcdn.net/v/t51.2885-19/441209671_464791366213015_4462646416131507707_n.jpg?_nc_ht=instagram.fbma6-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=bxKZKq6KyQUQ7kNvgF4lWL5&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDAaEygSalDhDBMULzhXKiHSvm5EZj9UumPJKKTbMxiZg&oe=665E96B1&_nc_sid=1e20d2
80	septichairinnisa	57608173580	Septi Chairinnisa	60	26	WONOGIRI	https://instagram.fbkk22-6.fna.fbcdn.net/v/t51.2885-19/323540747_492095259705652_4872710780466545377_n.jpg?_nc_ht=instagram.fbkk22-6.fna.fbcdn.net&_nc_cat=104&_nc_ohc=z-83ls710hcQ7kNvgFfL2aP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAUZpQ2vEz7Xi1GmDCcEw07UKey1ev2FQaJslsJExaqPw&oe=665E9CA5&_nc_sid=1e20d2
81	septichairinnisa	57608173580	Septi Chairinnisa	60	26	WONOGIRI	https://instagram.fbkk22-6.fna.fbcdn.net/v/t51.2885-19/323540747_492095259705652_4872710780466545377_n.jpg?_nc_ht=instagram.fbkk22-6.fna.fbcdn.net&_nc_cat=104&_nc_ohc=z-83ls710hcQ7kNvgFfL2aP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAUZpQ2vEz7Xi1GmDCcEw07UKey1ev2FQaJslsJExaqPw&oe=665E9CA5&_nc_sid=1e20d2
82	amelindamarwah5	57233295995	Amelinda Marwah	2	53	WONOGIRI	https://instagram.fotp3-2.fna.fbcdn.net/v/t51.2885-19/323701603_1505733566585381_7400421722589565588_n.jpg?_nc_ht=instagram.fotp3-2.fna.fbcdn.net&_nc_cat=105&_nc_ohc=mrKs2BOFVBwQ7kNvgFHLlix&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCJQqekpagQkumxwuRa7R26PcCM_0RtriEi6Yfb3vOvRg&oe=665E8788&_nc_sid=1e20d2
83	mercywikenoor	57261237046	Mercy Wike Noor	48	36	KEDIRI	https://instagram.facc9-1.fna.fbcdn.net/v/t51.2885-19/322554268_161919626579619_8581477808357451210_n.jpg?_nc_ht=instagram.facc9-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=bY6CbOESnjAQ7kNvgFcz1KP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBH45vdpuekqBgqe_xiBHZLJ23o07n1uzwjN1aVGOv1iA&oe=665E6F1C&_nc_sid=1e20d2
84	dishcavenlab	12031123863	Dishcaven Lab	2458	41	Konveksi (Premium)\nOUR STORE: @dishcavenstore \nKliklink⬇️\n-	https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/118470179_141262191003619_5181614039035528945_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=107&_nc_ohc=YZ7jAAHSvH4Q7kNvgGs4IIK&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYAvdjnY0D0_ZioR8s2EZszXPH5KjCQDfbU8SZ9y7a_UQA&oe=665E93A8&_nc_sid=1e20d2
85	rezahandika455	45717333620	Reza Handika	124	14	Dunia yang cerah	https://instagram.fcgy2-1.fna.fbcdn.net/v/t51.2885-19/148740435_706750016689808_4726903767370386245_n.jpg?_nc_ht=instagram.fcgy2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=pQwHdaJCqLsQ7kNvgG2mryV&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBmksv41-bLMBBVF1OgHlI03kPRXQJKTZ4GFJ377Xq8RA&oe=665E7A57&_nc_sid=1e20d2
86	pejuang_promil	6095806136	PROGRAM HAMIL	63628	7523	#pejuang_promiltestimoni\n*Open PP*\nMELAYANI : ⤵\n1.Program & panduan cepat hamil\n2.kesehatan\n⤵⤵🆗\nKONSULTASI GRATIS \nKlik \n👇👇👇	https://scontent-dus1-1.cdninstagram.com/v/t51.2885-19/44611478_561821304288947_5845445275765702656_n.jpg?_nc_ht=scontent-dus1-1.cdninstagram.com&_nc_cat=111&_nc_ohc=8JwEqEpnktYQ7kNvgHbSSNF&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDQzsvtrUUimaOPKXzY7nHmnIo80ZT0y8s2ps4UXOeXCg&oe=665E99D5&_nc_sid=1e20d2
87	mitsubishi.sunmotorjabodetabek	50110590442	Mitsubishi_Marthaalena	760	66	081388474447 wa/call 🙋‍♀️🤳\nBEST SALES Counter 🏆 Of The Year 2022 & 2023\nPT.SUN STAR MOTOR - Mitsubishi Kalimalang	https://instagram.flos5-3.fna.fbcdn.net/v/t51.2885-19/439204152_836260771654663_2152528813186340744_n.jpg?_nc_ht=instagram.flos5-3.fna.fbcdn.net&_nc_cat=107&_nc_ohc=qT1zSewK_UMQ7kNvgEFn7hW&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYCm6swNqlG7mwCZYGDBaDj2Pb7QQahuRm6AI-nwBV_N7A&oe=665E6E4E&_nc_sid=1e20d2
89	infonusantara.r1	53611277057	🅸🅽🅵🅾🅽🆄🆂🅰🅽🆃🅰🆁🅰	855	1382	Bangsa yang tidak percaya kepada kekuatan dirinya sebagai suatu bangsa, tidak dapat berdiri sebagai suatu bangsa yang merdeka. Dirgahayu Indonesiaku	https://instagram.fksn2-1.fna.fbcdn.net/v/t51.2885-19/427397963_414651814349924_2205144774546285121_n.jpg?_nc_ht=instagram.fksn2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=Pmgwqx9rROUQ7kNvgGXkAG0&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYA7AAf0zNeD3W9erJQQ9AARez4I6MWrumeN3x4GwoJrXA&oe=665E7FA5&_nc_sid=1e20d2
90	matapedia6com	63979287110	matapedia6.com	38	149	Perusahaan Media/Berita\nMengabarkan informasi tercepat, aktual dan verifikasi dengan valid.	https://instagram.faqa1-1.fna.fbcdn.net/v/t51.2885-19/417105803_664079409001601_7647163466701071746_n.jpg?_nc_ht=instagram.faqa1-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=ccdyvuxy470Q7kNvgEsycwz&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYD4L_OnoJNMVjUAONy9hEFaPeseH0-u4Y6LmPxTbskmUQ&oe=665E814F&_nc_sid=1e20d2
91	totalpolitikcom	4061615535	Total Politik	274677	18	Ingin Bicara Politik? Temukan Perspektif!\nDapatkan informasi politik menarik lainnya di : https://totalpolitik.com\nEmail: totalpolitikid@gmail.com	https://scontent-los2-1.cdninstagram.com/v/t51.2885-19/398673356_1549174855909198_2191962861747238167_n.jpg?_nc_ht=scontent-los2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=HUgJ9EYc9v8Q7kNvgFzam84&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYASSVPTGRHd50SsOkZf68YzK9cJ9bIB4R6A1AtJ8gLjDA&oe=665E825C&_nc_sid=1e20d2
92	jokowipresidenku5	53259364535	Jokowi Presidenku	15629	2706	Kami yakin bersama Jokowi	https://instagram.fayt3-1.fna.fbcdn.net/v/t51.2885-19/290363001_138012455534060_8913170220384762872_n.jpg?_nc_ht=instagram.fayt3-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=BLRo2RCsIjsQ7kNvgF4xirR&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDTBlU3FW21iptLq8BvA4-C1629wiAm-tIx_1wNGK28kQ&oe=665E9881&_nc_sid=1e20d2
93	totalpolitikcom	4061615535	Total Politik	274677	18	Ingin Bicara Politik? Temukan Perspektif!\nDapatkan informasi politik menarik lainnya di : https://totalpolitik.com\nEmail: totalpolitikid@gmail.com	https://scontent-los2-1.cdninstagram.com/v/t51.2885-19/398673356_1549174855909198_2191962861747238167_n.jpg?_nc_ht=scontent-los2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=HUgJ9EYc9v8Q7kNvgFzam84&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYASSVPTGRHd50SsOkZf68YzK9cJ9bIB4R6A1AtJ8gLjDA&oe=665E825C&_nc_sid=1e20d2
94	zaine.paysen	66335657779		8	19	bandung	https://instagram.fbeg4-1.fna.fbcdn.net/v/t51.2885-19/441027530_412325608431933_6049340968108115787_n.jpg?_nc_ht=instagram.fbeg4-1.fna.fbcdn.net&_nc_cat=109&_nc_ohc=nZgJZnejlD8Q7kNvgEfsaUM&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC0AnFUDbQMsnl_v06M014iZlmFy6NRrnY_nzei_7148Q&oe=665E6ABF&_nc_sid=1e20d2
95	bekesahdotco	16591843574	Bekesah.co	9278	71	Bekesah.co merupakan platform media massa yang mengusup konsep Jurnalisme yang mendalam. Update Berita Bekesah, dengan Klik link di Bawah Sini 🔽	https://instagram.frec15-1.fna.fbcdn.net/v/t51.2885-19/66844545_2896123027125464_4925605895351566336_n.jpg?_nc_ht=instagram.frec15-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=g861InIhX2wQ7kNvgEw19cA&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBUybvH1TPcsRx1a7QUWtITw1OySj0XEj4ck63tSebyIw&oe=665E955B&_nc_sid=1e20d2
96	pps.tanahkongkong	63931637461	PPS TANAH KONGKONG	74	69	Panitia Pemungutan Suara\n@kpu_bulukumba \n📍Sekretariat PPS Kantor Lurah Tanah Kongkong\nJl. DR. Muh. Hatta No. 66 | Prioritaskan Perhatikan Selesaikan	https://instagram.fkch2-2.fna.fbcdn.net/v/t51.2885-19/446346785_454525677268606_3749894482879845770_n.jpg?_nc_ht=instagram.fkch2-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=cyFOW_5SAWcQ7kNvgE6w_GT&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYDL_CGLHWg5zvWd6y-QrX_nm0ux4dLdQW-JMLfoQdWwiA&oe=665E6B7D&_nc_sid=1e20d2
97	infonusantara.r1	53611277057	🅸🅽🅵🅾🅽🆄🆂🅰🅽🆃🅰🆁🅰	855	1382	Bangsa yang tidak percaya kepada kekuatan dirinya sebagai suatu bangsa, tidak dapat berdiri sebagai suatu bangsa yang merdeka. Dirgahayu Indonesiaku	https://instagram.fksn2-1.fna.fbcdn.net/v/t51.2885-19/427397963_414651814349924_2205144774546285121_n.jpg?_nc_ht=instagram.fksn2-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=Pmgwqx9rROUQ7kNvgGXkAG0&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYA7AAf0zNeD3W9erJQQ9AARez4I6MWrumeN3x4GwoJrXA&oe=665E7FA5&_nc_sid=1e20d2
98	zaine.paysen	66335657779		8	19	bandung	https://instagram.fbeg4-1.fna.fbcdn.net/v/t51.2885-19/441027530_412325608431933_6049340968108115787_n.jpg?_nc_ht=instagram.fbeg4-1.fna.fbcdn.net&_nc_cat=109&_nc_ohc=nZgJZnejlD8Q7kNvgEfsaUM&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYC0AnFUDbQMsnl_v06M014iZlmFy6NRrnY_nzei_7148Q&oe=665E6ABF&_nc_sid=1e20d2
99	mercywikenoor	57261237046	Mercy Wike Noor	48	36	KEDIRI	https://instagram.facc9-1.fna.fbcdn.net/v/t51.2885-19/322554268_161919626579619_8581477808357451210_n.jpg?_nc_ht=instagram.facc9-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=bY6CbOESnjAQ7kNvgFcz1KP&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBH45vdpuekqBgqe_xiBHZLJ23o07n1uzwjN1aVGOv1iA&oe=665E6F1C&_nc_sid=1e20d2
100	toko_promilcepat	6162397075	carahamilcepat4🔵	27780	3984	🔖🅜🅔🅛🅐🅨🅐🅝🅘\n👉 KONSULTASI MASALAH KEHAMILAN DAN PROMIL\n👉BIMBINGAN DAN PANDUAN PROMIL💯\nPromil Holistik Natural.\n@toko_promilcepat\nInfo wa.088232943658	https://scontent-hel3-1.cdninstagram.com/v/t51.2885-19/434023655_1443331619605138_4500063315995371505_n.jpg?_nc_ht=scontent-hel3-1.cdninstagram.com&_nc_cat=1&_nc_ohc=AokejFgMgy4Q7kNvgGD8uMi&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AYBX3w3KYskmltP7QYK-8jm2w2kjyMIKbfPgBRnMZrAipA&oe=665E8B47&_nc_sid=1e20d2
\.


--
-- Data for Name: followers_private; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.followers_private (fs_id, user_id, id, user_link) FROM stdin;
1	1001	1790463493965246467	https://twitter.com/intent/user?user_id=1790463493965246467
2	1001	1738925842192035840	https://twitter.com/intent/user?user_id=1738925842192035840
3	1001	1782686701040902144	https://twitter.com/intent/user?user_id=1782686701040902144
4	1001	1541048309749383168	https://twitter.com/intent/user?user_id=1541048309749383168
5	1001	1310514797968982022	https://twitter.com/intent/user?user_id=1310514797968982022
6	1001	1553672463195574272	https://twitter.com/intent/user?user_id=1553672463195574272
7	1001	1381256257739218948	https://twitter.com/intent/user?user_id=1381256257739218948
8	1001	1201164500235194370	https://twitter.com/intent/user?user_id=1201164500235194370
9	1001	1775594586863509504	https://twitter.com/intent/user?user_id=1775594586863509504
10	1001	4362523392	https://twitter.com/intent/user?user_id=4362523392
11	1001	1453927622753206281	https://twitter.com/intent/user?user_id=1453927622753206281
12	1001	1355583820297240576	https://twitter.com/intent/user?user_id=1355583820297240576
13	1001	1782655032468652032	https://twitter.com/intent/user?user_id=1782655032468652032
14	1001	1782710947658010624	https://twitter.com/intent/user?user_id=1782710947658010624
15	1001	1782297650093850624	https://twitter.com/intent/user?user_id=1782297650093850624
16	1001	1782232920083861504	https://twitter.com/intent/user?user_id=1782232920083861504
17	1001	1782230764949811200	https://twitter.com/intent/user?user_id=1782230764949811200
18	1001	1762904913284046848	https://twitter.com/intent/user?user_id=1762904913284046848
19	1001	1653309406707326976	https://twitter.com/intent/user?user_id=1653309406707326976
20	1001	702392352434987008	https://twitter.com/intent/user?user_id=702392352434987008
21	1001	1495857768301207552	https://twitter.com/intent/user?user_id=1495857768301207552
22	1001	802796659130310657	https://twitter.com/intent/user?user_id=802796659130310657
23	1001	1148632670538125312	https://twitter.com/intent/user?user_id=1148632670538125312
24	1001	1397523854126317569	https://twitter.com/intent/user?user_id=1397523854126317569
25	1001	1699821311244091394	https://twitter.com/intent/user?user_id=1699821311244091394
26	1001	89412430	https://twitter.com/intent/user?user_id=89412430
27	1001	843394894848712704	https://twitter.com/intent/user?user_id=843394894848712704
28	1001	1194250125159342080	https://twitter.com/intent/user?user_id=1194250125159342080
29	1001	1625009558300274688	https://twitter.com/intent/user?user_id=1625009558300274688
30	1001	1729830855043108864	https://twitter.com/intent/user?user_id=1729830855043108864
31	1001	1647413555673825282	https://twitter.com/intent/user?user_id=1647413555673825282
32	1001	1725743537608941568	https://twitter.com/intent/user?user_id=1725743537608941568
33	1001	1248583173811798016	https://twitter.com/intent/user?user_id=1248583173811798016
34	1001	1200342062878429185	https://twitter.com/intent/user?user_id=1200342062878429185
35	1001	2731724953	https://twitter.com/intent/user?user_id=2731724953
36	1001	2269818308	https://twitter.com/intent/user?user_id=2269818308
37	1001	1264091792024252416	https://twitter.com/intent/user?user_id=1264091792024252416
38	1001	1120649135458095104	https://twitter.com/intent/user?user_id=1120649135458095104
39	1001	2297133960	https://twitter.com/intent/user?user_id=2297133960
40	1001	945113729389158401	https://twitter.com/intent/user?user_id=945113729389158401
41	1001	1664104521440821249	https://twitter.com/intent/user?user_id=1664104521440821249
42	1001	1020247507073298432	https://twitter.com/intent/user?user_id=1020247507073298432
43	1001	3278543233	https://twitter.com/intent/user?user_id=3278543233
44	1001	1258780853406068737	https://twitter.com/intent/user?user_id=1258780853406068737
45	1001	3257808338	https://twitter.com/intent/user?user_id=3257808338
46	1001	1291667127007551489	https://twitter.com/intent/user?user_id=1291667127007551489
47	1001	1114868046244356096	https://twitter.com/intent/user?user_id=1114868046244356096
48	1001	1554528063354183681	https://twitter.com/intent/user?user_id=1554528063354183681
49	1001	1465882289447923718	https://twitter.com/intent/user?user_id=1465882289447923718
50	1001	1286464326220443648	https://twitter.com/intent/user?user_id=1286464326220443648
51	1001	720193962695270400	https://twitter.com/intent/user?user_id=720193962695270400
52	1001	1539914033783922689	https://twitter.com/intent/user?user_id=1539914033783922689
53	1001	1098812087726268416	https://twitter.com/intent/user?user_id=1098812087726268416
54	1001	1667371355241848833	https://twitter.com/intent/user?user_id=1667371355241848833
55	1001	1385659735827906564	https://twitter.com/intent/user?user_id=1385659735827906564
56	1001	1616312287224303616	https://twitter.com/intent/user?user_id=1616312287224303616
57	1001	1302896613321371648	https://twitter.com/intent/user?user_id=1302896613321371648
58	1001	1306552783282122753	https://twitter.com/intent/user?user_id=1306552783282122753
59	1001	81881014	https://twitter.com/intent/user?user_id=81881014
60	1001	2934723193	https://twitter.com/intent/user?user_id=2934723193
61	1001	1621878920688844800	https://twitter.com/intent/user?user_id=1621878920688844800
62	1001	1541769992915415041	https://twitter.com/intent/user?user_id=1541769992915415041
63	1001	1137560449904308225	https://twitter.com/intent/user?user_id=1137560449904308225
64	1001	740739758993735684	https://twitter.com/intent/user?user_id=740739758993735684
65	1001	703954342726885376	https://twitter.com/intent/user?user_id=703954342726885376
66	1001	594313739	https://twitter.com/intent/user?user_id=594313739
67	1001	1502438925901918209	https://twitter.com/intent/user?user_id=1502438925901918209
68	1001	1539943168795643905	https://twitter.com/intent/user?user_id=1539943168795643905
69	1001	1393915269743923203	https://twitter.com/intent/user?user_id=1393915269743923203
70	1001	1216685981258010636	https://twitter.com/intent/user?user_id=1216685981258010636
71	1001	1115859719669915648	https://twitter.com/intent/user?user_id=1115859719669915648
72	1001	1437255332737126400	https://twitter.com/intent/user?user_id=1437255332737126400
73	1001	232779531	https://twitter.com/intent/user?user_id=232779531
74	1001	1393986075203280896	https://twitter.com/intent/user?user_id=1393986075203280896
75	1001	1200149381384560641	https://twitter.com/intent/user?user_id=1200149381384560641
76	1001	1093724965344428032	https://twitter.com/intent/user?user_id=1093724965344428032
77	1001	1315887627615129600	https://twitter.com/intent/user?user_id=1315887627615129600
78	1001	966594313147723777	https://twitter.com/intent/user?user_id=966594313147723777
79	1001	709256151511117825	https://twitter.com/intent/user?user_id=709256151511117825
80	1001	966578650698035200	https://twitter.com/intent/user?user_id=966578650698035200
81	1001	1276699647336001536	https://twitter.com/intent/user?user_id=1276699647336001536
82	1001	1014623674677092352	https://twitter.com/intent/user?user_id=1014623674677092352
83	1001	1240036380467585025	https://twitter.com/intent/user?user_id=1240036380467585025
84	1001	2806793917	https://twitter.com/intent/user?user_id=2806793917
85	1001	1252936851058384896	https://twitter.com/intent/user?user_id=1252936851058384896
86	1001	297771765	https://twitter.com/intent/user?user_id=297771765
87	1001	1237639481148100609	https://twitter.com/intent/user?user_id=1237639481148100609
88	1001	1071921521679982592	https://twitter.com/intent/user?user_id=1071921521679982592
89	1001	1196314380423426053	https://twitter.com/intent/user?user_id=1196314380423426053
90	1001	1226172530530013184	https://twitter.com/intent/user?user_id=1226172530530013184
91	1001	1238609567837089792	https://twitter.com/intent/user?user_id=1238609567837089792
92	1001	1141617037229166597	https://twitter.com/intent/user?user_id=1141617037229166597
93	1001	1139105918648324097	https://twitter.com/intent/user?user_id=1139105918648324097
94	1001	875713870236491776	https://twitter.com/intent/user?user_id=875713870236491776
95	1001	1244384745145819136	https://twitter.com/intent/user?user_id=1244384745145819136
96	1001	1089320321092542465	https://twitter.com/intent/user?user_id=1089320321092542465
97	1001	1098199368111337472	https://twitter.com/intent/user?user_id=1098199368111337472
98	1001	1246962918278574082	https://twitter.com/intent/user?user_id=1246962918278574082
99	1001	1137217921267130368	https://twitter.com/intent/user?user_id=1137217921267130368
100	1001	101215878	https://twitter.com/intent/user?user_id=101215878
101	1001	1108970355962437634	https://twitter.com/intent/user?user_id=1108970355962437634
102	1001	1215499327054864384	https://twitter.com/intent/user?user_id=1215499327054864384
103	1001	1100265706489143297	https://twitter.com/intent/user?user_id=1100265706489143297
104	1001	1240649724354416640	https://twitter.com/intent/user?user_id=1240649724354416640
105	1001	1198907792045686784	https://twitter.com/intent/user?user_id=1198907792045686784
106	1001	1172640462252806145	https://twitter.com/intent/user?user_id=1172640462252806145
107	1001	970091090043793409	https://twitter.com/intent/user?user_id=970091090043793409
\.


--
-- Data for Name: following_private; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.following_private (fg_id, user_id, id, user_link) FROM stdin;
1	1001	850528532774109184	https://twitter.com/intent/user?user_id=850528532774109184
2	1001	1784609124623540224	https://twitter.com/intent/user?user_id=1784609124623540224
3	1001	881821981397704704	https://twitter.com/intent/user?user_id=881821981397704704
4	1001	17919972	https://twitter.com/intent/user?user_id=17919972
5	1001	1541048309749383168	https://twitter.com/intent/user?user_id=1541048309749383168
6	1001	1553672463195574272	https://twitter.com/intent/user?user_id=1553672463195574272
7	1001	1201164500235194370	https://twitter.com/intent/user?user_id=1201164500235194370
8	1001	1453927622753206281	https://twitter.com/intent/user?user_id=1453927622753206281
9	1001	1381256257739218948	https://twitter.com/intent/user?user_id=1381256257739218948
10	1001	4362523392	https://twitter.com/intent/user?user_id=4362523392
11	1001	1310514797968982022	https://twitter.com/intent/user?user_id=1310514797968982022
12	1001	1775594586863509504	https://twitter.com/intent/user?user_id=1775594586863509504
13	1001	1355583820297240576	https://twitter.com/intent/user?user_id=1355583820297240576
14	1001	1345281599605075969	https://twitter.com/intent/user?user_id=1345281599605075969
15	1001	1547968106592899077	https://twitter.com/intent/user?user_id=1547968106592899077
16	1001	1725203010434056193	https://twitter.com/intent/user?user_id=1725203010434056193
17	1001	949269417245863936	https://twitter.com/intent/user?user_id=949269417245863936
18	1001	1586990445854593024	https://twitter.com/intent/user?user_id=1586990445854593024
19	1001	1587001241200390144	https://twitter.com/intent/user?user_id=1587001241200390144
20	1001	1267485832543219712	https://twitter.com/intent/user?user_id=1267485832543219712
21	1001	1725130363620753408	https://twitter.com/intent/user?user_id=1725130363620753408
22	1001	1057323534551142400	https://twitter.com/intent/user?user_id=1057323534551142400
23	1001	1725207957129084928	https://twitter.com/intent/user?user_id=1725207957129084928
24	1001	1725188974296391680	https://twitter.com/intent/user?user_id=1725188974296391680
25	1001	1487072752955658243	https://twitter.com/intent/user?user_id=1487072752955658243
26	1001	1441661092334170112	https://twitter.com/intent/user?user_id=1441661092334170112
27	1001	1587026900635242497	https://twitter.com/intent/user?user_id=1587026900635242497
28	1001	1725125435045163008	https://twitter.com/intent/user?user_id=1725125435045163008
29	1001	702392352434987008	https://twitter.com/intent/user?user_id=702392352434987008
30	1001	1653309406707326976	https://twitter.com/intent/user?user_id=1653309406707326976
31	1001	1061312904354586624	https://twitter.com/intent/user?user_id=1061312904354586624
32	1001	4684394125	https://twitter.com/intent/user?user_id=4684394125
33	1001	3292334401	https://twitter.com/intent/user?user_id=3292334401
34	1001	386467796	https://twitter.com/intent/user?user_id=386467796
35	1001	1200338119104417793	https://twitter.com/intent/user?user_id=1200338119104417793
36	1001	1670355830108200960	https://twitter.com/intent/user?user_id=1670355830108200960
37	1001	813348203303079936	https://twitter.com/intent/user?user_id=813348203303079936
38	1001	1637087245189656576	https://twitter.com/intent/user?user_id=1637087245189656576
39	1001	33043063	https://twitter.com/intent/user?user_id=33043063
40	1001	1495857768301207552	https://twitter.com/intent/user?user_id=1495857768301207552
41	1001	1487067198162046979	https://twitter.com/intent/user?user_id=1487067198162046979
42	1001	1148632670538125312	https://twitter.com/intent/user?user_id=1148632670538125312
43	1001	1397523854126317569	https://twitter.com/intent/user?user_id=1397523854126317569
44	1001	843394894848712704	https://twitter.com/intent/user?user_id=843394894848712704
45	1001	1194250125159342080	https://twitter.com/intent/user?user_id=1194250125159342080
46	1001	2225791442	https://twitter.com/intent/user?user_id=2225791442
47	1001	560103367	https://twitter.com/intent/user?user_id=560103367
48	1001	802796659130310657	https://twitter.com/intent/user?user_id=802796659130310657
49	1001	1729830855043108864	https://twitter.com/intent/user?user_id=1729830855043108864
50	1001	1625009558300274688	https://twitter.com/intent/user?user_id=1625009558300274688
51	1001	1270366067693457410	https://twitter.com/intent/user?user_id=1270366067693457410
52	1001	416704702	https://twitter.com/intent/user?user_id=416704702
53	1001	2455740283	https://twitter.com/intent/user?user_id=2455740283
54	1001	1495326248100589569	https://twitter.com/intent/user?user_id=1495326248100589569
55	1001	282006208	https://twitter.com/intent/user?user_id=282006208
56	1001	78185470	https://twitter.com/intent/user?user_id=78185470
57	1001	1685574055083261952	https://twitter.com/intent/user?user_id=1685574055083261952
58	1001	60893980	https://twitter.com/intent/user?user_id=60893980
59	1001	109762193	https://twitter.com/intent/user?user_id=109762193
60	1001	730400376	https://twitter.com/intent/user?user_id=730400376
61	1001	174799330	https://twitter.com/intent/user?user_id=174799330
62	1001	330262748	https://twitter.com/intent/user?user_id=330262748
63	1001	1090574935	https://twitter.com/intent/user?user_id=1090574935
64	1001	1314975287294083073	https://twitter.com/intent/user?user_id=1314975287294083073
65	1001	1281904534416060418	https://twitter.com/intent/user?user_id=1281904534416060418
66	1001	1316441034117718016	https://twitter.com/intent/user?user_id=1316441034117718016
67	1001	1046084008742801408	https://twitter.com/intent/user?user_id=1046084008742801408
68	1001	1500703127997087746	https://twitter.com/intent/user?user_id=1500703127997087746
69	1001	4642482935	https://twitter.com/intent/user?user_id=4642482935
70	1001	872985649871282176	https://twitter.com/intent/user?user_id=872985649871282176
71	1001	1247096496270368769	https://twitter.com/intent/user?user_id=1247096496270368769
72	1001	2538322138	https://twitter.com/intent/user?user_id=2538322138
73	1001	825412651	https://twitter.com/intent/user?user_id=825412651
74	1001	1586998054384586753	https://twitter.com/intent/user?user_id=1586998054384586753
75	1001	1248583173811798016	https://twitter.com/intent/user?user_id=1248583173811798016
76	1001	1565895180	https://twitter.com/intent/user?user_id=1565895180
77	1001	1111873826537635840	https://twitter.com/intent/user?user_id=1111873826537635840
78	1001	1242697044923305984	https://twitter.com/intent/user?user_id=1242697044923305984
79	1001	1304068061079547904	https://twitter.com/intent/user?user_id=1304068061079547904
80	1001	2413636441	https://twitter.com/intent/user?user_id=2413636441
81	1001	43105835	https://twitter.com/intent/user?user_id=43105835
82	1001	1303588601880477696	https://twitter.com/intent/user?user_id=1303588601880477696
83	1001	1581884899560423424	https://twitter.com/intent/user?user_id=1581884899560423424
84	1001	855300206086168576	https://twitter.com/intent/user?user_id=855300206086168576
85	1001	1372054296594944000	https://twitter.com/intent/user?user_id=1372054296594944000
86	1001	1356478042797797377	https://twitter.com/intent/user?user_id=1356478042797797377
87	1001	1251407687650177025	https://twitter.com/intent/user?user_id=1251407687650177025
88	1001	1574174311388426240	https://twitter.com/intent/user?user_id=1574174311388426240
89	1001	932502575689035776	https://twitter.com/intent/user?user_id=932502575689035776
90	1001	1079260908801511424	https://twitter.com/intent/user?user_id=1079260908801511424
91	1001	719944279452446720	https://twitter.com/intent/user?user_id=719944279452446720
92	1001	1162545299614662656	https://twitter.com/intent/user?user_id=1162545299614662656
93	1001	1168336921237409792	https://twitter.com/intent/user?user_id=1168336921237409792
94	1001	1292806214955307010	https://twitter.com/intent/user?user_id=1292806214955307010
95	1001	627673190	https://twitter.com/intent/user?user_id=627673190
96	1001	96951800	https://twitter.com/intent/user?user_id=96951800
97	1001	46475424	https://twitter.com/intent/user?user_id=46475424
98	1001	578062972	https://twitter.com/intent/user?user_id=578062972
99	1001	1225501286021451776	https://twitter.com/intent/user?user_id=1225501286021451776
100	1001	318872893	https://twitter.com/intent/user?user_id=318872893
101	1001	102215394	https://twitter.com/intent/user?user_id=102215394
102	1001	1469495629541904384	https://twitter.com/intent/user?user_id=1469495629541904384
103	1001	1678973209172152320	https://twitter.com/intent/user?user_id=1678973209172152320
104	1001	1200342062878429185	https://twitter.com/intent/user?user_id=1200342062878429185
105	1001	1264091792024252416	https://twitter.com/intent/user?user_id=1264091792024252416
106	1001	2269818308	https://twitter.com/intent/user?user_id=2269818308
107	1001	996204338174283779	https://twitter.com/intent/user?user_id=996204338174283779
108	1001	1120649135458095104	https://twitter.com/intent/user?user_id=1120649135458095104
109	1001	1664104521440821249	https://twitter.com/intent/user?user_id=1664104521440821249
110	1001	1258780853406068737	https://twitter.com/intent/user?user_id=1258780853406068737
111	1001	945113729389158401	https://twitter.com/intent/user?user_id=945113729389158401
112	1001	1465882289447923718	https://twitter.com/intent/user?user_id=1465882289447923718
113	1001	1291667127007551489	https://twitter.com/intent/user?user_id=1291667127007551489
114	1001	1114868046244356096	https://twitter.com/intent/user?user_id=1114868046244356096
115	1001	1539914033783922689	https://twitter.com/intent/user?user_id=1539914033783922689
116	1001	2297133960	https://twitter.com/intent/user?user_id=2297133960
117	1001	3278543233	https://twitter.com/intent/user?user_id=3278543233
118	1001	1254285530419752960	https://twitter.com/intent/user?user_id=1254285530419752960
119	1001	720193962695270400	https://twitter.com/intent/user?user_id=720193962695270400
120	1001	1286464326220443648	https://twitter.com/intent/user?user_id=1286464326220443648
121	1001	1554528063354183681	https://twitter.com/intent/user?user_id=1554528063354183681
122	1001	1020247507073298432	https://twitter.com/intent/user?user_id=1020247507073298432
123	1001	3257808338	https://twitter.com/intent/user?user_id=3257808338
124	1001	1098812087726268416	https://twitter.com/intent/user?user_id=1098812087726268416
125	1001	2600210567	https://twitter.com/intent/user?user_id=2600210567
126	1001	780460754910732288	https://twitter.com/intent/user?user_id=780460754910732288
127	1001	1281182825392164864	https://twitter.com/intent/user?user_id=1281182825392164864
128	1001	1616312287224303616	https://twitter.com/intent/user?user_id=1616312287224303616
129	1001	1322691535213785088	https://twitter.com/intent/user?user_id=1322691535213785088
130	1001	1157164084850122752	https://twitter.com/intent/user?user_id=1157164084850122752
131	1001	960704423826567168	https://twitter.com/intent/user?user_id=960704423826567168
132	1001	1384802358538883073	https://twitter.com/intent/user?user_id=1384802358538883073
133	1001	388787305	https://twitter.com/intent/user?user_id=388787305
134	1001	19583545	https://twitter.com/intent/user?user_id=19583545
135	1001	1399238850614988811	https://twitter.com/intent/user?user_id=1399238850614988811
136	1001	1258052597111336964	https://twitter.com/intent/user?user_id=1258052597111336964
137	1001	1302896613321371648	https://twitter.com/intent/user?user_id=1302896613321371648
138	1001	1306552783282122753	https://twitter.com/intent/user?user_id=1306552783282122753
139	1001	81881014	https://twitter.com/intent/user?user_id=81881014
140	1001	592151376	https://twitter.com/intent/user?user_id=592151376
141	1001	2934723193	https://twitter.com/intent/user?user_id=2934723193
142	1001	1207499167062355968	https://twitter.com/intent/user?user_id=1207499167062355968
143	1001	2266800937	https://twitter.com/intent/user?user_id=2266800937
144	1001	740739758993735684	https://twitter.com/intent/user?user_id=740739758993735684
145	1001	1621878920688844800	https://twitter.com/intent/user?user_id=1621878920688844800
146	1001	1502438925901918209	https://twitter.com/intent/user?user_id=1502438925901918209
147	1001	703954342726885376	https://twitter.com/intent/user?user_id=703954342726885376
148	1001	594313739	https://twitter.com/intent/user?user_id=594313739
149	1001	1137560449904308225	https://twitter.com/intent/user?user_id=1137560449904308225
150	1001	1541769992915415041	https://twitter.com/intent/user?user_id=1541769992915415041
151	1001	947281567	https://twitter.com/intent/user?user_id=947281567
152	1001	1539943168795643905	https://twitter.com/intent/user?user_id=1539943168795643905
153	1001	1385659735827906564	https://twitter.com/intent/user?user_id=1385659735827906564
154	1001	18211861	https://twitter.com/intent/user?user_id=18211861
155	1001	1089010123	https://twitter.com/intent/user?user_id=1089010123
156	1001	750751206427860992	https://twitter.com/intent/user?user_id=750751206427860992
157	1001	990891107943759872	https://twitter.com/intent/user?user_id=990891107943759872
158	1001	791243051813462016	https://twitter.com/intent/user?user_id=791243051813462016
159	1001	1448512059319078916	https://twitter.com/intent/user?user_id=1448512059319078916
160	1001	1415598353522458625	https://twitter.com/intent/user?user_id=1415598353522458625
161	1001	950632407530577920	https://twitter.com/intent/user?user_id=950632407530577920
162	1001	15687962	https://twitter.com/intent/user?user_id=15687962
163	1001	178690996	https://twitter.com/intent/user?user_id=178690996
164	1001	1179191990086275072	https://twitter.com/intent/user?user_id=1179191990086275072
165	1001	1501547120	https://twitter.com/intent/user?user_id=1501547120
166	1001	1272192611357323264	https://twitter.com/intent/user?user_id=1272192611357323264
167	1001	846923375209594880	https://twitter.com/intent/user?user_id=846923375209594880
168	1001	337589397	https://twitter.com/intent/user?user_id=337589397
169	1001	1393915269743923203	https://twitter.com/intent/user?user_id=1393915269743923203
170	1001	863981324117327872	https://twitter.com/intent/user?user_id=863981324117327872
171	1001	1216685981258010636	https://twitter.com/intent/user?user_id=1216685981258010636
172	1001	1126162424397041664	https://twitter.com/intent/user?user_id=1126162424397041664
173	1001	2363585042	https://twitter.com/intent/user?user_id=2363585042
174	1001	3243561805	https://twitter.com/intent/user?user_id=3243561805
175	1001	4722555409	https://twitter.com/intent/user?user_id=4722555409
176	1001	1050070953982484480	https://twitter.com/intent/user?user_id=1050070953982484480
177	1001	1076407478	https://twitter.com/intent/user?user_id=1076407478
178	1001	1471414739880189955	https://twitter.com/intent/user?user_id=1471414739880189955
179	1001	1241044602	https://twitter.com/intent/user?user_id=1241044602
180	1001	762799939395158016	https://twitter.com/intent/user?user_id=762799939395158016
181	1001	72842511	https://twitter.com/intent/user?user_id=72842511
182	1001	245548093	https://twitter.com/intent/user?user_id=245548093
183	1001	1316935098151792640	https://twitter.com/intent/user?user_id=1316935098151792640
184	1001	1198179584308588544	https://twitter.com/intent/user?user_id=1198179584308588544
185	1001	1681324362	https://twitter.com/intent/user?user_id=1681324362
186	1001	928308639315648512	https://twitter.com/intent/user?user_id=928308639315648512
187	1001	1179451804280479744	https://twitter.com/intent/user?user_id=1179451804280479744
188	1001	1163303067879477248	https://twitter.com/intent/user?user_id=1163303067879477248
189	1001	1365297503860445184	https://twitter.com/intent/user?user_id=1365297503860445184
190	1001	356049981	https://twitter.com/intent/user?user_id=356049981
191	1001	886568542295826432	https://twitter.com/intent/user?user_id=886568542295826432
192	1001	1292896873791930368	https://twitter.com/intent/user?user_id=1292896873791930368
193	1001	1280080708665409538	https://twitter.com/intent/user?user_id=1280080708665409538
194	1001	1115859719669915648	https://twitter.com/intent/user?user_id=1115859719669915648
195	1001	1271426846664454145	https://twitter.com/intent/user?user_id=1271426846664454145
196	1001	432654924	https://twitter.com/intent/user?user_id=432654924
197	1001	1200006384	https://twitter.com/intent/user?user_id=1200006384
198	1001	819191230273765376	https://twitter.com/intent/user?user_id=819191230273765376
199	1001	864120714739068928	https://twitter.com/intent/user?user_id=864120714739068928
200	1001	1021604918	https://twitter.com/intent/user?user_id=1021604918
201	1001	3196434278	https://twitter.com/intent/user?user_id=3196434278
202	1001	1277250144405041152	https://twitter.com/intent/user?user_id=1277250144405041152
203	1001	1130446548913934336	https://twitter.com/intent/user?user_id=1130446548913934336
204	1001	435344253	https://twitter.com/intent/user?user_id=435344253
205	1001	1727346757	https://twitter.com/intent/user?user_id=1727346757
206	1001	430821756	https://twitter.com/intent/user?user_id=430821756
207	1001	1308548637547347968	https://twitter.com/intent/user?user_id=1308548637547347968
208	1001	232779531	https://twitter.com/intent/user?user_id=232779531
209	1001	2363027508	https://twitter.com/intent/user?user_id=2363027508
210	1001	1393986075203280896	https://twitter.com/intent/user?user_id=1393986075203280896
211	1001	1200149381384560641	https://twitter.com/intent/user?user_id=1200149381384560641
212	1001	1093724965344428032	https://twitter.com/intent/user?user_id=1093724965344428032
213	1001	1084557086162210816	https://twitter.com/intent/user?user_id=1084557086162210816
214	1001	44196397	https://twitter.com/intent/user?user_id=44196397
215	1001	2916305152	https://twitter.com/intent/user?user_id=2916305152
216	1001	1315887627615129600	https://twitter.com/intent/user?user_id=1315887627615129600
217	1001	966594313147723777	https://twitter.com/intent/user?user_id=966594313147723777
218	1001	709256151511117825	https://twitter.com/intent/user?user_id=709256151511117825
219	1001	966578650698035200	https://twitter.com/intent/user?user_id=966578650698035200
220	1001	1276699647336001536	https://twitter.com/intent/user?user_id=1276699647336001536
221	1001	297771765	https://twitter.com/intent/user?user_id=297771765
222	1001	439164730	https://twitter.com/intent/user?user_id=439164730
223	1001	1014623674677092352	https://twitter.com/intent/user?user_id=1014623674677092352
224	1001	1095352812840472576	https://twitter.com/intent/user?user_id=1095352812840472576
225	1001	2806793917	https://twitter.com/intent/user?user_id=2806793917
226	1001	1252936851058384896	https://twitter.com/intent/user?user_id=1252936851058384896
227	1001	16548023	https://twitter.com/intent/user?user_id=16548023
228	1001	765149955396734976	https://twitter.com/intent/user?user_id=765149955396734976
229	1001	1237639481148100609	https://twitter.com/intent/user?user_id=1237639481148100609
230	1001	89412430	https://twitter.com/intent/user?user_id=89412430
231	1001	1196314380423426053	https://twitter.com/intent/user?user_id=1196314380423426053
232	1001	1226172530530013184	https://twitter.com/intent/user?user_id=1226172530530013184
233	1001	1238609567837089792	https://twitter.com/intent/user?user_id=1238609567837089792
234	1001	1141617037229166597	https://twitter.com/intent/user?user_id=1141617037229166597
235	1001	1244384745145819136	https://twitter.com/intent/user?user_id=1244384745145819136
236	1001	1089320321092542465	https://twitter.com/intent/user?user_id=1089320321092542465
237	1001	1098199368111337472	https://twitter.com/intent/user?user_id=1098199368111337472
238	1001	1071921521679982592	https://twitter.com/intent/user?user_id=1071921521679982592
239	1001	970091090043793409	https://twitter.com/intent/user?user_id=970091090043793409
240	1001	1139105918648324097	https://twitter.com/intent/user?user_id=1139105918648324097
241	1001	875713870236491776	https://twitter.com/intent/user?user_id=875713870236491776
242	1001	1139112298943897600	https://twitter.com/intent/user?user_id=1139112298943897600
243	1001	1246962918278574082	https://twitter.com/intent/user?user_id=1246962918278574082
244	1001	1172640462252806145	https://twitter.com/intent/user?user_id=1172640462252806145
245	1001	1137217921267130368	https://twitter.com/intent/user?user_id=1137217921267130368
246	1001	131476314	https://twitter.com/intent/user?user_id=131476314
247	1001	16912985	https://twitter.com/intent/user?user_id=16912985
248	1001	101215878	https://twitter.com/intent/user?user_id=101215878
249	1001	159764278	https://twitter.com/intent/user?user_id=159764278
250	1001	1215499327054864384	https://twitter.com/intent/user?user_id=1215499327054864384
251	1001	1100265706489143297	https://twitter.com/intent/user?user_id=1100265706489143297
252	1001	1240649724354416640	https://twitter.com/intent/user?user_id=1240649724354416640
253	1001	1027235279336288256	https://twitter.com/intent/user?user_id=1027235279336288256
254	1001	366987179	https://twitter.com/intent/user?user_id=366987179
255	1001	95411613	https://twitter.com/intent/user?user_id=95411613
256	1001	303651216	https://twitter.com/intent/user?user_id=303651216
257	1001	1198907792045686784	https://twitter.com/intent/user?user_id=1198907792045686784
258	1001	16573941	https://twitter.com/intent/user?user_id=16573941
259	1001	1033922521492381696	https://twitter.com/intent/user?user_id=1033922521492381696
260	1001	14372726	https://twitter.com/intent/user?user_id=14372726
\.


--
-- Data for Name: ip_audit_private; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.ip_audit_private (ip_ap_id, user_id, created_at, login_ip) FROM stdin;
1	1001	2024-06-04 14:36:05+00	182.253.158.137
2	1001	2024-06-04 14:33:12+00	182.253.158.137
3	1001	2024-06-04 05:46:58+00	114.122.84.188
4	1001	2024-06-04 05:46:57+00	114.122.68.160
5	1001	2024-06-03 23:56:23+00	182.253.158.137
6	1001	2024-06-03 19:30:49+00	182.253.158.137
7	1001	2024-06-03 17:07:47+00	114.122.73.89
8	1001	2024-06-03 08:54:11+00	114.122.68.91
9	1001	2024-06-02 23:59:17+00	182.253.158.137
10	1001	2024-06-02 20:19:07+00	182.253.158.137
11	1001	2024-06-01 19:10:54+00	182.253.158.137
12	1001	2024-06-01 15:11:21+00	182.253.158.137
13	1001	2024-06-01 05:48:15+00	114.122.69.45
14	1001	2024-06-01 05:46:51+00	114.122.72.185
15	1001	2024-06-01 02:27:38+00	114.122.75.74
16	1001	2024-05-31 20:10:58+00	182.253.158.137
17	1001	2024-05-31 19:57:30+00	182.253.158.137
18	1001	2024-05-31 17:44:56+00	182.253.158.38
19	1001	2024-05-31 14:27:39+00	114.122.69.153
20	1001	2024-05-31 14:27:34+00	114.122.69.153
21	1001	2024-05-31 12:48:50+00	114.122.85.167
22	1001	2024-05-30 19:34:28+00	182.253.158.38
23	1001	2024-05-30 15:12:46+00	182.253.158.38
24	1001	2024-05-30 11:32:43+00	114.122.71.119
25	1001	2024-05-30 11:32:36+00	114.122.68.123
26	1001	2024-05-29 21:54:52+00	182.253.158.38
27	1001	2024-05-29 16:25:12+00	182.253.158.38
28	1001	2024-05-29 05:33:29+00	114.122.77.227
29	1001	2024-05-28 23:35:35+00	182.253.158.38
30	1001	2024-05-28 18:56:40+00	182.253.158.38
31	1001	2024-05-28 06:09:03+00	114.122.108.140
32	1001	2024-05-27 21:30:40+00	182.253.158.38
33	1001	2024-05-27 19:45:06+00	182.253.158.38
34	1001	2024-05-26 20:51:43+00	182.253.158.38
35	1001	2024-05-26 18:46:16+00	182.253.158.38
36	1001	2024-05-26 16:41:55+00	114.122.106.55
37	1001	2024-05-26 16:41:53+00	114.122.100.147
38	1001	2024-05-26 16:41:52+00	114.122.100.147
39	1001	2024-05-26 16:41:51+00	114.122.106.55
40	1001	2024-05-26 16:41:51+00	114.122.115.143
41	1001	2024-05-26 13:33:09+00	114.122.104.135
42	1001	2024-05-26 13:30:55+00	114.122.102.139
43	1001	2024-05-26 13:20:46+00	114.122.103.131
44	1001	2024-05-26 10:43:23+00	114.122.116.199
45	1001	2024-05-26 10:43:20+00	114.122.108.155
46	1001	2024-05-26 10:43:20+00	114.122.108.155
47	1001	2024-05-26 10:42:46+00	114.122.116.199
48	1001	2024-05-26 10:42:44+00	114.122.104.139
49	1001	2024-05-25 20:47:26+00	182.253.158.38
50	1001	2024-05-25 20:47:13+00	182.253.158.38
51	1001	2024-05-25 10:31:32+00	114.122.116.67
52	1001	2024-05-25 10:31:30+00	114.122.116.67
53	1001	2024-05-24 22:38:35+00	182.253.158.38
54	1001	2024-05-24 19:27:59+00	182.253.158.38
55	1001	2024-05-24 17:47:19+00	114.122.105.209
56	1001	2024-05-24 13:41:05+00	114.122.69.226
57	1001	2024-05-24 13:41:04+00	114.122.73.66
58	1001	2024-05-24 13:41:03+00	114.122.78.86
59	1001	2024-05-24 13:41:03+00	114.122.75.46
60	1001	2024-05-24 11:53:21+00	114.122.76.58
61	1001	2024-05-24 11:53:19+00	114.122.72.22
62	1001	2024-05-24 11:53:18+00	114.122.75.50
63	1001	2024-05-24 11:23:39+00	114.122.73.86
64	1001	2024-05-24 08:19:17+00	114.122.77.28
65	1001	2024-05-24 07:25:24+00	114.122.85.147
66	1001	2024-05-24 07:25:22+00	114.122.72.147
67	1001	2024-05-24 06:45:19+00	114.122.68.131
68	1001	2024-05-23 23:20:51+00	182.253.158.38
69	1001	2024-05-23 19:33:40+00	182.253.158.38
70	1001	2024-05-23 15:23:21+00	114.122.75.136
71	1001	2024-05-23 08:23:11+00	114.122.115.175
72	1001	2024-05-22 21:09:02+00	182.253.158.38
73	1001	2024-05-22 20:44:10+00	182.253.158.38
74	1001	2024-05-22 10:13:31+00	114.122.85.109
75	1001	2024-05-21 22:36:21+00	182.253.158.38
76	1001	2024-05-21 22:19:14+00	182.253.158.38
77	1001	2024-05-21 15:53:08+00	114.122.85.5
78	1001	2024-05-21 15:53:03+00	114.122.68.81
79	1001	2024-05-21 15:53:03+00	114.122.68.81
80	1001	2024-05-21 15:53:01+00	114.122.85.5
81	1001	2024-05-21 15:53:01+00	114.122.73.229
82	1001	2024-05-21 12:03:45+00	114.122.83.8
83	1001	2024-05-21 12:03:45+00	114.122.78.204
84	1001	2024-05-21 12:03:41+00	114.122.85.28
85	1001	2024-05-21 10:38:20+00	114.122.74.240
86	1001	2024-05-20 23:36:02+00	182.253.158.38
87	1001	2024-05-20 20:35:10+00	182.253.158.38
88	1001	2024-05-19 19:43:12+00	182.253.158.38
89	1001	2024-05-19 18:30:29+00	182.253.158.38
90	1001	2024-05-19 15:27:53+00	114.122.71.18
91	1001	2024-05-19 15:27:53+00	114.122.69.42
92	1001	2024-05-18 21:04:53+00	182.253.158.38
93	1001	2024-05-18 19:43:12+00	182.253.158.38
94	1001	2024-05-18 16:30:01+00	114.122.105.67
95	1001	2024-05-18 16:29:58+00	114.122.105.67
96	1001	2024-05-18 10:25:57+00	114.122.84.107
97	1001	2024-05-18 10:03:39+00	114.122.71.115
98	1001	2024-05-18 10:03:39+00	114.122.76.103
99	1001	2024-05-18 08:38:28+00	114.122.78.123
100	1001	2024-05-18 06:57:53+00	114.122.85.115
101	1001	2024-05-17 20:35:09+00	182.253.158.38
102	1001	2024-05-17 18:14:58+00	182.253.158.38
103	1001	2024-05-16 21:23:30+00	182.253.158.38
104	1001	2024-05-16 20:23:30+00	182.253.158.38
105	1001	2024-05-16 17:12:55+00	114.122.85.114
106	1001	2024-05-16 17:11:02+00	114.122.104.211
107	1001	2024-05-16 12:49:55+00	114.122.111.121
108	1001	2024-05-16 12:47:46+00	114.122.109.101
109	1001	2024-05-16 09:07:25+00	114.122.70.109
110	1001	2024-05-16 09:06:28+00	114.122.69.125
111	1001	2024-05-16 06:43:05+00	114.122.115.12
112	1001	2024-05-16 06:38:42+00	114.122.115.12
113	1001	2024-05-16 03:31:23+00	114.122.116.100
114	1001	2024-05-15 19:45:16+00	182.253.158.38
115	1001	2024-05-15 19:34:39+00	182.253.158.38
116	1001	2024-05-15 16:21:39+00	114.122.103.18
117	1001	2024-05-15 14:04:28+00	114.122.84.19
118	1001	2024-05-15 14:04:28+00	114.122.72.39
119	1001	2024-05-14 21:49:19+00	182.253.158.38
120	1001	2024-05-14 18:46:17+00	182.253.158.38
121	1001	2024-05-14 18:05:09+00	114.122.72.27
122	1001	2024-05-14 13:58:03+00	114.122.72.58
123	1001	2024-05-14 13:40:18+00	182.253.158.44
124	1001	2024-05-13 20:48:21+00	182.253.158.44
125	1001	2024-05-13 19:36:44+00	182.253.158.44
126	1001	2024-05-12 20:14:17+00	182.253.158.44
127	1001	2024-05-12 17:26:57+00	182.253.158.44
128	1001	2024-05-11 19:44:08+00	182.253.158.44
129	1001	2024-05-11 11:10:08+00	185.213.83.134
130	1001	2024-05-11 09:13:45+00	185.213.83.159
131	1001	2024-05-11 08:52:56+00	182.253.158.44
132	1001	2024-05-11 08:00:35+00	185.213.83.55
133	1001	2024-05-11 07:36:26+00	185.213.83.197
134	1001	2024-05-11 07:08:30+00	114.122.83.100
135	1001	2024-05-10 18:51:49+00	182.253.158.44
136	1001	2024-05-10 16:55:22+00	185.213.83.155
137	1001	2024-05-10 10:56:10+00	182.253.158.44
138	1001	2024-05-09 23:20:08+00	182.253.158.44
139	1001	2024-05-09 16:55:20+00	185.213.83.223
140	1001	2024-05-09 15:48:34+00	114.122.75.135
141	1001	2024-05-09 14:53:41+00	114.122.82.155
142	1001	2024-05-09 14:03:38+00	114.122.84.131
143	1001	2024-05-09 10:00:36+00	182.253.158.44
144	1001	2024-05-08 22:41:06+00	182.253.158.44
145	1001	2024-05-08 15:20:28+00	185.213.83.40
146	1001	2024-05-08 11:20:18+00	182.253.158.44
147	1001	2024-05-08 09:23:12+00	114.122.106.119
148	1001	2024-05-08 04:54:55+00	114.122.103.183
149	1001	2024-05-08 04:53:55+00	114.122.114.11
150	1001	2024-05-07 19:54:33+00	182.253.158.44
151	1001	2024-05-07 16:18:39+00	182.253.158.44
152	1001	2024-05-07 14:42:03+00	114.122.108.133
153	1001	2024-05-07 07:49:23+00	114.122.74.59
154	1001	2024-05-07 04:52:24+00	114.122.114.127
155	1001	2024-05-06 22:40:28+00	182.253.158.44
156	1001	2024-05-06 13:57:08+00	114.122.70.58
157	1001	2024-05-06 07:47:08+00	114.122.76.109
158	1001	2024-05-05 19:53:23+00	182.253.158.44
159	1001	2024-05-05 07:06:20+00	114.122.110.60
160	1001	2024-05-04 20:19:41+00	182.253.158.44
161	1001	2024-05-04 17:38:30+00	182.253.158.44
162	1001	2024-05-04 15:38:50+00	114.122.76.148
163	1001	2024-05-04 08:34:35+00	114.122.114.137
164	1001	2024-05-03 16:55:03+00	182.253.158.44
165	1001	2024-05-03 10:55:53+00	182.253.158.44
166	1001	2024-05-03 07:05:56+00	114.122.104.84
167	1001	2024-05-03 07:03:50+00	114.122.115.130
168	1001	2024-05-03 02:40:37+00	114.122.105.132
169	1001	2024-05-03 00:53:04+00	182.3.53.191
170	1001	2024-05-02 22:56:17+00	182.3.53.191
171	1001	2024-05-02 21:01:35+00	103.120.169.31
172	1001	2024-05-02 21:01:31+00	103.120.169.97
173	1001	2024-05-02 16:36:52+00	182.2.167.208
174	1001	2024-05-02 16:12:07+00	182.2.167.196
175	1001	2024-05-02 12:45:52+00	182.0.205.227
176	1001	2024-05-02 12:44:49+00	182.0.207.63
177	1001	2024-05-02 12:44:49+00	182.0.207.107
178	1001	2024-05-02 12:43:46+00	182.0.239.59
179	1001	2024-05-02 12:42:46+00	182.0.238.243
180	1001	2024-05-02 12:33:35+00	182.0.229.243
181	1001	2024-05-02 12:33:33+00	182.0.245.247
182	1001	2024-05-02 12:33:33+00	182.0.207.51
183	1001	2024-05-02 09:59:10+00	182.0.206.227
184	1001	2024-05-02 09:59:08+00	182.0.228.175
185	1001	2024-05-02 09:59:08+00	182.0.214.251
186	1001	2024-05-02 08:07:35+00	182.0.238.119
187	1001	2024-05-02 08:05:59+00	182.0.247.59
188	1001	2024-05-02 05:37:28+00	114.124.210.234
189	1001	2024-05-02 05:37:27+00	114.124.204.202
190	1001	2024-05-02 05:37:27+00	114.124.215.123
191	1001	2024-05-02 05:19:09+00	114.124.242.75
192	1001	2024-05-02 04:21:29+00	182.0.229.205
193	1001	2024-05-02 04:21:21+00	182.0.238.69
194	1001	2024-05-02 03:43:04+00	114.124.241.80
195	1001	2024-05-02 03:42:03+00	114.124.238.64
196	1001	2024-05-02 03:42:03+00	114.124.245.96
197	1001	2024-05-02 03:00:08+00	114.124.206.65
198	1001	2024-05-01 21:59:57+00	103.120.169.97
199	1001	2024-05-01 21:59:56+00	103.120.169.31
200	1001	2024-05-01 16:18:47+00	182.2.145.103
201	1001	2024-05-01 16:18:47+00	182.2.145.115
202	1001	2024-05-01 09:26:56+00	182.2.167.148
203	1001	2024-05-01 07:33:14+00	182.2.146.85
204	1001	2024-05-01 07:27:36+00	114.122.75.148
205	1001	2024-05-01 02:33:39+00	114.122.75.128
206	1001	2024-05-01 00:21:49+00	182.253.158.44
207	1001	2024-04-30 22:26:55+00	182.253.158.44
208	1001	2024-04-30 16:53:52+00	114.122.73.242
209	1001	2024-04-30 16:53:52+00	114.122.85.86
210	1001	2024-04-30 16:44:56+00	114.122.77.106
211	1001	2024-04-30 16:44:49+00	114.122.74.198
212	1001	2024-04-30 12:44:35+00	114.122.71.149
213	1001	2024-04-30 08:17:16+00	114.122.102.98
214	1001	2024-04-29 22:56:57+00	182.253.158.44
215	1001	2024-04-29 15:44:20+00	114.122.74.205
216	1001	2024-04-29 11:53:18+00	114.122.115.218
217	1001	2024-04-29 11:52:17+00	114.122.117.218
218	1001	2024-04-29 07:54:12+00	114.122.70.17
219	1001	2024-04-29 07:54:02+00	114.122.82.100
220	1001	2024-04-29 07:52:55+00	114.122.76.45
221	1001	2024-04-29 07:52:38+00	114.122.73.77
222	1001	2024-04-29 05:09:53+00	182.253.158.44
223	1001	2024-04-28 22:49:13+00	182.253.158.44
224	1001	2024-04-28 09:50:57+00	114.122.108.36
225	1001	2024-04-28 09:47:02+00	114.122.78.216
226	1001	2024-04-28 09:38:36+00	114.122.100.11
227	1001	2024-04-28 09:38:25+00	114.122.103.207
228	1001	2024-04-28 08:19:57+00	114.122.69.33
229	1001	2024-04-27 20:49:39+00	182.253.158.44
230	1001	2024-04-27 16:42:47+00	114.122.107.85
231	1001	2024-04-27 16:37:04+00	114.122.110.56
232	1001	2024-04-27 16:35:55+00	114.122.107.40
233	1001	2024-04-27 16:35:38+00	114.122.115.208
234	1001	2024-04-27 07:35:36+00	114.122.85.184
235	1001	2024-04-26 19:41:52+00	182.253.158.44
236	1001	2024-04-26 11:07:55+00	114.122.82.215
237	1001	2024-04-26 11:06:53+00	114.122.79.143
238	1001	2024-04-25 22:07:22+00	182.253.158.44
239	1001	2024-04-24 20:15:00+00	182.253.158.44
240	1001	2024-04-23 19:46:56+00	182.253.158.44
241	1001	2024-04-22 19:32:03+00	182.253.158.44
242	1001	2024-04-22 16:24:33+00	182.253.158.44
243	1001	2024-04-22 13:25:36+00	114.122.74.133
244	1001	2024-04-22 13:25:36+00	114.122.70.21
245	1001	2024-04-22 07:57:34+00	114.122.108.156
246	1001	2024-04-22 07:47:24+00	114.122.104.124
247	1001	2024-04-22 07:43:39+00	114.122.110.244
248	1001	2024-04-22 07:27:46+00	114.122.104.231
249	1001	2024-04-22 07:27:46+00	114.122.107.43
250	1001	2024-04-22 07:01:11+00	114.122.105.214
251	1001	2024-04-22 06:40:27+00	182.2.46.126
252	1001	2024-04-22 04:17:47+00	182.2.77.111
253	1001	2024-04-22 01:08:10+00	103.18.35.6
254	1001	2024-04-21 18:45:10+00	103.18.35.6
255	1001	2024-04-21 13:53:51+00	182.2.42.98
256	1001	2024-04-21 02:54:08+00	103.18.35.6
257	1001	2024-04-20 17:41:20+00	103.18.35.6
258	1001	2024-04-20 05:12:11+00	182.2.70.113
259	1001	2024-04-20 04:47:49+00	182.2.46.206
260	1001	2024-04-19 18:40:38+00	103.18.35.6
261	1001	2024-04-19 17:29:32+00	194.35.122.18
262	1001	2024-04-19 17:08:26+00	217.146.93.175
263	1001	2024-04-19 17:08:07+00	192.166.246.55
264	1001	2024-04-19 16:37:57+00	103.18.35.6
265	1001	2024-04-18 18:36:11+00	103.18.35.6
266	1001	2024-04-18 16:29:48+00	185.216.231.204
267	1001	2024-04-18 04:35:11+00	182.2.77.150
268	1001	2024-04-17 20:08:12+00	103.18.35.6
269	1001	2024-04-17 11:03:29+00	182.2.83.86
270	1001	2024-04-16 23:46:38+00	103.18.35.6
271	1001	2024-04-16 16:47:02+00	103.18.35.6
272	1001	2024-04-16 12:02:19+00	182.2.50.68
273	1001	2024-04-16 10:46:43+00	182.2.78.110
274	1001	2024-04-16 09:13:07+00	182.2.46.221
275	1001	2024-04-16 08:24:41+00	182.2.75.84
276	1001	2024-04-16 05:22:15+00	182.2.72.232
277	1001	2024-04-15 20:14:29+00	103.18.35.6
278	1001	2024-04-14 21:28:44+00	103.18.35.6
279	1001	2024-04-13 23:01:36+00	103.18.35.6
280	1001	2024-04-13 16:42:58+00	103.18.35.6
281	1001	2024-04-12 20:41:44+00	103.18.35.6
282	1001	2024-04-12 15:11:13+00	182.2.74.210
283	1001	2024-04-12 07:44:33+00	182.2.42.89
284	1001	2024-04-12 03:40:13+00	182.2.52.69
285	1001	2024-04-12 03:39:20+00	182.2.51.253
286	1001	2024-04-12 02:03:50+00	182.2.76.108
287	1001	2024-04-11 22:53:10+00	103.18.35.6
288	1001	2024-04-11 13:13:21+00	103.18.35.6
289	1001	2024-04-11 07:02:15+00	182.2.41.224
290	1001	2024-04-10 21:38:22+00	103.18.35.77
291	1001	2024-04-10 06:51:20+00	182.2.76.33
292	1001	2024-04-09 23:02:55+00	103.18.35.77
293	1001	2024-04-09 12:41:09+00	182.2.52.102
294	1001	2024-04-08 21:53:00+00	103.18.35.77
295	1001	2024-04-08 12:09:43+00	182.2.75.107
296	1001	2024-04-08 11:28:57+00	182.2.45.235
297	1001	2024-04-07 23:29:07+00	103.18.35.77
298	1001	2024-04-07 12:31:31+00	182.2.43.243
299	1001	2024-04-07 11:56:34+00	182.2.42.70
300	1001	2024-04-07 11:25:46+00	182.2.44.172
301	1001	2024-04-07 10:46:44+00	182.2.68.234
302	1001	2024-04-07 10:19:03+00	182.2.69.250
303	1001	2024-04-07 08:47:16+00	182.2.37.35
304	1001	2024-04-07 08:04:46+00	182.2.37.47
305	1001	2024-04-06 22:03:41+00	103.18.35.77
306	1001	2024-04-05 23:50:54+00	103.18.35.77
\.


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.keywords (keyword_id, keyword) FROM stdin;
201	pemilu
202	pilpres
\.


--
-- Data for Name: tweet_keyword; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.tweet_keyword (tk_id, tweet_id, keyword_id) FROM stdin;
301	101	201
302	102	201
303	103	201
304	104	202
305	105	201
306	106	202
307	107	201
308	108	201
309	109	201
310	110	201
311	111	202
312	112	202
313	113	201
314	114	202
315	115	202
316	116	201
317	117	202
318	118	202
319	119	202
320	120	202
321	121	201
322	122	202
323	123	201
324	124	202
325	125	202
326	126	201
327	127	201
328	128	202
329	129	202
330	130	201
331	131	201
332	132	201
333	133	202
334	134	201
335	135	201
336	136	202
337	137	202
338	138	201
339	139	201
340	140	202
341	141	201
342	142	202
343	143	201
344	144	201
345	145	202
346	146	202
347	147	201
348	148	202
349	149	202
350	150	202
351	151	201
352	152	202
353	153	201
354	154	201
355	155	202
356	156	201
357	157	202
358	158	201
359	159	201
360	160	201
361	161	201
362	162	201
363	163	201
364	164	201
365	165	201
366	166	201
367	167	201
368	168	201
369	169	201
370	170	202
371	171	201
372	172	201
373	173	202
374	174	202
375	175	202
376	176	202
377	177	202
378	178	201
379	179	201
380	180	202
381	181	201
382	182	201
383	183	201
384	184	202
385	185	201
386	186	201
387	187	201
388	188	201
389	189	201
390	190	201
391	191	201
392	192	202
393	193	201
394	194	201
395	195	202
396	196	201
397	197	202
398	198	201
399	199	201
400	200	201
\.


--
-- Data for Name: tweet_sentiment; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.tweet_sentiment (ts_id, tweet_id, sentiment_analysis) FROM stdin;
401	101	negative
402	102	neutral
403	103	negative
404	104	neutral
405	105	neutral
406	106	neutral
407	107	negative
408	108	positive
409	109	neutral
410	110	positive
411	111	neutral
412	112	neutral
413	113	negative
414	114	negative
415	115	neutral
416	116	neutral
417	117	negative
418	118	neutral
419	119	neutral
420	120	negative
421	121	neutral
422	122	negative
423	123	neutral
424	124	negative
425	125	positive
426	126	negative
427	127	negative
428	128	negative
429	129	negative
430	130	neutral
431	131	neutral
432	132	neutral
433	133	neutral
434	134	neutral
435	135	positive
436	136	negative
437	137	neutral
438	138	neutral
439	139	neutral
440	140	neutral
441	141	positive
442	142	neutral
443	143	neutral
444	144	negative
445	145	negative
446	146	neutral
447	147	neutral
448	148	negative
449	149	negative
450	150	neutral
451	151	positive
452	152	neutral
453	153	negative
454	154	positive
455	155	negative
456	156	neutral
457	157	neutral
458	158	negative
459	159	negative
460	160	neutral
461	161	positive
462	162	negative
463	163	negative
464	164	neutral
465	165	neutral
466	166	negative
467	167	neutral
468	168	neutral
469	169	neutral
470	170	negative
471	171	negative
472	172	neutral
473	173	negative
474	174	neutral
475	175	negative
476	176	neutral
477	177	neutral
478	178	neutral
479	179	negative
480	180	neutral
481	181	neutral
482	182	neutral
483	183	neutral
484	184	negative
485	185	neutral
486	186	negative
487	187	negative
488	188	neutral
489	189	neutral
490	190	negative
491	191	neutral
492	192	negative
493	193	neutral
494	194	negative
495	195	neutral
496	196	positive
497	197	neutral
498	198	neutral
499	199	neutral
500	200	positive
\.


--
-- Data for Name: tweet_type; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.tweet_type (tt_id, tweet_id, content_type) FROM stdin;
501	101	opinion
502	102	opinion
503	103	opinion
504	104	opinion
505	105	news
506	106	opinion
507	107	opinion
508	108	opinion
509	109	opinion
510	110	opinion
511	111	opinion
512	112	opinion
513	113	opinion
514	114	opinion
515	115	opinion
516	116	opinion
517	117	opinion
518	118	opinion
519	119	opinion
520	120	opinion
521	121	personal
522	122	opinion
523	123	promotion
524	124	opinion
525	125	opinion
526	126	opinion
527	127	opinion
528	128	opinion
529	129	opinion
530	130	opinion
531	131	opinion
532	132	opinion
533	133	opinion
534	134	opinion
535	135	opinion
536	136	opinion
537	137	opinion
538	138	opinion
539	139	opinion
540	140	opinion
541	141	opinion
542	142	opinion
543	143	news
544	144	opinion
545	145	opinion
546	146	news
547	147	opinion
548	148	opinion
549	149	opinion
550	150	opinion
551	151	opinion
552	152	opinion
553	153	opinion
554	154	opinion
555	155	opinion
556	156	opinion
557	157	personal
558	158	opinion
559	159	opinion
560	160	opinion
561	161	opinion
562	162	opinion
563	163	opinion
564	164	opinion
565	165	opinion
566	166	opinion
567	167	opinion
568	168	news
569	169	opinion
570	170	opinion
571	171	opinion
572	172	opinion
573	173	opinion
574	174	opinion
575	175	opinion
576	176	opinion
577	177	opinion
578	178	opinion
579	179	opinion
580	180	opinion
581	181	news
582	182	news
583	183	news
584	184	opinion
585	185	news
586	186	opinion
587	187	opinion
588	188	opinion
589	189	opinion
590	190	opinion
591	191	opinion
592	192	opinion
593	193	promotion
594	194	opinion
595	195	opinion
596	196	opinion
597	197	opinion
598	198	news
599	199	news
600	200	opinion
\.


--
-- Data for Name: tweets; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.tweets (tweet_id, user_id, twitter_url, entry_id, created_at, full_text, media_url, retweet_count, reply_count, like_count, quote_count) FROM stdin;
116	16	https://twitter.com/afifaq_talina23/status/1792534619767832684	1792534619767832684	2024-05-20 12:35:31+00	@AgikMauripta Pemilu adalah perhelatan demokrasi, mari hormati setiap langkahnya.		0	0	0	0
101	1	https://twitter.com/akhmadsayfull/status/1792535928726339673	1792535928726339673	2024-05-20 12:40:43+00	@HeryIdris5 Dia tau yg dikeluhkan kesah kan netizen di tweet, semua info kecurangan pemilu, legalitas ijasah jkw, marak KKN, bikin EM mikir 1000x		0	0	0	0
102	2	https://twitter.com/OjolKoko25410/status/1792535877048266831	1792535877048266831	2024-05-20 12:40:31+00	@Mdy_Asmara1701 Nikmati saja bro, waktu paslon 01 & 03 menolak hasil pemilu kemana kalian wahai mahasiswa...		0	0	0	0
103	3	https://twitter.com/iyai_toeni/status/1792535817875014123	1792535817875014123	2024-05-20 12:40:17+00	@Mas_Hario @tvOneNews Ngaca brooo.....\nYg disentil partainya jd pemenang pemilu...lha prestasinya yg nyentil apa coba?? Jd ketua partai itu dibilang berhasil klo partainya masuk parlemen....😅🤣🤣🤣		0	0	0	0
104	4	https://twitter.com/tenda_arin/status/1792535801114644626	1792535801114644626	2024-05-20 12:40:13+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital..\n^ol\n\n\nPDemokrat\nAgusYudhoyono\nDemokrat Pro Rakyat\nhttps://t.co/r4sPVrJU5t	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
130	30	https://twitter.com/Thondhanks/status/1792530617282048053	1792530617282048053	2024-05-20 12:19:37+00	@geloraco Itu reward bagi mrk yg tlh 𝗕𝗘𝗥𝗛𝗔𝗦𝗨𝗟 menyelesaika Tugas Negara dlm penyelenggara PEMILU.		0	0	0	0
143	43	https://twitter.com/BandungTV38/status/1792526579509387659	1792526579509387659	2024-05-20 12:03:34+00	SIDANG DUGAAN PIDANA PEMILU,KADES DITUNTUT 1 TAHUN PENJARA https://t.co/0BNiPJ2RpE		0	0	0	0
144	44	https://twitter.com/Fauzi56100765/status/1792526453017543132	1792526453017543132	2024-05-20 12:03:04+00	@Mdy_Asmara1701 Diem... diem.. Diem.... Pemilu Curang kalian pade kemaneee... ???		0	0	0	0
145	45	https://twitter.com/temanduit/status/1792526102071816391	1792526102071816391	2024-05-20 12:01:40+00	jadi pengangguran baperan akibat kalah telak pilpres, jelas bikin cemas. gimana caranya balikin hutang ke bohir?🤣🤣🤣		0	0	0	0
146	46	https://twitter.com/liputan6dotcom/status/1792525959297630279	1792525959297630279	2024-05-20 12:01:06+00	VIDEO: Suara Warga Keturunan Asia Diperebutkan dalam Pilpres AS https://t.co/rNmq92j9C9		0	0	0	0
147	47	https://twitter.com/gita_iskandar44/status/1792525935679562129	1792525935679562129	2024-05-20 12:01:01+00	@AgikMauripta Pemilu bersih menghormati prinsip-prinsip hukum yang adil		0	0	0	0
148	48	https://twitter.com/morris1745541/status/1792525917862183419	1792525917862183419	2024-05-20 12:00:56+00	@Putri_Aalona Bingung kan mau menjabat di mana, pilpres gagal... turun tangga pilgub🤣🤣		0	1	1	0
149	49	https://twitter.com/Anintemanreza/status/1792525610029552036	1792525610029552036	2024-05-20 11:59:43+00	Habis pilpres selesai kan aku nggak begitu ngikutin macapres (ngapain) tapi beberapa kali Pak Anies masih lewat FYP. Anehnya kenapa setiap konten beliau tuh selalu ada pendukung paslon lain 😭 Maksudnya aku yang dulu milih dia aja belum liat kontennya eh yang lain udah komen		0	0	0	0
150	50	https://twitter.com/YosepZainal/status/1792525571601334545	1792525571601334545	2024-05-20 11:59:34+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital.. ^ol PDemokrat AgusYudhoyono Demokrat Pro Rakyat https://t.co/ckzbNJPnkg	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
108	8	https://twitter.com/bulan_cahaya4/status/1792535565726077094	1792535565726077094	2024-05-20 12:39:17+00	@AgikMauripta Pemilu damai mengajarkan bahwa kita mampu menyelesaikan konflik tanpa kekerasan		0	0	0	0
105	5	https://twitter.com/medcom_id/status/1792535746110242859	1792535746110242859	2024-05-20 12:40:00+00	Badan Pengawas Pemilihan Umum (Bawaslu) Kota Tangerang membutuhkan 39 pengawas pemilu kecamatan (Panwascam) untuk Pilkada 2024. \n\n\n#Bawaslu #Pilkada2024 #MedcomId \n\n\nhttps://t.co/74z16pufnO		0	0	0	0
106	6	https://twitter.com/masherugad63111/status/1792535629147869473	1792535629147869473	2024-05-20 12:39:32+00	@bengkeldodo @Kimberley_PS08 @EffendiRistriy1 @Bambangmulyonoo @xquitavee @AnKiiim_ @mumungwisnu_1 @Partono_ADjem @PenjualSate69 @are_inismyname @florieliciouss Perubahan\nBoleh lah nyapres kalah terus istirahat.\nPilpres selesai kampanye yo selesai\nPiye iki..		0	0	0	0
107	7	https://twitter.com/BatuKepla/status/1792535605286719880	1792535605286719880	2024-05-20 12:39:26+00	@victorpangkey @Gunawan75_ Aduhh... Vicktor anjing, aturan PKPU itu berada dibawah UU Pemilu. Apa hubungan Perda sama UU Pemilu. Dan yg dibahas oleh Mahfid itu soal UU Pemilu. Paham ya Vicktor anjing.   😂😂😂		0	0	0	0
109	9	https://twitter.com/aulinadiana/status/1792535517512548391	1792535517512548391	2024-05-20 12:39:05+00	Jaga persatuan pasca pemilu https://t.co/8gwR1U2g2W	https://pbs.twimg.com/media/GOBdjZ-asAAo0YI.jpg	0	0	0	0
110	10	https://twitter.com/lasti_bunayah2/status/1792535374931300593	1792535374931300593	2024-05-20 12:38:31+00	@marsieles_monly Kita telah menunjukkan kepada dunia bahwa pemilu damai adalah identitas kita sebagai bangsa		0	0	0	0
111	11	https://twitter.com/Linktop287390/status/1792535307554111897	1792535307554111897	2024-05-20 12:38:15+00	pernyataan pemungkas anies di debat pertama pilpres 2024 https://t.co/arpdqBut7V		0	0	0	0
112	12	https://twitter.com/SitiRaf21214506/status/1792535256526143673	1792535256526143673	2024-05-20 12:38:03+00	@adri_7i @M4NIKM0Y0 @AndreasSolusi @VaniaKiara3002 @Putri_Aalona @OX_Carli2971 @99propaganda @bengkeldodo @xquitavee @mas_veel @CebyReborn @Mamamochi1 ya kami udah sering ketemu di rumah ku semenjak pilpres kami blm ada kontak		0	0	0	0
113	13	https://twitter.com/lovetheavocados/status/1792535109813608571	1792535109813608571	2024-05-20 12:37:28+00	@diaumond gara gara pemilu makin sadar banyak bgt yang ga beres di app sebelah 😭		0	1	0	0
134	34	https://twitter.com/randy_wijaya38/status/1792529548124569927	1792529548124569927	2024-05-20 12:15:22+00	@AgikMauripta Mari kita dukung pemilu sebagai upaya nyata dalam memilih pemerintahan yang adil dan responsif		0	0	0	0
114	14	https://twitter.com/mamagemoybiasa/status/1792535094135255246	1792535094135255246	2024-05-20 12:37:24+00	akunku lapakku terserah aku dunk mau posting apapun, pendukung anies banyak yg nyinyirin Prabowo Gibran terus kenapa ngamok klo ada yg bahas anies ? lagian siapa bahas pilpres, ngawur egois klo orang di larang bahas anies tapi gerombolan nya sendiri boleh bebas nyinyirin PraGib		0	0	0	0
115	15	https://twitter.com/senairojc1/status/1792534646317797851	1792534646317797851	2024-05-20 12:35:38+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital.. ^ol PDemokrat AgusYudhoyono Demokrat Pro Rakyat https://t.co/lSzVanM2bs	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
117	17	https://twitter.com/dp_koesmirah/status/1792534116069703848	1792534116069703848	2024-05-20 12:33:31+00	Pilpres 2024, Bawaslu ke mana aja? Yang diawasi cuma peserta tertentu. Galak beud ke yang satu tapi lemah ke yang sebelahnya.		0	0	0	0
118	18	https://twitter.com/ViralVideo73683/status/1792533900117606834	1792533900117606834	2024-05-20 12:32:40+00	pernyataan pemungkas anies di debat pertama pilpres 2024 https://t.co/XdZP51tg5g		0	0	0	0
119	19	https://twitter.com/Gurane11316/status/1792533878936392052	1792533878936392052	2024-05-20 12:32:35+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital.. ^ol PDemokrat AgusYudhoyono Demokrat Pro Rakyat https://t.co/bBSaJlHm9R	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
120	20	https://twitter.com/unseasonedfish/status/1792533398080332121	1792533398080332121	2024-05-20 12:30:40+00	kenapa setiap aing nemu orang aneh, pas aing tanya "mnh kmrn pilpres dukung siapa?" jawabannya SAMA SEMUA		0	0	0	0
121	21	https://twitter.com/MissJoane09/status/1792533271630528738	1792533271630528738	2024-05-20 12:30:10+00	@tanyarlfes Samsung A20 udah 5 tahunan..... Beli pas pemilu..... 😅😅😅		0	0	0	0
122	22	https://twitter.com/kri_tik_us/status/1792532916687573257	1792532916687573257	2024-05-20 12:28:45+00	@kompascom Akal dangkal, orang lain jadi korban Maaf bkn Pilpres		0	0	0	0
123	23	https://twitter.com/idolletes/status/1792532474536636519	1792532474536636519	2024-05-20 12:27:00+00	#zonauang #zonajajan #infoloker #lokerwfh info loker parttime part time freelance freelancer pelajar mahsiswa kuliah sekolah wfh iphone netflix disney+ viu joki wts wtb pc konser tiket pemilu anies imin prabowo gibran ganjar mahfud 16		0	0	0	0
124	24	https://twitter.com/JR007_/status/1792532368986976377	1792532368986976377	2024-05-20 12:26:35+00	@dhemit_is_back @opposite6892 Emang dari waktu pilpres juga keliatan kalo akun ini ga beres..		0	0	0	0
125	25	https://twitter.com/SaptoHape/status/1792532215743889607	1792532215743889607	2024-05-20 12:25:58+00	@tempodotco Mereka peduli dan mewakili "rakyat" disaat pilpres dan pilkada doang..		0	0	0	0
126	26	https://twitter.com/SuyadiPatmo/status/1792532046990266811	1792532046990266811	2024-05-20 12:25:18+00	@MichelAdam7__ Jika Revolusi Mental gagal total, kini saatnya Revolusi Hasil Pemilu Jujur Diskualifikasi Hasil Pemilu Curang		0	0	1	0
127	27	https://twitter.com/19_45d/status/1792531508894511323	1792531508894511323	2024-05-20 12:23:10+00	@KentLavis Coba bahas hasil pemilu 2006 yang menang siapa?? Gak heran sih situ secara gak langsung pro Zionis		0	0	0	0
128	28	https://twitter.com/opaparawitha/status/1792531299397521452	1792531299397521452	2024-05-20 12:22:20+00	@Anak__Ogi @jagaNKRI__ @are_inismyname @jokowi @ganjarpranowo Pemuja Jokowi dadakan setelah ikutan menang pilpres semua begitu. Asal nyinyiir.		0	0	0	0
129	29	https://twitter.com/Sukirman2019/status/1792530652300279988	1792530652300279988	2024-05-20 12:19:45+00	@Mdy_Asmara1701 Mereka bergerak saat kebutuhan dan kepentingannya terganggu, artinya isu2 penting negara saat pilpres kemarin , yang membuat mereka diam, bukan kepentingan mereka.		0	0	1	0
131	31	https://twitter.com/BetsyHa70452279/status/1792530605621796998	1792530605621796998	2024-05-20 12:19:34+00	Hoax pemilu sudah beredar dimana-mana, Waspadalah teman-teman #Pilkada2024AmanDamai #SukseskanPilkada2024 #WujudkanKerukunanPilkada2024 https://t.co/u8oUhu35lW		0	1	0	0
132	32	https://twitter.com/jevina_mays4/status/1792530524407468473	1792530524407468473	2024-05-20 12:19:25+00	@RatuMedia20 Pemilu adalah ajang penghormatan terhadap kedaulatan rakyat, mari lakukan dengan penuh kebijaksanaan.		0	0	0	0
133	33	https://twitter.com/Rere_melindaa/status/1792529703959749112	1792529703959749112	2024-05-20 12:15:59+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital.. ^ol PDemokrat AgusYudhoyono Demokrat Pro Rakyat https://t.co/VWcUkvX4td	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
135	35	https://twitter.com/Goyobodl88140/status/1792528778008367470	1792528778008367470	2024-05-20 12:12:18+00	@DokterTifa Alhamdulillah sjk pemilu gub jg prsiden sy ga plih jkw. Sampe skrng 2024jg sy plih Anies. Sy sdih krn sangat disyangkan anies dngn ide"nya yg briliant akalnya yg crdas diakui dunia tk trpilih jd prsiden. Suer sy sdih banggt 😭 tp gpp krn 2014 dn 2019 sy dkung PS jg tdk mnyesal		0	0	0	0
136	36	https://twitter.com/AziAbdullah/status/1792528620436771048	1792528620436771048	2024-05-20 12:11:41+00	@toe_giman Anak-anak Indonesia disuruh bodoh agar bisa dibeli suaranya saat pileg dan pilpres, dan juga supaya tdk banyak faham politik		0	0	1	0
137	37	https://twitter.com/Madun_fans/status/1792528545690136734	1792528545690136734	2024-05-20 12:11:23+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital.. ^ol PDemokrat AgusYudhoyono Demokrat Pro Rakyat https://t.co/PYjKnE3XX9	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
138	38	https://twitter.com/busan_dari26/status/1792527910395633857	1792527910395633857	2024-05-20 12:08:52+00	@AgikMauripta Pemilu adalah saatnya menunjukkan bahwa kita adalah masyarakat yang cerdas dan dewasa.		0	0	0	0
139	39	https://twitter.com/nizarargh/status/1792527700860760544	1792527700860760544	2024-05-20 12:08:02+00	@unggulrmd @officialJKT48 menjelang pemilu bolo		0	0	0	0
140	40	https://twitter.com/ayrifkiprayitno/status/1792527460128751659	1792527460128751659	2024-05-20 12:07:04+00	@kyndcyc @yusuf_dumdum Setelah kulihat siapa kau, ternyata ada kaitan sama pendukung pilpres		0	0	0	0
141	41	https://twitter.com/khusn_mub/status/1792527415350292860	1792527415350292860	2024-05-20 12:06:54+00	@H4T14K4LN4L42 Apa berani ? Apa bisa ? Semua lini di bawah kendalinya lho...coba aja lihat pemilu kmrn...tp ya ikhtiar sih bagus, daripada diam saja atau tdk peduli...		0	0	0	0
142	42	https://twitter.com/Dinda_Kirantii/status/1792527126903849398	1792527126903849398	2024-05-20 12:05:45+00	Terbukti menangkan pilpres 2 kali, pengamat nilai peran Demokrat menangkan Prabowo-Gibran sangat vital.. ^ol PDemokrat AgusYudhoyono Demokrat Pro Rakyat https://t.co/BuD6emHo5W	https://pbs.twimg.com/media/GFJ7HBvaQAAVadm.jpg	0	0	0	0
151	51	https://twitter.com/Mpok_Hanum/status/1792525499035693517	1792525499035693517	2024-05-20 11:59:17+00	@SoundOfYogi @ardisatriawan Done, Yogi.....\nSembari nunggu capres yg menjanjikan pengurangan pajak di segala lini. Di negara barat, udah jadi dagangan tiap pemilu soalnya. Di sini, belom kelihatan hilalnya		0	0	0	0
152	52	https://twitter.com/Alexparisyel/status/1792525115152122102	1792525115152122102	2024-05-20 11:57:45+00	@tvOneNews Bawaslu tak ada gunanya, contoh nya di pilpres kemarin		0	0	0	0
153	53	https://twitter.com/Justonedy2/status/1792525079206895701	1792525079206895701	2024-05-20 11:57:37+00	@Putri_Aalona Tujuannya bikin kacau pemilu! Saja. Pemilu presiden keok,\nGubernur juga gakda prestasi bagus yg patut dibanggakan.		0	0	0	0
154	54	https://twitter.com/julia_maya66/status/1792525042934551026	1792525042934551026	2024-05-20 11:57:28+00	@marsieles_monly Pemilu damai membawa harapan baru bagi masa depan bangsa ini, mari kita jaga momentumnya		0	0	0	0
155	55	https://twitter.com/TonyParker19679/status/1792525000203018394	1792525000203018394	2024-05-20 11:57:18+00	@tvOneNews Dalam politik itu teman adalah musuh dalam selimut. 2 x dikalahkan pilpres dgn cara yang menyakitkan setidak prabowo tahu seperti apa sifat jokowi yg tlah dibantunya jd gubernur dki dan mengatakan akan fokus 5 thn jadi gub. DKI dan akhirnya berkhianat menjadi rivalnya di pilpres		0	0	0	0
156	56	https://twitter.com/sofyan_aznawi37/status/1792524968720564590	1792524968720564590	2024-05-20 11:57:10+00	@AgikMauripta Pemilu adalah kesempatanmu untuk menentukan masa depan bangsa Jangan golput dan gunakan hak pilihmu dengan bijak!		0	0	0	0
157	57	https://twitter.com/deluluww/status/1792524902593187855	1792524902593187855	2024-05-20 11:56:54+00	list tugas;\n1. review buku sistem peradilan indo\n2. buat artikel sosio hukum bahas pilpres AHAY\n3. sidang semu 28 mei\n4. makalah ppt 27 mei		0	0	0	1
158	58	https://twitter.com/dancersejati07/status/1792524855994462342	1792524855994462342	2024-05-20 11:56:43+00	China ingin jadikan Indonesia bagian dr RRC Raya.\n\nPeriode 2019-2029 akan terjadi migrasi besar-besaran rakyat China ke Indonesia: 100 juta. Strategi mereka yg atur\n\nWaktu untuk pribumi hanya 2024. Jika pribumi kalah pemilu, sgt mengerikan\n\n#NeoPKIBiangBencana\n#NeoPKIBiangBencana https://t.co/gD5S6Wyz9r	https://pbs.twimg.com/media/GOBT17ZagAAsmyr.jpg	0	1	1	0
159	59	https://twitter.com/koviiyay/status/1792524637055922208	1792524637055922208	2024-05-20 11:55:51+00	@ursusursidaee Kyk ga semua solusi tuh bisa diterapin, yg paling memungkinkan itu skrg solusinya ngasih subsiddi ke perguruan tinggi biar bisa mangkas duit bayar kuliah mahasiswa/i. Negara ini emang hobinya melihara kebodohan buat panen pas pemilu sih, heran		0	0	0	0
160	60	https://twitter.com/khrnnsnb/status/1792524494357307830	1792524494357307830	2024-05-20 11:55:17+00	@AdilaLega Semoga masih ada pemilu selanjutnya 🥹		0	0	0	0
161	61	https://twitter.com/benazir_muthia7/status/1792524413000368157	1792524413000368157	2024-05-20 11:54:58+00	@AgikMauripta Sukses Pemilu adalah tanggung jawab bersama, mari bersatu demi Indonesia yang lebih baik.		0	0	0	0
162	62	https://twitter.com/jepaforger/status/1792524109462855766	1792524109462855766	2024-05-20 11:53:45+00	@geminijahat capek ya jadi pihak yang kalah? pilpres udah kelar masih ungkit2. padahal prabski belum berkuasa. gubernur bali dan mayoritas kepala daerah bali kan pdip 🤭		0	1	0	1
163	63	https://twitter.com/_sabtumingyu/status/1792523424486813793	1792523424486813793	2024-05-20 11:51:02+00	menurut gw mise kmrn pemilu milihnya yg sm2 anti kritik alias yg tengah🤭		0	0	0	0
164	64	https://twitter.com/huangiill/status/1792523397953647030	1792523397953647030	2024-05-20 11:50:56+00	@nctzenbase Gaji abdi negara alias KPPS wkwkwk makasih pemilu, sering" ya wkwkwk		0	0	0	0
165	65	https://twitter.com/jusuf_iskandarr/status/1792523287005991313	1792523287005991313	2024-05-20 11:50:29+00	@RatuMedia20 Pemilu adil adalah bentuk tanggung jawab terhadap masa depan negara		0	0	0	0
166	66	https://twitter.com/_haye_/status/1792522912341319909	1792522912341319909	2024-05-20 11:49:00+00	Mungkin kamu tidak tau bahwa yg disebut Otoritas Palestina itu diciptakan Israel, Mahmoud Abbas sbg alternatif Yasser Arafat yg saat itu tidak disukai Israel, ditunjuk Israel dan Amerika, tanpa Pemilu atau konstituensi.\n\nJauh dari Hamas, mungkin. Jauh dari Gaza? Hadeh.		1	1	2	0
167	67	https://twitter.com/Hana70116972/status/1792522788663709739	1792522788663709739	2024-05-20 11:48:30+00	@bnsphrxyzzz Mereka ga pemilu ya?		0	0	0	0
168	68	https://twitter.com/partaigeloraid/status/1792522757336596537	1792522757336596537	2024-05-20 11:48:23+00	#Rilis | Partai Gelora Tolak Usulan Politik Uang Dilegalkan dalam Pemilu\nhttps://t.co/It78rNSuAV\n@anismatta @Fahrihamzah https://t.co/QRnyHhMW77	https://pbs.twimg.com/media/GOBR8ITaEAAE9qH.jpg	0	2	2	0
169	69	https://twitter.com/imam_tito77/status/1792522710419214347	1792522710419214347	2024-05-20 11:48:12+00	@AgikMauripta Satukan hati dan pikiran kita demi masa depan yang lebih baik melalui pemilu 2024 yang damai.		0	0	0	0
170	70	https://twitter.com/greg_wahyu/status/1792522581746254173	1792522581746254173	2024-05-20 11:47:41+00	@Julianpyupyu @Anak__Ogi @zy_zy_its_me @jokowi Kalo cerdas gak bakalan ngomong spt ini. Pasti 100% gak paham politik. Atau tau2an sedikit bacotnya dibumbuin penyedap yg banyak.\nPahami ya.\nCapres itu pasti direkomendasikan dr partai. Kalo gak ditunjuk/dipilih/direkomendasikan partai. Ya gak bakalan ikut pilpres.		0	0	0	1
171	71	https://twitter.com/79_two/status/1792522141164019746	1792522141164019746	2024-05-20 11:45:56+00	Dulu seblm pemilu , Pak. Try sebagai tokoh bangsa ini sdh ingat kan juga , sebaiknya Jkw jgn cawe2 , tapi ya ndablek.		0	2	0	0
172	72	https://twitter.com/KochengPosi/status/1792522086566826469	1792522086566826469	2024-05-20 11:45:43+00	Hoax pemilu sudah beredar dimana-mana, waspadalah teman-teman #Pilkada2024AmanDamai #SukseskanPilkada2024 #WujudkanKerukunanPilkada2024 https://t.co/sDwS1RAaij		0	1	0	1
173	73	https://twitter.com/bedasablon/status/1792521743179116857	1792521743179116857	2024-05-20 11:44:21+00	@geloraco Ya,, itu untuk tipu tipu pilpres 2029 kelak ..		0	0	0	0
174	74	https://twitter.com/civil_cociety/status/1792521577478881293	1792521577478881293	2024-05-20 11:43:42+00	@mardigu024 Yang penting hutangnya kemarin kan udah lunas bang... Di lunasi pakai pilpres..		0	0	0	0
175	75	https://twitter.com/MarSol6606/status/1792521352060264714	1792521352060264714	2024-05-20 11:42:48+00	@mardigu024 Ngapain malu kalo kalah? Ada yg kalah berkali2 pilpres bahkan smpe jd pembantu yg menang pemilu yg dicap curang oleh capres yg kalah itu wkwkwk		0	0	0	0
176	76	https://twitter.com/Madlanunu/status/1792521268304257328	1792521268304257328	2024-05-20 11:42:28+00	perasaan dari sebelum pilpres gini anjir		0	0	0	0
177	77	https://twitter.com/TiurWahyuni/status/1792521186146230583	1792521186146230583	2024-05-20 11:42:08+00	@QalbuBahasa @puanmaharani_ri Bahkan tidak menutup kemungkinan keluarga @jokowi pun BS ikut di panggil dan di periksa @DPR_RI karena di duga terlibat kampanye Pilpres 2024.		0	2	0	1
178	78	https://twitter.com/lostacker/status/1792521137265750261	1792521137265750261	2024-05-20 11:41:57+00	Mendekati pemilu di US, mulai cari muka buat cari suara dia		0	0	0	0
179	79	https://twitter.com/honeynula/status/1792521003270336977	1792521003270336977	2024-05-20 11:41:25+00	@NGHTERK8 ya lo mikirnya aneh. gaada selesai pilihan lo sampe pemilu doang. yang ada pemilu itu dampaknya sampe 5 tahun kedepan atau bahkan selamanya. lu yang mikir		0	0	0	0
180	80	https://twitter.com/TiurWahyuni/status/1792520923003932796	1792520923003932796	2024-05-20 11:41:06+00	@QalbuBahasa @puanmaharani_ri Dari awal dan sampe saat ini saya kurang sreg sama @puanmaharani_ri . Org nya plin plan. Kalau saja hak angket @DPR_RI di gunakan, semua yang di duga terkait dan di duga terlibat dalam pilpres 2024 di panggil dan di periksa termasuk @jokowi dan @ListyoSigitP		0	1	0	0
181	81	https://twitter.com/democrazymedia/status/1792520646515118354	1792520646515118354	2024-05-20 11:40:00+00	Franz Magnis Suseno Sepakat dengan JK: Pemilu 2024 Adalah yang Terburuk!\nhttps://t.co/RTv5MjRMQu		0	26	12	1
182	82	https://twitter.com/Kapolrestangkot/status/1792520312795676688	1792520312795676688	2024-05-20 11:38:40+00	Kapolres Metro Tangerang Kota Kombes Pol Zain Dwi Nugroho S.H., S.I.K,.M.Si., melaksanakan kegiatan penandatanganan NPHD ( Naskah Perjanjian Hibah Daerah) dan berita acara penerimaan hibah pemilu pilkada Kota Tangerang dipimpin oleh PJ Walikota Tangerang Dr. Nurdin, S.Sos., https://t.co/J5MBkKUkJ9	https://pbs.twimg.com/media/GOBPuLAbgAABV_k.jpg	0	1	0	0
183	83	https://twitter.com/tempodotco/status/1792520293589942690	1792520293589942690	2024-05-20 11:38:36+00	Dinasti Politik Warnai Pemilu India 2024 https://t.co/G3Yyyp10xW #TempoDunia		0	1	0	1
184	84	https://twitter.com/TulusWijanarko/status/1792520217186472237	1792520217186472237	2024-05-20 11:38:17+00	@Putri_Aalona Pilpres sudah selesai masih ngamuk-ngamuk saja. Gak bisa move on! Kasihan!		0	0	0	0
185	85	https://twitter.com/liputan6dotcom/status/1792520174433980522	1792520174433980522	2024-05-20 11:38:07+00	Perintah Habib Luthfi ke Sudaryono: Niati Jateng 1, Kencangkan Ikhtiar https://t.co/IPxZSlF2vR #Pemilu		0	1	1	0
186	86	https://twitter.com/fahryfajar09/status/1792520012613525979	1792520012613525979	2024-05-20 11:37:29+00	@bijitalisasi bangst pemilu udah beres cok muak gw politik politik, belajar dari emyu bisa menerima kekalahan lahh		0	0	0	0
187	87	https://twitter.com/nieke_olivia/status/1792519866659766493	1792519866659766493	2024-05-20 11:36:54+00	Kemaren di kontestasi Pemilu ada Capres seorang intelektual dan akademisi yang kemampuan komunikasi dan logika serta akalnya runut, baik dan bagus dalam melihat pola khususnya pendidikan, padahal udh digeber juga saat wawancara dengan Najwa Shihab menyoal biaya kuliah yang semakin mahal, Ibu Bapak kalian prefer milih Gemoy dan Oke Gas, sih, dan kalian cuma diam heuheuheu\n\nAkal itu berfungsi MEWASPADAI PERINGATAN. Bukan diam bahkan ambruk ikut bahu-membahu dalam kebodohan level kaidah dasar‼️		2	41	13	3
188	88	https://twitter.com/daniya_rahna24/status/1792519478309429308	1792519478309429308	2024-05-20 11:35:21+00	@AgikMauripta Partisipasi aktif dalam pemilu adil adalah pilar demokrasi yang kuat		0	0	0	0
189	89	https://twitter.com/paijomarkucel/status/1792519349913399698	1792519349913399698	2024-05-20 11:34:51+00	@abu_waras @Mdy_Asmara1701 Dari dulu sebelum Pemilu		0	0	0	0
190	90	https://twitter.com/posieclair/status/1792519312143781980	1792519312143781980	2024-05-20 11:34:42+00	lho sejak kapan kpop serame pemilu anjir wajar knetz gatau. mungkin selera dia lim youngwoong yg dia denger bukan dari media streaming tp dari radio		0	0	0	0
191	91	https://twitter.com/Zetrogede/status/1792519114919219360	1792519114919219360	2024-05-20 11:33:55+00	SENGKUNI MODERN PASCA PEMILU 2024 https://t.co/pd5LkHeT6O @GerbangInterview		0	0	0	0
192	92	https://twitter.com/RianiNurAisyah/status/1792519098431389780	1792519098431389780	2024-05-20 11:33:51+00	@0xladePick2 Acara kenegaraan,carinya capres? 😁😁😁\npilpres sudah usai tapi otak masih terbelenggu kedunguan...		0	0	0	0
193	93	https://twitter.com/BawasluKotaBima/status/1792518879568331174	1792518879568331174	2024-05-20 11:32:58+00	#SahabatBawaslu\nBerikut ini awasmin sampaikan update pendaftar calon Pengawas Kelurahan untuk pemilihan serentak 2024.\n\nAyo buruan mendaftar sebelum ditutup pada tanggal 21 Mei 2024.\n\nAYO JADI PENGAWAS PEMILU\n\n#BawasluKotaBima\n#bawaslumemanggil\n#pemilihanserentak2024 https://t.co/v0za2dZ3WT	https://pbs.twimg.com/media/GOBOahlaMAAL7_r.jpg	0	0	0	0
194	94	https://twitter.com/victorpangkey/status/1792518874061209618	1792518874061209618	2024-05-20 11:32:57+00	@BatuKepla @Gunawan75_ Hmmmm gitu ya iya aja deh kasihan sih gw dg KETOLOLAN LU\nBerarti aturan2 lain yg bisa saja terkait dg pemilu dianggap ngga ada ya misalnya PKPU, PERMENDAGERI, PERDA bahkan PP dll\nOke deh lu emang GENIUS bgt 👍		0	0	0	1
195	95	https://twitter.com/cryptogem1000/status/1792518813390610617	1792518813390610617	2024-05-20 11:32:43+00	@andreasrtobing_ Bayangin kalo november Trump menang pilpres		0	0	0	0
196	96	https://twitter.com/MilkC4ndy/status/1792518717135524096	1792518717135524096	2024-05-20 11:32:20+00	enhypen yg mana si🤣 nostalgia bgt denger lagu 1d jd keinget waktu iklannya jaman pemilu jokowi&amp;basuki pake lagu wmyb🤣		0	0	0	1
197	97	https://twitter.com/aaa_nto/status/1792518308354502698	1792518308354502698	2024-05-20 11:30:42+00	@anamazingbali @sandiuno @jokowi Jogetin aja...\nRakyat Bali kan enjoy.. Jokowi dan Prabowo menang pilpres di Bali.		0	0	0	0
198	98	https://twitter.com/KompasData/status/1792517908536652197	1792517908536652197	2024-05-20 11:29:07+00	Sebanyak 90 perkara, dari total 297 perkara sengketa pemilu legislatif, diperkirakan lanjut ke tahap pembuktian. https://t.co/F5waMhqDAV #Polhuk #AdadiKompas		0	0	0	0
199	99	https://twitter.com/hariankompas/status/1792517908079538236	1792517908079538236	2024-05-20 11:29:07+00	Sebanyak 90 perkara, dari total 297 perkara sengketa pemilu legislatif, diperkirakan lanjut ke tahap pembuktian. https://t.co/VhFL5IhqKb #Polhuk #AdadiKompas		0	0	0	1
200	100	https://twitter.com/rafaila_ashadi/status/1792517892849979479	1792517892849979479	2024-05-20 11:29:03+00	@AgikMauripta Pemilu 2024 adalah peluang untuk menunjukkan bahwa kita bisa menghormati hasil demokrasi.		0	0	0	0
\.


--
-- Data for Name: tweets_private; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.tweets_private (tweet_id, user_id, twitter_url, entry_id, created_at, full_text, media_url, retweet_count, like_count) FROM stdin;
1101	1001	https://twitter.com/handokota/status/1797665916920201254	1797665916920201254	2024-06-03 16:25:28+00	Anjir ada dani rojas cuy haha https://t.co/TYTEfNJGjM		0	0
1102	1001	https://twitter.com/handokota/status/1797369391027466747	1797369391027466747	2024-06-02 20:47:10+00	BROOO WHAT A GAME!! CONGRATSSS VENEZIA AND JAY IDZES FOR PROMOTION TO SERIE A😮‍💨🇮🇩 https://t.co/MFX7bP3dcz		0	0
1103	1001	https://twitter.com/handokota/status/1797268627789594758	1797268627789594758	2024-06-02 14:06:47+00	She's a 10 but she's a madrid fan😏 https://t.co/v8LgEBaZgR		0	0
1104	1001	https://twitter.com/handokota/status/1795148923004387405	1795148923004387405	2024-05-27 17:43:50+00	"pak beliin es krim paddle pop"\n\noh god, i miss that time🤧 https://t.co/sEwE6YB6LW		0	1
1105	1001	https://twitter.com/handokota/status/1794816166185336971	1794816166185336971	2024-05-26 19:41:34+00	one step closer, bismillah🏆 https://t.co/gE2aG9tqAx		0	0
1106	1001	https://twitter.com/handokota/status/1794814510517342615	1794814510517342615	2024-05-26 19:35:00+00	love u @persib https://t.co/ZAKhpG7kpk	http://pbs.twimg.com/media/GOh2SNVacAAUCKV.jpg	0	0
1107	1001	https://twitter.com/handokota/status/1794065403276144701	1794065403276144701	2024-05-24 17:58:18+00	Tom holland https://t.co/3OPVz86mFP	http://pbs.twimg.com/media/GOXM-QqacAA74-5.jpg	0	0
1108	1001	https://twitter.com/handokota/status/1792659130035192206	1792659130035192206	2024-05-20 20:50:17+00	Asli smt 8 menurut gua smt tercepat selama kuliah, tbtb dah mau juni aja https://t.co/ioGBDDTxfo		0	0
1109	1001	https://twitter.com/handokota/status/1792647665483645326	1792647665483645326	2024-05-20 20:04:43+00	LMAO https://t.co/GrAW8brXrc		0	0
1110	1001	https://twitter.com/handokota/status/1792644583471370606	1792644583471370606	2024-05-20 19:52:29+00	Ngepush TA dari sore smpe jam 3 pagi is another lvl of mumet😵‍💫😴		0	0
1111	1001	https://twitter.com/handokota/status/1791378888855310566	1791378888855310566	2024-05-17 08:03:03+00	Danke Jurgen❤️😢 https://t.co/KCHoSGEZ8u		0	0
1112	1001	https://twitter.com/handokota/status/1791218543951745288	1791218543951745288	2024-05-16 21:25:54+00	Boring game😴 https://t.co/6xG1lDBC6B		0	0
1113	1001	https://twitter.com/handokota/status/1790429608124510248	1790429608124510248	2024-05-14 17:10:57+00	well keun di bandung sib ahh💙 https://t.co/vYwT58oogi		0	1
1114	1001	https://twitter.com/handokota/status/1788147142789664994	1788147142789664994	2024-05-08 10:01:15+00	damn baru jg kelar nyuci motor langsung ujan👊 https://t.co/VYqCdrYvT4	https://pbs.twimg.com/media/GNDGWPqbYAA8mt2.jpg	0	1
1115	1001	https://twitter.com/handokota/status/1787885455893250284	1787885455893250284	2024-05-07 16:41:24+00	grok grok grok		0	1
1116	1001	https://twitter.com/handokota/status/1786756315077058799	1786756315077058799	2024-05-04 13:54:36+00	Super Kieran McKenna!\n\nELKAN EPL COYYYY😎 https://t.co/D1gPP7IIjv		0	0
1117	1001	https://twitter.com/handokota/status/1785082378492555775	1785082378492555775	2024-04-29 23:02:58+00	at least barca gua menang😤 https://t.co/GLfA0tr4Vo		0	0
1118	1001	https://twitter.com/handokota/status/1784834606182895958	1784834606182895958	2024-04-29 06:38:25+00	gw kalo scroll gopud stengah jam lebih ada kali, bingung makan apa bjir wkwkw		0	0
1119	1001	https://twitter.com/handokota/status/1783605552691704150	1783605552691704150	2024-04-25 21:14:36+00	PARIS 2024, WE WILL BE THERE🇮🇩🦅 https://t.co/iAGIlEnm6D		0	0
1120	1001	https://twitter.com/handokota/status/1783601219027837353	1783601219027837353	2024-04-25 20:57:22+00	WHATTTT A MATCHHHHH, PARIS WE'RE COMING😍🦅🇮🇩		0	1
1121	1001	https://twitter.com/handokota/status/1780247038405517429	1780247038405517429	2024-04-16 14:49:04+00	Hold up, let tim cook🔥 https://t.co/XG3w8qlSRo		0	0
1122	1001	https://twitter.com/handokota/status/1779929102008643994	1779929102008643994	2024-04-15 17:45:42+00	🇶🇦🇶🇦🤡🤡🤡🤡🤡		0	0
1123	1001	https://twitter.com/handokota/status/1779819400729927840	1779819400729927840	2024-04-15 10:29:47+00	Naik whoosh lgi apa gopar aja ya ke jkt		0	0
1124	1001	https://twitter.com/handokota/status/1778164959488385199	1778164959488385199	2024-04-10 20:55:37+00	Visca Barca❤️💙 https://t.co/L4LxQV9oh9		0	0
1125	1001	https://twitter.com/handokota/status/1778080366471111121	1778080366471111121	2024-04-10 15:19:29+00	Tinggal ber 4, mulai berkurang personel krn sold out 1😁 https://t.co/oR3yeLjtFk	http://pbs.twimg.com/media/GK0Cq2vbwAAFIFC.jpg	0	0
1126	1001	https://twitter.com/handokota/status/1777798573083574436	1777798573083574436	2024-04-09 20:39:44+00	What a match anjir seruuuuu		0	1
1127	1001	https://twitter.com/handokota/status/1777750497635819539	1777750497635819539	2024-04-09 17:28:42+00	Eid mubarak y'all🌙		0	0
1128	1001	https://twitter.com/handokota/status/1777678042720289075	1777678042720289075	2024-04-09 12:40:47+00	Opportunity to have u https://t.co/BQQAOqhsTl		0	0
1129	1001	https://twitter.com/handokota/status/1776977526298177726	1776977526298177726	2024-04-07 14:17:11+00	Bjir sejak kapan gw merah https://t.co/WgmEswIj1z		0	0
1130	1001	https://twitter.com/handokota/status/1772943321754636689	1772943321754636689	2024-03-27 11:06:42+00	Pln nya lgi war takjir dulu, pas buka baru dinyalain listriknya		0	0
1131	1001	https://twitter.com/handokota/status/1772626728927564185	1772626728927564185	2024-03-26 14:08:40+00	🤫🤫🤫 https://t.co/UkYuif4ear		0	0
1132	1001	https://twitter.com/handokota/status/1770841188939051037	1770841188939051037	2024-03-21 15:53:34+00	Jay Idzes masterclass🎩😮‍💨 https://t.co/dVoJQJFVfB		0	0
1133	1001	https://twitter.com/handokota/status/1757436094717800870	1757436094717800870	2024-02-13 16:06:31+00	Ga ngaruh. All in dakota-sydney😋 https://t.co/86QvgH4pbE		0	0
1134	1001	https://twitter.com/handokota/status/1757086574897250670	1757086574897250670	2024-02-12 16:57:39+00	📸 https://t.co/UByk00TIJr	http://pbs.twimg.com/media/GGJs7UKbcAAYKjK.jpg	0	0
1135	1001	https://twitter.com/handokota/status/1756699932541780110	1756699932541780110	2024-02-11 15:21:16+00	6 https://t.co/AEaFEv0i3O		0	0
1136	1001	https://twitter.com/handokota/status/1756616317963219327	1756616317963219327	2024-02-11 09:49:01+00	Coblos ini aja deh https://t.co/qT6Obt11B9		0	0
1137	1001	https://twitter.com/handokota/status/1754923384549605683	1754923384549605683	2024-02-06 17:41:54+00	I'll be there no matter what😮‍💨 https://t.co/ZYBz32hHvw		0	0
1138	1001	https://twitter.com/handokota/status/1754921759420383654	1754921759420383654	2024-02-06 17:35:26+00	Gerah bet bjir di rumah, biasa di kosan dingin		0	1
1139	1001	https://twitter.com/handokota/status/1754553103872143750	1754553103872143750	2024-02-05 17:10:32+00	USER > DEVELOPER https://t.co/VJOrZznPFQ		0	0
1140	1001	https://twitter.com/handokota/status/1750570516161925577	1750570516161925577	2024-01-25 17:25:09+00	History has been made, letsgoooo Garuda🦅🇮🇩 https://t.co/f2fzbJqutw		0	0
1141	1001	https://twitter.com/handokota/status/1748295984495608106	1748295984495608106	2024-01-19 10:46:59+00	AAAAA Alhamdulillah stress dikit ga ngaruh wir👊😎 https://t.co/f8X8QGXG0X	http://pbs.twimg.com/media/GEMx7t7boAA9CL4.jpg	0	0
1142	1001	https://twitter.com/handokota/status/1724414249009594594	1724414249009594594	2023-11-14 13:09:29+00	Bang chris abis nguli https://t.co/SUNXbgCBg1		0	0
1143	1001	https://twitter.com/handokota/status/1721976997377921396	1721976997377921396	2023-11-07 19:44:43+00	We played like shit. This is not barca anymore. #XaviOut https://t.co/gJJ0x81h1d		0	0
1144	1001	https://twitter.com/handokota/status/1721656362911035877	1721656362911035877	2023-11-06 22:30:38+00	Craziest game in the PL this season😮‍💨 https://t.co/KvjdXjxu6A		0	0
1145	1001	https://twitter.com/handokota/status/1720505080301154720	1720505080301154720	2023-11-03 18:15:51+00	Lesgoooo https://t.co/6NdCzAYfes	http://pbs.twimg.com/media/F-B2QK4a8AE_o4D.jpg	0	0
1146	1001	https://twitter.com/handokota/status/1720424332248367485	1720424332248367485	2023-11-03 12:54:59+00	Here we go🦅 https://t.co/Wkmo5KjQax		0	0
1147	1001	https://twitter.com/handokota/status/1719735743445356654	1719735743445356654	2023-11-01 15:18:47+00	Presale the marvels mulai kapan sii		0	0
1148	1001	https://twitter.com/handokota/status/1719094478810804434	1719094478810804434	2023-10-30 20:50:37+00	THE GOAT🐐 https://t.co/Jd55Vvc0pQ		0	0
1149	1001	https://twitter.com/handokota/status/1718959058185752623	1718959058185752623	2023-10-30 11:52:30+00	The Meow https://t.co/IGARC4KEYJ		0	0
1150	1001	https://twitter.com/handokota/status/1718360266818408618	1718360266818408618	2023-10-28 20:13:07+00	Kaget ada takbiran, kirain ada apa		0	0
1151	1001	https://twitter.com/handokota/status/1716849085217739193	1716849085217739193	2023-10-24 16:08:14+00	Lorem ipsum😭 https://t.co/rTu8glbjB9		0	0
1152	1001	https://twitter.com/handokota/status/1716846927755800720	1716846927755800720	2023-10-24 15:59:39+00	Lagi berada di fase dimana buka laptop bikin gejala pusing, mual, muntah2😣		0	1
1153	1001	https://twitter.com/handokota/status/1716037147738972637	1716037147738972637	2023-10-22 10:21:53+00	Bojongsoang dah mulai mode switzerland🥶🥶🥶		0	1
1154	1001	https://twitter.com/handokota/status/1711818621436264880	1711818621436264880	2023-10-10 18:58:58+00	INI BOJONGSOANG EMANG LAGI GERAH BGT YA ASTAGFIRULLAH 😭😭		0	0
1155	1001	https://twitter.com/handokota/status/1682300885807026177	1682300885807026177	2023-07-21 08:06:01+00	YESSSSS I DID IT!!! https://t.co/UMZWiKeVrV https://t.co/Stzm4OUn4C	http://pbs.twimg.com/media/F1i7vWNaYAIQICS.jpg	0	1
1156	1001	https://twitter.com/handokota/status/1672609402774495232	1672609402774495232	2023-06-24 14:15:31+00	Gilaaaa smt ter stresss malah clean sheet gini, alhamdulillah😭 https://t.co/gqpkMj8L4p	http://pbs.twimg.com/media/FzZNY02aAAolHbZ.jpg	0	1
1157	1001	https://twitter.com/handokota/status/1654180590189531155	1654180590189531155	2023-05-04 17:46:00+00	Gotg terbaikkk, puas bgtttt\n\n10/10 https://t.co/QAoHeQrMxr		0	1
1158	1001	https://twitter.com/handokota/status/1634248262684393472	1634248262684393472	2023-03-10 17:42:03+00	here we go again https://t.co/ynKFcvRO1I	http://pbs.twimg.com/media/Fq4EIXNaMAYbTGw.jpg	0	0
1159	1001	https://twitter.com/handokota/status/1625770465804550144	1625770465804550144	2023-02-15 08:14:19+00	let's start the journey https://t.co/4qESfPDTLc	http://pbs.twimg.com/media/Fo_lnzEagAAEvxJ.jpg	0	1
1160	1001	https://twitter.com/handokota/status/1548537658682806272	1548537658682806272	2022-07-17 05:18:42+00	bener bgt anjj😭😭 https://t.co/K8NW2Lvllz		0	1
1161	1001	https://twitter.com/handokota/status/1520561148730691587	1520561148730691587	2022-05-01 00:30:03+00	Bulan puasa gini jam tidur jd kebalik		0	2
1162	1001	https://twitter.com/handokota/status/1490181764777930754	1490181764777930754	2022-02-06 04:33:13+00	No carla no party! https://t.co/pn3rh6BwWn		0	0
1163	1001	https://twitter.com/handokota/status/1483095111676628995	1483095111676628995	2022-01-17 15:13:23+00	Gak pbsi gak pssi lagi nglawak kabeh https://t.co/ThgZhoyE0V		0	0
1164	1001	https://twitter.com/handokota/status/1466812467300868103	1466812467300868103	2021-12-03 16:51:58+00	endingnya😭 https://t.co/MsWyQHxaRd		0	0
1165	1001	https://twitter.com/handokota/status/1452892991949926400	1452892991949926400	2021-10-26 07:00:57+00	No henhen no party🔥 https://t.co/GL3mdntgwu		0	0
1166	1001	https://twitter.com/handokota/status/1393829856631132160	1393829856631132160	2021-05-16 07:25:08+00	@Andhika41336575 @badilllahhh @hanzaniiitiezer\n#BEERY #DEFI #BSC  #Binance #PancakeSwap https://t.co/fgWYTeQrs7		0	0
1167	1001	https://twitter.com/handokota/status/1289224300583464962	1289224300583464962	2020-07-31 15:40:00+00	Arturito wajib mati!! https://t.co/01Q7zKsEKJ		0	0
1168	1001	https://twitter.com/handokota/status/1289200126519459840	1289200126519459840	2020-07-31 14:03:56+00	🤣🤣 https://t.co/peFxpE2Ia1		0	2
1169	1001	https://twitter.com/handokota/status/1278959576042242048	1278959576042242048	2020-07-03 07:51:39+00	Oteweee https://t.co/y5VSlNHxm7		0	0
1170	1001	https://twitter.com/handokota/status/1270050103672201219	1270050103672201219	2020-06-08 17:48:35+00	sadiss https://t.co/C0pWjJoSZT		0	2
1171	1001	https://twitter.com/handokota/status/1265993500459323397	1265993500459323397	2020-05-28 13:09:06+00	La Casa de Papel = Money Heist https://t.co/4EBxmvK43R		0	0
1172	1001	https://twitter.com/handokota/status/1265616093541855235	1265616093541855235	2020-05-27 12:09:25+00	Valid https://t.co/s3DEZYcA2m		0	5
1173	1001	https://twitter.com/handokota/status/1260812476217581569	1260812476217581569	2020-05-14 06:01:33+00	gasabaarrr https://t.co/H9fEO9VtQY		0	3
1174	1001	https://twitter.com/handokota/status/1251724003992981504	1251724003992981504	2020-04-19 04:07:13+00	haha😂 https://t.co/pICNjh3WK7		0	0
1175	1001	https://twitter.com/handokota/status/1245652975520907266	1245652975520907266	2020-04-02 10:03:07+00	Ngilu pilm nya https://t.co/XF50FCjlPj		0	0
1176	1001	https://twitter.com/handokota/status/1243208546721783810	1243208546721783810	2020-03-26 16:09:49+00	waw😂 https://t.co/HFNPYq4bsA		0	0
\.


--
-- Data for Name: user_private; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.user_private (user_id, user_name, id, name, followers, following, description, profile_picture, cover_picture, location, created_at, timezone, user_creation_ip, email, phone_number, birth_date) FROM stdin;
1001	handokota	2325000872	Koko	106	260	lagi skripsian👊	https://pbs.twimg.com/profile_images/1794065104537038848/sXJeEc2l.jpg		Indonesia	2014-02-03 07:06:29+00	Bangkok	114.79.29.32	handokota@protonmail.com	+628122222419	2002-04-19 00:00:00+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: twitter; Owner: avnadmin
--

COPY twitter.users (user_id, user_name, id, name, followers, following, description, profile_picture, cover_picture, location, created_at) FROM stdin;
1	akhmadsayfull	81801659	bocil	18	75		https://pbs.twimg.com/profile_images/1374710407198281730/nBVaxq7O_normal.jpg	https://pbs.twimg.com/profile_banners/81801659/1616591476	Dki jkt	2009-10-12 09:15:03+00
2	OjolKoko25410	1764583845087870976	Koko Ojol	0	26	Etika & kejujuran saat ini dibutuhkan oleh NKRI	https://pbs.twimg.com/profile_images/1764587748114255872/okTvpXLG_normal.jpg	https://pbs.twimg.com/profile_banners/1764583845087870976/1709545508	Jakarta Utara, DKI Jakarta	2024-03-04 09:29:20+00
3	iyai_toeni	4515256214	emdetoeni	49	102	Hajar Bleehhhh....!!!	https://pbs.twimg.com/profile_images/1503850730196635651/OYXXIjnS_normal.jpg	https://pbs.twimg.com/profile_banners/4515256214/1450048398		2015-12-10 06:36:41+00
4	tenda_arin	1737651340560711680	Arin Tidalope	5	0		https://pbs.twimg.com/profile_images/1750390062364479488/qD6wuYsG_normal.jpg			2023-12-21 01:49:13+00
5	medcom_id	902837643024539651	medcom_id	45079	51	https://t.co/HgJ9GzPiao is part of Media Group Network, a leader in multi-platform news and information. #CekDuluMedcom  #MudaMemilahMemilih	https://pbs.twimg.com/profile_images/1601367847900307456/NGlKXu2Q_normal.jpg	https://pbs.twimg.com/profile_banners/902837643024539651/1693456274	Jakarta Capital Region, Indone	2017-08-30 10:17:22+00
6	masherugad63111	1690144362368569348	masherugading	158	144	Tinggalkan semua ketika bersujud	https://pbs.twimg.com/profile_images/1690148765318152192/CY7g1T_P_normal.jpg	https://pbs.twimg.com/profile_banners/1690144362368569348/1691797885	Gondangrejo, Indonesia	2023-08-11 23:34:00+00
7	BatuKepla	1326612023174590465	Kepla Batu	1610	1760	santai tapi serius	https://pbs.twimg.com/profile_images/1327260778240503808/Yv_SMxbx_normal.jpg	https://pbs.twimg.com/profile_banners/1326612023174590465/1605277786		2020-11-11 19:46:15+00
8	bulan_cahaya4	1689919343952642048	Bulan Cahaya	0	25	Stay humble. Be kind. Work hard.	https://pbs.twimg.com/profile_images/1689919746316410880/uqk7ZWEM_normal.jpg			2023-08-11 08:39:14+00
9	aulinadiana	1581850798782263296	aulinadiana	8	15	Black & White	https://pbs.twimg.com/profile_images/1585070891880546307/dToAfHjU_normal.jpg		Bengkulu, Indonesia	2022-10-17 03:33:22+00
10	lasti_bunayah2	1684043074375397376	Lasti Bunayah	0	19	sakit dibalas maaf itu ga adil	https://pbs.twimg.com/profile_images/1684043703906877440/_b0bJ79w_normal.jpg			2023-07-27 03:29:01+00
11	Linktop287390	1784518345318158336	Link top	0	1		https://pbs.twimg.com/profile_images/1784518502382280705/aYzneiMS_normal.jpg			2024-04-28 09:42:00+00
12	SitiRaf21214506	1603589813428310016	fi/scorpiometal	7469	7452	saling follow yuk kecuali pembenci pemerintah. tidak akan saya fb #pancasila💯 cooling down. #silen#	https://pbs.twimg.com/profile_images/1773817669244067840/3pBeWt0Q_normal.jpg	https://pbs.twimg.com/profile_banners/1603589813428310016/1691688169	Batam	2022-12-16 03:16:59+00
13	lovetheavocados	1100014266973806593	arabella✮	232	369	alter ego 💭 | fangirling acc and anything lol	https://pbs.twimg.com/profile_images/1776657015617851392/8WjvzURv_normal.jpg	https://pbs.twimg.com/profile_banners/1100014266973806593/1712722159	she/her	2019-02-25 12:46:53+00
14	mamagemoybiasa	1370343082495942660	¥ a u m e n e e r	2148	1685	no DM plis🔸️akun alter @mamabiasai	https://pbs.twimg.com/profile_images/1493085209259962370/IfTMNACv_normal.jpg	https://pbs.twimg.com/profile_banners/1370343082495942660/1703652235		2021-04-12 11:57:27+00
15	senairojc1	4898588847	Senairo	8	71		https://pbs.twimg.com/profile_images/1782395156999901184/tEnDYrYe_normal.jpg			2016-02-11 17:32:57+00
16	afifaq_talina23	1689861502399057920	afifaq_talina23	0	30	I am called mother, you are called father, simple for the future of both of us	https://pbs.twimg.com/profile_images/1689861655117901824/WLBbSYFu_normal.jpg			2023-08-11 04:49:30+00
17	dp_koesmirah	1131410981131653120	dp_koesmirah	2554	2515	selalu berusaha menjadi lebih baik dari hari kemarin	https://pbs.twimg.com/profile_images/1508625355745402881/TAOBJYni_normal.jpg	https://pbs.twimg.com/profile_banners/1131410981131653120/1649598909	Mengwi, Indonesia	2019-05-23 04:06:13+00
18	ViralVideo73683	1784282754240380928	Viral Videos	0	0		https://pbs.twimg.com/profile_images/1784282890630803456/RI14dOW__normal.jpg			2024-04-27 18:05:47+00
19	Gurane11316	1733885164185649153	Agung Satrio	2	5		https://pbs.twimg.com/profile_images/1750522493268590593/xWn0YFw4_normal.jpg			2023-12-10 16:23:56+00
20	unseasonedfish	1414947285553881092	dim 🐟	144	216	sorry im kinda slow, but ill make it i promise	https://pbs.twimg.com/profile_images/1789257769071362048/58iB-ETh_normal.jpg	https://pbs.twimg.com/profile_banners/1414947285553881092/1699333153	Bandung, Jawa Barat	2021-07-13 13:58:24+00
21	MissJoane09	271898786	Noname	592	592	💖Jesus Christ| Anxiety survivor|❤Coffee & Chocolate|	https://pbs.twimg.com/profile_images/1757973622176755712/hJ6H1qC7_normal.jpg	https://pbs.twimg.com/profile_banners/271898786/1690764709	Malang,Indonesia	2011-03-25 11:58:35+00
22	kri_tik_us	530920037	kri_tik_us	1857	796	#BenciPembohong.	https://pbs.twimg.com/profile_images/1585041298570215424/Ptfkt39i_normal.jpg	https://pbs.twimg.com/profile_banners/530920037/1666744711	Indonesia	2012-03-20 04:50:28+00
23	idolletes	734741352236220417	rara - loker wfh on pinned	313	214	gg enthu • she/her	https://pbs.twimg.com/profile_images/1788185908354891777/QQi3h-54_normal.jpg	https://pbs.twimg.com/profile_banners/734741352236220417/1715171684	swifties	2016-05-23 13:42:44+00
24	JR007_	492227293	007	15	43		https://pbs.twimg.com/profile_images/1638893204073480192/4ezT4EwY_normal.jpg	https://pbs.twimg.com/profile_banners/492227293/1679577575	Americana, Brasil	2012-02-14 13:47:51+00
25	SaptoHape	1615286103388610562	Sapto hape	4	15		https://pbs.twimg.com/profile_images/1615286240018063361/PL1TO-YS_normal.png			2023-01-17 09:53:44+00
26	SuyadiPatmo	2397255536	Suyadi Patmo	129	1290	Biasakanlah Memberikan Sesuatu Pada Seseorang Sesuai Dengan Haknya	https://pbs.twimg.com/profile_images/1596098779777798147/JnR8XLRv_normal.jpg	https://pbs.twimg.com/profile_banners/2397255536/1491043953	Jawa Tengah,Indonesia	2014-03-19 04:37:43+00
27	19_45d	838615679783723008	inizialled_45	118	224		https://pbs.twimg.com/profile_images/1771119490308460544/tjXuCRae_normal.jpg	https://pbs.twimg.com/profile_banners/838615679783723008/1711102807		2017-03-06 05:02:13+00
28	opaparawitha	1328715418916122625	Pakde yan 🇮🇩	18418	17767	enggak mencela sana mencela sini, agar enggak mencla - mencle.	https://pbs.twimg.com/profile_images/1632634549061701632/kroiDAHk_normal.jpg	https://pbs.twimg.com/profile_banners/1328715418916122625/1632990820		2020-11-17 15:04:14+00
29	Sukirman2019	900969794786148352	Makan siang gratis	75	741	cuma tukang kepo di medsos	https://pbs.twimg.com/profile_images/1437939537368403971/CBkxkh--_normal.jpg			2017-08-25 06:35:13+00
30	Thondhanks	217395541	𝗕𝗮𝗻𝗴 🆃︎🅷︎🅾︎🅽︎🅳︎🅰︎🅽︎🅶︎	150	403	Humoris. Traveling. Penari Lintas. Kecoa Jalanan, #Jangan Biarkan Dia Sendiri...	https://pbs.twimg.com/profile_images/1586191058895093760/OPhtzrcm_normal.jpg	https://pbs.twimg.com/profile_banners/217395541/1659858054	Mandailing Natal, Sumatera Uta	2010-11-19 12:15:59+00
31	BetsyHa70452279	1583798964905992195	Betsy Harper	3	5		https://pbs.twimg.com/profile_images/1583799368922333185/CUGvR5CK_normal.jpg			2022-10-22 12:34:58+00
32	jevina_mays4	1697460186590633984	Jevina Maysa	1	25	Terwujud ataupun tidak, tetaplah bersujud.	https://pbs.twimg.com/profile_images/1697461475257032704/eCQfyZRV_normal.jpg			2023-09-01 04:03:49+00
33	Rere_melindaa	1654635401230032897	Rere	7	2	!	https://pbs.twimg.com/profile_images/1655414448348356608/zTUOfxr-_normal.jpg			2023-05-05 23:53:29+00
34	randy_wijaya38	1689493976137814016	Randy Wijaya	0	22	good always has the best one for you	https://pbs.twimg.com/profile_images/1689494119557783552/ONj6SHBY_normal.jpg			2023-08-10 04:29:03+00
35	Goyobodl88140	1741796337388285953	ganker khan	4	66	Kerja cari nafkah halalan toyiban biar besar asal berkah😍	https://pbs.twimg.com/profile_images/1743078481775542273/hWv7y6t8_normal.jpg			2024-01-01 12:20:37+00
36	AziAbdullah	395177175	Azi Abdullah	36	118	Baik	https://pbs.twimg.com/profile_images/1526193874842300419/bIqA8zPU_normal.jpg			2011-10-21 07:58:02+00
37	Madun_fans	1654637112506093568	Madun	9	0	Yuhu	https://pbs.twimg.com/profile_images/1655415054043578369/XY4Ol0D4_normal.jpg			2023-05-06 00:00:19+00
38	busan_dari26	1689921247369699328	Busan Dari	0	23	harta tahta busan	https://pbs.twimg.com/profile_images/1689921598529376256/isf4uCDV_normal.jpg			2023-08-11 08:47:06+00
39	nizarargh	1055809899605585921	adzceng	480	440	jawani	https://pbs.twimg.com/profile_images/1780469949724798976/5I8p3ZZz_normal.jpg	https://pbs.twimg.com/profile_banners/1055809899605585921/1707844304	📍	2018-10-26 13:14:30+00
40	ayrifkiprayitno	1042637882073051137	A Y	65	531	sosial keadilan	https://pbs.twimg.com/profile_images/1746782138350059520/QqJT7teR_normal.jpg	https://pbs.twimg.com/profile_banners/1042637882073051137/1592362876	Semarang, Jawa Tengah	2018-09-20 04:53:37+00
41	khusn_mub	1591217679561433088	Khusn Mub	9	24		https://pbs.twimg.com/profile_images/1591217823023439872/lVB-F0ds_normal.png			2022-11-11 23:54:26+00
42	Dinda_Kirantii	1654636715645243397	dinda	9	0	why	https://pbs.twimg.com/profile_images/1655416424129765376/aDXusx1R_normal.jpg			2023-05-05 23:58:46+00
43	BandungTV38	159014326	Bandung TV Official	11534	406	PT. BANDUNG MEDIA TELEVISI INDONESIA Email : marketing@bandungtv.tv Telp : 022-7213862 WA : 0811-818992 Jl. Pacuan Kuda No. 63 Arcamanik	https://pbs.twimg.com/profile_images/687609668114366464/lD9TB1fC_normal.jpg	https://pbs.twimg.com/profile_banners/159014326/1481010134	Bandung - Jawa Barat	2010-06-24 06:33:26+00
44	Fauzi56100765	1163267898753744896	Fauzi	750	1048	Fanfiru Ilalloh....!!! Gak ikutan Otak Kotor...! Menjaga Kebersihan HATI..!	https://pbs.twimg.com/profile_images/1678658918757838848/f6ray9jp_normal.jpg			2019-08-19 01:54:32+00
45	temanduit	1299521463150542849	7Eliaz 📢PrabowoRI1️⃣בחסד	861	657	everyone has the same opportunity to succeed in life. money is just an idea. just make it simple stupid (MISS)! #JalinPersatuanKesatuanNasionalis	https://pbs.twimg.com/profile_images/1707327756001054720/5AEc6pht_normal.jpg	https://pbs.twimg.com/profile_banners/1299521463150542849/1603873384	Jakarta Capital Region	2020-08-29 01:37:36+00
46	liputan6dotcom	47596019	LIPUTAN6	4643067	694	The official Instagram of https://t.co/DCmGvp3y9e. A member of KapanLagi Youniverse & EMTEK group.	https://pbs.twimg.com/profile_images/1706236803903324160/gJo8r9IX_normal.jpg	https://pbs.twimg.com/profile_banners/47596019/1713419013	Jakarta	2009-06-16 10:48:24+00
47	gita_iskandar44	1709051977609728000	Gita Iskandar	2	38	Embracing the art of self-expression through visuals 🎨	https://pbs.twimg.com/profile_images/1709052805741506560/vGUoNOOH_normal.jpg			2023-10-03 03:45:38+00
48	morris1745541	1776803320482676736	morris	12	33		https://pbs.twimg.com/profile_images/1776803623177166848/gZ0iTQiO_normal.jpg			2024-04-07 02:45:25+00
49	Anintemanreza	4112663838	Transformer Pisang	3458	253	Something cute with a little bit of spices // 👩	https://pbs.twimg.com/profile_images/1424000264738992134/P8xEk8E7_normal.jpg	https://pbs.twimg.com/profile_banners/4112663838/1563458977		2015-11-03 12:20:13+00
50	YosepZainal	1706238991673257984	yosep zainal	1	3		https://pbs.twimg.com/profile_images/1706256566591344640/uud6MAeA_normal.jpg		Jakartaa	2023-09-25 09:27:48+00
51	Mpok_Hanum	500705112	Hanum Larasati	1293	204	Pensiunan Pendamping 16 Kelompok Tani\nSwitch Career Sbg Meta Ads Specialist, Digital Marketer, dan Copywriter\nMuridnya @MikaelDewabrata @ryan_nira @copyraharja	https://pbs.twimg.com/profile_images/1148415648613224448/9v2sPbAT_normal.png	https://pbs.twimg.com/profile_banners/500705112/1591533948	Jakarta, ID	2024-05-20 11:59:17+00
52	Alexparisyel	547175585	Alexander	271	1003	General Industrial supplier	https://pbs.twimg.com/profile_images/819409493142315008/kJWsOKKU_normal.jpg		Pariaman Tengah, Indonesia	2024-05-20 11:57:45+00
53	Justonedy2	1392702498482188289	Justonedy	43	149	@cah Jimatan.\nkalisuren, tajurhalang, bogor	https://pbs.twimg.com/profile_images/1577252686462070786/d5cZOG7b_normal.jpg		Senen, Indonesia	2024-05-20 11:57:37+00
54	julia_maya66	1703629115541315584	Julia Maya	0	19	sorry, siapa ya?	https://pbs.twimg.com/profile_images/1703629300652810240/rUeosP5x_normal.jpg			2024-05-20 11:57:28+00
55	TonyParker19679	1764873623083614208	Tony Parker	19	78	Sesosok makhluk hina yg gak sudi diperintah oleh pemimpin durjana.	https://pbs.twimg.com/profile_images/1767546009243242496/rP2agFn8_normal.jpg	https://pbs.twimg.com/profile_banners/1764873623083614208/1709856056	Jakarta Capital Region	2024-05-20 11:57:18+00
56	sofyan_aznawi37	1689479740745510912	Sofyan Aznawi	0	20	love brings pain -	https://pbs.twimg.com/profile_images/1689480110083301376/U4CNpkub_normal.jpg			2024-05-20 11:57:10+00
57	deluluww	1608589718081638401	zzzz	2	47		https://pbs.twimg.com/profile_images/1731936372754391040/pCDmV7Rb_normal.jpg	https://pbs.twimg.com/profile_banners/1608589718081638401/1673046091		2024-05-20 11:56:54+00
58	dancersejati07	1605747132014637061	dancersejati07	1020	142		https://pbs.twimg.com/profile_images/1610255957543768066/dTzjGVsM_normal.jpg			2024-05-20 11:56:43+00
59	koviiyay	1052926842284298240	ꦏꦺꦴꦥ꦳ꦶ	16379	349	instagram/tiktok/misskey/bsky = @koviiyay || mona and woman centric acc • multi-fandom • might post 🔞 • NO AI/eNeFTeeS • PPF by @ysnden\n\nRepost with proper cr	https://pbs.twimg.com/profile_images/1673590876696637442/SmPnHyNY_normal.jpg	https://pbs.twimg.com/profile_banners/1052926842284298240/1695380491	MF/GL	2024-05-20 11:55:51+00
60	khrnnsnb	1028924007767138304	mél	106	219	ohh just to mind your business and leave people alone.\nit's me. I'm people.\n\n--Normal People, 115 3:9--	https://pbs.twimg.com/profile_images/1766820443263307776/NCtUj6jD_normal.jpg	https://pbs.twimg.com/profile_banners/1028924007767138304/1710077794	🌏	2024-05-20 11:55:17+00
61	benazir_muthia7	1689851386073317376	Benazir Muthia	0	18	What should I put here?	https://pbs.twimg.com/profile_images/1689852183146344448/swPbE56X_normal.jpg			2024-05-20 11:54:58+00
62	jepaforger	1197233714800939008	🐶	1525	1422		https://pbs.twimg.com/profile_images/1488070413947379713/Y04R40St_normal.jpg	https://pbs.twimg.com/profile_banners/1197233714800939008/1657707229		2024-05-20 11:53:45+00
63	_sabtumingyu	1549091135418953728	al🫧	54	118		https://pbs.twimg.com/profile_images/1791500526233997312/OGJecVAH_normal.jpg	https://pbs.twimg.com/profile_banners/1549091135418953728/1681443607		2024-05-20 11:51:02+00
64	huangiill	1289151478418903043	chie	25	163	💚Huang Renjun little bro💚	https://pbs.twimg.com/profile_images/1538479604251250694/9sgtntlx_normal.jpg	https://pbs.twimg.com/profile_banners/1289151478418903043/1655637147		2024-05-20 11:50:56+00
65	jusuf_iskandarr	1694962803201961984	Jusuf Iskandar	0	39	semua bakalan ada waktu yang tepat di temlat yang istimewa	https://pbs.twimg.com/profile_images/1694962917526183937/Jbbv7GIC_normal.jpg			2024-05-20 11:50:29+00
66	_haye_	753553855	Haye Targaryen	29131	4566	Ketua Panitia Lomba Balap Kucing, Pakar Dekonstruksi Sosial, Wali Murid Gerakan Tertib Nalar. The Paramilitary Wing of Reason.	https://pbs.twimg.com/profile_images/1305039445226209281/LAQiuHHa_normal.jpg	https://pbs.twimg.com/profile_banners/753553855/1396394337		2024-05-20 11:49:00+00
67	Hana70116972	1301172950897496065	SnowFlakes	32	129	Paling emosi liat ortu2 tolol, tukang ngentu tapi menelantarkan anak, ortu² biadab dan jahanam.\n\nhttps://t.co/EzvOxWktU0	https://pbs.twimg.com/profile_images/1783144921760727040/05qgRMel_normal.jpg			2024-05-20 11:48:30+00
68	partaigeloraid	1179718333605658624	Partai Gelora Indonesia	13723	103	Gelorakan semangat Indonesia\nmenuju kekuatan 5 besar dunia! @anismatta @Fahrihamzah #Gelora7 #ArahBaruIndonesia #Indonesia5besardunia #partaigelora\n\n👇	https://pbs.twimg.com/profile_images/1483548688517824512/qDEhRbwS_normal.jpg	https://pbs.twimg.com/profile_banners/1179718333605658624/1672289089	Indonesia	2024-05-20 11:48:23+00
69	imam_tito77	1694974454886207488	Imam Tito	3	19	aku sudah berhenti berharap kepada siapapun	https://pbs.twimg.com/profile_images/1694974599161847808/mG4Y2kFL_normal.jpg			2024-05-20 11:48:12+00
70	greg_wahyu	2440979406	Jhony Boba	34	140	Suka yg wangi.\n\nJgn prnah takut bermimpi, krn dr bermimpi kita termotivasi utk mewujudkannya	https://pbs.twimg.com/profile_images/840298511396564992/jieHGNdT_normal.jpg		Indonesia	2024-05-20 11:47:41+00
71	79_two	1499725799196217345	rh.andij.s.	1934	1708	former presecutor. alone but not lonely, akun jilid III,orang Hukum asli,DR.tapi bkn dokter medis,hidup cukup tnpa prnah korupsi.	https://pbs.twimg.com/profile_images/1640474993179127808/p-mafHfB_normal.jpg			2024-05-20 11:45:56+00
72	KochengPosi	1579499361599631367	Kocheng Positif	38	57		https://pbs.twimg.com/profile_images/1618561270881587200/m93fiGT0_normal.jpg	https://pbs.twimg.com/profile_banners/1579499361599631367/1665417199		2024-05-20 11:45:43+00
73	bedasablon	1732243827489218560	Didiek Ananta	63	126		https://pbs.twimg.com/profile_images/1732244193651871744/kOtIFWm-_normal.jpg			2024-05-20 11:44:21+00
74	civil_cociety	740397376725254148	Asta	33	140	semangat pagii..!!!	https://pbs.twimg.com/profile_images/1721067445971189761/nNY3tP-L_normal.jpg	https://pbs.twimg.com/profile_banners/740397376725254148/1547144832	Indonesia	2024-05-20 11:43:42+00
75	MarSol6606	1629730692853796864	🇵🇸FreePalestine🇵🇸	241	466	Twitter ini hanya diary dan tempat curcol.	https://pbs.twimg.com/profile_images/1720359812717027328/sSDfDviG_normal.jpg	https://pbs.twimg.com/profile_banners/1629730692853796864/1687262677	Jakarta Capital Region, Indone	2024-05-20 11:42:48+00
76	Madlanunu	1584609799	amladin	1132	1114	isinya tweet sampah	https://pbs.twimg.com/profile_images/1756642926694924288/LsSHGU-q_normal.jpg	https://pbs.twimg.com/profile_banners/1584609799/1589060530		2024-05-20 11:42:28+00
77	TiurWahyuni	1364531709815918593	Tiur Wahyuni Zulyanti Simatupang	455	729	Basic - Ilmu Sosial dan Ilmu Politik.\nLike - Ilmu Filsafat	https://pbs.twimg.com/profile_images/1791288728092340224/ncqRdw4S_normal.jpg	https://pbs.twimg.com/profile_banners/1364531709815918593/1707725124		2024-05-20 11:42:08+00
78	lostacker	1117069176714059776	🍉	191	189		https://pbs.twimg.com/profile_images/1741245415264260096/EpD3MN_p_normal.jpg	https://pbs.twimg.com/profile_banners/1117069176714059776/1698823844	West Java, Indonesia	2024-05-20 11:41:57+00
79	honeynula	1592212079628673025	honey	0	8	i just want to die and i have zero intention of gaining any followers here so do not hit the follow button	https://pbs.twimg.com/profile_images/1773655940983861248/wXkkmPIz_normal.jpg	https://pbs.twimg.com/profile_banners/1592212079628673025/1712863860	(any pronouns) follow=block	2024-05-20 11:41:25+00
80	TiurWahyuni	1364531709815918593	Tiur Wahyuni Zulyanti Simatupang	455	729	Basic - Ilmu Sosial dan Ilmu Politik.\nLike - Ilmu Filsafat	https://pbs.twimg.com/profile_images/1791288728092340224/ncqRdw4S_normal.jpg	https://pbs.twimg.com/profile_banners/1364531709815918593/1707725124		2024-05-20 11:41:06+00
81	democrazymedia	1243804423001763841	Democrazy News	101790	250	Democrazy News - Indonesian Political News • Terkini, Independen, Akurat & Kredibel - ✉️: democrazynews@gmail.com | https://t.co/SLLjzRdpeC	https://pbs.twimg.com/profile_images/1480783321609113600/9C8OVc7R_normal.png	https://pbs.twimg.com/profile_banners/1243804423001763841/1625856345	Indonesia	2024-05-20 11:40:00+00
82	Kapolrestangkot	1552212625533968386	Kapolresmetrotangerangkota	397	21		https://pbs.twimg.com/profile_images/1552212878819610624/RWYxtL9r_normal.jpg			2024-05-20 11:38:40+00
83	tempodotco	18129942	tempo.co	2254088	18	#BicaraFakta | Follow us for breaking news, current events, and more at https://t.co/aR6kgUM5in | Read our in-depth coverage at @temponewsroom & @korantempo	https://pbs.twimg.com/profile_images/1580466468629594112/Q-zcV6aQ_normal.jpg	https://pbs.twimg.com/profile_banners/18129942/1664552448	Indonesia	2024-05-20 11:38:36+00
84	TulusWijanarko	338499453	tulus wijanarko🇲🇨	659	578	Penulis, Puisi, dan peminum teh tongtji	https://pbs.twimg.com/profile_images/1003053068903014400/uxXNNeoA_normal.jpg	https://pbs.twimg.com/profile_banners/338499453/1370260490	Jakarta	2024-05-20 11:38:17+00
85	liputan6dotcom	47596019	LIPUTAN6	4643067	694	The official Instagram of https://t.co/DCmGvp3y9e.\nA member of KapanLagi Youniverse & EMTEK group.	https://pbs.twimg.com/profile_images/1706236803903324160/gJo8r9IX_normal.jpg	https://pbs.twimg.com/profile_banners/47596019/1713419013	Jakarta	2024-05-20 11:38:07+00
86	fahryfajar09	1782093788393123840	fahry yourbae	13	25		https://pbs.twimg.com/profile_images/1784530248975241216/RzKZU-MM_normal.jpg			2024-05-20 11:37:29+00
87	nieke_olivia	1689553843200110593	Olivia Nieke Yuliane	13050	684	Rabb-ku❤️| Follower Muhammad SAW | Pengganti @nieke_aereta | Proud Mamma Di Maitreya | LEONESSA, JUVENTUS, Very Picky INTROVERT & KOLERIS | Coffee Addicted🇮🇹	https://pbs.twimg.com/profile_images/1759020729499103232/4UvwljWc_normal.jpg	https://pbs.twimg.com/profile_banners/1689553843200110593/1708218270	Italy	2024-05-20 11:36:54+00
88	daniya_rahna24	1689862761378201600	Daniya Rahna	0	30	even I am willing to wait for your arrival even though I know you will not come	https://pbs.twimg.com/profile_images/1689862889333768193/ux6zBu2-_normal.jpg			2024-05-20 11:35:21+00
89	paijomarkucel	1577664605274284034	P4170	1636	1644	random tweets// a good friendship is conversation that never end // auto follow back, terms & conditions apply : ⛔porn ⛔cebi ⛔syi'ah ⛔LGBT	https://pbs.twimg.com/profile_images/1641039059383644160/BBtlFVCA_normal.jpg	https://pbs.twimg.com/profile_banners/1577664605274284034/1669943681	台灣🚴Malang	2024-05-20 11:34:51+00
90	posieclair	1722988124303978496	Eira Loretta🇵🇸❄	69	68		https://pbs.twimg.com/profile_images/1760612306168487936/bnZ4AglK_normal.jpg	https://pbs.twimg.com/profile_banners/1722988124303978496/1699948576		2024-05-20 11:34:42+00
91	Zetrogede	73539095	Zetrosoft ∀🔺	3069	4964	don't #think about what you can't #think of, but try to #think what you want to do to get it. #think #AVAX from #Avalanche\n\n#AI #MachineLearning #BijakTechno	https://pbs.twimg.com/profile_images/1599271474208346112/z-7hu7uB_normal.jpg	https://pbs.twimg.com/profile_banners/73539095/1670131006	Indonesia	2024-05-20 11:33:55+00
92	RianiNurAisyah	1580114053581901824	🇮🇩 ABS 🇮🇩	1012	1002	No Kadrun-No Sara,-No Porno\nNKRI Harga Mati	https://pbs.twimg.com/profile_images/1759544132522135552/SDjyyYRa_normal.jpg	https://pbs.twimg.com/profile_banners/1580114053581901824/1708343141	Sendawar -Kutai Barat	2024-05-20 11:33:51+00
93	BawasluKotaBima	1110728638305951744	BAWASLU KOTA BIMA	297	402	BERSAMA RAKYAT AWASI PEMILU, BERSAMA BAWASLU TEGAKKAN KEADILAN PEMILU	https://pbs.twimg.com/profile_images/1622801725177626625/qq-b3hhM_normal.jpg	https://pbs.twimg.com/profile_banners/1110728638305951744/1692496837	KOTA BIMA - NTB	2024-05-20 11:32:58+00
94	victorpangkey	215601167	Victor Pangkey	417	876	Make everything as simple as possible but not simpler	https://pbs.twimg.com/profile_images/1569933952768692225/HVCtq_M__normal.jpg		Jakarta	2024-05-20 11:32:57+00
95	cryptogem1000	80613264	Crypto Gems 100x	223	417	LongTerm Investor, Cryptoworld since 2017 #Metatime	https://pbs.twimg.com/profile_images/1497022078192881664/nzFl-BoP_normal.jpg	https://pbs.twimg.com/profile_banners/80613264/1362672513		2024-05-20 11:32:43+00
96	MilkC4ndy	3305309365	taa ×͜×	1178	775	Keep yourself alive	https://pbs.twimg.com/profile_images/1736743100968738816/yAx4Rdi6_normal.jpg	https://pbs.twimg.com/profile_banners/3305309365/1715167808	🏸❣️	2024-05-20 11:32:20+00
97	aaa_nto	1577441633649717249	Anto •	36	57		https://pbs.twimg.com/profile_images/1731593522158170112/fsUa_qqA_normal.jpg		Purwokerto, Indonesia	2024-05-20 11:30:42+00
98	KompasData	771030588	Kompas Data	11222	102	Akun resmi Kompas Data, bagian dari @hariankompas | Info arsip/data Litbang Kompas, hubungi Pusat Informasi Kompas: (021) 5347710, https://t.co/BiiftM6w9X	https://pbs.twimg.com/profile_images/779349972571398144/-IYrd31Q_normal.jpg	https://pbs.twimg.com/profile_banners/771030588/1489133589	Palmerah, Jakarta	2024-05-20 11:29:07+00
99	hariankompas	255866913	Harian Kompas	1049405	274	Amanat Hati Nurani Rakyat | Pendiri: PK Ojong dan Jakob Oetama | Info langganan: @hotlinekompas & https://t.co/my27NRMXuC |#MultimediaMencerahkan	https://pbs.twimg.com/profile_images/1676798978917269504/l5K2fHZQ_normal.jpg	https://pbs.twimg.com/profile_banners/255866913/1713943062	Palmerah, Jakarta	2024-05-20 11:29:07+00
100	rafaila_ashadi	1689858586724511744	Rafaila Ashadiya	0	26	Hanya seorang manusia yang ingin menggapai mimpi.	https://pbs.twimg.com/profile_images/1689858900630368257/VEvZYz6T_normal.jpg			2024-05-20 11:29:03+00
\.


--
-- Name: account_history_login_private_ah_lp_id_seq; Type: SEQUENCE SET; Schema: instagram; Owner: avnadmin
--

SELECT pg_catalog.setval('instagram.account_history_login_private_ah_lp_id_seq', 125, true);


--
-- Name: followers_private_fs_id_seq; Type: SEQUENCE SET; Schema: instagram; Owner: avnadmin
--

SELECT pg_catalog.setval('instagram.followers_private_fs_id_seq', 440, true);


--
-- Name: following_private_fg_id_seq; Type: SEQUENCE SET; Schema: instagram; Owner: avnadmin
--

SELECT pg_catalog.setval('instagram.following_private_fg_id_seq', 658, true);


--
-- Name: followers_private_fs_id_seq; Type: SEQUENCE SET; Schema: twitter; Owner: avnadmin
--

SELECT pg_catalog.setval('twitter.followers_private_fs_id_seq', 107, true);


--
-- Name: following_private_fg_id_seq; Type: SEQUENCE SET; Schema: twitter; Owner: avnadmin
--

SELECT pg_catalog.setval('twitter.following_private_fg_id_seq', 260, true);


--
-- Name: ip_audit_private_ip_ap_id_seq; Type: SEQUENCE SET; Schema: twitter; Owner: avnadmin
--

SELECT pg_catalog.setval('twitter.ip_audit_private_ip_ap_id_seq', 306, true);


--
-- Name: account_history_login_private account_history_login_private_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.account_history_login_private
    ADD CONSTRAINT account_history_login_private_pkey PRIMARY KEY (ah_lp_id);


--
-- Name: followers_private followers_private_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.followers_private
    ADD CONSTRAINT followers_private_pkey PRIMARY KEY (fs_id);


--
-- Name: following_private following_private_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.following_private
    ADD CONSTRAINT following_private_pkey PRIMARY KEY (fg_id);


--
-- Name: hashtags hashtags_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.hashtags
    ADD CONSTRAINT hashtags_pkey PRIMARY KEY (hashtag_id);


--
-- Name: post_hashtag post_hashtag_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_hashtag
    ADD CONSTRAINT post_hashtag_pkey PRIMARY KEY (ph_id);


--
-- Name: post_sentiment post_sentiment_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_sentiment
    ADD CONSTRAINT post_sentiment_pkey PRIMARY KEY (ps_id);


--
-- Name: post_type post_type_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_type
    ADD CONSTRAINT post_type_pkey PRIMARY KEY (pt_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- Name: posts_private posts_private_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.posts_private
    ADD CONSTRAINT posts_private_pkey PRIMARY KEY (post_id);


--
-- Name: user_private user_private_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.user_private
    ADD CONSTRAINT user_private_pkey PRIMARY KEY (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: followers_private followers_private_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.followers_private
    ADD CONSTRAINT followers_private_pkey PRIMARY KEY (fs_id);


--
-- Name: following_private following_private_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.following_private
    ADD CONSTRAINT following_private_pkey PRIMARY KEY (fg_id);


--
-- Name: ip_audit_private ip_audit_private_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.ip_audit_private
    ADD CONSTRAINT ip_audit_private_pkey PRIMARY KEY (ip_ap_id);


--
-- Name: keywords keywords_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (keyword_id);


--
-- Name: tweet_keyword tweet_keyword_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_keyword
    ADD CONSTRAINT tweet_keyword_pkey PRIMARY KEY (tk_id);


--
-- Name: tweet_sentiment tweet_sentiment_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_sentiment
    ADD CONSTRAINT tweet_sentiment_pkey PRIMARY KEY (ts_id);


--
-- Name: tweet_type tweet_type_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_type
    ADD CONSTRAINT tweet_type_pkey PRIMARY KEY (tt_id);


--
-- Name: tweets tweets_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (tweet_id);


--
-- Name: tweets_private tweets_private_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweets_private
    ADD CONSTRAINT tweets_private_pkey PRIMARY KEY (tweet_id);


--
-- Name: user_private user_private_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.user_private
    ADD CONSTRAINT user_private_pkey PRIMARY KEY (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: account_history_login_private account_history_login_private_user_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.account_history_login_private
    ADD CONSTRAINT account_history_login_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES instagram.user_private(user_id);


--
-- Name: followers_private followers_private_user_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.followers_private
    ADD CONSTRAINT followers_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES instagram.user_private(user_id);


--
-- Name: following_private following_private_user_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.following_private
    ADD CONSTRAINT following_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES instagram.user_private(user_id);


--
-- Name: post_hashtag post_hashtag_hashtag_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_hashtag
    ADD CONSTRAINT post_hashtag_hashtag_id_fkey FOREIGN KEY (hashtag_id) REFERENCES instagram.hashtags(hashtag_id);


--
-- Name: post_hashtag post_hashtag_post_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_hashtag
    ADD CONSTRAINT post_hashtag_post_id_fkey FOREIGN KEY (post_id) REFERENCES instagram.posts(post_id);


--
-- Name: post_sentiment post_sentiment_post_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_sentiment
    ADD CONSTRAINT post_sentiment_post_id_fkey FOREIGN KEY (post_id) REFERENCES instagram.posts(post_id);


--
-- Name: post_type post_type_post_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.post_type
    ADD CONSTRAINT post_type_post_id_fkey FOREIGN KEY (post_id) REFERENCES instagram.posts(post_id);


--
-- Name: posts_private posts_private_user_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.posts_private
    ADD CONSTRAINT posts_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES instagram.user_private(user_id);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: instagram; Owner: avnadmin
--

ALTER TABLE ONLY instagram.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES instagram.users(user_id);


--
-- Name: followers_private followers_private_user_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.followers_private
    ADD CONSTRAINT followers_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES twitter.user_private(user_id);


--
-- Name: following_private following_private_user_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.following_private
    ADD CONSTRAINT following_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES twitter.user_private(user_id);


--
-- Name: ip_audit_private ip_audit_private_user_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.ip_audit_private
    ADD CONSTRAINT ip_audit_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES twitter.user_private(user_id);


--
-- Name: tweet_keyword tweet_keyword_keyword_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_keyword
    ADD CONSTRAINT tweet_keyword_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES twitter.keywords(keyword_id);


--
-- Name: tweet_keyword tweet_keyword_tweet_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_keyword
    ADD CONSTRAINT tweet_keyword_tweet_id_fkey FOREIGN KEY (tweet_id) REFERENCES twitter.tweets(tweet_id);


--
-- Name: tweet_sentiment tweet_sentiment_tweet_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_sentiment
    ADD CONSTRAINT tweet_sentiment_tweet_id_fkey FOREIGN KEY (tweet_id) REFERENCES twitter.tweets(tweet_id);


--
-- Name: tweet_type tweet_type_tweet_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweet_type
    ADD CONSTRAINT tweet_type_tweet_id_fkey FOREIGN KEY (tweet_id) REFERENCES twitter.tweets(tweet_id);


--
-- Name: tweets_private tweets_private_user_id_fkey; Type: FK CONSTRAINT; Schema: twitter; Owner: avnadmin
--

ALTER TABLE ONLY twitter.tweets_private
    ADD CONSTRAINT tweets_private_user_id_fkey FOREIGN KEY (user_id) REFERENCES twitter.user_private(user_id);


--
-- PostgreSQL database dump complete
--

