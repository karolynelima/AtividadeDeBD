-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 19-Jun-2018 às 14:04
-- Versão do servidor: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `atividade_db`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamento`
--

CREATE TABLE `Departamento` (
  `CodDepartamento` int(4) NOT NULL,
  `Descrição` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estrutura da tabela `Funcionario`
--

CREATE TABLE `Funcionario` (
  `CodFuncionario` varchar(3) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `CodDepartamento` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE 'TipoEquipamento'(
  'CodTipoEquipamento' int(1) NOT NULL,
  'Descricao' varchar(20)
)

CREATE TABLE 'Equipamento'(
  'Etiqueta' varchar(8) NOT NULL,
  'Marca' varchar(2) NOT NULL,
  'Descricao' varchar(30) NOT NULL,
  'dataAquisicao' date NOT NULL,
  'CodTipoEquipamento' int(1) NOT NULL,
  'CodDepartamento' int(3) NOT NULL
)

CREATE TABLE 'Avaria'(
  'CodAvaria' int(1) NOT NULL,
  'Descrição' varchar(30) NOT NULL,
  'Data' date NOT NULL,
  'Etiqueta' varchar(8) NOT NULL,
  'CodFuncionario' int(1) NOT NULL
)

CREATE TABLE 'Intervencao'(
  'CodIntervencao' int(1) NOT NULL,
  'Descrição' varchar(30) NOT NULL,
  'Data' date NOT NULL,
  'CodAvaria' int(1) NOT NULL,
  'CodFuncionario' int(1) NOT NULL
)
--
-- Indexes for dumped tables
--
--
-- Indexes for table `Departamento`
--
ALTER TABLE `Departamento`
  ADD PRIMARY KEY (`CodDepartamento`);

--
-- Indexes for table `Funcionario`
--
ALTER TABLE `Funcionario`
  ADD PRIMARY KEY (`CodFuncionario`);

--
-- Indexes for table `TipoEquipamento`
--
ALTER TABLE `TipoEquipamento`
  ADD PRIMARY KEY (`CodTipoEquipamento`);

--
-- Indexes for table `Equipamento`
--
ALTER TABLE `Equipamento`
  ADD PRIMARY KEY (`Etiqueta`);

--
-- Indexes for table `Avaria`
--
ALTER TABLE `Avaria`
  ADD PRIMARY KEY (`CodAvaria`);

--
-- Indexes for table `Avaria`
--
ALTER TABLE `Intervencao`
  ADD PRIMARY KEY (`CodIntervencao`);

--
-- AUTO_INCREMENT for dumped tables
--
--
-- AUTO_INCREMENT for table `departamento`
--
ALTER TABLE `departamento`
  MODIFY `CodDepartamento` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
COMMIT;


--
-- Extraindo dados da tabela `departamento`
--

INSERT INTO `departamento` (`CodDepartamento`, `Descricao`) VALUES
(101, 'Contabilidade'),
(102, 'Comercial'),
(103, 'Recursos Humanos'),
(104, 'Informatica');


--
-- Extraindo dados da tabela `funcionario`
--

INSERT INTO `funcionario` (`CodFuncionario`, `Nome`) VALUES
('', ''),
('1', 'Ana Souza');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
