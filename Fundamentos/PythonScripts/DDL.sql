-- SQL para CREAR/REEMPLAZAR la tabla `tbl_product_data`
-- Asegúrate de que el warehouse, la base de datos y el esquema sean los correctos
-- (WH_SMALL, workshop, bronze_mercadeo) y que tengas los permisos adecuados (ROLE_DEVELOPER).

USE WAREHOUSE WH_SMALL;
USE DATABASE workshop;
USE SCHEMA bronze_mercadeo;
USE ROLE ROLE_DEVELOPER; -- Asegúrate de usar el rol correcto

CREATE OR REPLACE TABLE bronze_mercadeo.tbl_product_data (
    name VARCHAR(255),
    description VARCHAR(1000)
);

-- Verificar que la tabla se creó (opcional)
-- SELECT * FROM bronze_mercadeo.tbl_product_data;

-- SQL para INSERTAR los datos en la tabla `tbl_product_data`
-- Generado con 100 productos sintéticos, agrupados en lotes de 10 por cada sentencia INSERT.

USE WAREHOUSE WH_SMALL;
USE DATABASE workshop;
USE SCHEMA bronze_mercadeo;
USE ROLE ROLE_DEVELOPER; -- Asegúrate de usar el rol correcto

INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Lámpara UltraConnect', 'Lámpara UltraConnect: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Cámara UltraConnect', 'Cámara UltraConnect: Navega y trabaja con fluidez incomparable. 💡'),
('Cámara Guardian', 'Cámara Guardian: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Teclado Evo', 'Teclado Evo: Voz clara y sin interrupciones. 🎤'),
('Tablet Lite', 'Tablet Lite: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Altavoz Guardian', 'Altavoz Guardian: Conexión estable y segura en cada rincón. 🛡️'),
('Lámpara Max', 'Lámpara Max: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Ratón Hyper', 'Ratón Hyper: Control absoluto con precisión milimétrica. 🎯'),
('Teclado Zen', 'Teclado Zen: Navega y trabaja con fluidez incomparable. 💡'),
('Teclado Elite', 'Teclado Elite: Control absoluto con precisión milimétrica. 🎯');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Auriculares Lite', 'Auriculares Lite: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Lámpara Quantum', 'Lámpara Quantum: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Lámpara Astro', 'Lámpara Astro: Transforma tu ambiente con millones de colores. ✨ ¡Crea el ambiente perfecto!'),
('Monitor Nova', 'Monitor Nova: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!'),
('Altavoz Vitality', 'Altavoz Vitality: Domina cada partida con teclas ultrasensibles. 🎮 ¡Tu victoria te espera!'),
('Tablet Astro', 'Tablet Astro: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Monitor Astro', 'Monitor Astro: Conexión estable y segura en cada rincón. 🛡️'),
('Drone Zen', 'Drone Zen: Navega y trabaja con fluidez incomparable. 💡'),
('Ratón Max', 'Ratón Max: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Lámpara Quantum', 'Lámpara Quantum: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Drone Guardian', 'Drone Guardian: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Lámpara Max', 'Lámpara Max: Conexión estable y segura en cada rincón. 🛡️'),
('Cámara Air', 'Cámara Air: Navega y trabaja con fluidez incomparable. 💡'),
('Auriculares Elite', 'Auriculares Elite: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Altavoz Quantum', 'Altavoz Quantum: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Micrófono Zen', 'Micrófono Zen: Control absoluto con precisión milimétrica. 🎯'),
('Altavoz Nova', 'Altavoz Nova: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Tablet Lite', 'Tablet Lite: Control absoluto con precisión milimétrica. 🎯'),
('Micrófono UltraConnect', 'Micrófono UltraConnect: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!'),
('Monitor Astro', 'Monitor Astro: Voz clara y sin interrupciones. 🎤');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Micrófono Astro', 'Micrófono Astro: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Cámara Nova', 'Cámara Nova: Audio inmersivo para cada aventura. 🚀'),
('Smartwatch Nova', 'Smartwatch Nova: Navega y trabaja con fluidez incomparable. 💡'),
('Micrófono Evo', 'Micrófono Evo: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Auriculares Lite', 'Auriculares Lite: Conexión estable y segura en cada rincón. 🛡️'),
('Lámpara Max', 'Lámpara Max: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Monitor Nova', 'Monitor Nova: Transforma tu ambiente con millones de colores. ✨ ¡Crea el ambiente perfecto!'),
('Cámara Zen', 'Cámara Zen: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!'),
('Altavoz Lite', 'Altavoz Lite: Control absoluto con precisión milimétrica. 🎯'),
('Smartwatch Pro-Gamer', 'Smartwatch Pro-Gamer: Imágenes nítidas y colores vibrantes. 🌈');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Micrófono Guardian', 'Micrófono Guardian: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!'),
('Monitor Lite', 'Monitor Lite: Sumérgete en un sonido cristalino. 🎧 ¡Libertad total!'),
('Cámara Nova', 'Cámara Nova: Domina cada partida con teclas ultrasensibles. 🎮 ¡Tu victoria te espera!'),
('Lámpara Astro', 'Lámpara Astro: Conexión estable y segura en cada rincón. 🛡️'),
('Teclado Elite', 'Teclado Elite: Navega y trabaja con fluidez incomparable. 💡'),
('Teclado Elite', 'Teclado Elite: Control absoluto con precisión milimétrica. 🎯'),
('Monitor Hyper', 'Monitor Hyper: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Lámpara Elite', 'Lámpara Elite: Sumérgete en un sonido cristalino. 🎧 ¡Libertad total!'),
('Hub Quantum', 'Hub Quantum: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!'),
('Cámara UltraConnect', 'Cámara UltraConnect: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Smartwatch Vitality', 'Smartwatch Vitality: Sumérgete en un sonido cristalino. 🎧 ¡Libertad total!'),
('Altavoz Guardian', 'Altavoz Guardian: Control absoluto con precisión milimétrica. 🎯'),
('Micrófono Quantum', 'Micrófono Quantum: Audio inmersivo para cada aventura. 🚀'),
('Teclado Vitality', 'Teclado Vitality: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Hub Astro', 'Hub Astro: Domina cada partida con teclas ultrasensibles. 🎮 ¡Tu victoria te espera!'),
('Altavoz GlowUp', 'Altavoz GlowUp: Imágenes nítidas y colores vibrantes. 🌈'),
('Monitor UltraConnect', 'Monitor UltraConnect: Voz clara y sin interrupciones. 🎤'),
('Smartwatch Elite', 'Smartwatch Elite: Sumérgete en un sonido cristalino. 🎧 ¡Libertad total!'),
('Router Air', 'Router Air: Conexión estable y segura en cada rincón. 🛡️'),
('Teclado Astro', 'Teclado Astro: Domina cada partida con teclas ultrasensibles. 🎮 ¡Tu victoria te espera!');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Cámara UltraConnect', 'Cámara UltraConnect: Navega y trabaja con fluidez incomparable. 💡'),
('Tablet Guardian', 'Tablet Guardian: Transforma tu ambiente con millones de colores. ✨ ¡Crea el ambiente perfecto!'),
('Drone Pro-Gamer', 'Drone Pro-Gamer: Navega y trabaja con fluidez incomparable. 💡'),
('Lámpara Max', 'Lámpara Max: Transforma tu ambiente con millones de colores. ✨ ¡Crea el ambiente perfecto!'),
('Monitor Astro', 'Monitor Astro: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Cámara Quantum', 'Cámara Quantum: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Lámpara Nova', 'Lámpara Nova: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Altavoz Astro', 'Altavoz Astro: Conexión estable y segura en cada rincón. 🛡️'),
('Teclado Hyper', 'Teclado Hyper: Voz clara y sin interrupciones. 🎤'),
('Smartwatch Pro-Gamer', 'Smartwatch Pro-Gamer: Conexión estable y segura en cada rincón. 🛡️');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Smartwatch GlowUp', 'Smartwatch GlowUp: Conexión estable y segura en cada rincón. 🛡️'),
('Monitor Quantum', 'Monitor Quantum: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Auriculares Evo', 'Auriculares Evo: Conexión estable y segura en cada rincón. 🛡️'),
('Teclado Evo', 'Teclado Evo: Audio inmersivo para cada aventura. 🚀'),
('Monitor Quantum', 'Monitor Quantum: Voz clara y sin interrupciones. 🎤'),
('Monitor Max', 'Monitor Max: Imágenes nítidas y colores vibrantes. 🌈'),
('Hub Nova', 'Hub Nova: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Micrófono Evo', 'Micrófono Evo: Navega y trabaja con fluidez incomparable. 💡'),
('Micrófono Astro', 'Micrófono Astro: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Drone Air', 'Drone Air: Imágenes nítidas y colores vibrantes. 🌈');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Micrófono Pro-Gamer', 'Micrófono Pro-Gamer: Voz clara y sin interrupciones. 🎤'),
('Hub UltraConnect', 'Hub UltraConnect: Control absoluto con precisión milimétrica. 🎯'),
('Auriculares Lite', 'Auriculares Lite: Imágenes nítidas y colores vibrantes. 🌈'),
('Altavoz Guardian', 'Altavoz Guardian: Sonido potente en la palma de tu mano. 🎉 ¡Lleva la fiesta a todas partes!'),
('Smartwatch Nova', 'Smartwatch Nova: Navega y trabaja con fluidez incomparable. 💡'),
('Altavoz Max', 'Altavoz Max: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Monitor Astro', 'Monitor Astro: Navega y trabaja con fluidez incomparable. 💡'),
('Tablet Vitality', 'Tablet Vitality: Conexión estable y segura en cada rincón. 🛡️'),
('Router Astro', 'Router Astro: Protege tu hogar con visión nocturna. 🏠 ¡Tranquilidad 24/7 en tu bolsillo!'),
('Monitor Max', 'Monitor Max: Control absoluto con precisión milimétrica. 🎯');
INSERT INTO workshop.bronze_mercadeo.tbl_product_data (name, description) VALUES 
('Monitor Vitality', 'Monitor Vitality: Tu entrenador personal en la muñeca. 💪 ¡Mantente activo y conectado!'),
('Auriculares UltraConnect', 'Auriculares UltraConnect: Sumérgete en un sonido cristalino. 🎧 ¡Libertad total!'),
('Router Vitality', 'Router Vitality: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Router Guardian', 'Router Guardian: Navega y trabaja con fluidez incomparable. 💡'),
('Teclado Nova', 'Teclado Nova: Control absoluto con precisión milimétrica. 🎯'),
('Smartwatch UltraConnect', 'Smartwatch UltraConnect: Navega y trabaja con fluidez incomparable. 💡'),
('Router UltraConnect', 'Router UltraConnect: Sumérgete en un sonido cristalino. 🎧 ¡Libertad total!'),
('Auriculares Max', 'Auriculares Max: Conexión estable y segura en cada rincón. 🛡️'),
('Router Zen', 'Router Zen: Expande tu conectividad al instante. 🔌 ¡Todo al alcance de tu mano!'),
('Smartwatch Zen', 'Smartwatch Zen: Domina cada partida con teclas ultrasensibles. 🎮 ¡Tu victoria te espera!');

-- Fin de las sentencias SQL

SELECT * FROM workshop.bronze_mercadeo.tbl_product_data;
