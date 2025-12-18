INSERT INTO Departamento (nombre) VALUES
('Ingeniería'),
('Ciencias'),
('Administración');


INSERT INTO Profesor (nombre, id_departamento) VALUES
('Juan Carlos Pérez', 1),
('María Rodríguez', 2),
('Luis Alberto Gómez', 1);


INSERT INTO Estudiante (nombre, matricula) VALUES
('José Manuel Martínez', '2024-001'),
('Ana Carolina Peña', '2024-002'),
('Luis Miguel Santos', '2024-003');


INSERT INTO Curso (nombre, creditos) VALUES
('Base de Datos', 4),
('Programación I', 3);


INSERT INTO Clase (id_curso, id_profesor, horario) VALUES
(1, 1, 'Lunes 8:00 - 10:00'),
(2, 3, 'Miércoles 2:00 - 4:00');


INSERT INTO Inscripcion (id_estudiante, id_clase, fecha) VALUES
(1, 1, '2024-09-01'),
(2, 1, '2024-09-01'),
(3, 2, '2024-09-02');


INSERT INTO Calificacion (id_inscripcion, nota) VALUES
(1, 88.50),
(2, 92.00),
(3, 85.75);