--------------------------------------------------------------------------------
-- Project Name: SBA_Liofilizador
-- Title: Control Principal SBA
-- Version: 0.1.1
-- Date: 2019/04/02
-- Project Author: Miguel A. Risco Castillo
-- Description: Sistema de control e instrumentación para el Liofilizador
--------------------------------------------------------------------------------
--
-- SBA Config
--
-- Constants for SBA system configuration and address map.
-- Based on SBA v1.2 guidelines
--
-- v1.7 2018/03/18
--
-- SBA Author: Miguel A. Risco-Castillo
-- sba webpage: http://sba.accesus.com
--
--------------------------------------------------------------------------------
-- Copyright example, you can use or modify at your convenience for your project.
--
-- This code, modifications, derivate work or based upon, can not be used or
-- distributed without the complete credits on this header.
--
-- The copyright notices in the source code may not be removed or modified.
-- If you modify and/or distribute the code to any third party then you must not
-- veil the original author. It must always be clearly identifiable.
--
-- Although it is not required it would be a nice move to recognize my work by
-- adding a citation to the application's and/or research. If you use this
-- component for your research please include the appropriate credit of Author.
--
-- FOR COMMERCIAL PURPOSES REQUEST THE APPROPRIATE LICENSE FROM THE AUTHOR.
--
-- For non commercial purposes this version is released under the GNU/GLP license
-- http://www.gnu.org/licenses/gpl.html
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package SBA_Liofilizador_SBAconfig is

-- System configuration
  Constant debug     : integer := 1;    -- '1' for Debug reports
  Constant Adr_width : integer := 16;   -- Width of address bus
  Constant Dat_width : integer := 16;   -- Width of data bus
  Constant Stb_width : integer := 8;    -- number of strobe signals (chip select)
  Constant sysfreq   : integer := 10e6; -- Main system clock frequency

-- Address Map
  Constant GPIO       : integer := 0;
  Constant TC1R0      : integer := 2;
  Constant TC1R1      : integer := 3;
  Constant TMRDATL    : integer := 4;
  Constant TMRDATH    : integer := 5;
  Constant TMRCFG     : integer := 6;
  Constant TMRCHS     : integer := 7;
  Constant UART0      : integer := 8;
  Constant UART1      : integer := 9;
  constant HXR0       : integer := 10;
  constant HXR1       : integer := 11;
  constant ADFMAX     : integer := 12;


--Strobe Lines
  Constant STB_GPIO   : integer := 0;
  Constant STB_PMODTC1: integer := 1;
  Constant STB_TIMER  : integer := 2;
  Constant STB_UART   : integer := 3;
  constant STB_HX711  : integer := 4;
  constant STB_ADFMAX : integer := 5;

-- System Type definitions
  Subtype ADDR_type is std_logic_vector(Adr_width-1 downto 0); -- Address Bus type
  Subtype DATA_type is std_logic_vector(Dat_width-1 downto 0); -- Data Bus type
  type    ADAT_type is array(0 to Stb_width-1) of DATA_type;     -- Array of Data Bus

end SBA_Liofilizador_SBAconfig;
