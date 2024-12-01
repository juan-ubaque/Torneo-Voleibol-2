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