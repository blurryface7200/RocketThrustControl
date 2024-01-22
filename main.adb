-- it initialises the system
-- then runs for ever in a loop which
--   1) reads the Pressure from console
--   2) monitors the combustion chamber so that combustion in 
--      the combustion chamber is stopped if the Pressure is too high
--   3) prints out the status
-- 
--  the loop_invariant expresses that the system stays safe all the time.

pragma SPARK_Mode (On);

with Thrust_Control_System;
use Thrust_Control_System;



procedure Main
is
begin
   Init;
   loop
      pragma Loop_Invariant (Is_Safe(Status_System));
      Read_Pressure;
      Monitor_Combustion_Chamber;
      Print_Status;
   end loop;
end Main;

      
