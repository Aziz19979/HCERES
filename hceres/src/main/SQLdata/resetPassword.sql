-- changer l'id du researcher id pour un researcher existant

-- username = admin
-- password = admin
update researcher
set researcher_login = 'admin', researcher_password = '$2a$10$tR4NMaRiVG.QZdXoCsmEUuDltA7Siy0kisCbUwT3p3P3s9wQWdySi'
where researcher_id = 3;

-- username = user
-- password = user
update researcher
set researcher_login = 'user', researcher_password = '$2a$10$nbNEAKss3/jeNdOPfCqel.cLltnDIfE15jpGFEo7rZw1aY/5nAbzi'
where researcher_id = 4;