--Comandos para configurar la replicación en MongoDB
--1. Crear directorios para los nodos
md c:\mongodb\repset\rs1
md c:\mongodb\repset\rs2
md c:\mongodb\repset\rs3

--2. Crear los nodos

start mongod --bind_ip localhost --dbpath c:\mongodb\repset\rs1 --port 20001 --replSet myrs
start mongod --bind_ip localhost --dbpath c:\mongodb\repset\rs2 --port 20002 --replSet myrs
start mongod --bind_ip localhost --dbpath c:\mongodb\repset\rs3 --port 20003 --replSet myrs

--3. Conectarse al nodo principal
rs.initiate()

--4. Agregar los nodos secundarios
rs.add("localhost:20002")
rs.add("localhost:20003")

--5. Verificar el estado de la replicación
mongosh  --port 20001

rs.status()

--6. Crear una base de datos y una colección
db.equipos.insertOne({ "nombre": "Tiburones", "entrenador": { "nombre": "Carlos Pérez" } })
db.equipos.insertOne({ "nombre": "Aguilas", "entrenador": { "nombre": "Andres Torres" } })

--7. Verificar que los datos se han replicado
db.equipos.find()

--8. Agregar un nuevo nodo
start mongod --bind_ip localhost --dbpath c:\mongodb\repset\rs3 --port 20004 --replSet myrs
rs.add("localhost:20004"); // Esto agrega un nuevo nodo en el puerto 20004
  
--9. Verificar el estado de la replicación
mongosh  --port 20001

rs.status();


--10. Detener un nodo
use admin
db.shutdownServer()

--11. Verificar el estado de la replicación

mongosh  --port 20002

rs.status();

--10. Detener un nodo
use admin
db.shutdownServer()

--11. Verificar el estado de la replicación

mongosh  --port 20002

rs.status();

--12. Eliminar un nodo

rs.remove("localhost:20003")

--13. Verificar el estado de la replicación


mongosh  --port 20001

rs.status();

--14. Detener los nodos

use admin

db.shutdownServer()

--15. Eliminar los directorios

rd /s /q c:\mongodb\repset\rs1

rd /s /q c:\mongodb\repset\rs2

rd /s /q c:\mongodb\repset\rs3

// Caso de Prueba 1: Verificar la distribución de datos entre shards
db.equipos.getShardDistribution()
sh.splitAt("evento_deportivo.equipos", { "nombre": "M" });


// Caso de Prueba 2: Validar el rendimiento de consultas
db.equipos.find({ "nombre": "Águilas" }).

// Caso de Prueba 3: Verificar alta disponibilidad tras la caída de un shard
db.equipos.find()


// Caso de Prueba 4: Validar el balanceo automático
sh.status()



