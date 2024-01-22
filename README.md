# RocketThrustControl
 
Designed and implemented a safety critical system for simple thrust control in a rocket. Developed the system using Spark Ada and verified its functionality in GNAT Studio IDE.

Thrust is the propulsive force of a rocket which provides acceleration in it. The thrust comes from the high pressure inside a cavity in the rocket called combustion chamber. The fuel burning up in the combustion chamber builds up high pressure and the expanding gas escapes through the nozzle at the lower end of the cavity in the rocket thereby providing it with the thrust. The combustion in the combustion chamber is always ongoing once the rocket takes off. 

But, sometimes the pressure build up can become excessive due to various circumstances and to prevent any accident, the controller stops the combustion as a safety precaution. A sensor is present which measures the pressure inside the combustion chamber. The pressure at which the combustion in the combustion chamber is stopped is called critical pressure (at 500 KPa). 

Once the critical pressure is reached, the controller system stops the combustion so as to slow the pressure build up and thereby preventing any accident.  Once the pressure is back to below the critical pressure, the combustion is started again.
