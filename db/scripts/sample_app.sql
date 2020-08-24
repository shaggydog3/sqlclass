-- photo blog app (like instagram)

/* enties:
    users
    photos (image url)
        blog post
    likes
        one user can only like one blog post
    hashtags
        for posts/photos
    comments
    followers & following;
        a person can follow someone, but the followed doesn't have
        to follow the other person.
*/
DROP DATABASE sample_app;

CREATE DATABASE sample_app;
USE sample_app;

CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- need to consider what fields should be unique, or not null.

CREATE TABLE photos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    caption VARCHAR(255),
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id)
        REFERENCES users(id)
);

CREATE TABLE comments(
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(140) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id)
        REFERENCES users(id),
    FOREIGN KEY(photo_id)
        REFERENCES photos(id)
);

CREATE TABLE likes(
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id)
        REFERENCES photos(id),
    FOREIGN KEY(user_id)
        REFERENCES users(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows(
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id)
        REFERENCES users(id),
    FOREIGN KEY(followee_id)
        REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
    tag_id INT NOT NULL,
    photo_id INT NOT NULL,
    FOREIGN KEY(photo_id)
        REFERENCES photos(id),
    FOREIGN KEY(tag_id)
        REFERENCES tags(id),
    PRIMARY KEY(tag_id, photo_id)
);

