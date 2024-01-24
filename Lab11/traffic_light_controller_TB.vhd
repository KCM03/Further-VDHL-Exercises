---------------------------------------------------------------------------------------------------
--
-- Title       : traffic_light_controller_TB.vhd
-- Author      : Louise Crockett - University of Strathclyde
-- Description : Test Bench for traffic_light_controller.
--
---------------------------------------------------------------------------------------------------

-------------------------
-- library declarations
-------------------------

library ieee;
use ieee.std_logic_1164.all;


-----------------------
-- entity declaration
-----------------------

entity e_traffic_light_controller_tb is
end e_traffic_light_controller_tb;


-------------------------------------------------------------
-- architecture "a_traffic_light_controller_tb" starts here
-------------------------------------------------------------

architecture a_traffic_light_controller_tb of e_traffic_light_controller_tb is
    
    ---------------------------------------------
    -- Component declaration of the tested unit
    ---------------------------------------------
    
    component e_traffic_light_controller
        generic(
            amber_time  :     integer;
            red_time    :     integer
        );
        port(
            button      : in  std_logic;
            reset       : in  std_logic;
            clk_enable  : in  std_logic;
            clk         : in  std_logic;
            red_man     : out std_logic;
            green_man   : out std_logic;
            red_light   : out std_logic;
            amber_light : out std_logic;
            green_light : out std_logic );
    end component;

    --------------------------------------
    -- Constants used within the design
    --------------------------------------
   
    constant amber_time : integer := 10;  		-- define length of stopping/starting phases as 10 clock cycles 
    constant red_time   : integer := 60; 		-- define length of stopped phase as 60 clock cycles
    constant T_clk      : time    := 100 ns;	-- define clock period
    constant T_reset    : time    := 50 ns;		-- define reset period

    ------------------------------------------------------------------------------
    -- Stimulus signals - signals mapped to the input ports of the tested entity
    ------------------------------------------------------------------------------
    
    signal button      : std_logic;
    signal reset       : std_logic;
    signal clk_enable  : std_logic;
    signal clk         : std_logic;
    
    -------------------------------------------------------------------------------
    -- Observed signals - signals mapped to the output ports of the tested entity
    -------------------------------------------------------------------------------
    
    signal red_man     : std_logic;
    signal green_man   : std_logic;
    signal red_light   : std_logic;
    signal amber_light : std_logic;
    signal green_light : std_logic;



begin

    -----------------------------------------------
    -- Unit Under Test instantiation and port map
    -----------------------------------------------
    
    UUT : e_traffic_light_controller
    generic map (
        amber_time  => amber_time,
        red_time    => red_time
    )
    port map (
        button      => button,
        reset       => reset,
        clk_enable  => clk_enable,
        clk         => clk,
        red_man     => red_man,
        green_man   => green_man,
        red_light   => red_light,
        amber_light => amber_light,
        green_light => green_light
    );



    ---------------------------------
    -- stimulus process (UUT inputs)
    ---------------------------------

    stimulus : process is

    begin

        reset <= '1'; clk_enable <= '1'; button <= '0';  -- initial reset
        wait for T_reset;

        reset <= '0'; clk_enable <= '1'; button <= '0';  -- nothing happening
        wait for (9*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '1';  -- pedestrian presses button
        wait for (1*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '0';  -- cycles through states, then waits
        wait for (90*T_clk);
        reset <= '1'; clk_enable <= '1'; button <= '0';  -- reset
        wait for (1*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '0';  -- nothing happening
        wait for (1*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '1';  -- pedestrian presses button
        wait for (1*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '0';  -- starts cycling through states
        wait for (20*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '1';  -- pedestrian presses button, has no effect, continues above
        wait for (1*T_clk);
        reset <= '0'; clk_enable <= '1'; button <= '0';  -- completes cycling through states
        wait for (80*T_clk);


        wait;

    end process;


    ------------------------------
    -- clock generation process
    ------------------------------

    clk_generator : process is          

    begin
        
        while now <= 300*T_clk loop		-- define number of clock cycles to simulate
        
			clk <= '1';					-- create one full clock period every loop iteration
            wait for T_clk/2;
			clk <= '0'
            wait for T_clk/2;
			
        end loop;	   
		
		wait;		
        
    end process	clk_generator;
    
    
    
end a_traffic_light_controller_tb;

-------------------------------------------------------
-- end of architecture "a_traffic_light_controller_tb"
-------------------------------------------------------


-- end of file --
