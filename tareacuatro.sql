BEGIN;
SAVEPOINT checkpoint;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (1, NOW());
UPDATE producto SET stock = stock - 5 WHERE id = 9;
ROLLBACK TO SAVEPOINT checkpoint;
COMMIT;
SELECT id, stock FROM producto WHERE descripcion = 'producto9';

-- Identificar id y consultar de producto1, producto2 y producto8

SELECT id, stock FROM producto WHERE descripcion = 'producto1';
SELECT id, stock FROM producto WHERE descripcion = 'producto2';
SELECT id, stock FROM producto WHERE descripcion = 'producto8';

--Ingresando transacciones

BEGIN;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (2, NOW());
UPDATE producto SET stock = stock - 3 WHERE id = 1;
SAVEPOINT checkpoint;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (2, NOW());
UPDATE producto SET stock = stock - 3 WHERE id = 2;
SAVEPOINT checkpoint;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (2, NOW());
UPDATE producto SET stock = stock - 3 WHERE id = 8;
ROLLBACK TO SAVEPOINT checkpoint;
COMMIT;

--Chequear si el stock fue descontado

SELECT stock FROM producto WHERE id = 1;
SELECT stock FROM producto WHERE id = 2;
SELECT stock FROM producto WHERE id = 8;

\echo :AUTOCOMMIT

\set AUTOCOMMIT off

\echo :AUTOCOMMIT

BEGIN;
    SAVEPOINT add_client;
    INSERT INTO cliente (nombre,email)
    VALUES ('Pedro', usuario11@gmail.com);
    SELECT * FROM cliente WHERE id = 11;
    ROLLBACK to SAVEPOINT add_client;
    SELECT * FROM cliente WHERE id = 11;
COMMIT;


\set AUTOCOMMIT on

\echo :AUTOCOMMIT