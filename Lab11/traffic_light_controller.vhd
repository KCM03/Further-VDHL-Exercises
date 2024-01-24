-------------------------------------------------------------------
--
-- File        : traffic_light_controller.vhd
-- Authors     : Louise Crockett - University of Strathclyde 
--		           Garrey Rice - Steepest Ascent Ltd.
-- Description : This entity is a state machine which controls a
--               pedestrian crossing.   
--
-------------------------------------------------------------------

-------------------------
-- library declarations
-------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--------------------------------------
-- entity e_traffic_light_controller
--------------------------------------

entity e_traffic_light_controller is
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
        green_light : out std_logic
    );
end e_traffic_light_controller;

-------------------------------------------------------
-- start of architecture "a_traffic_light_controller"
-------------------------------------------------------

architecture a_traffic_light_controller of e_traffic_light_controller is

    -- declare state type as an enumerated type with sensible names
    
    type crossing_states is (
        traffic_go,
        traffic_stopping,
        traffic_stopped,
        traffic_starting
    );
    
    -- create a signal of the enumerated type
    signal current_state : crossing_states;

begin

    ---------------------------------------------------------------------------
    -- Synchronous process to update the state (with asychronous reset)
    ---------------------------------------------------------------------------

    update_state : process (clk, reset)

        variable stopping_count : integer range 0 to amber_time;
        variable stopped_count  : integer range 0 to red_time;
        variable starting_count : integer range 0 to amber_time;

        variable next_state : crossing_states;

    begin

        if reset = '1' then                     -- asychronous reset
            current_state <= traffic_go;
            
        elsif (clk'event and clk = '1') then
            if clk_enable = '1' then

                case current_state is            -- case statement (1 section for each state)
                
                    when traffic_go =>
                        stopping_count := 0;
                        stopped_count  := 0;
                        starting_count := 0;

                        if button = '1' then
                            next_state := traffic_stopping;
                        else
                            next_state := traffic_go;
                        end if;

                    when traffic_stopping =>
                        if stopping_count < amber_time then
                            next_state     := traffic_stopping;
                            stopping_count := stopping_count + 1;
                        else
                            next_state     := traffic_stopped;
                        end if;

                    when traffic_stopped =>
                        if stopped_count < red_time then
                            next_state    := traffic_stopped;
                            stopped_count := stopped_count + 1;
                        else
                            next_state    := traffic_starting;
                        end if;

                    when traffic_starting =>
                        if starting_count < amber_time then
                            next_state     := traffic_starting;
                            starting_count := starting_count + 1;
                        else
                            next_state     := traffic_go;
                        end if;

                end case;

                current_state <= next_state;         -- update current_state signal at end of process

            end if;
        end if;
    end process;


    ---------------------------------------------------------------------------
    -- Process to determine the outputs based purely on the current state.
    ---------------------------------------------------------------------------

    assign_outputs : process (current_state) is
    begin
        
        case current_state is
            
            when traffic_go =>         -- 1 section for each state
                red_man     <= '1';    -- ALL outputs are assigned each time
                green_man   <= '0';
                red_light   <= '0';
                amber_light <= '0';
                green_light <= '1';

            when traffic_stopping =>
                red_man     <= '1';
                green_man   <= '0';
                red_light   <= '0';
                amber_light <= '1';
                green_light <= '0';

            when traffic_stopped =>
                red_man     <= '0';
                green_man   <= '1';
                red_light   <= '1';
                amber_light <= '0';
                green_light <= '0';

            when traffic_starting =>
                red_man     <= '1';
                green_man   <= '0';
                red_light   <= '1';
                amber_light <= '1';
                green_light <= '0';

        end case;

    end process;

end a_traffic_light_controller;

-------------------------------------------------------
-- start of architecture "a_traffic_light_controller"
-------------------------------------------------------

-- end of file --

