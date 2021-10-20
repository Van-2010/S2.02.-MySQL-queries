-- 1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El 
-- llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom 
-- i nom.
SELECT p.nombre, p.apellido1,p.apellido2 FROM persona p WHERE p.tipo ='alumno' ORDER BY apellido1 DESC,apellido2 DESC, nombre DESC;
-- 2.Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de 
-- telèfon en la base de dades.
SELECT p.nombre, p.apellido1,p.apellido2,p.telefono FROM persona p WHERE telefono IS NULL ORDER BY apellido1 DESC,apellido2 DESC, nombre DESC;
-- 3.Retorna el llistat dels alumnes que van néixer en 1999.
SELECT p.nombre,p.apellido1,p.apellido2,fecha_nacimiento FROM persona p WHERE fecha_nacimiento LIKE '%1999%'ORDER BY apellido1 DESC,apellido2 DESC, nombre DESC;
-- 4.Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en 
-- la base de dades i a més la seva nif acaba en K.
SELECT*FROM persona WHERE telefono IS NULL AND tipo LIKE 'profesor'AND nif LIKE '%K%';
-- 5.Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, 
-- en el tercer curs del grau que té l'identificador 7.
SELECT id,nombre, cuatrimestre,id_grado FROM asignatura WHERE cuatrimestre=1 AND id_grado=7;
-- 6.Retorna un llistat dels professors juntament amb el nom del departament al qual estan 
-- vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i 
-- nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms 
-- i el nom.
SELECT apellido1, apellido2, persona.nombre AS nombre_profesor, departamento.nombre FROM persona INNER JOIN profesor ON profesor.id_profesor=persona.id INNER JOIN departamento ON profesor.id_departamento=departamento.id;
-- 7.Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs 
-- escolar de l'alumne amb nif 26902806M.
SELECT p.nombre,a.nombre,p.nif,c.anyo_inicio,c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura  am ON p.id=am.id_alumno JOIN asignatura a ON a.id=am.id_asignatura JOIN curso_escolar c ON c.id=am.id_curso_escolar WHERE p.nif LIKE '26902806M';
-- 8.Retorna un llistat amb el nom de tots els departaments que tenen professors que 
-- imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT d.nombre, a.nombre, p.id_profesor, pe.nombre FROM asignatura a JOIN profesor p ON a.id_profesor=p.id_profesor JOIN persona pe ON pe.id=p.id_profesor JOIN grado g ON g.id=a.id_grado JOIN departamento d ON d.id=p.id_departamento WHERE g.nombre LIKE 'Grado en Ingeniería Informática (Plan 2015)';
-- 9.Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura 
-- durant el curs escolar 2018/2019.
SELECT p.nombre,a.nombre,p.nif,c.anyo_inicio,c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura  am ON p.id=am.id_alumno JOIN asignatura a ON a.id=am.id_asignatura JOIN curso_escolar c ON c.id=am.id_curso_escolar WHERE c.id LIKE '5';

-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN--

-- 1.Retorna un llistat amb els noms de tots els professors i els departaments que tenen 
-- vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament 
-- associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, 
-- segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major 
-- pel nom del departament, cognoms i el nom.
SELECT d.nombre AS nombre_departamento,apellido1, apellido2, pe.nombre AS nombre_profesor FROM profesor p LEFT JOIN persona pe ON pe.id=p.id_profesor LEFT JOIN departamento d ON d.id=p.id_departamento ORDER BY d.nombre DESC,pe.apellido1 DESC,pe.apellido2 DESC;
-- 2.Retorna un llistat amb els professors que no estan associats a un departament
-- 3.Retorna un llistat amb els departaments que no tenen professors associats.
-- 4.Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT apellido1, apellido2, pe.nombre AS nombre_profesor,a.nombre AS nom_asignatura, a.id_profesor FROM persona pe JOIN profesor p ON pe.id=p.id_profesor LEFT JOIN asignatura a ON a.id_profesor=p.id_profesor WHERE a.id_profesor IS NULL;
-- 5.Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT apellido1, apellido2, pe.nombre AS nombre_profesor,a.nombre AS nom_asignatura, a.id_profesor FROM asignatura a LEFT JOIN persona pe ON  a.id_profesor=pe.id WHERE a.id_profesor IS NULL;
-- 6.Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre AS nombre_departamento,a.nombre AS nombre_asignatura,c.id FROM asignatura a LEFT JOIN curso_escolar c ON a.curso=c.id JOIN profesor p ON  a.id_profesor=p.id_profesor JOIN departamento d ON p.id_profesor=d.id WHERE a.id_profesor IS NULL;
-- Consultes resum:
-- 1.Retorna el nombre total d'alumnes que hi ha.
SELECT persona.tipo, COUNT(*) FROM persona WHERE persona.tipo='alumno';
-- 2.Calcula quants alumnes van néixer en 1999.
SELECT persona.nombre,persona.fecha_nacimiento,COUNT(*)FROM persona WHERE persona.tipo='alumno' AND persona.fecha_nacimiento LIKE '%1999%';
-- 3.Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar 
-- dues columnes, una amb el nom del departament i una altra amb el nombre de professors 
-- que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen 
-- professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
SELECT COUNT(profesor.id_departamento) AS total,departamento.nombre FROM departamento INNER JOIN profesor ON profesor.id_departamento=departamento.id GROUP BY departamento.nombre ORDER BY total DESC;
-- 4.Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en 
-- cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors 
-- associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT COUNT(profesor.id_departamento) AS total,departamento.nombre FROM departamento LEFT JOIN profesor ON profesor.id_departamento=departamento.id GROUP BY departamento.nombre ORDER BY total DESC;
-- 5.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el 
-- nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no 
-- tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre, COUNT(asignatura.id_grado) AS total_asignatures FROM asignatura RIGHT JOIN grado ON(asignatura.id_grado=grado.id) GROUP BY grado.nombre ORDER BY total_asignatures DESC;
-- 6.Retorna un llistat amb el nom de tots els graus existents en la base de dades i 
-- el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures 
-- associades.
SELECT grado.nombre, COUNT(asignatura.id_grado) AS total_asignatures FROM asignatura JOIN grado ON(asignatura.id_grado=grado.id)GROUP BY grado.nombre HAVING COUNT(asignatura.id_grado)>40;
-- 7.Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits 
-- que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del 
-- grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha 
-- d'aquest tipus.
SELECT grado.nombre,asignatura.tipo, SUM(asignatura.creditos) AS total_creditos FROM asignatura RIGHT JOIN grado ON(asignatura.id_grado=grado.id) GROUP BY grado.nombre,asignatura.tipo;
-- 8.Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura 
-- en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, 
-- una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes 
-- matriculats.
SELECT asignatura.nombre,COUNT(alumno_se_matricula_asignatura.id_alumno) AS numero_alumnos,curso_escolar.anyo_inicio FROM alumno_se_matricula_asignatura JOIN asignatura ON (asignatura.id=alumno_se_matricula_asignatura.id_asignatura) RIGHT JOIN curso_escolar ON (asignatura.id=curso_escolar.id) GROUP BY asignatura.nombre;
-- 9.Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. 
-- El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. 
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre 
-- d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT asignatura.id_profesor, persona.nombre,persona.apellido1, persona.apellido2, COUNT(asignatura.id_profesor)AS total_asignaturas FROM persona LEFT  JOIN asignatura ON(persona.id=asignatura.id_profesor) GROUP BY(persona.nombre)ORDER BY total_asignaturas DESC;
-- 10.Retorna totes les dades de l'alumne més jove.
SELECT*FROM persona INNER JOIN(SELECT MAX(fecha_nacimiento) AS mas_joven FROM persona) EDAD_MINIMA  ON (persona.fecha_nacimiento) = EDAD_MINIMA.EDAD;
-- 11.Retorna un llistat amb els professors que tenen un departament associat i que no 
-- imparteixen cap assignatura.
SELECT d.nombre AS nombre_departamento,apellido1, apellido2, pe.nombre AS nombre_profesor FROM profesor LEFT JOIN persona pe ON pe.id=p.id_profesor LEFT JOIN departamento d ON d.id=p.id_departamento LEFT JOIN asignatura ON asignatura.id_profesor=p.id_profesor WHERE asignatura.id_profesor IS NULL
