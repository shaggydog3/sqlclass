CREATE DATABASE trigger_demo;

USE trigger_demo;

CREATE TABLE users(
    username VARCHAR(100),
    age INT
);

INSERT INTO users(username, age) VALUES("bobby", 23);

DELIMITER $$

CREATE TRIGGER must_be_adult
    BEFORE INSERT ON users FOR EACH ROW
    BEGIN
        IF NEW.age < 18
        THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Must be an adult!';
        END IF;
    END;
$$

DELIMITER ;

-- another example; preventing self-follows...

DELIMITER $$

CREATE TRIGGER prevent_self_follows
    BEFORE INSERT ON follows FOR EACH ROW
    begin
        IF NEW.follower_id = NEW.followee_id
        then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'You cannot follow yourself!';
        END IF;
    END;
$$

DELIMITER ;

-- logging unfollows in ig clone db
CREATE TABLE unfollows(
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id)
        REFERENCES users(id),
    FOREIGN KEY(followee_id)
        REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);
DELIMITER $$

CREATE TRIGGER logging_unfollows
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows
        SET
        follower_id = OLD.follower_id,
        followee_id = OLD.followee_id;
    END;
$$

DELIMITER ;