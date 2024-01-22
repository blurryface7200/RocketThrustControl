-- the thrust control system of a rocket.
-- if the pressure goes above a critical value
-- the combustion in combustion chamber will stop.

pragma SPARK_Mode (On);

with SPARK.Text_IO;use  SPARK.Text_IO;


package Thrust_Control_System is
   
   --The Pressure inside combustion chamber (or Thrust per unit area) in KPa
   
   -- Maximum_Pressure_Possible (it is needed since 
   -- we need to restrict the integers up to a value).
   
   Maximum_Pressure_Possible : constant Integer := 1000;
   
   -- if the Pressure exceeds Critical_Pressure
   -- then combustion in combustion chamber will stop
   Critical_Pressure : constant Integer := 500;
   
   -- range of pressures that is possible 
   type Pressure_Range is new Integer range 0 .. Maximum_Pressure_Possible;
   
   -- status of the combustion chamber
   -- Activated : Combustion is ongoing
   -- Not_Activated : Combustion has stopped
   type Status_Combustion_Chamber_Type is (Activated, Not_Activated);
   
   -- status of the overall system consisting of the pressure and the status of the combustion chamber
   type Status_System_Type  is 
      record
         Pressure_Measured   : Pressure_Range;
         Status_Combustion_Chamber : Status_Combustion_Chamber_Type;
      end record;
   
   -- Status System is a global variable determining the status of the system
   Status_System : Status_System_Type;
   
   -- Read_Pressure gets the current pressure from console input output
   -- and updates Status_System
   procedure Read_pressure with
     Global => (In_Out => (Standard_Output, Standard_Input,Status_System)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 Status_System   => (Status_System, Standard_Input));
   
   -- This function converts a value from Status_Combustion_Chamber_Type
   -- into a string which can be printed to console
   function Status_Combustion_Chamber_To_String (Status_Combustion_Chamber   : Status_Combustion_Chamber_Type) return String;
      
   
   
   -- Print Status prints out the status of the system on console
   procedure Print_Status with
     Global => (In_Out => Standard_Output, 
                Input  => Status_System),
     Depends => (Standard_Output => (Standard_Output,Status_System));
   
   
   -- Is_Safe determines whether the system is safe, if applied to Status_System
   function Is_Safe (Status : Status_System_Type) return Boolean is
     (if Integer(Status.Pressure_Measured) > Critical_Pressure 
      then Status.Status_Combustion_Chamber = Not_Activated
      else Status.Status_Combustion_Chamber = Activated);

   
   
   -- Monitor_Combustion_Chamber monitors the pressure; if it is too high
   -- it stops combustion in the combustion chamber if the pressure is higher than the critical pressure
   -- Afterwards the system will be safe as expressed by the post condition

   procedure Monitor_Combustion_Chamber  with
     Global  => (In_Out => Status_System),
     Depends => (Status_System => Status_System),
     Post    => Is_Safe(Status_System);
	      
   -- Init initialises the system to some values.
   -- afterwards the system is safe
   procedure Init with
     Global => (Output => (Standard_Output,Standard_Input,Status_System)),
     Depends => ((Standard_Output,Standard_Input,Status_System) => null),
     Post    => Is_Safe(Status_System);

end  Thrust_Control_System;


