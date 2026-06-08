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





