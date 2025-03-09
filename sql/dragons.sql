ALTER TABLE dragon ADD CONSTRAINT unique_dragon_name UNIQUE (name);

INSERT INTO dragon (name, color, eye_color, fireball_color, birth_date, death_date)
VALUES
('Balerion', 'Black', 'Red', 'Red', 'Before 114 BC', '94 AC'),  -- ridden by Aegon I
('Vhagar', 'Green', 'Green', 'Orange', '52 BC', '130 AC'),     -- ridden by Visenya, later others
('Meraxes', 'Silver', 'Pale Gold', 'White', 'Before 4 BC', '10 AC'), -- ridden by Rhaenys
('Caraxes', 'Red', 'Red', 'Red', 'Before 72 AC', '130 AC'),    -- ridden by Daemon
('Meleys', 'Pink', 'Pale Pink', 'Red', 'Before 66 AC', '129 AC'), -- ridden by Rhaenys (daughter of Aemon)
('Syrax', 'Yellow', 'Yellow', 'Yellow', 'Before 100 AC', '130 AC'), -- ridden by Rhaenyra
('Vermax', 'Green', 'Green', 'Green', 'Before 114 AC', '130 AC'), -- ridden by Jacaerys
('Arrax', 'White', 'White', 'White', 'Before 115 AC', '129 AC'), -- ridden by Lucerys
('Tyraxes', 'Pale Blue', 'Pale Blue', 'Blue', 'Before 117 AC', '130 AC'), -- ridden by Joffrey
('Dreamfyre', 'Blue', 'Blue', 'Blue', 'Before 36 AC', '130 AC'), -- ridden by Helaena
('Sunfyre', 'Gold', 'Gold', 'Gold', 'Before 107 AC', '131 AC'), -- ridden by Aegon II
('Tessarion', 'Blue', 'Blue', 'Blue', 'Before 114 AC', '130 AC'), -- ridden by Daeron
('Moondancer', 'Pale Green', 'Pale Green', 'Green', 'Before 116 AC', '130 AC'), -- ridden by Baela
('Stormcloud', 'Grey', 'Grey', 'Grey', 'Before 120 AC', '131 AC'), -- ridden by Aegon III
('Shrykos', 'Green', 'Green', 'Green', 'Before 123 AC', '129 AC'), -- ridden by Jaehaerys (son of Aegon II)
('Morghul', 'Purple', 'Purple', 'Purple', 'Before 123 AC', '129 AC'), -- ridden by Jaehaera
('Drogon', 'Black', 'Red', 'Red', '298 AC', 'Alive'),           -- ridden by Daenerys
('Rhaegal', 'Green', 'Green', 'Green', '298 AC', 'Alive'),      -- ridden by Daenerys
('Viserion', 'Cream', 'Red', 'Red', '298 AC', 'Alive')          -- ridden by Daenerys
ON CONFLICT (name) DO NOTHING;


-- dragon rider
ALTER TABLE dragon_rider ADD CONSTRAINT unique_dragon_rider UNIQUE (targaryen_id, dragon_id);

INSERT INTO dragon_rider (targaryen_id, dragon_id, start_date, end_date)
VALUES
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen I'), (SELECT dragon_id FROM dragon WHERE name = 'Balerion'), '1 BC', '37 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Visenya Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Vhagar'), '1 BC', '44 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaenys Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Meraxes'), '1 BC', '10 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Daemon Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Caraxes'), '100 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaenys Targaryen (daughter of Aemon)'), (SELECT dragon_id FROM dragon WHERE name = 'Meleys'), '100 AC', '129 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Rhaenyra Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Syrax'), '113 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Jacaerys Velaryon'), (SELECT dragon_id FROM dragon WHERE name = 'Vermax'), '129 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Lucerys Velaryon'), (SELECT dragon_id FROM dragon WHERE name = 'Arrax'), '129 AC', '129 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Joffrey Velaryon'), (SELECT dragon_id FROM dragon WHERE name = 'Tyraxes'), '129 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Helaena Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Dreamfyre'), '129 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen II'), (SELECT dragon_id FROM dragon WHERE name = 'Sunfyre'), '129 AC', '131 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Daeron Targaryen (son of Viserys I)'), (SELECT dragon_id FROM dragon WHERE name = 'Tessarion'), '129 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Baela Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Moondancer'), '129 AC', '130 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Aegon Targaryen III'), (SELECT dragon_id FROM dragon WHERE name = 'Stormcloud'), '131 AC', '131 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaerys Targaryen (son of Aegon II)'), (SELECT dragon_id FROM dragon WHERE name = 'Shrykos'), '129 AC', '129 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Jaehaera Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Morghul'), '129 AC', '129 AC'),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Drogon'), '298 AC', 'Alive'),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Rhaegal'), '298 AC', 'Alive'),
((SELECT character_id FROM targaryen WHERE full_name = 'Daenerys Targaryen'), (SELECT dragon_id FROM dragon WHERE name = 'Viserion'), '298 AC', 'Alive')
ON CONFLICT (targaryen_id, dragon_id) DO NOTHING;