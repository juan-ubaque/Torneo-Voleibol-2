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



