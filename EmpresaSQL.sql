Create Database  EmpresaSQLA;
go

User EmpresaSQLA

go

Create Table TDepartamento (
nDepartamentoID Int Identity(1,1) Not Null,
    cNombreDepartamento Varchar(100) Not Null, 
    Constraint PK_TDepartamento Primary Key (nDepartamentoID),
    Constraint UQ_TDepartamento_cNombre Unique (cNombreDepartamento)
);
go

Create Table TCargo (
    nCargoID Int Identity(1,1) Not Null, 
    cNombreCargo Varchar(100) Not Null, 
    Constraint PK_TCargo Primary Key (nCargoID),
    Constraint UQ_TCargo_cNombre Unique (cNombreCargo)
);
go

Create Table TEmpleado (
    nEmpleadoID Int Identity(1,1) Not Null,
    cNIF Varchar(20) Not Null,
    cNombre Varchar(100) Not Null,
    cApellido Varchar(100) Not Null, 
    nDepartamentoID Int Not Null,
    nCargoID Int Not Null, 
    dFechaContratacion Date Not Null Constraint DF_TEmpleado_dFechaContratacion Default Getdate(), 
    nSalario Decimal(18,2) Not Null, 
    Constraint PK_TEmpleado Primary Key (nEmpleadoID),
    Constraint UQ_TEmpleado_cNIF Unique (cNIF),
    Constraint CK_TEmpleado_nSalario Check (nSalario > 300), 
    Constraint FK_TEmpleado_TDepartamento Foreign Key (nDepartamentoID) References TDepartamento(nDepartamentoID), 
    Constraint FK_TEmpleado_TCargo Foreign Key (nCargoID) References TCargo(nCargoID) 
);
go
Create Table TProyecto (
    nProyectoID Int Identity(1,1) Not Null, 
    cNombreProyecto Varchar(150) Not Null, 
    dFechaInicio Date Not Null, 
    dFechaFinalizacion Date Null,
    Constraint PK_TProyecto Primary Key (nProyectoID)
    );
go

Create Table TEmpleadoProyecto (
    nEmpleadoID Int Not Null,
    nProyectoID Int Not Null,
    Constraint PK_TEmpleadoProyecto Primary Key (nEmpleadoID, nProyectoID),
    Constraint FK_TEmpleadoProyecto_TEmpleado Foreign Key (nEmpleadoID) References TEmpleado(nEmpleadoID),
    Constraint FK_TEmpleadoProyecto_TProyecto Foreign Key (nProyectoID) References TProyecto(nProyectoID)
);
Go
Use EmpresaSQL;
Go

--  agregar columna cemail y columna ctelefono.
Alter Table TEmpleado Add 
    cEmail Varchar(150) Null,
    cTelefono Varchar(15) Null;
Go

--  modificar longitud de cnombre a 100 caracteres.
--  modificar longitud de capellido a 100 caracteres.
Alter Table TEmpleado Alter Column cNombre Varchar(100) Not Null;
Alter Table TEmpleado Alter Column cApellido Varchar(100) Not Null;
Go

--agregar columna cdireccion.
Alter Table TEmpleado Add cDireccion Varchar(255) Null;
Go

--agregar columna nedad.
Alter Table TEmpleado Add nEdad Int Null;
Go

--crear restricción check para edades entre 18 y 65 años.
Alter Table TEmpleado Add Constraint CK_TEmpleado_nEdad Check (nEdad Between 18 And 65);
Go

--agregar restricción unique al correo electrónico.
Alter Table TEmpleado Add Constraint UQ_TEmpleado_cEmail Unique (cEmail);
Go

--agregar columna bactivo tipo bit con valor por defecto 1.
Alter Table TEmpleado Add bActivo Bit Not Null Constraint DF_TEmpleado_bActivo Default 1;
Go

-- eliminar la columna cdireccion.
Alter Table TEmpleado Drop Column cDireccion;
Go

-- cambiar el tipo de dato de teléfono a varchar(20).
Alter Table TEmpleado Alter Column cTelefono Varchar(20) Null;
Go

-- agregar columna cgenero.
Alter Table TEmpleado Add cGenero Char(1) Null;
Go

--agregar restricción check para que el género solo permita m o f.
Alter Table TEmpleado Add Constraint CK_TEmpleado_cGenero Check (cGenero In ('M', 'F'));
Go

--agregar columna dfechanacimiento.
Alter Table TEmpleado Add dFechaNacimiento Date Null;
Go

Create Table TSucursal (
    nSucursalID Int Identity(1,1) Not Null,
    cNombreSucursal Varchar(100) Not Null,
    Constraint PK_TSucursal Primary Key (nSucursalID)
);
Go
--  insertar 5 departamentos diferentes.
Insert Into TDepartamento (cNombreDepartamento) Values 
('Tecnología'), ('Recursos Humanos'), ('Finanzas'), ('Marketing'), ('Operaciones');
Go

-- 32. insertar 5 cargos diferentes.
Insert Into TCargo (cNombreCargo) Values 
('Desarrollador Senior'), ('Analista de RRHH'), ('Contador'), ('Especialista SEO'), ('Gerente de Operaciones');
Go

-- 33. insertar 10 empleados (considerando las columnas agregadas en la parte ii).
Insert Into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, cTelefono, nEdad, bActivo, cGenero, dFechaNacimiento) Values
('11111111A', 'Carlos', 'Gómez', 1, 1, '2026-01-15', 1500.00, 'carlos.gomez@empresa.com', '555-0011', 30, 1, 'M', '1996-05-12'),
('22222222B', 'Ana', 'Martínez', 2, 2, '2025-03-20', 1200.00, 'ana.martinez@empresa.com', '555-0022', 28, 1, 'F', '1998-08-24'),
('33333333C', 'Luis', 'Rodríguez', 3, 3, '2024-06-10', 1400.00, 'luis.rodriguez@empresa.com', '555-0033', 45, 1, 'M', '1981-11-02'),
('44444444D', 'María', 'García', 4, 4, '2026-02-01', 1100.00, 'maria.garcia@empresa.com', '555-0044', 32, 1, 'F', '1994-04-15'),
('55555555E', 'Jorge', 'López', 5, 5, '2023-09-05', 2000.00, 'jorge.lopez@empresa.com', '555-0055', 50, 1, 'M', '1976-12-20'),
('66666666F', 'Elena', 'Fernández', 1, 1, '2026-05-18', 1600.00, 'elena.fernandez@empresa.com', '555-0066', 26, 1, 'F', '2000-01-30'),
('77777777G', 'Pedro', 'Sánchez', 1, 1, '2026-01-10', 450.00, 'pedro.sanchez@empresa.com', '555-0077', 35, 1, 'M', '1991-07-08'),
('88888888H', 'Lucía', 'Pérez', 2, 2, '2024-11-12', 1250.00, 'lucia.perez@empresa.com', '555-0088', 23, 1, 'F', '2003-10-05'),
('99999999I', 'Miguel', 'Gutiérrez', 3, 3, '2025-07-25', 1350.00, 'miguel.gutierrez@empresa.com', '555-0099', 40, 1, 'M', '1986-03-14'),
('00000000J', 'Sofía', 'Castro', 4, 4, '2026-02-28', 480.00, 'sofia.castro@empresa.com', '555-0100', 29, 0, 'F', '1997-02-21');
Go

-- 34. insertar 3 proyectos.
Insert Into TProyecto (cNombreProyecto, dFechaInicio, dFechaFinalizacion) Values
('Migración Cloud', '2026-01-01', '2026-12-31'),
('Optimización Web', '2026-03-15', Null),
('Auditoría Financiera', '2026-05-01', '2026-09-30');
Go

-- 35. asignar empleados a proyectos.
Insert Into TEmpleadoProyecto (nEmpleadoID, nProyectoID) Values
(1, 1), (1, 2), (6, 1), (6, 2), (7, 1), (3, 3), (9, 3);
Go

-- 36. insertar un empleado utilizando el valor por defecto de fecha.
Insert Into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, bActivo, cGenero) Values
('12345678X', 'Roberto', 'Díaz', 1, 1, 1550.00, 'roberto.diaz@empresa.com', 34, 1, 'M');
Go

-- 38. insertar un empleado sin indicar estado activo (tomará default 1).
Insert Into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, dFechaContratacion, nSalario, cEmail, nEdad, cGenero) Values
('56781234Z', 'Manuel', 'Ruiz', 2, 2, '2026-05-01', 1150.00, 'manuel.ruiz@empresa.com', 41, 'M');
Go

-- 39. insertar registros usando múltiples values.
Insert Into TDepartamento (cNombreDepartamento) Values
('Investigación y Desarrollo'), ('Logística');
Go

41. incrementar en 10% el salario de todos los empleados.
Update TEmpleado Set nSalario = nSalario * 1.10;
Go

-- 42. incrementar en 20% el salario de los empleados de un departamento específico (ej: tecnología id=1).
Update TEmpleado Set nSalario = nSalario * 1.20 Where nDepartamentoID = 1;
Go

-- 43. actualizar el correo electrónico de un empleado.
Update TEmpleado Set cEmail = 'carlos.gomez.nuevo@empresa.com' Where cNIF = '11111111A';
Go

-- 44. modificar el cargo de un empleado.
Update TEmpleado Set nCargoID = 5 Where nEmpleadoID = 1;
Go

-- 45. cambiar el departamento de dos empleados.
Update TEmpleado Set nDepartamentoID = 3 Where nEmpleadoID In (2, 4);
Go

-- 46. marcar como inactivos a los empleados con salario inferior a 500.
Update TEmpleado Set bActivo = 0 Where nSalario < 500;
Go

-- 47. actualizar la fecha de finalización de un proyecto.
Update TProyecto Set dFechaFinalizacion = '2026-07-31' Where nProyectoID = 2;
Go

-- 48. asignar un nuevo proyecto a un empleado.
Insert Into TEmpleadoProyecto (nEmpleadoID, nProyectoID) Values (3, 2);
Go








