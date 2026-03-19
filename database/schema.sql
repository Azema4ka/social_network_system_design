CREATE SCHEMA IF NOT EXISTS "public";

CREATE TABLE "public"."users" (
    "id" uuid NOT NULL,
    "first_name" varchar(32) NOT NULL,
    "last_name" varchar(32) NOT NULL,
    "age" smallint NOT NULL,
    "region" char(2) NOT NULL,
    "city" varchar(256),
    "description" varchar(512),
    "photoUrl" text,
    "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."posts" (
    "id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "title" varchar(256) NOT NULL,
    "description" varchar(2048),
    "photoUrls" text[],
    "coordinates" bigserial NOT NULL,
    "likes_count" int NOT NULL DEFAULT 0,
    "dislikes_count" int NOT NULL DEFAULT 0,
    "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id")
);

CREATE TABLE "public"."reactions" (
    "post_id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "positive" boolean NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("post_id", "user_id")
);

CREATE TABLE "public"."subscribers" (
    "user_targer" uuid NOT NULL,
    "user_subscriber" uuid NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_targer", "user_subscriber")
);

CREATE TABLE "public"."comments" (
    "post_id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "parent_comment_id" uuid,
    "description" text NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("post_id", "user_id")
);

-- Foreign key constraints
-- Schema: public
ALTER TABLE "public"."posts" ADD CONSTRAINT "fk_posts_user_id_users_id" FOREIGN KEY("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."reactions" ADD CONSTRAINT "fk_reactions_post_id_posts_id" FOREIGN KEY("post_id") REFERENCES "public"."posts"("id");
ALTER TABLE "public"."reactions" ADD CONSTRAINT "fk_reactions_user_id_users_id" FOREIGN KEY("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."subscribers" ADD CONSTRAINT "fk_subscribers_user_targer_users_id" FOREIGN KEY("user_targer") REFERENCES "public"."users"("id");
ALTER TABLE "public"."subscribers" ADD CONSTRAINT "fk_subscribers_user_subscriber_users_id" FOREIGN KEY("user_subscriber") REFERENCES "public"."users"("id");
ALTER TABLE "public"."comments" ADD CONSTRAINT "fk_comments_post_id_posts_id" FOREIGN KEY("post_id") REFERENCES "public"."posts"("id");
ALTER TABLE "public"."comments" ADD CONSTRAINT "fk_comments_user_id_users_id" FOREIGN KEY("user_id") REFERENCES "public"."users"("id");