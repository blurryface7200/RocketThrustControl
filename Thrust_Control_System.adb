pragma SPARK_Mode (On);

with AS_IO_Wrapper;  use AS_IO_Wrapper; 


package body Thrust_Control_System is
   
   
   procedure Read_Pressure is
      Pressure : Integer;
   begin
      AS_Put_Line("Please type in current pressure in the combustion chamber as read by sensors");
      loop
         AS_Get(Pressure,"Please type in an integer");
         exit when (Pressure >=0) and (Pressure <= Maximum_Pressure_Possible);
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Pressure_Possible);
         AS_Put_Line("");
      end loop;
      Status_System.Pressure_Measured := Pressure_Range(Pressure);
   end Read_Pressure;
   
   function Status_Combustion_Chamber_To_String (Status_Combustion_Chamber   : Status_Combustion_Chamber_Type) return String is
   begin
      if (Status_Combustion_Chamber = Activated) 
      then return "Activated";
      else return "Not_Activated";
      end if;
   end Status_Combustion_Chamber_To_String;
	
   
   
   procedure Print_Status is
   begin
      AS_Put("Pressure = ");
      AS_Put(Integer(Status_System.Pressure_Measured));
      AS_Put_Line("");
      AS_Put("Combustion_Chamber = ");
      AS_Put_Line(Status_Combustion_Chamber_To_String(Status_System.Status_Combustion_Chamber));
   end Print_Status;
   
   
   procedure Monitor_Combustion_Chamber  is
   begin
      if Integer(Status_System.Pressure_Measured) > Critical_Pressure 
      then Status_System.Status_Combustion_Chamber := Not_Activated;
      else Status_System.Status_Combustion_Chamber := Activated;
      end if;
   end Monitor_Combustion_Chamber;
   
   
   procedure Init is
   begin
      AS_Init_Standard_Input; 
      AS_Init_Standard_Output;
      Status_System := (Pressure_Measured  => 0,
                        Status_Combustion_Chamber => Activated);
   end Init;
   
   
      
     
end Thrust_Control_System;
	


