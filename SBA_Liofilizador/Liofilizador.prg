-- /SBA: Program Details =======================================================
-- Project Name: SBA_Liofilizador
-- Title: Control Principal SBA
-- Version: 0.1.1
-- Date: 2019/04/02
-- Project Author: Miguel A. Risco Castillo
-- Description: Sistema de control e instrumentación para el Liofilizador
-- /SBA: End Program Details ---------------------------------------------------

-- /SBA: User Registers and Constants ==========================================

   constant ms         : positive:= positive(real(sysfreq)/real(1000)+0.499)-1;
   variable DlyReg_1ms : natural;   -- Constant Delay of 1ms
   variable Dlytmp_ms  : positive;  -- Delay register in ms
   variable counter    : natural range 0 to 65535;  -- Simple counter
   variable capture    : natural range 0 to 65535;  -- Capture data at timer interrupt
-- /SBA: End User Registers and Constants --------------------------------------

-- /SBA: User Program ==========================================================

=> SBAjump(Init);            -- Reset Vector (001)
=> SBAjump(INT);             -- Interrupt Vector (002)

------------------------------ ROUTINES ----------------------------------------
-- /L:Delay_ms
=> DlyReg_1ms:=ms;
=> if DlyReg_1ms/=0 then
     dec(DlyReg_1ms);
     SBAjump(Delay_ms+1);
   end if;
=> if Dlytmp_ms/=0 then
     dec(Dlytmp_ms);
     SBAjump(Delay_ms);
   else
     SBARet;
   end if;

------------------------------ INTERRUPT ---------------------------------------
-- /L:INT
=> capture:=counter;
   SBARead(TMRCFG);
=> SBAreti;
------------------------------ MAIN PROGRAM ------------------------------------

-- /L:Init
=> counter:=1; capture:=0;
=> SBAwrite(TMRCHS,0);          -- Select timer 0
=> SBAwrite(TMRDATL,x"E100");   -- Write to LSW, (100'000,000 = 5F5E100)
=> SBAwrite(TMRDATH,x"05F5");   -- Write to MSW
=> SBAwrite(TMRCFG,"0X11");     -- Disable output, Enable timer interrupt
=> SBAinte(true);               -- Enable interrupts

-- /L:LoopMain
=> if (capture=0) then
     SBAjump(LoopMain);
   else
     capture:=0;
   end if;

=> SBAwrite(GPIO,counter);
   inc(counter);
=> SBAjump(LoopMain);

-- /SBA: End User Program ------------------------------------------------------

