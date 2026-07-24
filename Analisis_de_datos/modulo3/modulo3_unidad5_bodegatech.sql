-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Manuela Caro Villada
-- Fecha: 23/07/2026
-- ══════════════════════════════════════════
USE BodegaTech;

-- ── SECCIÓN DDL ──────────────────────────
DROP TABLE IF EXISTS inventario;

CREATE TABLE inventario (
	id_producto INT PRIMARY KEY IDENTITY(1,1),
	nombre_producto VARCHAR(100) NOT NULL,
	categoria VARCHAR(100) NOT NULL,
	precio_unitario DECIMAL(10,2) NOT NULL,
	stock_actual INT NOT NULL, -- int porque es un numero
	stock_minimo INT NOT NULL,
	fecha_ingreso DATE NOT NULL, --Es date porque la idea es guardarlos como fecha
	activo TINYINT NOT NULL
);

-- ── SECCIÓN DML ──────────────────────────
INSERT INTO inventario(nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES 
    ('Laptop Pro 15','Computacion',1200.00,15,3,'2024-01-10',1),
    ('Mouse Inalambrico','Accesorios',28.00,80,10,'2024-01-10',1),
    ('Monitor 4K 27"','Computacion',450.00,12,2,'2024-01-15',1),
    ('Teclado Mecanico','Accesorios',95.00,40,5,'2024-01-15',1),
    ('Laptop Basic 14','Computacion',650.00,20,3,'2024-02-01',1),
    ('Auriculares BT Pro','Audio',120.00,35,5,'2024-02-01',1),
    ('Hub USB-C 7 puertos','Accesorios',45.00,60,10,'2024-02-10',1),
    ('Webcam HD 1080p','Accesorios',85.00,25,5,'2024-02-10',1),
    ('SSD Externo 1TB','Almacenamiento',130.00,18,3,'2024-03-01',1),
    ('Parlante Bluetooth','Audio',60.00,45,8,'2024-03-01',1);

SELECT * FROM inventario;

UPDATE inventario SET stock_actual = 3 
WHERE id = 1;

UPDATE inventario SET stock_actual = 12 
WHERE id = 2;

UPDATE inventario SET stock_actual = 5 
WHERE id = 6;

UPDATE inventario SET activo = 0 
WHERE id_producto = 8;

SELECT * FROM inventario;

