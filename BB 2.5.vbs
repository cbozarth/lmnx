dim obj
set obj = CreateObject("Luminex.LXS.Interpreter")

obj.log "System Info"
	REM obj.LogPropertyValue  177						'MAgPix Serial Number
	REM obj.LogPropertyValue  12318						'APM Serial Number


obj.Log "Load Variables Constant Across Entire Protocol"
	'FLUIDIC SYSTEM VARIABLES
			AverageProbeLineVolume = 70				'AVERAGE Volume of the probe line(based on tolerance data and rounded from 68.65uL) from tip of the probe to and including sample valve dead volume. 
			MaximumErrorOnProbeLineVolume = 10		'Maximum Possible error (Based on tolerance analysis and rounded from +or- 7.5uL) on the actual probe line volume when estimated by the average probe line volume - Add error to garantee a burp that pass the sample valve. Subtract error to garantee a probe refill without spill.
			SyringePumpCapacity = 500				'Capacity of the syringe pump in uL
			MinimumProbeToPumpVolume = 354			'Smallest volume possible, based on tolerance analysis, between the tip of the probe and the syringe pump valve 
			MaximumProbeToPumpVolume = 436			'Largest volume possible, based on tolerance analysis, between the tip of the probe and the syringe pump valve			
	
	'TRAY VARIABLES
		'REACTION WELLS VARIABLES
			ReactionWellsLA = 0						'All reactionwells belong to the same logical area 0
			ReactionWellsAcquisitionMod = 0		
			ReactionWellsDispenseBeadsMod = 1
			ReactionWellsAspirateReagentMod = 2
			ReactionWellsDispenseReagentMod = 3
			
		'REAGENT RESERVOIR VARIABLES
			ReagentLA = 4							'All reservoirs belong to the same logical area 4
			ReagentRow = 0							'All reservoirs have the same and single row 0
			ReagentAspirateMod = 0
			ReagentDispenseMod = 1					'Z height to dispense waste
			ReagentVentMod = 3						'Vent Location that enables dispensing in the reservoir
		'DEDICATED WASTE RESERVOIR CONSTANT VARIABLES
			WasteLA = 4								'Waste is predefined like other reservoir - Final location is defined by a waste column number in the protocol
			WasteRow = 0	
			WasteColumn = 0							'Default Waste Column
			WasteDispenseMod = 1		
			WasteVentMod = 3	
	
	'SHAKER VARIABLES
			ShakerSpeed = 900						'Shaker speed in RPM

	'BEAD HANDLING VARIABLES	
		'PELLETIZATION TIMES BASED ON REACTION WELL CONTENT
			ShortShakeTimeBeforeCriticalReagentAddition = 5
			PelletizationTimeBeforeCriticalReagentAddition = 10
			ShortShakeTimeForRemovingBuffer = 10
			PelletizationTimeForRemovingBuffer = 120
			ShortShakeTimeForRemovingSerum = 10
			PelletizationTimeForRemovingSerum = 120
		'BEAD RESUSPENSION TIME
			ReservoirResuspensionTime = 120
			ReservoirResuspensionTimeBetweenTransfer = 15
			ReactionWellsResuspensionTime = 120								'NUMBER OF SECONDS OF SHAKING AT THE BEGINNING OF THE ACQUISITION COMMAND TO FULLY RESUSPEND THE BEADS
			ReactionWellResuspensionTimeBetweenAcquisition = 5				'NUMBER OF SECONDS OF SHAKING PRIOR TO EACH INDIVIDUAL ACQUISITION TO MAINTAIN BEAD RESUSPENSION 
			NumberOfAgitateCyclesForAPMAcquisition = 5						'PROPERTY 65796. NUMBER OF AGITATE CYCLE THE SAMPLE IS SUBJECTED TO PRIOR TO AN APM ACQUISITION	

	'DEFAULT VALUES FOR MAGPIX PROPERTIES ALTERED BY APM PROCESSED
			Default_65796_AcquisitionAgitateCycle = 3						'NUMBER OF AGITATE CYCLE THE SAMPLE IS SUBJECTED TO PRIOR TO A STANDARD MAGPIX ACQUISITION		
		
	'REAGENT ADDITION (ADD) VARIABLES
			Add_BurpVolume = AverageProbeLineVolume + MaximumErrorOnProbeLineVolume
			Add_BurpVelocity = 50
			Add_BubbleVolume = 20
			Add_ReagentPickupVelocity = 50
			Add_FlushPickupVolume = 200 
			Add_FlushPickupVolumeVelocity = 20
			Add_FlushDispenseVelocity = 20
			Add_PreDispenseVolume = 25
			Add_preDispenseVelocity = 50
			Add_ExcessPickupVolume = 50
			Add_PauseAfterReagentPickup = 1000
			Add_ReagentDispenseVelocity = 50
			Add_PullBackVolume = 0
			Add_PullBackVelocity = Add_ReagentPickupVelocity
			Add3_BubbleVolumeForPriming = 10
			Add3_PrimingVelocity = 50
			Add3_PrimingVolume1_UpToPumpValve = 325							'THIS VOLUME WAS BASED ON THE MINIMUM VOLUME POSSIBLE BETWEEN THE PROBE TIP AND THE PUMP VALVE, MINUS A MARGIN OF ~10uL to 20uL (INCLUDING THE PRIMING BUBBLE) TO ENSURE NOT ENTERING THE SYRINGE PUMP
			Add3_PrimingVolume2_PassPumpValve = 275							'THIS VOLUME WAS BASED ON THE CAPACITY OF THE SYRINGE PUMP, MINUS THE VOLUME THAT WILL BE NEEDED FOR TRANSFER (UP TO 200uL + 25uL PREDSIPENSE VOLUME) - 
	'REAGENT ADDITION OPTIONS
		'ADDITION TYPE: Add_ApproximateBubbleSize (or 1), Add_PreciseBubblesize (or 2), AddWith_LinePrimedbyReagent (or 3)
			ApproximateBubbleSize = "ApproximateBubbleSize"
			PreciseBubblesize = "PreciseBubblesize"
			With_LinePrimedbyReagent = "With_LinePrimedbyReagent"
		'REAGENT TYPE: Beads or CriticalReagent or WashBuffer
			Beads = "Beads"
			CriticalReagent = "CriticalReagent"
			WashBuffer = "WashBuffer"
		'TRANSFER TYPE: SingleDipsense or MultiDispense
			SingleDispense = "SingleDispense"
			Multidispense = "Multidispense"
		
	
	'SUPERNATANT REMOVAL (REMOVE) VARIABLES
			Remove_BurpVelocity = 50
			Remove_BurpVolume =  AverageProbeLineVolume + MaximumErrorOnProbeLineVolume
			Remove_FlushVolume = 280
			Remove_FlushPickupVolumeVelocity = 20
			Remove_FlushDispenseVelocity = 20
			Remove_SupernatantPickupVelocity = 50
			Remove_ExcessPickupVolume = 25
			Remove_PauseAfterSupernatantPickup = 500
			Remove_SyringeFlushVolume = 400
			Remove_SyringeFlushVelocity = 50
			Remove_NumberOfSyringeFlushLoop = 5
			Remove_ProbeValveExtraFlushVolume = 100
			Remove_ProbeValveSpillVolume = 75
			Remove_ProbeValveFlushVelocity = 50
			Remove_NumberOfProbeValveFlushLoop = 3
	'SUPERNATANT REMOVAL OPTIONS
		'******************REMOVAL TYPE: Remove_FlushAfterEachWell (or 1), Remove_CleanLineOnceAtTheEnd (2) --> THIS IS UNUSED AND SHOULD BE DELETED
		'SUPERNATANT TYPE: BufferBasedSample, or SerumBasedSample, or CriticalReagent, or WashBuffer, or OtherBuffer
			BufferBasedSample = "BufferBasedSample" 
			SerumBasedSample = "Serum Based Sample"
			OtherBuffer = "OtherBuffer"
	
	'SELF TEST TYPES
			Quick = "Quick"
			Thorough = "Thorough"

	
obj.Log "Assay Prototocol"
	
	' BB2.4	
	' ON FT1, REMOVE THE PREPERFORATION OF COLUMN 4 AT THE FINAL ACQUISITION STAGE AS IT WAS A REDONDANT STEP
	' Quick Self Test: UPDATED TO COVER ALL RANGE OF XY AND LOCATION MODS ON QUiCK SELF TEST
	' Thorough Self Test: UPDATED TO COVER ALL XY LOCATIONS FOR REACTION WELLS AND RESERVOIRS, AND ALL MODS
	' Acquire : update so it moves to well before shaking
	'Rinse command: UPDATE ALL RINSE COMMANDS SO NOW THEY ALL INCLUDE THE LOCATION MOD AS PARAMETER
	'Creating SUBWASH
	'SubWash (ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn)
	REM SubWash 25,2,0,0
	REM obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	REM Selftest Thorough
	StartSession
	CloseSession
	
obj.RunBatch


'ALL AVAIALABLE COMMANDS"

	'PROTOCOL COMMANDS
Sub Pre_Perforate_ReactionWells (PerforationMod, FirstColumn, LastColumn)
	'PERFORATION MOD FOR THE REACTION WELLS ARE 1(BEAD DISPENSING MOD) OR 3(REAGENT DISPENSING MOD)
	'SHOULD BE EXECUTED BEFORE WASTE PRE-PERFORATION
	
	obj.Log "	Start Pre-Perforation of MOD " & PerforationMod & " for each reaction wells from column " & FirstColumn & " to column " & LastColumn & "."	
	
	For Column=FirstColumn to LastColumn
		For Row=0 to 7
			obj.MoveWell Row,Column,0,PerforationMod
			obj.ProbeMove 1
			obj.ProbeMove 0
		Next
	Next
	
	obj.Log "		End Pre-Perforation of reaction wells"
	
End Sub

Sub DefineAndPre_PerforateWaste (NewWasteColumn)
	'SHOULD BE EXECUTED IMMEDIATELY AFTER REACTION WELLS PRE-PERFORATION
	obj.Log "	Start Identification and Pre-Perforation of Waste Reservoir"
	Obj.Log "		Reservoir " & WasteColumn & " is established as new waste reservoir"	
	WasteColumn = NewWasteColumn
	obj.MoveWell WasteRow, WasteColumn, WasteLA, WasteVentMod
	obj.ProbeMove 1
	obj.ProbeMove 0
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	obj.Log "		End Pre-Perforation of Waste Reservoir"
End Sub

Sub ReagentAddition (AdditionType, ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn)
	
	obj.Log "	Start" & ReagentVolume & "uL Reagent Addition (" & AdditionType & ") of " & ReagentType & ", in a" & TransferType & " trasnfer type, from reservoir" & ReagentReservoirColumnNumber & "into column" & FirstColumn & "to column" & LastColumn & "."

	'DEPLOY MAGNETS BEFORE FOR REAGENT ADDITION, IF REQUIRED BY REAGENT TYPE, OTHERWISE RETRACT MAGNETS
	If ReagentType = Beads Then
		DeployMagnet 0,0
		ElseIf ReagentType = CriticalReagent Then
		DeployMagnet ShortShakeTimeBeforeCriticalReagentAddition,PelletizationTimeBeforeCriticalReagentAddition	
		'IF REAGENT TYPE IS WASH BUFFER, THEN RETRACT MAGNETS
		ElseIf ReagentType = WashBuffer Then
		obj.APMMoveMagnet 2,0
		Else
		obj.Log  "		Unknown ReagentType - Magnets are retracted"
		obj.APMMoveMagnet 2,0
	End If
	
	'SHAKE TRAY BEFORE PICKING UP THE REAGENT (IF REAGENT TYPE IS BEADS) TO ACHIEVE FULL RESUSPENSION BEFORE FIRST TRANSFER
	If ReagentType = Beads Then
		obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTime,1
		obj.Pause ReservoirResuspensionTime*1000+500
	End If	
	
	'PREPERFORATE THE REAGENT RESERVOIR ONCE, BEFORE THE FISRT TRANSFER TO ENABLE THE PREDISPENSE STEP WITHOUT BUBBLING OF THE REAGENT ABOVE THE SEAL
	obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentVentMod
	obj.ProbeMove 1
	
	'DEFINE THE REACTION WELL DISPENSING MOD BASED ON REAGENT TYPE (BEADS AND WASHBUFFER ARE DISPENSED FROM ABOVE THE MAGNET (MOD 1 AKA BEADMOD) AND CRITICIAL REAGENTS ARE DISPENSED AWAY FROM THE MAGNETS TO NOT DISTURB THE PELLET (MOD 3 AKA REAGENTMOD))
	If ReagentType = Beads Or ReagentType = WashBuffer Then
		ReactionWellsDispenseMod = ReactionWellsDispenseBeadsMod
		ElseIf ReagentType = CriticalReagent Then
		ReactionWellsDispenseMod = ReactionWellsDispenseReagentMod
	End If
	
	'EXECUTE APPROPRIATE ADDITION COMMAND BASED ON SELECTED ADDITION TYPE
	If AdditionType = ApproximateBubbleSize Then
		obj.Log "		Start reagent addition type " & ApproximateBubbleSize & "."
		Add_ApproximateBubbleSize ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn 
		obj.Log "		End reagent addition type " & ApproximateBubbleSize & "."
		ElseIf Additiontype = PreciseBubblesize Then
		obj.Log "		Start reagent addition type " & PreciseBubblesize & "."
		Add_PreciseBubblesize ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn 
		obj.Log "		End reagent addition type " & PreciseBubblesize & "."
		ElseIf Additiontype = LinePrimedbyReagent Then
		obj.Log "		Start reagent addition type " & LinePrimedbyReagent & "."
		Add_LinePrimedbyReagent ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn
		obj.Log "		End reagent addition type " & LinePrimedbyReagent & "."
		Else
		obj.Log "		Unrecognized Reagent Addition Type - No Addition was performed"
	End IF
	
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	obj.Log "		End Reagent Addition"
End Sub

Sub Incubation (IncubationShakingTime)
	obj.Log "	Start Incubation"
	
	' RETRACT MAGNETS
	obj.APMMoveMagnet 2,0
	
	'SHAKE FOR INCUBATION OR RESUSPENSION PURPOSES
	If ( incubationShakingTime <> 0 ) Then	
		obj.Log "		Incubation for " & incubationShakingTime & " Seconds at " & ShakerSpeed & " RPM"
		obj.APMShakerEnable ShakerSpeed, incubationShakingTime,1
		obj.Pause incubationShakingTime*1000+500
	End IF
	
	obj.Log "		End Incubation"
End Sub

Sub SupernatantRemoval (SupernatantType, VolumeToRemove, FirstColumn, LastColumn)
	obj.Log "	Start Supernatant Removal of " & VolumeToRemove & "uL of " & SupernatantType & " from column " & FirstColumn & " to column " & LastColumn & "."
	
	'BASED ON SUPERNATANT TYPE: DEPLOY MAGNETS AND WAIT APPROPRIATE TIME FOR PELLETIZATION , THEN EXECUTE A REMOVE COMMAND WITH APPROPRIATE LINE CLEANING PARAMETERS
	If SupernatantType = SerumBasedSample Then
		DeployMagnet ShortShakeTimeForRemovingSerum, PelletizationTimeForRemovingSerum
		Remove VolumeToRemove, FirstColumn, LastColumn,280,5,3
		
		ElseIf SupernatantType = BufferBasedSample Then
		DeployMagnet ShortShakeTimeForRemovingBuffer, PelletizationTimeForRemovingBuffer
		Remove VolumeToRemove, FirstColumn, LastColumn,280,5,3		
		
		ElseIf SupernatantType = CriticalReagent Then
		DeployMagnet ShortShakeTimeForRemovingBuffer, PelletizationTimeForRemovingBuffer
		Remove VolumeToRemove, FirstColumn, LastColumn,0,5,3
		
		ElseIf SupernatantType = WashBuffer or SupernatantType = OtherBuffer Then
		DeployMagnet ShortShakeTimeForRemovingBuffer, PelletizationTimeForRemovingBuffer
		Remove VolumeToRemove, FirstColumn, LastColumn,0,3,3
		
		Else
		DeployMagnet ShortShakeTimeForRemovingBuffer, PelletizationTimeForRemovingBuffer
		Remove VolumeToRemove, FirstColumn, LastColumn,25,5,3
	End IF
	
	obj.Log "		End Supernatant Removal"
End Sub

Sub SubWash (ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn)
	ReagentAddition ApproximateBubbleSize, WashBuffer, Multidispense, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn
	Incubation 15
	SupernatantRemoval WashBuffer, ReagentVolume, FirstColumn, LastColumn
End Sub

sub ResuspensionInDriveFluid (ResuspensionVolume, FirstColumn, LastColumn)
	'THIS COMMAND ASSUMES A CLEAN LINE TO START WITH. 
	'THIS COMMAND ALSO ASSUMES THE INTENT OF RESUSPENDING THE BEADS AND THEREFORE SEND THE DRIVE FLUID THROUGH THE SAME MOD THAT WILL BE USED IF REAGENT TYPE HAD BEEN BEADS OR WASHBUFFER (ReactionWellsDispenseBeadsMod)
	obj.Log "	Start Resuspension using " & ResuspensionVolume & "uL of Drive FLuid, from column " & FirstColumn & " to column " & LastColumn & "."
	
	'ENSURE COMPLETE PRIMING OF THE LINE
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod

	'FOR EACH REACTION WELLS, PICK A VOLUME FROM THE DRIVE SIDE AND DISPENSE IT INTO THE WELL
	For Column=FirstColumn to LastColumn
		For Row=0 to 7
			obj.MoveWell Row,Column,ReactionWellsLA,ReactionWellsDispenseBeadsMod
			obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,ResuspensionVolume,0,1
			obj.ProbeMove 1
			obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,ResuspensionVolume,1,1
		Next
	Next
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	obj.Log "		End Resuspension using Drive FLuid"
	
End Sub

Sub Acquire (FirstColumn, LastColumn)
	obj.Log "	Start Acquisition from column " & FirstColumn & " to column " & LastColumn & "."
	
	'RETRACT MAGNETS
	obj.APMMoveMagnet 2,0	
	
	'CLEAN UP SAMPLE LINE AND PROBE LINE
	obj.Prime
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	
	'MODIFY THE NUMBER OF AGITATE CYCLE TO BE COMPATIBLE WITH APM ACQUISITION. THIS PROPERTY WILL BE RESET TO ITS DEFAULT MAGPIX VALUE AT THE END OF THIS ACQUISITION COMMAND
	obj.Log "		Change the number of agitate cycles for acquisiton (property #65796) from 3 to 5"
	obj.SetProperty 65796,NumberOfAgitateCyclesForAPMAcquisition

	'SHAKE PRIOR TO ANY ACQUISITION
	obj.APMShakerEnable ShakerSpeed, ReactionWellsResuspensionTime,1
	obj.Pause ReactionWellsResuspensionTime*1000+500
	
	'START ACQUIRING WELLS INCLUDING A SHORT SHAKE PRIOR TO ALL ACQUISITIONS
	For Column=FirstColumn to LastColumn
		For Row=0 to 7
			obj.MoveWell Row,Column,ReactionWellsLA,ReactionWellsAcquisitionMod
			obj.APMShakerEnable ShakerSpeed,ReactionWellResuspensionTimeBetweenAcquisition,0
			obj.Pause ReactionWellResuspensionTimeBetweenAcquisition*1000+500
			obj.Acquisition Row,Column,ReactionWellsLA,0,0,ReactionWellsAcquisitionMod
		Next
	Next
	
	'RESET MAGPIX PROPERTY TO THEIR DEFAULT VALUES
	obj.Log "		Reset the number of agitate cycles for acquisiton (property #65796) to its MagPIx default value of 3"
	obj.SetProperty 65796,Default_65796_AcquisitionAgitateCycle
	
	obj.Log "		End Acquisition"
End Sub


	'BASIC COMMANDS
Sub DeployMagnet (ShortShakeTime, PelletizationTime)
	obj.APMMoveMagnet 2,1
	obj.Pause 1000
	obj.APMShakerEnable ShakerSpeed,ShortShakeTime,0
	obj.Pause (ShortShakeTime + PelletizationTime)*1000+500	
End Sub  

sub Add_ApproximateBubbleSize (ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn)
	'THIS IS THE STANDARD BRASSBOARD ADDITION WHERE BUBBLE SIZE IS BASED ON A ASSUMED KNOWN PROBE LINE VOLUME, SO BUBBLE SIZE COULD VARY BETWEEN SYSTEMS

	obj.Log "			Start basic sub-routine of addition with approximate bubble size"
	'START REAGENT PICK UP, TRANSFER, AND REAGENT DISPENSE	
	If TransferType = SingleDispense Or ReagentVolume > 100 Then	
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn
			For ReactionWellsDispenseRow=0 to 7
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If				
				obj.ProbeMove 0																														'EMPTY PROBE BY BURPING
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BurpVolume,1,1				
				obj.ProbeMove 1																														'PARTIAL FILL OF THE LINE BEFORE FLUSH
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,AverageProbeLineVolume-Add_BubbleVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume,0,0												'PICK UP FLUSH VOLUME FROM DRIVE 
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume+Add_BurpVolume,1,0									'FLUSH LINE
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,reagentVolume-(AverageProbeLineVolume-Add_BubbleVolume)+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1		'COMPLETE REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				obj.MoveWell ReactionWellsDispenseRow,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_PullBackVolume,1,0							'RESET PUMP AND GET RID OF EXCESS PICK UP (AND PULLBACK_VOLUME IF NON-ZERO)
			Next
		Next
	
	
	ElseIf TransferType = MultiDispense And ReagentVolume <= 25 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn
			obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
			If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
				obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
				obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
			End If				
			obj.ProbeMove 0																														'EMPTY PROBE BY BURPING
			obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BurpVolume,1,1				
			obj.ProbeMove 1																														'PARTIAL FILL OF THE LINE BEFORE FLUSH
			obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,AverageProbeLineVolume-Add_BubbleVolume,1,1
			obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume,0,0												'PICK UP FLUSH VOLUME FROM DRIVE 
			obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume+Add_BurpVolume,1,0									'FLUSH LINE
			obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,8*reagentVolume-(AverageProbeLineVolume-Add_BubbleVolume)+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1		'COMPLETE REAGENT PICKUP
			obj.Pause Add_PauseAfterReagentPickup
			obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
			obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1												'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1														'PICK UP THE PULL BACK VOLUME
			For Aliquot=0 to 7				
				obj.MoveWell Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
			Next				
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_PullBackVolume,1,0							'RESET PUMP AND GET RID OF EXCESS PICK UP (AND PULLBACK_VOLUME IF NON-ZERO)
		Next
	
	
	ElseIf TransferType = MultiDispense And ReagentVolume <= 50 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn	
			For ReagentTransfer=0 to 1
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If				
				obj.ProbeMove 0																														'EMPTY PROBE BY BURPING
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BurpVolume,1,1				
				obj.ProbeMove 1																														'PARTIAL FILL OF THE LINE BEFORE FLUSH
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,AverageProbeLineVolume-Add_BubbleVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume,0,0												'PICK UP FLUSH VOLUME FROM DRIVE 
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume+Add_BurpVolume,1,0									'FLUSH LINE
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,4*reagentVolume-(AverageProbeLineVolume-Add_BubbleVolume)+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1		'COMPLETE REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				For Aliquot=0 to 3			
					obj.MoveWell ReagentTransfer*4+Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
					obj.ProbeMove 1
					obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
					obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				Next				
					obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_PullBackVolume,1,0							'RESET PUMP AND GET RID OF EXCESS PICK UP (AND PULLBACK_VOLUME IF NON-ZERO)
			Next
		Next	
	
	ElseIf TransferType = MultiDispense And ReagentVolume <= 100 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn	
			For ReagentTransfer=0 to 3
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If				
				obj.ProbeMove 0																														'EMPTY PROBE BY BURPING
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BurpVolume,1,1				
				obj.ProbeMove 1																														'PARTIAL FILL OF THE LINE BEFORE FLUSH
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,AverageProbeLineVolume-Add_BubbleVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume,0,0												'PICK UP FLUSH VOLUME FROM DRIVE 
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume+Add_BurpVolume,1,0									'FLUSH LINE
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,2*reagentVolume-(AverageProbeLineVolume-Add_BubbleVolume)+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1		'COMPLETE REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				For Aliquot=0 to 1			
					obj.MoveWell ReagentTransfer*2+Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
					obj.ProbeMove 1
					obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
					obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				Next				
					obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_PullBackVolume,1,0							'RESET PUMP AND GET RID OF EXCESS PICK UP (AND PULLBACK_VOLUME IF NON-ZERO)
			Next
		Next
	End If
	'EMPTY PROBE LINE AND FLUSH THROUGH CHAMBER
	obj.ProbeMove 0	
	obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_BurpVolume,1,1																				'BURP
	obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume,0,1	
	obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume + Add_BurpVolume,1,0	
	
	obj.Log "			End basic sub-routine of addition with approximate bubble size"
End Sub

sub Add_PreciseBubblesize (ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn)
	'THIS IS THE REAGENT ADDITION WHERE THE BUBBLE IS CREATED IN SUCH A WAY THAT ITS SIZE IS EXACTLY CONTROLLED AND KNOWN. HOWEVER IT REQUIRES GOING TO THE WASTE WELL BEFORE EACH TRANSFER TO REFILL THE PROBE LINE VIA A RINSE

	obj.Log "			Start basic sub-routine of addition with precise bubble size"
	
	'START REAGENT PICK UP, TRANSFER, AND REAGENT DISPENSE	
	If TransferType = SingleDispense Or ReagentVolume > 100 Then	
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn
			For ReactionWellsDispenseRow=0 to 7		
				'BUBBLE CREATION/RESET WHERE THE PROBE IS FILLED WITH DRIVE FLUID AND AN EXCESS IS DISPENSED INTO THE WASTE RESERVOIR, THEN THE BUBBLE IS PICKED UP
				obj.MoveWell WasteRow,WasteColumn,WasteLA,WasteDispenseMod																			'GO TO WASTE
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume+Add_BurpVolume,0,0								'PICK UP ENOUGH DRIVE FLUID TO FLUSH SAMPLE LINE + PROBE LINE
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume,1,0													'FLUSH SAMPLE LINE
				obj.ProbeMove 1																														'SEND PROBE BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_BurpVolume,1,1															'REFILL PROBE LINE UNTIL EXCESS IS DISPENSED INTO WASTE
				obj.ProbeMove 0																														'SEND THE PROBE BACK UP
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BubbleVolume,1,1																'ASPIRATE AIR BUBBLE OF DESIRED SIZE				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,reagentVolume+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1				'REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				obj.MoveWell ReactionWellsDispenseRow,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_BubbleVolume+Add_PullBackVolume,1,0				'RESET PUMP AND GET RID OF EXCESS PICK UP, BUBBLE AND PULLBACK_VOLUME IF NON-ZERO
			Next
		Next
		
	ElseIf TransferType = MultiDispense And ReagentVolume <= 25 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn			
				'BUBBLE CREATION/RESET WHERE THE PROBE IS FILLED WITH DRIVE FLUID AND AN EXCESS IS DISPENSED INTO THE WASTE RESERVOIR, THEN THE BUBBLE IS PICKED UP
				obj.MoveWell WasteRow,WasteColumn,WasteLA,WasteDispenseMod																			'GO TO WASTE
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume+Add_BurpVolume,0,0								'PICK UP ENOUGH DRIVE FLUID TO FLUSH SAMPLE LINE + PROBE LINE
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume,1,0													'FLUSH SAMPLE LINE
				obj.ProbeMove 1																														'SEND PROBE BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_BurpVolume,1,1															'REFILL PROBE LINE UNTIL EXCESS IS DISPENSED INTO WASTE
				obj.ProbeMove 0																														'SEND THE PROBE BACK UP
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BubbleVolume,1,1																'ASPIRATE AIR BUBBLE OF DESIRED SIZE				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,8*reagentVolume+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1				'REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
			For Aliquot=0 to 7	
				obj.MoveWell Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
			Next	
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_BubbleVolume+Add_PullBackVolume,1,0				'RESET PUMP AND GET RID OF EXCESS PICK UP, BUBBLE AND PULLBACK_VOLUME IF NON-ZERO
			
		Next	
		
	ElseIf TransferType = MultiDispense And ReagentVolume <= 50 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn		
			For ReagentTransfer=0 to 1		
				'BUBBLE CREATION/RESET WHERE THE PROBE IS FILLED WITH DRIVE FLUID AND AN EXCESS IS DISPENSED INTO THE WASTE RESERVOIR, THEN THE BUBBLE IS PICKED UP
				obj.MoveWell WasteRow,WasteColumn,WasteLA,WasteDispenseMod																			'GO TO WASTE
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume+Add_BurpVolume,0,0								'PICK UP ENOUGH DRIVE FLUID TO FLUSH SAMPLE LINE + PROBE LINE
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume,1,0													'FLUSH SAMPLE LINE
				obj.ProbeMove 1																														'SEND PROBE BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_BurpVolume,1,1															'REFILL PROBE LINE UNTIL EXCESS IS DISPENSED INTO WASTE
				obj.ProbeMove 0																														'SEND THE PROBE BACK UP
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BubbleVolume,1,1																'ASPIRATE AIR BUBBLE OF DESIRED SIZE				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,4*reagentVolume+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1				'REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				For Aliquot=0 to 3	
					obj.MoveWell ReagentTransfer*4+Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
					obj.ProbeMove 1
					obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
					obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				Next	
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_BubbleVolume+Add_PullBackVolume,1,0				'RESET PUMP AND GET RID OF EXCESS PICK UP, BUBBLE AND PULLBACK_VOLUME IF NON-ZERO
			next
		Next	
		
	ElseIf TransferType = MultiDispense And ReagentVolume <= 100 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn		
			For ReagentTransfer=0 to 3		
				'BUBBLE CREATION/RESET WHERE THE PROBE IS FILLED WITH DRIVE FLUID AND AN EXCESS IS DISPENSED INTO THE WASTE RESERVOIR, THEN THE BUBBLE IS PICKED UP
				obj.MoveWell WasteRow,WasteColumn,WasteLA,WasteDispenseMod																			'GO TO WASTE
				obj.MoveSyringeAndSampleValve 0,Add_FlushPickupVolumeVelocity,1,Add_FlushPickupVolume+Add_BurpVolume,0,0								'PICK UP ENOUGH DRIVE FLUID TO FLUSH SAMPLE LINE + PROBE LINE
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_FlushPickupVolume,1,0													'FLUSH SAMPLE LINE
				obj.ProbeMove 1																														'SEND PROBE BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_BurpVolume,1,1															'REFILL PROBE LINE UNTIL EXCESS IS DISPENSED INTO WASTE
				obj.ProbeMove 0																														'SEND THE PROBE BACK UP
				obj.MoveSyringeAndSampleValve 0,Add_BurpVelocity,1,Add_BubbleVolume,1,1																'ASPIRATE AIR BUBBLE OF DESIRED SIZE				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,2*reagentVolume+Add_PreDispenseVolume+Add_ExcessPickupVolume,1,1				'REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				For Aliquot=0 to 1	
					obj.MoveWell ReagentTransfer*2+Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
					obj.ProbeMove 1
					obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
					obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				Next	
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_ExcessPickupVolume+Add_BubbleVolume+Add_PullBackVolume,1,0				'RESET PUMP AND GET RID OF EXCESS PICK UP, BUBBLE AND PULLBACK_VOLUME IF NON-ZERO
			next
		Next	
		
	End If
	
	obj.Log "			End basic sub-routine of addition with precise bubble size"
End Sub

sub Add_LinePrimedbyReagent (ReagentType, TransferType, ReagentVolume, ReagentReservoirColumnNumber, FirstColumn, LastColumn)
	'THIS IS THE REAGENT ADDITION WHERE THE PROBE LINE, THE SAMPLE LINE AND PART OF THE SYRINGE PUMP IS PRIMED WITH REAGENT. THE PRIMING VOLUME ASSUMES THE SMALLEST LINE VOLUME TO PREVENT SENDING REAGENT IN THE DRIVE LINE. THIS RESULT IN SOME DRIVE FLUID LEFT IN THE LINE AND SOME MIXING WITH REAGENT

	obj.Log "			Start basic sub-routine of addition with line primed with reagent"
	
	'START REAGENT PICK UP, TRANSFER, AND REAGENT DISPENSE	
	
	'PRIME SYSTEM WITH DESIRED REAGENT
	obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
	obj.ProbeMove 0	
	obj.MoveSyringeAndSampleValve 0,Add3_PrimingVelocity,1,Add3_BubbleVolumeForPriming,1,1																						'WITH THE PROBE UP, PICK UP A SMALL BUBBLE BEFORE PRIMING	
	obj.ProbeMove 1
	obj.MoveSyringeAndSampleValve 0,Add3_PrimingVelocity,1,Add3_PrimingVolume1_UpToPumpValve,1,1																				'ASPIRATE ENOUGH REAGENT TO PRIME THE PROBE LINE AND MOST OF SAMPLE LOOP - MARGIN IS BUILT IN SO NO REAGENT ENTER THE SYRINGE PUMP
	obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add3_BubbleVolumeForPriming+Add3_PrimingVolume1_UpToPumpValve,0,1												'EMTPY THE SYRINGE PUMP AND SEND BACK DRIVE FLUID IN THE DRIVE FLUID LINE
	obj.MoveSyringeAndSampleValve 0,Add3_PrimingVelocity,1,Add3_PrimingVolume2_PassPumpValve,1,1				'COMPLETE PRIMING WITH ADDITIONAL REAGENT VOLUME
	obj.Pause Add_PauseAfterReagentPickup
	
	'REAGENT PICK UP FOR ACTUAL TRANSFER AND REAGENT PRE-DISPENSE	
	If TransferType = SingleDispense Or ReagentVolume > 100 Then	
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn
			For ReactionWellsDispenseRow=0 to 7					
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,reagentVolume+Add_PreDispenseVolume,1,1									'REAGENT PICKUP - BECAUSE THE LINE IS PRIMED WITH REAGENT, NO EXCESS PICK UP IS NECESSARY
				obj.Pause Add_PauseAfterReagentPickup
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME

				obj.MoveWell ReactionWellsDispenseRow,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod					'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'GO BACK TO THE REAGENT RESERVOIR AND THE DISPENSE PROBE HEIGHT TO RESET THE PUMP HOME AND GET RID OF PULLBACK VOLUME
				obj.ProbeMove 1					
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_PullBackVolume,1,0														'RESET PUMP AND GET RID OF PULLBACK_VOLUME IF NON-ZERO
			Next
		Next
		
	ElseIf TransferType = MultiDispense And ReagentVolume <= 25 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn			
			obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
			If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
				obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
				obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
			End If	
			obj.ProbeMove 1				
			obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,8*reagentVolume+Add_PreDispenseVolume,1,1									'REAGENT PICKUP
			obj.Pause Add_PauseAfterReagentPickup				
			obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
			obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
			obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
			obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
			For Aliquot=0 to 7	
				obj.MoveWell Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod								'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
			Next	
			obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'GO BACK TO THE REAGENT RESERVOIR AND THE DISPENSE PROBE HEIGHT TO RESET THE PUMP HOME AND GET RID OF PULLBACK VOLUME
			obj.ProbeMove 1	
			obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_PullBackVolume,1,0														'RESET PUMP AND GET RID OF PULLBACK_VOLUME IF NON-ZERO
		Next	
		
	ElseIf TransferType = MultiDispense And ReagentVolume <= 50 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn		
			For ReagentTransfer=0 to 1		
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,4*reagentVolume+Add_PreDispenseVolume,1,1									'REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				For Aliquot=0 to 3	
					obj.MoveWell ReagentTransfer*4+Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod				'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
					obj.ProbeMove 1
					obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
					obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				Next
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'GO BACK TO THE REAGENT RESERVOIR AND THE DISPENSE PROBE HEIGHT TO RESET THE PUMP HOME AND GET RID OF PULLBACK VOLUME
				obj.ProbeMove 1					
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_PullBackVolume,1,0														'RESET PUMP AND GET RID OF PULLBACK_VOLUME IF NON-ZERO
			next
		Next	
		
	ElseIf TransferType = MultiDispense And ReagentVolume <= 100 Then
		For ReactionWellsDispenseColumn= FirstColumn to LastColumn		
			For ReagentTransfer=0 to 3		
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,reagentAspirateMod
				If ReagentType = Beads Then																											'SHAKE SHORTLY TO MAINTAIN RESUSPENSION BEFORE EACH TRANSFER, IF NEEDED BY REAGENT TYPE		'
					obj.APMShakerEnable ShakerSpeed,ReservoirResuspensionTimeBetweenTransfer,0
					obj.Pause ReservoirResuspensionTimeBetweenTransfer*1000+500
				End If	
				obj.ProbeMove 1				
				obj.MoveSyringeAndSampleValve 0,Add_ReagentPickupVelocity,1,2*reagentVolume+Add_PreDispenseVolume,1,1									'REAGENT PICKUP
				obj.Pause Add_PauseAfterReagentPickup				
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'SEND THE PREDISPENSE VOLUME BACK FROM ABOVE THE LIQUID LEVEL, AND PULLBACK IF PULLBACK_VOLUME IS NON-ZERO
				obj.ProbeMove 1																														'ALTHOUGH THE PROBE IS SENT DOWN, IT IS ACTUALLY SENT TO THE ReagentDispensMod WHICH IS ABOVE THE LIQUID LEVEL BUT BELOW THE SEAL
				obj.MoveSyringeAndSampleValve 0,Add_preDispenseVelocity,0,Add_PreDispenseVolume,1,1													'SEND THE PRE-DISPENSE VOLUME DOWN
				obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1															'PICK UP THE PULL BACK VOLUME
				For Aliquot=0 to 1	
					obj.MoveWell ReagentTransfer*2+Aliquot,ReactionWellsDispenseColumn,reactionWellsLA,ReactionWellsDispenseMod				'GO TO THE TARGET REACTION WELL AND DISPENSE REAGENT VOLUME
					obj.ProbeMove 1
					obj.MoveSyringeAndSampleValve 0,Add_ReagentDispenseVelocity,0,reagentVolume+Add_PullBackVolume,1,1
					obj.MoveSyringeAndSampleValve 0,Add_PullBackVelocity,1,Add_PullBackVolume,1,1
				Next
				obj.MoveWell reagentRow,ReagentReservoirColumnNumber,reagentLA,ReagentDispenseMod													'GO BACK TO THE REAGENT RESERVOIR AND THE DISPENSE PROBE HEIGHT TO RESET THE PUMP HOME AND GET RID OF PULLBACK VOLUME
				obj.ProbeMove 1									
				obj.MoveSyringeAndSampleValve 0,Add_FlushDispenseVelocity,0,Add_PullBackVolume,1,0														'RESET PUMP AND GET RID OF PULLBACK_VOLUME IF NON-ZERO
			next
		Next		
	End If
	
	'END OF COMMAND CLEANING PROCEDURE 
		Remove_NumberOfSyringeFlushLoop = 5
		Remove_NumberOfProbeValveFlushLoop = 3
		'RESET SYRINGE PUMP POSITION TO HOME BY FLUSHING PRIMING REAGENT INSIDE THE SAMPLE LOOP AND VIA THE CHAMBER
			obj.MoveSyringeAndSampleValve 0,Remove_SyringeFlushVelocity,0,Add3_PrimingVolume2_PassPumpValve,1,0		
		'FLUSH SYRINGE PUMP AND SAMPLE LOOP
			For i= 0 to Remove_NumberOfSyringeFlushLoop-1																													'AT LEAST 1 LOOP WILL ALWAYS BE EXECUTED. 
				obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,Remove_SyringeFlushVolume,0,0																'LOOP FLUSHING 400uL FROM DRIVE DIRECTLY THROUGH CHAMBER
				obj.MoveSyringeAndSampleValve 0,Remove_SyringeFlushVelocity,0,Remove_SyringeFlushVolume,1,0
			Next		
		'CLEAN PROBE AND SAMPLE VALVE (TO THIS POINT, THE PROBE WAS EMPTIED)
			'REFILL OF THE PROBE LINE
				obj.MoveWell WasteRow, WasteColumn, WasteLA, WasteDispenseMod																
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,AverageProbeLineVolume+MaximumErrorOnProbeLineVolume,0,1									'PUSH A VOLUME THROUGH THE PROBE TO ENSURE COMPLETE REFILL AND SOME SPILL IN WASTE
				obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,AverageProbeLineVolume+MaximumErrorOnProbeLineVolume,1,1				
			'CLEANING LOOP FOR THE PROBE LINE AND SAMPLE VALVE
				For i= 0 to Remove_NumberOfProbeValveFlushLoop-1																											'AT LEAST 1 LOOP WILL ALWAYS BE EXECUTED. 
					obj.MoveSyringeAndSampleValve 0,Remove_BurpVelocity,1,Remove_BurpVolume,1,1																				'BURP
					obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,Remove_ProbeValveExtraFlushVolume +Remove_BurpVolume +Remove_ProbeValveSpillVolume,0,1	'PICK UP (EXTRA+PROBE REFILL+ SPILL)						
					obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,Remove_BurpVolume + Remove_ProbeValveExtraFlushVolume,1,0									'FLUSH BURP + EXTRA THROUGH CHAMBER
					obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,Remove_BurpVolume + Remove_ProbeValveSpillVolume,1,1										'REFILL PROBE + SPILL
				Next			
		'FINAL RINSE
			obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod

	obj.Log "			End basic sub-routine of addition with line primed with reagent"
	
End Sub

Sub Remove (VolumeToRemove, FirstColumn, LastColumn, Remove_FlushVolume, NumberOfSyringeFlushLoops, NumberOfProbeValveFlushLoops)
	'THIS IS A 3-STEPS REMOVAL PROCESS (PICK UP SUPERNATANT - BURP - FLUSH) . NO BUBBLE IS USED. BURP AND FLUSH ONLY, WITH FLUSH VOLUME BEING A VARIABLE
	obj.Log "		Start basic 'Remove' command with " & Remove_FlushVolume & "uL Flush after each well," & NumberOfSyringeFlushLoops & " Loops of syringe pump flush, and" & NumberOfProbeValveFlushLoops & " loops of probe and sample valve Flush"
	
	'FIRST BURP: TO ESTABLISH THE FIRST AIR GAP THAT WILL SEPARATE THE FIRST SUPERNATANT FROM THE DRIVE FLUID
	obj.ProbeMove 0
	obj.MoveSyringeAndSampleValve 0,Remove_BurpVelocity,1,Remove_BurpVolume,1,1										'BURP TO EMPTY THE PROBE. BURP VOLUME SHOULD SUCH THAT IT GARANTEE PASSING THE SAMPLE VALVE
	obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,Remove_FlushVolume,0,1							'PICK UP SOME DRIVE FLUID TO FLUSH (THIS PARAMETER CAN BE ZERO IF DESIRED)	
	obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,Remove_FlushVolume+Remove_BurpVolume,1,0			'FLUSH THE BURP VOLUME AND THE FLUSH VOLUME IF DIFFERENT THAN ZERO, 

	'REMOVE SUPERNATANT FROM EACH REACTION WELL
	For Column=FirstColumn to LastColumn
	obj.Log "			Start basic 'Remove' command on column " & Column & "."
		For Row=0 to 7
			obj.MoveWell Row,Column,ReactionWellsLA,ReactionWellsAspirateReagentMod
			obj.ProbeMove 1
			obj.MoveSyringeAndSampleValve 0,Remove_SupernatantPickupVelocity,1,VolumeToRemove+Remove_ExcessPickupVolume,1,1
			obj.Pause Remove_PauseAfterSupernatantPickup
			obj.ProbeMove 0
			'BURP AND FLUSH
			obj.MoveSyringeAndSampleValve 0,Remove_BurpVelocity,1,Remove_BurpVolume,1,1
			obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,Remove_FlushVolume,0,1
			obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,Remove_FlushVolume+Remove_BurpVolume+VolumeToRemove+Remove_ExcessPickupVolume,1,0
		Next
	Next
	
	'END OF COMMAND CLEANING PROCEDURE
	obj.Log "		Start end of 'Remove' command cleaning procedure"
		'FLUSH SYRINGE PUMP AND SAMPLE LOOP
			For i= 0 to Remove_NumberOfSyringeFlushLoop-1																			'AT LEAST 1 LOOP WILL ALWAYS BE EXECUTED. 
				obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,Remove_SyringeFlushVolume,0,0						'LOOP FLUSHING 400uL FROM DRIVE DIRECTLY THROUGH CHAMBER
				obj.MoveSyringeAndSampleValve 0,Remove_SyringeFlushVelocity,0,Remove_SyringeFlushVolume,1,0
			Next
		
		'CLEAN PROBE AND SAMPLE VALVE (TO THIS POINT, THE PROBE WAS EMPTIED)
			'REFILL OF THE PROBE LINE
				obj.MoveWell WasteRow, WasteColumn, WasteLA, WasteDispenseMod																
				obj.ProbeMove 1
				obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,AverageProbeLineVolume+MaximumErrorOnProbeLineVolume,0,1									'PUSH A VOLUME THROUGH THE PROBE TO ENSURE COMPLETE REFILL AND SOME SPILL IN WASTE
				obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,AverageProbeLineVolume+MaximumErrorOnProbeLineVolume,1,1				
			'CLEANING LOOP FOR THE PROBE LINE AND SAMPLE VALVE
				For i= 0 to Remove_NumberOfProbeValveFlushLoop-1																											'AT LEAST 1 LOOP WILL ALWAYS BE EXECUTED. 
					obj.MoveSyringeAndSampleValve 0,Remove_BurpVelocity,1,Remove_BurpVolume,1,1																				'BURP
					obj.MoveSyringeAndSampleValve 0,Remove_FlushPickupVolumeVelocity,1,Remove_ProbeValveExtraFlushVolume +Remove_BurpVolume +Remove_ProbeValveSpillVolume,0,1	'PICK UP (EXTRA+PROBE REFILL+ SPILL)						
					obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,Remove_BurpVolume + Remove_ProbeValveExtraFlushVolume,1,0									'FLUSH BURP + EXTRA THROUGH CHAMBER
					obj.MoveSyringeAndSampleValve 0,Remove_FlushDispenseVelocity,0,Remove_BurpVolume + Remove_ProbeValveSpillVolume,1,1										'REFILL PROBE + SPILL
				Next			
		'FINAL RINSE
			obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	obj.Log "		End of basic 'Remove' command"
End Sub


	'OTHER MISCELLANEOUS COMMANDS
Sub BackwardAcquire (FirstColumnAcquiredLast, LastColumnAcquiredFirst)
	obj.Log "	Start Backward Acquisition from column " & LastColumnAcquiredFirst & " to column " & FirstColumnAcquiredLast & "."
	
	' RETRACT MAGNETS
	obj.APMMoveMagnet 2,0	
	
	'CLEAN UP SAMPLE LINE AND PROBE LINE
	obj.Prime
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
	
	'MODIFY THE NUMBER OF AGITATE CYCLE TO BE COMPATIBLE WITH APM ACQUISITION. THIS PROPERTY WILL BE RESET TO ITS DEFAULT MAGPIX VALUE AT THE END OF THIS ACQUISITION COMMAND
	obj.Log "	Change the number of agitate cycles for acquisiton (property #65796) from 3 to 5"
	obj.SetProperty 65796,NumberOfAgitateCyclesForAPMAcquisition

	'SHAKE PRIOR TO ANY ACQUISITION
	obj.APMShakerEnable ShakerSpeed, ReactionWellsResuspensionTime,1
	obj.Pause ReactionWellsResuspensionTime*1000+500
	
	'START ACQUIRING WELLS INCLUDING A SHORT SHAKE PRIOR TO ALL ACQUISITIONS
	For Column= LastColumn to FirstColumn step -1
		For Row=7 to 0 step -1
			obj.APMShakerEnable ShakerSpeed,ReactionWellResuspensionTimeBetweenAcquisition,0
			obj.Pause ReactionWellResuspensionTimeBetweenAcquisition*1000+500
			obj.Acquisition Row,Column,ReactionWellsLA,0,0,ReactionWellsAcquisitionMod
		Next
	Next
	
	'RESET MAGPIX PROPERTY TO THEIR DEFAULT VALUES
	obj.Log "Reset the number of agitate cycles for acquisiton (property #65796) to its MagPIx default value of 3"
	obj.SetProperty 65796,Default_65796_AcquisitionAgitateCycle
	
	obj.Log "		End Backward Acquisition"
End Sub

Sub StartSession
	dim filesys, my_sessions, path
	set filesys = CreateObject("Scripting.FileSystemObject")
	my_sessions = "C:\My Sessions\"
	' LOOP UNTIL VALID SESSION NAME
	REM do 
		REM SessionName = InputBox ("Enter a unique name for this session")
		REM path = my_sessions & SessionName
		REM if filesys.FolderExists(path) then
			REM MsgBox("Session Name Not Unique")
		REM end if
	REM loop while filesys.FolderExists(path)
	' IF NOT UNIQUE ADD DATE/TIME
	SessionName = InputBox ("Enter a unique name for this session")
	path = my_sessions & SessionName
	if filesys.FolderExists(path) then
		SessionName = SessionName & StrDate
	end if
	obj.StartSession SessionName
	obj.Log "Start Session " & SessionName & "."
End Sub

Function StrDate
	dim str_year, str_month, str_day, str_hour, str_minute, str_second
	if (year(now()) < 10) then
		str_year = "0" & year(now())
	else
		str_year = year(now())
	end if
	if (month(now()) < 10) then
		str_month = "0" & month(now())
	else
		str_month = month(now())
	end if
	if (day(now()) < 10) then
		str_day = "0" & day(now())
	else
		str_day = day(now())
	end if
	if (hour(now()) < 10) then
		str_hour = "0" & hour(now())
	else
		str_hour = hour(now())
	end if
	if (minute(now()) < 10) then
		str_minute = "0" & minute(now())
	else
		str_minute = minute(now())
	end if
	if (second(now()) < 10) then
		str_second = "0" & second(now())
	else
		str_second = second(now())
	end if
	StrDate = "_" & str_year & str_month & str_day & "_" & str_hour & str_minute & str_second
End Function

Sub CloseSession	
	obj.CloseSession true
End Sub

Sub FT1	
	'FUNCTIONAL TESTING 1 - COUNT
	obj.Log "Start the FT1 Session"
	StartSession
	
	obj.ActiveAnalytes Array (45)
	
	'DEFINE WASTE LOCATION
	DefineAndPre_PerforateWaste 1

	'COLUMN 0 IS DIRECTLY AQCUIRED
	obj.Log "Acquire Column 0 to establish a count baseline"
	Pre_Perforate_ReactionWells 3,0,0
	Acquire 0,0
	
	'BEADS ARE ADDED FROM RESERVOIR 2 TO COLUMN 4
	obj.Log "Transfer Beads from reservoir 2 into column 4"
	Pre_Perforate_ReactionWells 3,4,4
	ReagentAddition ApproximateBubbleSize, Beads, MultiDispense,100,2,4,4

	
	'90mL SUPERNATANT FROM COLUMN 1 ARE ACQUIRED WITHOUT AGITATION, FROM LOCATION MOD 2, AND WITH MAGNETS APPLIED, TO EVALUATE BEAD LOSS DURING SUPERNATANT REMOVAL
	obj.Log "Acquire Column 1 From supernatant side and without agitation to evaluate bead loss during supernatant removal"
	Pre_Perforate_ReactionWells  1,1,1
	obj.SetProperty 65796,0										'CHANGE THE NUMBER OF AGITATE CYCLE FOR ACQUISITION DOWN TO 0
	obj.SetProperty 65576,90									'INCREASE SAMPLE UPTAKE VOLUME TO 90uL
	obj.Prime								
	obj.APMMoveMagnet 2,1										'DEPLOY MAGNETS	
	obj.Pause (PelletizationTimeForRemovingBuffer)*1000+500	
	obj.Rinse WasteRow,WasteColumn,WasteLA,WasteDispenseMod
		For Row=0 to 7
		obj.Acquisition Row,1,0,0,0,2							'Acquisition on MOD 2
		Next
	obj.SetProperty 65576,50									'RESET SAMPLE UPTAKE VOLUME
	
	'MAINTAIN MAGNETS DEPLOYED AND REMOVE SUPERNATANT FROM COLUMN 3 BEFORE RESUSPENDING COLUMN 3 WITH 100uL FROM DRIVE
	obj.Log "Subwash Column 3 to evaluate bead retention and reaction well dead volume"
	Pre_Perforate_ReactionWells  1,3,3
	SupernatantRemoval WashBuffer,100,3,3
	ResuspensionInDriveFluid 100,3,3
	
	'STANDARD ACQUISTION FOR COLUMN 2, 3, and 4
	obj.Log "Acquire Column 2 (Validate Resuspension in reaction wells) , 3 (estimates Bead retention and dead volume)and 4 (Validates Resuspension efficiency for transfer)"
	Pre_Perforate_ReactionWells  3,2,2
	Pre_Perforate_ReactionWells  3,4,4
	Acquire 2,4
	
	CloseSession
End Sub

sub Selftest (SelfTest_Type) 
	'SET SELF TEST VARIABLES
	StartSession
	
	Obj.log "Start SelfTest type " & SelfTest_Type & "."
	If SelfTest_Type = Quick Then
		obj.Log "	Quick SelfTest"	
		'Actuate Eject/Retract
			obj.MoveEject
			obj.MoveRetract
		'Actuate Shaker	
			obj.APMShakerEnable ShakerSpeed,15,1
			obj.Pause 15500
		'Actuate Magnet: Deploy then Retract
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
			obj.APMMoveMagnet 2,1
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
			obj.APMMoveMagnet 2,0
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
		'Check Range of XY Locations and all mods
		obj.Log "		Check reaction wells A1, H6 and all 4 mods"	
			'Move to A1 location mods 1,2,3,and 4
			obj.MoveWell 0,0,0,0
			obj.ProbeMove 1
			obj.MoveWell 0,0,0,1
			obj.ProbeMove 1
			obj.MoveWell 0,0,0,2
			obj.ProbeMove 1
			obj.MoveWell 0,0,0,3
			obj.ProbeMove 1
			'Move to H6 location mods 1,2,3,and 4
			obj.MoveWell 7,5,0,0
			obj.ProbeMove 1	
			obj.MoveWell 7,5,0,1
			obj.ProbeMove 1	
			obj.MoveWell 7,5,0,2
			obj.ProbeMove 1	
			obj.MoveWell 7,5,0,3
			obj.ProbeMove 1	
		obj.Log "		Check Reservoirs 0,1,5,9,12,and 15 and all 3 mods"	
			'Move to reservoir 0 Mod 1,2,and 3
			obj.MoveWell 0,0,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,0,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,0,4,3
			obj.ProbeMove 1	
			'Move to reservoir 1 Mod 1,2,and 3
			obj.MoveWell 0,1,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,1,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,1,4,3
			obj.ProbeMove 1	
			'Move to reservoir 5 Mod 1,2,and 3
			obj.MoveWell 0,5,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,5,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,5,4,3
			obj.ProbeMove 1	
			'Move to reservoir 9 Mod 1,2,and 3
			obj.MoveWell 0,9,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,9,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,9,4,3
			obj.ProbeMove 1
			'Move to reservoir 12 Mod 1,2,and 3
			obj.MoveWell 0,12,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,12,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,12,4,3
			obj.ProbeMove 1	
			'Move to reservoir 15 Mod 1,2,and 3
			obj.MoveWell 0,15,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,15,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,15,4,3
			obj.ProbeMove 1
			
	ElseIf SelfTest_Type = Thorough Then
		obj.Log "	Thorough SelfTest"		
		'START WITH A QUICK TEST
		obj.Log "		1: Start with actuating moving parts"	
		'Actuate Eject/Retract
			obj.MoveEject
			obj.MoveRetract
		'Actuate Shaker	
			obj.APMShakerEnable ShakerSpeed,15,1
			obj.Pause 15500
		'Actuate Magnet: Deploy then Retract
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
			obj.APMMoveMagnet 2,1
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
			obj.APMMoveMagnet 2,0
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
		'Check Range of XY Locations and all mods
		obj.Log "		2:Check all XY location and all mods"	
		obj.Log "			2.1: Check all reaction wells XY locations and all mods"	
			For ReactionWellColumn = 0 to 5
				For ReactionWellRow = 0 to 7
					obj.MoveWell ReactionWellRow, ReactionWellColumn,ReactionWellsLA,ReactionWellsDispenseBeadsMod
					obj.ProbeMove 1
					obj.Log "				Succesfully went to location " & ReactionWellRow & "," & ReactionWellColumn & "," & ReactionWellsLA & "," & ReactionWellsDispenseBeadsMod & "."
					obj.MoveWell ReactionWellRow, ReactionWellColumn,ReactionWellsLA,ReactionWellsDispenseReagentMod
					obj.ProbeMove 1	
					obj.Log "				Succesfully went to location " & ReactionWellRow & "," & ReactionWellColumn & "," & ReactionWellsLA & "," & ReactionWellsDispenseReagentMod & "."					
					obj.MoveWell ReactionWellRow, ReactionWellColumn,ReactionWellsLA,ReactionWellsAcquisitionMod
					obj.ProbeMove 1
					obj.Log "				Succesfully went to location " & ReactionWellRow & "," & ReactionWellColumn & "," & ReactionWellsLA & "," & ReactionWellsAcquisitionMod & "."		
					obj.MoveWell ReactionWellRow, ReactionWellColumn,ReactionWellsLA,ReactionWellsAspirateReagentMod
					obj.ProbeMove 1
					obj.Log "				Succesfully went to location " & ReactionWellRow & "," & ReactionWellColumn & "," & ReactionWellsLA & "," & ReactionWellsAspirateReagentMod & "."					
				Next
			Next			
		obj.Log "			2.2: Check all reservoirs XY locations and all mods"	
			For ReservoirsColumn = 0 to 16
				obj.MoveWell ReagentRow, ReservoirsColumn,ReagentLA,ReagentDispenseMod
				obj.ProbeMove 1
				obj.Log "				Succesfully went to location " & ReagentRow & "," & ReservoirsColumn & "," & ReagentLA & "," & ReagentDispenseMod & "."
				obj.MoveWell ReagentRow, ReservoirsColumn,ReagentLA,ReagentVentMod
				obj.ProbeMove 1					
				obj.Log "				Succesfully went to location " & ReagentRow & "," & ReservoirsColumn & "," & ReagentLA & "," & ReagentVentMod & "."
				obj.MoveWell ReagentRow, ReservoirsColumn,ReagentLA,ReagentAspirateMod
				obj.ProbeMove 1
				obj.Log "				Succesfully went to location " & ReagentRow & "," & ReservoirsColumn & "," & ReagentLA & "," & ReagentAspirateMod & "."				
			Next	

		'CONTINUE WITH SHAKER AND MAGNET COMBINATION
		obj.Log "		3: Continue self test with Magnet and Shaker combinations"	
		For i= 0 to 0	
			'SHAKER LONG WITHOUT MAGNET
			obj.Log "			3.1: Long shake with magnets retracted"
			obj.APMMoveMagnet 2,0
			obj.APMShakerEnable ShakerSpeed,120,1
			obj.Pause 120500
			'SHAKER SHORT WITHOUT MAGNET
			obj.Log "			3.2:Short shakes with magnets retracted"
			For j= 0 to 4 
				obj.APMShakerEnable ShakerSpeed,3,1
				obj.Pause 3500
			Next
			'MAGNETS
			obj.Log "			3.3: Execute All combinations of magnets deployments and retractions"
			obj.APMMoveMagnet 0,1
			obj.APMMoveMagnet 1,1
			obj.APMMoveMagnet 0,0
			obj.APMMoveMagnet 1,0
			obj.APMMoveMagnet 1,1
			obj.APMMoveMagnet 0,1
			obj.APMMoveMagnet 1,0
			obj.APMMoveMagnet 0,0
			obj.APMMoveMagnet 2,1
			obj.APMMoveMagnet 2,0
			'SHAKER LONG WITH DEPLOYED MAGNETS
			obj.Log "			3.4:Long shake with magnets deployed"
			obj.APMMoveMagnet 2,1
			obj.APMShakerEnable ShakerSpeed,15,1
			obj.Pause 15500
			'SHAKER SHORT WITH MAGNET DEPLOYED
			obj.Log "			3.5: Short shake with magnets deployed"
			For k= 0 to 4 
				obj.APMShakerEnable ShakerSpeed,3,1
				obj.Pause 3500
			Next
		Next
			'Actuate Eject/Retract
			obj.Log "			4: Finish Thorough SelfTest with Eject and Retract"	
			obj.MoveEject
			obj.MoveRetract	
	Else
		obj.Log "		Quick SelfTest chosen by default"	
		'Actuate Eject/Retract
			obj.MoveEject
			obj.MoveRetract
		'Actuate Shaker	
			obj.APMShakerEnable ShakerSpeed,15,1
			obj.Pause 15500
		'Actuate Magnet: Deploy then Retract
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
			obj.APMMoveMagnet 2,1
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
			obj.APMMoveMagnet 2,0
			obj.LogPropertyValue  12288
			obj.LogPropertyValue  12289
			obj.LogPropertyValue  12291
			obj.LogPropertyValue  12292
		'Check Range of XY Locations and all mods
		obj.Log "		Check reaction wells A1, H6 and all 4 mods"	
			'Move to A1 location mods 1,2,3,and 4
			obj.MoveWell 0,0,0,0
			obj.ProbeMove 1
			obj.MoveWell 0,0,0,1
			obj.ProbeMove 1
			obj.MoveWell 0,0,0,2
			obj.ProbeMove 1
			obj.MoveWell 0,0,0,3
			obj.ProbeMove 1
			'Move to H6 location mods 1,2,3,and 4
			obj.MoveWell 7,5,0,0
			obj.ProbeMove 1	
			obj.MoveWell 7,5,0,1
			obj.ProbeMove 1	
			obj.MoveWell 7,5,0,2
			obj.ProbeMove 1	
			obj.MoveWell 7,5,0,3
			obj.ProbeMove 1	
		obj.Log "		Check Reservoirs 0,1,5,9,12,and 15 and all 3 mods"	
			'Move to reservoir 0 Mod 1,2,and 3
			obj.MoveWell 0,0,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,0,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,0,4,3
			obj.ProbeMove 1	
			'Move to reservoir 1 Mod 1,2,and 3
			obj.MoveWell 0,1,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,1,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,1,4,3
			obj.ProbeMove 1	
			'Move to reservoir 5 Mod 1,2,and 3
			obj.MoveWell 0,5,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,5,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,5,4,3
			obj.ProbeMove 1	
			'Move to reservoir 9 Mod 1,2,and 3
			obj.MoveWell 0,9,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,9,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,9,4,3
			obj.ProbeMove 1
			'Move to reservoir 12 Mod 1,2,and 3
			obj.MoveWell 0,12,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,12,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,12,4,3
			obj.ProbeMove 1	
			'Move to reservoir 15 Mod 1,2,and 3
			obj.MoveWell 0,15,4,0
			obj.ProbeMove 1	
			obj.MoveWell 0,15,4,1
			obj.ProbeMove 1	
			obj.MoveWell 0,15,4,3
			obj.ProbeMove 1	
	End IF	

	CloseSession		
End Sub

REM obj.ActiveAnalytes Array (12,15,67,16,45)

