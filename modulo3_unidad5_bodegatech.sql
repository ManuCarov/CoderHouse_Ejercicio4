-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Manuela Caro Villada
-- Fecha: 23/07/2026
-- ══════════════════════════════════════════
USE BodegaTech;

-- ── SECCIÓN DDL ──────────────────────────
DROP TABLE IF EXISTS inventario;

CREATE TABLE inventario (
    -- Clave primaria autoincremental: INT soporta hasta ~2.100 millones de registros,
    -- suficiente para el crecimiento esperado del inventario. IDENTITY(1,1) evita 
    -- errores humanos al asignar IDs manualmente y garantiza unicidad.
    id_producto INT PRIMARY KEY IDENTITY(1,1),

    -- VARCHAR(100) porque los nombres de producto tienen longitud variable;
    -- se eligió 100 caracteres para cubrir descripciones comerciales largas
    -- sin desperdiciar espacio como haría un CHAR de longitud fija.
    nombre_producto VARCHAR(100) NOT NULL,

    -- VARCHAR(100) para permitir categorías descriptivas. En una versión más 
    -- normalizada convendría reemplazarlo por un id_categoria (FK) a otra tabla.
    categoria VARCHAR(100) NOT NULL,

    -- DECIMAL(10,2) es el tipo correcto para dinero: evita errores de redondeo
    -- propios de FLOAT/REAL. Permite hasta 99.999.999,99 con precisión exacta.
    precio_unitario DECIMAL(10,2) NOT NULL,

    -- INT porque el stock es un conteo entero (no admite decimales). 
    -- Se usa INT en lugar de SMALLINT para permitir inventarios grandes.
    stock_actual INT NOT NULL,

    -- INT por la misma razón que stock_actual; representa el umbral mínimo 
    -- antes de generar una alerta de reposición.
    stock_minimo INT NOT NULL,

    -- DATE (no DATETIME) porque solo interesa la fecha del ingreso, no la hora.
    -- Ocupa menos espacio (3 bytes vs 8) y evita comparaciones erróneas por horas.
    fecha_ingreso DATE NOT NULL,

    -- BIT es el tipo booleano de SQL Server: solo admite 0 o 1. Más eficiente 
    -- y semánticamente correcto que TINYINT para representar activo/inactivo.
    activo BIT NOT NULL
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

-- ── ACTUALIZACIONES CON OPERACIONES ARITMÉTICAS ──
-- Nota: se usa (stock_actual = stock_actual - N) en lugar de asignar un valor fijo.
-- Diferencia clave: la asignación directa (stock_actual = 3) sobrescribe el dato 
-- sin importar cuál sea el valor actual, lo que puede causar inconsistencias si 
-- el stock cambió entre consultas. La resta calculada (stock_actual = stock_actual - 12)
-- descuenta a partir del valor real en la base en ese momento, reflejando 
-- correctamente movimientos como ventas o salidas de bodega.

-- Venta de 12 Laptop Pro 15 (de 15 → 3)
UPDATE inventario SET stock_actual = stock_actual - 12 
WHERE id_producto = 1;

-- Venta de 68 Mouse Inalambrico (de 80 → 12)
UPDATE inventario SET stock_actual = stock_actual - 68 
WHERE id_producto = 2;

-- Venta de 30 Auriculares BT Pro (de 35 → 5)
UPDATE inventario SET stock_actual = stock_actual - 30 
WHERE id_producto = 6;

-- Desactivación de Webcam HD 1080p (cambio de estado, no de stock)
UPDATE inventario SET activo = 0 
WHERE id_producto = 8;

SELECT * FROM inventario;