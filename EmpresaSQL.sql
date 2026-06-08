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





