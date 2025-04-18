CREATE TABLE dragon (
    dragon_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    color VARCHAR(25),
    eye_color VARCHAR(25),
    fireball_color VARCHAR(25),
    birth_date VARCHAR(50),
    death_date VARCHAR(50)
);

CREATE TABLE targaryen (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    full_name VARCHAR(255),
    birth_date VARCHAR(50),
    death_date VARCHAR(50),
    reign_start VARCHAR(50),
    reign_end VARCHAR(50)
);

CREATE TABLE dragon_rider (
    rider_id SERIAL PRIMARY KEY,
    targaryen_id INT,
    dragon_id INT,
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    FOREIGN KEY (targaryen_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (dragon_id) REFERENCES dragon(dragon_id)
);

CREATE TABLE alias (
    alias_id SERIAL PRIMARY KEY,
    alias_name VARCHAR(255) NOT NULL
);

CREATE TABLE targaryen_alias (
    targaryen_id INT,
    alias_id INT,
    PRIMARY KEY (targaryen_id, alias_id),
    FOREIGN KEY (targaryen_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (alias_id) REFERENCES alias(alias_id)
);

CREATE TABLE title (
    title_id SERIAL PRIMARY KEY,
    title_name VARCHAR(255) NOT NULL
);

CREATE TABLE targaryen_title (
    targaryen_id INT,
    title_id INT,
    PRIMARY KEY (targaryen_id, title_id),
    FOREIGN KEY (targaryen_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (title_id) REFERENCES title(title_id)
);

CREATE TABLE targaryen_parent (
    child_id INT,
    parent_id INT,
    PRIMARY KEY (child_id, parent_id),
    FOREIGN KEY (child_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (parent_id) REFERENCES targaryen(character_id)
);

CREATE TABLE targaryen_spouse (
    targaryen_id INT,
    spouse_id INT,
    marriage_date VARCHAR(50),
    end_date VARCHAR(50),
    PRIMARY KEY (targaryen_id, spouse_id),
    FOREIGN KEY (targaryen_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (spouse_id) REFERENCES targaryen(character_id)
);
-- INSERT INTO non_targaryen (name, full_name, birth_date, death_date) VALUES
-- ('Elia', 'Elia Martell', '257 AC', '283 AC'),
-- ('Lyanna', 'Lyanna Stark', '266 AC', '283 AC'),
-- ('Myriah', 'Myriah Martell', '150 AC', '209 AC'),
-- ('Larra', 'Larra Rogare', '115 AC', '180 AC');
CREATE TABLE non_targaryen (
    non_targaryen_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    birth_date VARCHAR(50),
    death_date VARCHAR(50)
);

CREATE TABLE targaryen_heir (
    targaryen_id INT,
    heir_id INT,
    PRIMARY KEY (targaryen_id, heir_id),
    FOREIGN KEY (targaryen_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (heir_id) REFERENCES targaryen(character_id)
);

CREATE INDEX idx_targaryen_id ON targaryen(character_id);
CREATE INDEX idx_dragon_id ON dragon(dragon_id);
CREATE INDEX idx_targaryen_alias_targaryen_id ON targaryen_alias(targaryen_id);
CREATE INDEX idx_targaryen_spouse_targaryen_id ON targaryen_spouse(targaryen_id);
CREATE INDEX idx_dragon_rider_targaryen_id ON dragon_rider(targaryen_id);