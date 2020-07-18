WVPRPCD ;HCIOFO/FT,JR - WV PRINT A PROCEDURE;08/28/2017  12:42
 ;;1.0;WOMEN'S HEALTH;**6,7,24**;Sep 30, 1998;Build 582
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  DISPLAY CODE FOR PRINTING PROCEDURES.  ENTRY POINTS FOR PRINTING
 ;;  INDIVIDUAL PROCEDURES AND ALL NEW PROCEDURES.
 ;
TOP(DA) ;EP
 ;---> PRINT PROCEDURE (NOT CALLED BY ANY OPTION).
 ;---> REQUIRED VARIABLE: DA=IEN OF PROCEDURE IN PROC FILE 790.1.
 ;
 D SETVARS^WVUTL5
 D DEVICE Q:WVPOP
 D START(DA)
 D ^%ZISC
 W @IOF
 Q
 ;
 ;
STARTQ ;EP
 ;---> ENTRY POINT FOR TASKMAN--CANNOT PASS PARAMETERS.
 ;---> REQUIRED VARIABLE: DA=IEN OF PROCEDURE IN PROC FILE 790.1.
 D START(DA),EXIT
 Q
 ;
 ;
START(DA) ;EP
 N WVPRMT1,WVTITLE,WVY,N,X
 D SETVARS^WVUTL5
 S WVSL="I $Y+6>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  D HEADER4^WVUTL7"
 D TOPHEAD^WVUTL7,PCDVARS^WVUTL3(DA)
 ;---> WVCRT=1 IF OUTPUT IS TO SCREEN (SET BY TOPHEAD^WVUTL7).
 S WVTITLE1="* * *  WOMEN'S HEALTH: PROCEDURE PRINTOUT  * * *"
 D CENTERT^WVUTL5(.WVTITLE1)
 S WVPRMT1="   Press RETURN to continue or '^'to exit, or"
 S WVY=^WV(790.1,DA,0),WVDFN=$P(WVY,U,2)
 ;
 U IO
 D HEADER4^WVUTL7 W:'WVCRT !
 W !?5,"Date of Procedure: ",$$TXDT^WVUTL5($P(WVY,U,12))
 W !?4,"Date First Entered: ",$$TXDT^WVUTL5($P(WVY,U,19))
 W ?42,"First Entered By: " S X=$P(WVY,U,18) W $E($$PROV^WVUTL6,1,20)
 W ! W:$P(WVY,U,15)]"" ?43,"Radiology Case#: ",$P(WVY,U,15)
 S X=$P($G(^WV(790.1,DA,2)),U,17) ;lab accession#
 W:X]"" ?44,"Lab Accession#: ",X
 W !?4,"Clinician/Provider: ",WVPROV
 W !?2,"Ward/Clinic/Location: " S X=$P(WVY,U,11) W $$HOSPLC^WVUTL6
 W !?2,"Health Care Facility: " S X=$P(WVY,U,10) W $$INSTTX^WVUTL6(X)
 W !?14,"Comments: "
 ;---> WRITE OUT CLINICAL HISTORY; IF TWO LINES, SPLIT BETWEEN WORDS.
 D
 .Q:'$D(^WV(790.1,DA,3))
 .N L,Y
 .S Y=$P(^WV(790.1,DA,3),U)
 .I $L(Y)<57 W Y,! Q
 .S L=56 I Y[" " F  Q:$E(Y,L)=" "  S L=L-1
 .W $E(Y,1,L),! W:$L(Y)>56 ?24,$E(Y,L+1,109)
 ;
 W !?4,"Complete by (Date): ",$$TXDT^WVUTL5($P(WVY,U,13))
 W !?5,"Results/Diagnosis: ",WVRES
 W !," Sec Results/diagnosis: " W $$DIAG^WVUTL4($P(WVY,U,6))
 W ?57,"HPV: " W:$P(WVY,U,8) "YES"
 W !?16,"Status: " S Y=WVY W $$STATUS^WVUTL4
 ;
 ;---> IF THIS PROCEDURE HAS COLPOSCOPY-TYPE RESULTS, DISPLAY COLP PAGE.
 D:$$COLP^WVUTL4(DA)  Q:WVPOP
 .I WVCRT D DIRZ^WVUTL3 Q:WVPOP  D HEADER4^WVUTL7
 .S WVTITLE="-----  CLINICAL FINDINGS  -----"
 .D CENTERT^WVUTL5(.WVTITLE) W !!,WVTITLE
 .;
 .X WVSL Q:WVPOP  W !?2,"T-Zone Seen Entirely: "
 .W $S($P(WVY,U,21):"YES",$P(WVY,U,21)=0:"NO",1:"")
 .W ?54,"Multifocal: "
 .W $S($P(WVY,U,21):"YES",$P(WVY,U,21)=0:"NO",1:"")
 .;
 .X WVSL Q:WVPOP  W !?2,"Lesion Outside Canal: "
 .W $S($P(WVY,U,22):"YES",$P(WVY,U,22)=0:"NO",1:"")
 .W ?45,"Number of Quadrants: " W $P(WVY,U,24)
 .;
 .X WVSL Q:WVPOP  W !?5,"Satisfactory Exam: "
 .W $S($P(WVY,U,20):"YES",$P(WVY,U,20)=0:"NO",1:"")
 .W ?46,"Quadrant Locations: ",$P($G(^WV(790.1,DA,2)),U,16)
 .X WVSL Q:WVPOP  W !?12,"Impression: "
 .W $$DIAG^WVUTL4($P(WVY,U,29))
 .;
 .X WVSL Q:WVPOP  S WVTITLE="-----  TISSUE PATHOLOGY  -----"
 .D CENTERT^WVUTL5(.WVTITLE) W !!,WVTITLE
 .;
 .X WVSL Q:WVPOP  W !?9,"ECC Dysplasia: "
 .S X=$P(WVY,U,25) W $$ECCDYS^WVUTL6
 .W ?57,"Margins Clear: "
 .W $S($P(WVY,U,27):"YES",$P(WVY,U,27)=0:"NO",1:"") X WVSL Q:WVPOP
 .X WVSL Q:WVPOP  W !?3,"Ectocervical Biopsy: "
 .W $$DIAG^WVUTL4($P(WVY,U,26))
 .W ?57,"Stage: "
 .W $$STAGE^WVUTL4($P(WVY,U,31)) X WVSL Q:WVPOP
 .X WVSL Q:WVPOP  W !?8,"STD Evaluation: "
 .W $$DIAG^WVUTL4($P(WVY,U,28))
 ;
 I WVCRT D DIRZ^WVUTL3 Q:WVPOP  D HEADER4^WVUTL7
 S WVTITLE="-----  NOTES  -----  "
 D CENTERT^WVUTL5(.WVTITLE) W !!,WVTITLE,!
 S WVTITLE="-----  NOTES (continued)  -----"
 D CENTERT^WVUTL5(.WVTITLE) S WVSUBH=WVTITLE
 S N=0
 F  S N=$O(^WV(790.1,DA,1,N)) Q:'N!(WVPOP)  D
 .X WVSL Q:WVPOP
 .W !,^WV(790.1,DA,1,N,0)
 S WVTITLE="-----  End of Procedure Printout  -----"
 D CENTERT^WVUTL5(.WVTITLE) W !!,WVTITLE
 K WVSUBH
 I WVCRT&('$D(IO("S")))&('WVPOP) D DIRZ^WVUTL3 W @IOF
 Q
 ;
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTRTN="STARTQ^WVPRPCD",ZTSAVE("DA")=""
 D ZIS^WVUTL2(.WVPOP,1)
 Q
 ;
JUSTPRT ;EP
 ;---> CALLED BY OPTION: "WV  PRINT INDIVIDUAL PROCEDURES".
 ;---> JUST PRINT AN INDIVIDUAL PROCEDURE.
 N DA,Y
 F  D  Q:Y<0
 .D TITLE^WVUTL5("PRINT A PROCEDURE")
 .D LKUPPCD^WVPROC(.Y)
 .Q:Y<0
 .D TOP(+Y)
 D EXIT
 Q
 ;
PRTNEW ;EP
 ;---> CALLED BY OPTION: "WV PRINT ALL NEW PROCEDURES".
 ;---> PRINT ALL PROCEDURES WITH A STATUS OF "NEW" (NEW UPLOADED
 ;---> LAB RESULTS).
 D TITLE^WVUTL5("PRINT ALL ""NEW"" PROCEDURES")
 S ZTRTN="DEQUEUE^WVPRPCD"
 D ZIS^WVUTL2(.WVPOP,1)
 I WVPOP D EXIT Q
 ;
DEQUEUE ;EP
 ;---> FOR TASKMAN QUEUE OF PRINTOUT.
 S N=0
 F  S N=$O(^WV(790.1,"S","n",N)) Q:'N  D
 .D START(N)
 D ^%ZISC,EXIT
 Q
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 Q
