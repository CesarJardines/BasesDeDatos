USE Master;
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'TaqueroMucho')
BEGIN
DROP DATABASE TaqueroMucho
END;
GO

--Creamos la base
CREATE DATABASE TaqueroMucho
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaqueroMucho', 
FILENAME = N'C:\Bases\fundamentos\TaqueroMucho.mdf' , 
SIZE = 10240KB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 50%)
 LOG ON 
( NAME = N'TaqueroMucho_log', 
FILENAME = N'C:\Bases\fundamentos\TaqueroMucho_log.ldf' , 
SIZE = 2048KB , 
MAXSIZE = 102400KB , 
FILEGROWTH = 2048KB )
PRINT N'Base de datos creada correctamente';

--CREAMOS TABLAS DE LA BASE DE DATOS
SET DATEFORMAT dmy
USE TaqueroMucho;

--Eliminar tablar si es que existen
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Bono') )
	DROP TABLE "dbo"."Bono"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Nomina') )
	DROP TABLE "dbo"."Nomina"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ControlDePago') )
	DROP TABLE "dbo"."ControlDePago"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Taquero') )
	DROP TABLE "dbo"."Taquero"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Mesero') )
	DROP TABLE "dbo"."Mesero"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Cajero') )
	DROP TABLE "dbo"."Cajero"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Tortillero') )
	DROP TABLE "dbo"."Tortillero"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Parrillero') )
	DROP TABLE "dbo"."Parrillero"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Repartidor') )
	DROP TABLE "dbo"."Repartidor"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Cliente') )
	DROP TABLE "dbo"."Cliente"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Cliente1') )
	DROP TABLE "dbo"."Cliente1"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Empleado') )
	DROP TABLE "dbo"."Empleado"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Empleado1') )
	DROP TABLE "dbo"."Empleado1"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Empleado2') )
	DROP TABLE "dbo"."Empleado2"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Sucursal') )
	DROP TABLE "dbo"."Sucursal"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Sucursal2') )
	DROP TABLE "dbo"."Sucursal2"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Proveedor') )
	DROP TABLE "dbo"."Proveedor"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Proveedor2') )
	DROP TABLE "dbo"."Proveedor2"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Trabajar') )
	DROP TABLE "dbo"."Trabajar"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Producto') )
	DROP TABLE "dbo"."Producto"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Producto1') )
	DROP TABLE "dbo"."Producto1"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Producto2') )
	DROP TABLE "dbo"."Producto2"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Taco') )
	DROP TABLE "dbo"."Taco"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Burritos') )
	DROP TABLE "dbo"."Burritos"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Quesadillas') )
	DROP TABLE "dbo"."Quesadillas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Gringas') )
	DROP TABLE "dbo"."Gringas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Tortas') )
	DROP TABLE "dbo"."Tortas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Platillos') )
	DROP TABLE "dbo"."Platillos"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Bebidas') )
	DROP TABLE "dbo"."Bebidas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Pozole') )
	DROP TABLE "dbo"."Pozole"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ServicioDomicilio') )
	DROP TABLE "dbo"."ServicioDomicilio"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Comprar') )
	DROP TABLE "dbo"."Comprar"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Salsas') )
	DROP TABLE "dbo"."Salsas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Recomendar') )
	DROP TABLE "dbo"."Recomendar"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Obtener') )
	DROP TABLE "dbo"."Obtener"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Revisar') )
	DROP TABLE "dbo"."Revisar"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Proveer') )
	DROP TABLE "dbo"."Proveer"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Sillas') )
	DROP TABLE "dbo"."Sillas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Mesas') )
	DROP TABLE "dbo"."Mesas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Bancos') )
	DROP TABLE "dbo"."Bancos"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Ingredientes') )
	DROP TABLE "dbo"."Ingredientes"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Servilletas') )
	DROP TABLE "dbo"."Servilletas"
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.Platos') )
	DROP TABLE "dbo"."Platos"

--Usamos CASCADE cómo política de mantenimiento de FK

CREATE TABLE [Empleado] (
  [NoSeguroSocial] int not null,
  [fechaNacimiento] date,
  [fechaContratacion] date,
  [tipoSangre] nvarchar(15),
  [nombre] nvarchar(50),
  [paterno] nvarchar(50),
  [materno] nvarchar(50),
  [telefono] nvarchar(50),
  [calle] nvarchar(50),
  [numero] int,
  [CURP] nvarchar(13) not null,
  [RFC] nvarchar(10) not null,
  CONSTRAINT "PK_Empleado" PRIMARY KEY CLUSTERED
	(
		"RFC"
	),
	CONSTRAINT "CK_fechaNacimiento" CHECK (fechaNacimiento < getdate())
)


CREATE TABLE [Bono] (
  [idBono] int not null,
  [RFC] nvarchar(10),
   CONSTRAINT "PK_Bono" PRIMARY KEY CLUSTERED
	(
		"idBono"
	),
	  CONSTRAINT "FK_Bono_Empleado" FOREIGN KEY
	(
		"RFC"
	) REFERENCES "dbo"."Empleado" (
		"RFC"
	) ON DELETE CASCADE
)


CREATE TABLE [Nomina] (
  [noNomina] int not null,
  CONSTRAINT "PK_Nomina" PRIMARY KEY CLUSTERED
	(
		"noNomina"
	)

)


CREATE TABLE [ControlDePago] (
  [noNomina] int not null,
  [RFC] nvarchar(10),
    CONSTRAINT "FK_ControlDePago_Empleado" FOREIGN KEY
	(
		"RFC"
	) REFERENCES "dbo"."Empleado" (
		"RFC"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_ControlDePago_Nomina" FOREIGN KEY
	(
		"noNomina"
	) REFERENCES "dbo"."Nomina" (
		"noNomina"
	) ON DELETE CASCADE
)


CREATE TABLE [Taquero] (
  [RFC] nvarchar(10) not null,
  CONSTRAINT "PK_Taquero" PRIMARY KEY CLUSTERED
	(
		"RFC"
	)
)


CREATE TABLE [Mesero] (
  [RFC] nvarchar(10) not null,
  CONSTRAINT "PK_Mesero" PRIMARY KEY CLUSTERED
	(
		"RFC"
	)
)


CREATE TABLE [Cajero] (
  [RFC] nvarchar(10) not null,
  CONSTRAINT "PK_Cajero" PRIMARY KEY CLUSTERED
	(
		"RFC"
	)
)


CREATE TABLE [Tortillero] (
  [RFC] nvarchar(10) not null,
  CONSTRAINT "PK_Tortillero" PRIMARY KEY CLUSTERED
	(
		"RFC"
	)
)


CREATE TABLE [Parrillero] (
  [RFC] nvarchar(10) not null,
  CONSTRAINT "PK_Parrillero" PRIMARY KEY CLUSTERED
	(
		"RFC"
	)
)


CREATE TABLE [Repartidor] (
  [RFC] nvarchar(10) not null,
  [numLicencia] nvarchar(50),
  [transporte] nvarchar(50),
  CONSTRAINT "PK_Repartidor" PRIMARY KEY CLUSTERED
	(
		"RFC"
	)
)


CREATE TABLE [Cliente] (
  [idCliente] int not null,
  [nombre] nvarchar(50),
  [paterno] nvarchar(50),
  [materno] nvarchar(50),
  [telefono] nvarchar (50),
  [edad] int,
  [email] nvarchar (50),
  [calle] nvarchar(50),
  [numero] int,
  CONSTRAINT "PK_Cliente" PRIMARY KEY CLUSTERED
	(
		"idCliente"
	),
)


CREATE TABLE [Cliente1] (
  [idCliente] int,
  [alcaldia] nvarchar(50),
    CONSTRAINT "FK_Cliente1_Cliente" FOREIGN KEY
	(
		"idCliente"
	) REFERENCES "dbo"."Cliente" (
		"idCliente"
	) ON DELETE CASCADE
)



CREATE TABLE [Empleado1] (
  [RFC] nvarchar(10),
  [alcaldia] nvarchar(50),
    CONSTRAINT "FK_Empleado1_Empleado" FOREIGN KEY
	(
		"RFC"
	) REFERENCES "dbo"."Empleado" (
		"RFC"
	) ON DELETE CASCADE
)


CREATE TABLE [Sucursal] (
  [idSucursal] int not null,
  [nombre] nvarchar(50),
  CONSTRAINT "PK_Sucursal" PRIMARY KEY CLUSTERED
	(
		"idSucursal"
	)
)


CREATE TABLE [Sucursal2] (
  [alcaldia] nvarchar(50),
  [idSucursal] int,
    CONSTRAINT "FK_Sucursal2_Sucursal" FOREIGN KEY
	(
		"idSucursal"
	) REFERENCES "dbo"."Sucursal" (
		"idSucursal"
	) ON DELETE CASCADE
)


CREATE TABLE [Proveedor] (
  [idProveedor] int not null,
  [telefono] nvarchar (50),
  [nombre] nvarchar(50),
  [calle] nvarchar(50),
  [numero] int,
  CONSTRAINT "PK_Proveedor" PRIMARY KEY CLUSTERED
	(
		"idProveedor"
	)
)


CREATE TABLE [Proveedor2] (
  [alcaldia] nvarchar(50),
  [idProveedor] int,
    CONSTRAINT "FK_Proveedor2_Proveedor" FOREIGN KEY
	(
		"idProveedor"
	) REFERENCES "dbo"."Proveedor" (
		"idProveedor"
	) ON DELETE CASCADE
)


CREATE TABLE [Trabajar] (
  [RFC] nvarchar(10),
  [idSucursal] int,
    CONSTRAINT "FK_Trabajar_Empleado" FOREIGN KEY
	(
		"RFC"
	) REFERENCES "dbo"."Empleado" (
		"RFC"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_Trabajar_Sucursal" FOREIGN KEY
	(
		"idSucursal"
	) REFERENCES "dbo"."Sucursal" (
		"idSucursal"
	) ON DELETE CASCADE
)


CREATE TABLE [Producto] (
  [idProducto] int not null,
  [precio] int,
  CONSTRAINT "PK_Producto" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)



CREATE TABLE [Consumir] (
  [idCliente] int,
  [idProducto] int,
    CONSTRAINT "FK_Consumir_Producto" FOREIGN KEY
	(
		"idProducto"
	) REFERENCES "dbo"."Producto" (
		"idProducto"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_Consumir_Cliente" FOREIGN KEY
	(
		"idCliente"
	) REFERENCES "dbo"."Cliente" (
		"idCliente"
	) ON DELETE CASCADE
)


CREATE TABLE [Taco] (
  [idProducto] int not null,
  [descripcionTaco] nvarchar(50),
  CONSTRAINT "PK_Taco" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Burritos] (
  [idProducto] int not null,
  [descripcionBurrito] nvarchar(50),
  CONSTRAINT "PK_Burritos" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Quesadillas] (
  [idProducto] int not null,
  [descripcionQuesadilla] nvarchar(50),
  CONSTRAINT "PK_Quesadillas" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Gringas] (
  [idProducto] int not null,
  [descripcionGringas] nvarchar(50),
  CONSTRAINT "PK_Gringas" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Tortas] (
  [idProducto] int not null,
  [descripcionTortas] nvarchar(50),
  CONSTRAINT "PK_Tortas" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Platillos] (
  [idProducto] int not null,
  [descripcionPlatillos] nvarchar(50),
  CONSTRAINT "PK_Platillos" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Bebidas] (
  [idProducto] int not null,
  [descripcionBebidas] nvarchar(50),
  CONSTRAINT "PK_Bebidas" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [Pozole] (
  [idProducto] int not null,
  [descripcionPozole] nvarchar(50),
  CONSTRAINT "PK_Pozole" PRIMARY KEY CLUSTERED
	(
		"idProducto"
	)
)


CREATE TABLE [ServicioDomicilio] (
  [idCliente] int,
  [idProducto] int,
  [metodoDePago] nvarchar (50),
    CONSTRAINT "FK_ServicioDomicilio_Cliente" FOREIGN KEY
	(
		"idCliente"
	) REFERENCES "dbo"."Cliente" (
		"idCliente"
	) ON DELETE CASCADE,
    CONSTRAINT "FK_ServicioDomicilio_Producto" FOREIGN KEY
	(
		"idProducto"
	) REFERENCES "dbo"."Producto" (
		"idProducto"
	) ON DELETE CASCADE
)


CREATE TABLE [Comprar] (
  [idCliente] int,
  [idSucursal] int,
  [tipoPago] nvarchar(50),
  [diaCompra] date,
  [promocion] nvarchar(50),
    CONSTRAINT "FK_Comprar_Cliente" FOREIGN KEY
	(
		"idCliente"
	) REFERENCES "dbo"."Cliente" (
		"idCliente"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_Comprar_Sucursal" FOREIGN KEY
	(
		"idSucursal"
	) REFERENCES "dbo"."Sucursal" (
		"idSucursal"
	) ON DELETE CASCADE
)


CREATE TABLE [Salsas] (
  [idSalsa] int not null,
  [nivelPicor] nvarchar(50),
  [ingredientes] nvarchar(50),
  CONSTRAINT "PK_Salsas" PRIMARY KEY CLUSTERED
	(
		"idSalsa"
	)
)


CREATE TABLE [Recomendar] (
  [idSalsa] int,
  [idProducto] int,
    CONSTRAINT "FK_Recomendar_Salsas" FOREIGN KEY
	(
		"idSalsa"
	) REFERENCES "dbo"."Salsas" (
		"idSalsa"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_Recomendar_Producto" FOREIGN KEY
	(
		"idProducto"
	) REFERENCES "dbo"."Producto" (
		"idProducto"
	) ON DELETE CASCADE
)


CREATE TABLE [Obtener] (
  [idSalsa] int,
  [idCliente] int,
  [presentacion] nvarchar(50),
  [precio] int,
    CONSTRAINT "FK_Obtener_Salsas" FOREIGN KEY
	(
		"idSalsa"
	) REFERENCES "dbo"."Salsas" (
		"idSalsa"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_Obtener_Cliente" FOREIGN KEY
	(
		"idCliente"
	) REFERENCES "dbo"."Cliente" (
		"idCliente"
	) ON DELETE CASCADE
)


CREATE TABLE [Revisar] (
  [idSucursal] int,
  [idInventario] int not null,
  CONSTRAINT "PK_Revisar" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	),
	  CONSTRAINT "FK_Revisar_Sucursal" FOREIGN KEY
	(
		"idSucursal"
	) REFERENCES "dbo"."Sucursal" (
		"idSucursal"
	) ON DELETE CASCADE
)


CREATE TABLE [Proveer] (
  [idSucursal] int,
  [idProveedor] int,
    CONSTRAINT "FK_Proveer_Sucursal" FOREIGN KEY
	(
		"idSucursal"
	) REFERENCES "dbo"."Sucursal" (
		"idSucursal"
	) ON DELETE CASCADE,
	  CONSTRAINT "FK_RProveer_Proveedor" FOREIGN KEY
	(
		"idProveedor"
	) REFERENCES "dbo"."Proveedor" (
		"idProveedor"
	) ON DELETE CASCADE
)


CREATE TABLE [Sillas] (
  [idInventario] int not null,
  [fechaCompra] date,
  [precio] int,
  [cantidad] int,
  [marca] nvarchar(50),
   CONSTRAINT "PK_Sillas" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	)
)


CREATE TABLE [Mesas] (
  [idInventario] int not null,
  [fechaCompra] date,
  [precio] int,
  [cantidad] int,
  [marca] nvarchar(50),
   CONSTRAINT "PK_Mesas" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	)
)


CREATE TABLE [Bancos] (
  [idInventario] int not null,
  [fechaCompra] date,
  [precio] int,
  [cantidad] int,
  [marca] nvarchar(50),
   CONSTRAINT "PK_Bancos" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	)
)


CREATE TABLE [Ingredientes] (
  [idInventario] int not null,
  [fechaCompra] date,
  [precio] int,
  [cantidad] int,
  [marca] nvarchar(50),
  [tipoIngrediente] nvarchar(50),
   CONSTRAINT "PK_Ingredientes" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	)
)


CREATE TABLE [Servilletas] (
  [idInventario] int not null,
  [fechaCompra] date,
  [precio] int,
  [cantidad] int,
  [marca] nvarchar(50),
   CONSTRAINT "PK_Servilletas" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	)
)


CREATE TABLE [Platos] (
  [idInventario] int not null,
  [fechaCompra] date,
  [precio] int,
  [cantidad] int,
  [marca] nvarchar(50),
   CONSTRAINT "PK_Platos" PRIMARY KEY CLUSTERED
	(
		"idInventario"
	)
)