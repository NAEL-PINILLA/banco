-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2022 at 11:10 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `systcdb`
--
CREATE DATABASE IF NOT EXISTS `systcdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `systcdb`;

-- --------------------------------------------------------

--
-- Table structure for table `asesor`
--

DROP TABLE IF EXISTS `asesor`;
CREATE TABLE `asesor` (
  `id` int(11) NOT NULL,
  `nombres` varchar(32) NOT NULL,
  `apellidos` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `documento` varchar(16) NOT NULL,
  `nombres` varchar(32) NOT NULL,
  `apellidos` varchar(32) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(16) NOT NULL,
  `direccion` varchar(64) NOT NULL,
  `profesion` varchar(32) NOT NULL,
  `tipo_documento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`id`, `documento`, `nombres`, `apellidos`, `email`, `password`, `telefono`, `direccion`, `profesion`, `tipo_documento_id`) VALUES
(1, '1001', 'Alexandra', 'Casas', 'alex@gmail.com', 'abc', '123456789', 'Calle 11', 'Pintor', 1);

-- --------------------------------------------------------

--
-- Table structure for table `referencia`
--

DROP TABLE IF EXISTS `referencia`;
CREATE TABLE `referencia` (
  `id` int(11) NOT NULL,
  `nombres` varchar(32) NOT NULL,
  `apellidos` varchar(32) NOT NULL,
  `telefono` varchar(16) NOT NULL,
  `direccion` varchar(64) NOT NULL,
  `solicitud_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `solicitud`
--

DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE `solicitud` (
  `id` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `monto_deseado` double NOT NULL,
  `ingresos_menuales` double NOT NULL,
  `observaciones` varchar(1024) DEFAULT NULL,
  `solicitud_estado_id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `asesor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `solicitud_estado`
--

DROP TABLE IF EXISTS `solicitud_estado`;
CREATE TABLE `solicitud_estado` (
  `id` int(11) NOT NULL,
  `nombre` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `solicitud_estado`
--

INSERT INTO `solicitud_estado` (`id`, `nombre`) VALUES
(1, 'Aprobada'),
(2, 'Pendiente'),
(3, 'Rechazada'),
(4, 'Nuevo intento'),
(5, 'Aplazada'),
(6, 'Otra');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_documento`
--

DROP TABLE IF EXISTS `tipo_documento`;
CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `nombre` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipo_documento`
--

INSERT INTO `tipo_documento` (`id`, `nombre`) VALUES
(1, 'CC'),
(2, 'Pasaporte'),
(3, 'Otro');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asesor`
--
ALTER TABLE `asesor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento_UNIQUE` (`documento`),
  ADD KEY `fk_cliente_tipo_documento_idx` (`tipo_documento_id`);

--
-- Indexes for table `referencia`
--
ALTER TABLE `referencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_referencia_solicitud1_idx` (`solicitud_id`);

--
-- Indexes for table `solicitud`
--
ALTER TABLE `solicitud`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_solicitud_solicitud_estado1_idx` (`solicitud_estado_id`),
  ADD KEY `fk_solicitud_cliente1_idx` (`cliente_id`),
  ADD KEY `fk_solicitud_asesor1_idx` (`asesor_id`);

--
-- Indexes for table `solicitud_estado`
--
ALTER TABLE `solicitud_estado`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asesor`
--
ALTER TABLE `asesor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `referencia`
--
ALTER TABLE `referencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `solicitud`
--
ALTER TABLE `solicitud`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `solicitud_estado`
--
ALTER TABLE `solicitud_estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_tipo_documento` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipo_documento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `referencia`
--
ALTER TABLE `referencia`
  ADD CONSTRAINT `fk_referencia_solicitud1` FOREIGN KEY (`solicitud_id`) REFERENCES `solicitud` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `solicitud`
--
ALTER TABLE `solicitud`
  ADD CONSTRAINT `fk_solicitud_asesor1` FOREIGN KEY (`asesor_id`) REFERENCES `asesor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_solicitud_cliente1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_solicitud_solicitud_estado1` FOREIGN KEY (`solicitud_estado_id`) REFERENCES `solicitud_estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
