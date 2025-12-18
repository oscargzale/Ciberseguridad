-- Base de datos
USE universidad2;

-- 1. Seleccionar todos los estudiantes
SELECT * FROM Estudiante;

-- 2. Listar solo nombres y apellidos
SELECT Nombre, Apellido
FROM Estudiante;

-- 3. Filtrar estudiantes de un departamento
SELECT e.Nombre, e.Apellido
FROM Estudiante e
JOIN Departamento d ON e.DepartamentoID = d.DepartamentoID
WHERE d.Nombre = 'Ingeniería';

-- 4. Ordenar estudiantes por fecha de nacimiento (más viejos primero)
SELECT Nombre, Apellido, FechaNacimiento
FROM Estudiante
ORDER BY FechaNacimiento ASC;

-- 5. Contar cuántos estudiantes hay
SELECT COUNT(*) AS TotalEstudiantes
FROM Estudiante;

-- 6. Buscar estudiantes con apellido García
SELECT *
FROM Estudiante
WHERE Apellido = 'García';

-- 7. Nombres que empiezan con A
SELECT *
FROM Estudiante
WHERE Nombre LIKE 'A%';

-- 8. Estudiante y su departamento
SELECT e.Nombre, e.Apellido, d.Nombre AS Departamento
FROM Estudiante e
JOIN Departamento d ON e.DepartamentoID = d.DepartamentoID;

-- 9. Promedio de calificaciones por estudiante
SELECT e.Nombre, e.Apellido, AVG(c.Nota) AS Promedio
FROM Estudiante e
JOIN Inscripcion i ON e.EstudianteID = i.EstudianteID
JOIN Calificacion c ON i.InscripcionID = c.InscripcionID
GROUP BY e.EstudianteID;

-- 10. Cantidad de estudiantes por departamento
SELECT d.Nombre AS Departamento, COUNT(e.EstudianteID) AS Total
FROM Departamento d
JOIN Estudiante e ON d.DepartamentoID = e.DepartamentoID
GROUP BY d.DepartamentoID;

-- 11. Cursos impartidos por cada profesor
SELECT p.Nombre, p.Apellido, c.Nombre AS Curso
FROM Profesor p
JOIN Clase cl ON p.ProfesorID = cl.ProfesorID
JOIN Curso c ON cl.CursoID = c.CursoID;

-- 12. Estudiantes con promedio mayor a 9
SELECT e.Nombre, e.Apellido, AVG(c.Nota) AS Promedio
FROM Estudiante e
JOIN Inscripcion i ON e.EstudianteID = i.EstudianteID
JOIN Calificacion c ON i.InscripcionID = c.InscripcionID
GROUP BY e.EstudianteID
HAVING AVG(c.Nota) > 9;

-- 13. Top 5 estudiantes con mejores promedios
SELECT e.Nombre, e.Apellido, AVG(c.Nota) AS Promedio
FROM Estudiante e
JOIN Inscripcion i ON e.EstudianteID = i.EstudianteID
JOIN Calificacion c ON i.InscripcionID = c.InscripcionID
GROUP BY e.EstudianteID
ORDER BY Promedio DESC
LIMIT 5;
