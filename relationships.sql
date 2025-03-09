-- PARENTS
INSERT INTO targaryen_parent (child_id, parent_id)
VALUES
-- pre-conquest generation
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Gaemon)'), (SELECT character_id FROM targaryen WHERE full_name = 'Gaemon Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Elaena Targaryen (pre-conquest)'), (SELECT character_id FROM targaryen WHERE full_name = 'Gaemon Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maegon Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Gaemon)')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Gaemon)')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aelyx Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Gaemon)')),
((SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Aerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daemion Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aerion Targaryen (pre-conquest)'), (SELECT character_id FROM targaryen WHERE full_name = 'Daemion Targaryen')),
-- Aegon I’s generation
((SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenys Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maegor Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maegor Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Visenya Targaryen')),
-- Aenys I’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (the Uncrowned)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaena Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen (son of Aenys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Vaella Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aenys Targaryen I')),
-- Jaehaerys I and Alysanne’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen (daughter of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen (daughter of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aemon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aemon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Alyssa Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maegelle Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maegelle Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Vaegon Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Vaegon Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daella Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daella Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Saera Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Saera Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Viserra Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Viserra Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Gaemon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Gaemon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Valerion Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Valerion Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Gael Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Gael Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen')),
-- Baelon’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daemon Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)')),
((SELECT character_id FROM targaryen WHERE full_name = 'Alyssa Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)')),
-- Viserys I’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Helaena Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aemond Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen (son of Viserys I)'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen I')),
-- Daemon’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Baela Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Daemon Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaena Targaryen (daughter of Daemon)'), (SELECT character_id FROM targaryen WHERE full_name = 'Daemon Targaryen')),
-- Rhaenyra’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Jacaerys Velaryon'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Lucerys Velaryon'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Joffrey Velaryon'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Visenya Targaryen (daughter of Rhaenyra)'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen')),
-- Aegon II’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen (son of Aegon II)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaera Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maelor Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen II')),
-- Aegon III’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III')),
((SELECT character_id FROM targaryen WHERE full_name = 'Baelor Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daena Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaena Targaryen (daughter of Aegon III)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III')),
((SELECT character_id FROM targaryen WHERE full_name = 'Elaena Targaryen (daughter of Aegon III)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III')),
-- Viserys II’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen IV'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aemon the Dragonknight'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Naerys Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen II')),
-- Aegon IV’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen IV')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen (daughter of Aegon IV)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen IV')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daemon Blackfyre'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen IV')),
-- Daeron II’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Baelor Breakspear'), (SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaegel Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen II')),
-- Maekar I’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen (son of Maekar)'), (SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aerion Targaryen (Brightflame)'), (SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aemon Targaryen (Maester)'), (SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen V'), (SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daella Targaryen (daughter of Maekar)'), (SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhae Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Maekar Targaryen I')),
-- Aegon V’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Duncan Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen V')),
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen V')),
((SELECT character_id FROM targaryen WHERE full_name = 'Shaera Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen V')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen (son of Aegon V)'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen V')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaelle Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen V')),
-- Jaehaerys II’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaella Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen II')),
-- Aerys II’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen II')),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen II')),
-- Rhaegar’s children
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaenys Targaryen (daughter of Rhaegar)'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen (son of Rhaegar)'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen')),
((SELECT character_id FROM targaryen WHERE full_name = 'Jon Snow (Aegon Targaryen)'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen'))
ON CONFLICT (child_id, parent_id) DO NOTHING;



-- SPOUSES
INSERT INTO targaryen_spouse (targaryen_id, spouse_id, marriage_date, end_date)
VALUES
-- Aegon I’s Marriages
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Visenya Targaryen'), '1 BC', '37 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenys Targaryen'), '1 BC', '10 AC'),

-- Jaehaerys I and Alysanne
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen I'), (SELECT character_id FROM targaryen WHERE full_name = 'Alysanne Targaryen'), '50 AC', '100 AC'),

-- Baelon and Alyssa
((SELECT character_id FROM targaryen WHERE full_name = 'Baelon Targaryen (son of Jaehaerys)'), (SELECT character_id FROM targaryen WHERE full_name = 'Alyssa Targaryen'), '78 AC', '101 AC'),

-- Daemon and Rhaenyra
((SELECT character_id FROM targaryen WHERE full_name = 'Daemon Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen'), '120 AC', '130 AC'),

-- Aegon II and Helaena
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Helaena Targaryen'), '120 AC', '130 AC'),

-- Aegon III and Jaehaera
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III'), (SELECT character_id FROM targaryen WHERE full_name = 'Jaehaera Targaryen'), '131 AC', '133 AC'),

-- Viserys II and Larra Rogare (non-Targaryen, assumed outside table)
-- Aegon IV and Naerys
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen IV'), (SELECT character_id FROM targaryen WHERE full_name = 'Naerys Targaryen'), '153 AC', '184 AC'),

-- Daeron II and Myriah Martell (non-Targaryen, assumed outside table)
-- Aerys II and Rhaella
((SELECT character_id FROM targaryen WHERE full_name = 'Aerys Targaryen II'), (SELECT character_id FROM targaryen WHERE full_name = 'Rhaella Targaryen'), '276 AC', '283 AC'),

-- Rhaegar’s Marriages (non-Targaryen spouses assumed outside)
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Elia Martell'), '280 AC', '283 AC'), -- Placeholder
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen'), (SELECT character_id FROM targaryen WHERE full_name = 'Lyanna Stark'), '282 AC', '283 AC') -- Placeholder
ON CONFLICT (targaryen_id, spouse_id) DO NOTHING;

CREATE TABLE non_targaryen (
    non_targaryen_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    birth_date VARCHAR(50),
    death_date VARCHAR(50)
);

INSERT INTO non_targaryen (name, full_name, birth_date, death_date) VALUES
('Elia', 'Elia Martell', '257 AC', '283 AC'),
('Lyanna', 'Lyanna Stark', '266 AC', '283 AC'),
('Myriah', 'Myriah Martell', '150 AC', '209 AC'),
('Larra', 'Larra Rogare', '115 AC', '180 AC');

CREATE TABLE targaryen_non_targaryen_spouse (
    targaryen_id INT,
    non_targaryen_id INT,
    marriage_date VARCHAR(50),
    end_date VARCHAR(50),
    PRIMARY KEY (targaryen_id, non_targaryen_id),
    FOREIGN KEY (targaryen_id) REFERENCES targaryen(character_id),
    FOREIGN KEY (non_targaryen_id) REFERENCES non_targaryen(non_targaryen_id)
);

INSERT INTO targaryen_non_targaryen_spouse (targaryen_id, non_targaryen_id, marriage_date, end_date)
VALUES
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen'), (SELECT non_targaryen_id FROM non_targaryen WHERE full_name = 'Elia Martell'), '280 AC', '283 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaegar Targaryen'), (SELECT non_targaryen_id FROM non_targaryen WHERE full_name = 'Lyanna Stark'), '282 AC', '283 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen II'), (SELECT non_targaryen_id FROM non_targaryen WHERE full_name = 'Myriah Martell'), '170 AC', '209 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Viserys Targaryen II'), (SELECT non_targaryen_id FROM non_targaryen WHERE full_name = 'Larra Rogare'), '132 AC', '172 AC');


SELECT non_targaryen_id, name, full_name, birth_date, death_date
FROM non_targaryen
WHERE full_name IN ('Elia Martell', 'Lyanna Stark', 'Myriah Martell', 'Larra Rogare')
ORDER BY full_name;

DELETE FROM non_targaryen
WHERE non_targaryen_id IN (
    SELECT non_targaryen_id
    FROM (
        SELECT non_targaryen_id,
               ROW_NUMBER() OVER (PARTITION BY full_name ORDER BY non_targaryen_id) AS row_num
        FROM non_targaryen
    ) t
    WHERE row_num > 1
);

SELECT t.full_name AS targaryen, nt.full_name AS non_targaryen_spouse, tn.marriage_date, tn.end_date
FROM targaryen_non_targaryen_spouse tn
JOIN targaryen t ON tn.targaryen_id = t.character_id
JOIN non_targaryen nt ON tn.non_targaryen_id = nt.non_targaryen_id
ORDER BY t.full_name;

