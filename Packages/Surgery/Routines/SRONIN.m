SRONIN ;BIR/MAM,ADM - NURSE INTRAOPERATIVE REPORT ;10/24/2011
 ;;3.0;Surgery;**68,50,100,129,134,153,157,175,176,182,184,200,205**;24 Jun 93;Build 12
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to UPDATE^TIUSRVP supported by DBIA #3535
 ; Reference to ES^TIUSROI supported by DBIA #3537
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ;
 I '$D(SRSITE) D ^SROVAR G:'$D(SRSITE) END S SRSITE("KILL")=1
 I '$D(SRTN) K SRNEWOP D ^SROPS G:'$D(SRTN) END S SRTN("KILL")=1
 N SRAGE,SRDIV,SRDIVNM,SRDO,SRFUNCT,SRHDR,SRINUSE,SRLEAVE,SRLOC,SRPARAM,SRPRINT,SRSEL,SRSINED,SRDTITL,SRTIU,SRAT,SRXX
 S SRDTITL="Nurse Intraoperative Report"
 S (SRFUNCT,SRLEAVE,SRSINED)=0,SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",2)
 I SRTIU,$$STATUS^SROESUTL(SRTIU)=7 S SRSINED=1
 D:SRSINED FUNCT D:'SRSINED EN
ENF I 'SRLEAVE,SRFUNCT S SRSEL="" D FUNCT
 D END
 Q
DISPLY I SRSINED S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",2) I SRTIU D PRNT^SROESPR(SRTN,SRTIU,SRDTITL) S SRLEAVE=1 Q
 K %ZIS,IO("Q") S %ZIS="Q" D ^%ZIS I POP S SRLEAVE=1 Q
 I $D(IO("Q")) K IO("Q") N ZTRTN,ZTDESC,ZTSAVE,ZTQUEUED S ZTRTN="PRNT^SRONIN",ZTDESC=SRDTITL,(ZTSAVE("SRTN"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD,^%ZISC Q
EN D RPT^SRONRPT(SRTN) S DFN=$P(^SRF(SRTN,0),"^"),VAINDT=$P(^SRF(SRTN,0),"^",9)
 S Y=$E(VAINDT,1,7) D D^DIQ S SRSDATE=Y D OERR^VADPT
 S SRHDR=" "_VADM(1)_" ("_VA("PID")_")   Case #"_SRTN_" - "_SRSDATE
 S Y=$E($$NOW^XLFDT,1,12) D DD^%DT S SRPRINT="Printed: "_Y
 S SRLOC=" Pt Loc: "_$P(VAIN(4),"^",2)_"  "_VAIN(5)
 S SRAGE="",Z=$P(VADM(3),"^") I Z S X=$E($P(^SRF(SRTN,0),"^",9),1,12),Y=$E(X,1,7),SRAGE=$E(Y,1,3)-$E(Z,1,3)-($E(Y,4,7)<$E(Z,4,7))
 S SRDIV=$$SITE^SROUTL0(SRTN),SRDIVNM="" I SRDIV S X=$P(^SRO(133,SRDIV,0),"^"),SRDIVNM=$$EXTERNAL^DILFD(133,.01,"",X)
 S SRDIVNM=$S(SRDIVNM'="":SRDIVNM,1:SRSITE("SITE"))
 U IO S (SRPAGE,SRSOUT)=0,$P(SRLINE,"-",80)="" D HDR
 S SRI=0 F  S SRI=$O(^TMP("SRNIR",$J,SRTN,SRI)) Q:'SRI  D  Q:SRSOUT
 .I $E(IOST)="P",$Y+11>IOSL D FOOT Q:SRSOUT  D HDR
 .I $E(IOST)'="P",$Y+4>IOSL D FOOT Q:SRSOUT  D HDR
 .W !,^TMP("SRNIR",$J,SRTN,SRI)
 I SRSOUT D ^%ZISC Q 
 D FOOT D  D ^%ZISC
 .I $D(SRALRT) S SRFUNCT=1 Q
 .I '$G(SRFUNCT) S SRLEAVE=1
 Q
SRHDR S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT
 S Y=$E($P(^SRF(SRTN,0),"^",9),1,7) D D^DIQ S SRSDATE=Y
 S SRHDR=" "_VADM(1)_" ("_VA("PID")_")   Case #"_SRTN_" - "_SRSDATE
 Q
PRNT N SRDIV,SRFUNCT,SRLEAVE D EN
END K ^TMP("SRNIR",$J)
 W @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^SRSKILL K VAIN,VAINDT I $D(SRSITE("KILL")) K SRSITE
 I $D(SRTN("KILL")) K SRTN
 Q
PAGE I $D(SRNOEDIT) D LAST Q
 S (SRFUNCT,SRSOUT)=0
 W ! K DIR S DIR(0)="FOA",DIR("A",1)=" Press <return> to continue, 'A' to access Nurse Intraoperative Report",DIR("A")=" functions, or '^' to exit: " D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S (SRLEAVE,SRSOUT)=1 Q
 I X="A"!(X="a") S (SRFUNCT,SRSOUT)=1
 Q
LAST W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
FOOT ; print footer
 Q:SRSOUT  I $E(IOST)'="P" D PAGE Q
 I IOSL-9>$Y F X=$Y:1:(IOSL-10) W !
 W !,SRLINE,!,VADM(1),?50,SRPRINT,!,VA("PID")_"  Age: "_SRAGE,?50,SRLOC,!,SRDIVNM,?59,"Vice SF 509",!,SRLINE
 Q
HDR ; heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRPAGE=SRPAGE+1 I $Y'=0 W @IOF
 I $E(IOST)'="P",SRPAGE=1 S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRXX=VADM(1)_" ("_VA("PID")_")" W !,?(80-$L(SRXX)\2),SRXX
 W:$E(IOST)="P" !!!!,SRLINE W !,?3,"MEDICAL RECORD       NURSE INTRAOPERATIVE REPORT - CASE #"_SRTN,?(79-$L("PAGE "_SRPAGE)),"PAGE "_SRPAGE,!
 W:$E(IOST)="P" SRLINE,!
 Q
FUNCT ; nurse intraop report functions
 K SRALRT
 D:'$D(SRHDR) SRHDR S SRSOUT=0,SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",2)
 I 'SRSINED,SRTIU,$$STATUS^SROESUTL(SRTIU)=7 S SRSINED=1
 W @IOF,!,SRHDR I SRSINED W !!," * * The Nurse Intraoperative Report has been electronically signed. * *"
 W !!," Nurse Intraoperative Report Functions:",!
 S DIR("A",1)="  1. Edit report information",DIR("A",2)="  2. Print/View report from beginning"
 S DIR("A",3)=$S('SRTIU:"",'SRSINED:"  3. Sign the report electronically",1:"") I SRTIU,'SRSINED S DIR("A",4)=""
 S DIR("A")="Select number: ",DIR("B")=2,DIR(0)="SAM^1:Edit report information;2:Print/View report from beginning"_$S(('SRSINED&SRTIU):";3:Sign the report electronically",1:"")
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S (SRLEAVE,SRSOUT)=1 D END Q
 S SRSEL=Y,SRDO=$S(SRSEL=1:"EDIT",SRSEL=3:"SIGN",1:"DISPLY")
 D @SRDO D UNLOCK^SROUTL(SRTN)
 S SRSOUT=0,SRFUNCT=1 D ENF
 Q
EDIT ; edit report data fields
 D CHECK^SROES I SRSOUT Q
 N SROLOCK,SRX,SRZ D ^SROLOCK I SROLOCK S Q3("VIEW")=""
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK Q
 K ^TMP("SR182",$J) ; set by 'AO' x-ref
 K DA,DR,DIE S SRDTIME=DTIME,DTIME=3600,DIE=130,DA=SRTN
 S DR=$S($$VER1^SRTOVRF(SRTN):"[SRONRPT1]",$$VER2^SRTOVRF(SRTN):"[SRONRPT2]",1:"[SRONRPT]"),ST="NURSE INTRAOP"_$S(SROLOCK:" **LOCKED",1:"")
 D EN2^SROVAR,^SRCUSS S DTIME=SRDTIME K Q3("VIEW")
 ;;**SR*3.0*205 
 ;pause added to allow for system writes to take effect
 I $G(DIE)="^SRF(" W @IOF,!,"Processing for last edits..." H 2 W @IOF
 D WSXR^SRTOVRF(SRTN)
 I '$P(^SRF(SRTN,0),"^",20) D ^SROPCE1
 I $D(SRODR) D ^SROCON1
 S SROERR=SRTN D ^SROERR0
 D EXIT^SROES
 Q
SIGN ; sign report if appropriate user
 N SRLCK,SRESIG S SRESIG=1,SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK Q
 N SRMISS,SRNUR,SROK,SRA,SRII,SRJ,Y S SRII=$P($G(^SRF(SRTN,"TIU")),"^",2)
 S (SROK,SRNUR,SRJ)=0 F  S SRNUR=$O(^SRF(SRTN,19,SRNUR)) Q:'SRNUR  S SRJ=1 I $P(^SRF(SRTN,19,SRNUR,0),"^")=DUZ S SROK=1 Q
 I $D(^XUSEC("SROCHIEF",DUZ)) S SROK=1
 I 'SROK,'SRJ,SRII D EXTRACT^TIULQ(SRII,"SRA",.SRERR,"1302") I +$G(SRA(SRII,1302,"I"))=DUZ S SROK=1
 I 'SROK W !!,"Sorry, you are not authorized to sign this report." H 2 Q
 S SRMISS=0 D ALLIN Q:SRSOUT!SRMISS
ES D RPT^SRONRPT(SRTN) N SRAY,SRERR,SRI,SRP,SRSIG,SRTIU,X1
 S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",2)
 D SIG^XUSESIG I X1="" W !!,"Signature failed." H 2 Q
 F I=1:1 Q:'$D(^TMP("SRNIR",$J,SRTN,I))  S SRAY("TEXT",I,0)=^TMP("SRNIR",$J,SRTN,I)
 S SRAY(.05)=5 D UPDATE^TIUSRVP(.SRERR,SRTIU,.SRAY,1) K SRAY
 I +SRERR S SRSINED=1 D
 .D ES^TIUSROI(SRTIU,DUZ)
 .S XQAID="SRNIR-"_SRTN,XQAKILL=0 D DELETEA^XQALERT
 W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue... " D ^DIR K DIR
 Q
ALLIN N SRDONR1,SRDONR2,SRMISSD,SRFLD,SRI,SRJJ,SRJK,SRM,SRMISS1,SRMISS2,SRMISS3,SRMISS85,SRMIS508,SRMIS633,SRMIS636,SRMISSAT,SRO,SROO,SRP,SRPF,SRX,SRY,SRZ,SRABORT
 ;;**SR*3.0*205
 ;POSSIBLE ITEM RETENTION (#630) requirement for NIR to be electronically signed and variable storing its value (SRMIS630) removed per NSO request
 S (SREDIT,SRMISS,SRMISS1,SRMISS2,SRMISS3,SRMISS85,SRMIS508,SRMISSAT,SRSOUT,SRMIS633,SRMIS636,SRMISSD)=0
 S SRABORT=$$ABORT^SRTOVRF(SRTN) Q:SRABORT
 S (SRDONR1,SRDONR2)=0
 S SRDONR1=$$VER1^SRTOVRF(SRTN),SRDONR2=$$VER2^SRTOVRF(SRTN)
 K DA,DIC,DIQ,DR
 S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="I",DR=".205;.232;2006;44;45;46;47;48;606;605;600;601;602;603;604;607;608;609;610;611;506;.69;1.13;633;636;74"
 S DR=DR_$S(SRDONR1:";648;649;650;651;652;653;654;655;656;657;658;660;663;665;747;749;750;751;752;753",SRDONR2:";659",1:"") D EN^DIQ1
 F SRJJ=85,49 I '$O(^SRF(SRTN,SRJJ,0)) S SRJK=$S(SRJJ=49:508,1:SRJJ),SRY(130,SRTN,SRJK,"I")=""
 I $O(^SRF(SRTN,1,0)) S SRO=0 F  S SRO=$O(^SRF(SRTN,1,SRO)) Q:'SRO  S SROO=$G(^SRF(SRTN,1,SRO,2)),SROO1=$G(^SRF(SRTN,1,SRO,1)) D
 .F SRM=1,2,3 S:$P(SROO,"^",SRM)']"" SRY(130.47,SRTN,SRO_";"_(SRM+7),"I")=""
 .F SRM=3,4,5 S:$P(SROO1,"^",SRM)']"" SRY(130.47,SRTN,SRO_";"_(SRM+8),"I")=""
 I '$O(^SRF(SRTN,1,0)) S SRY(130.47,SRTN)=""
 I '$O(^SRF(SRTN,6,0)) S SRY(130.06,SRTN)=""
 ;I SRDONR1 F II="57;130.0664","63;130.0647" S:'$O(^SRF(SRTN,+II,0)) SRY($P(II,";",2),SRTN)=""
 K DA,DIC,DIQ,DR D LIST
 I $G(SRX(.205))'=""!($G(SRX(.232))'="")!($G(SRX(606))'="")!($G(SRX(605))'="")!($G(SRX(506))'="")!($G(SRX(1.13))'="") S SRMISS1=1
 F SRJJ=600:1:604,607:1:611,1.13 I $G(SRX(SRJJ))'="" S SRMISS1=1
 F SRJJ=.69,74,2006 I $G(SRX(SRJJ))'="" S SRMISS1=1
 F SRJJ=600:1:611 I (SRY(130,SRTN,SRJJ,"I")="N")!(SRY(130,SRTN,SRJJ,"I")=""),('$O(^SRF(SRTN,51,0))) S SRMISS85=1
 I SRY(130,SRTN,506,"I")="S"!(SRY(130,SRTN,506,"I")="O"),('$O(^SRF(SRTN,49,0))) S SRMIS508=1
 I (SRY(130,SRTN,44,"I")="N"!(SRY(130,SRTN,45,"I")="N")!(SRY(130,SRTN,46,"I")="N"))&(SRY(130,SRTN,633,"I")="") S SRMIS633=1
 I (SRY(130,SRTN,44,"I")="N"!(SRY(130,SRTN,45,"I")="N")!(SRY(130,SRTN,46,"I")="N"))&(SRY(130,SRTN,636,"I")="") S SRMIS636=1
 I $G(SRX(48))="" F SRZ=44,45,46,47 I $G(SRX(SRZ))'="" S SRMISS2=1 Q
 I $O(^SRF(SRTN,1,0)) I $O(SRX(130.47,0)) S SRMISS3=1
 I $D(SRY(130.06,SRTN)) S SRMISSAT=1
 I SRDONR1 F SRZ=648:1:660,663,665,747,749:1:753 I $G(SRX(SRZ))'="" S SRMISSD=1
 I SRDONR2 I $G(SRX(659))'="" S SRMISSD=1
 I SRMISS1!SRMISS2!$G(SRMISS85)!$G(SRMIS508)!(SRMISS3)!(SRMISSAT)!(SRMIS633)!(SRMIS636)!(SRMISSD) S SRMISS=1 D MESS Q:SRSOUT  I SREDIT D EDIT Q
 Q
MESS ; display list of missing items
 W @IOF,!,"The following information is required before this report may be signed:",!
 I SRMISS1 F SRZ=.205,.232,2006,606,605,600,601,602,603,604,607,608,609,610,611,506,1.13 I $G(SRX(SRZ))'="" W !,?5,SRX(SRZ)
 I SRMISS1 F SRZ=.69,74 I 'SRABORT,$G(SRX(SRZ))'="" W !,?5,SRX(SRZ)
 I SRMISS2 F SRZ=44:1:47 I $G(SRX(SRZ))'="" W !,?5,SRX(SRZ)
 S SRJJ=85 I $G(@("SRMISS"_SRJJ)),$G(SRX(SRJJ))'="" W !,?5,SRX(SRJJ)
 F SRZ=508,633,636 I $G(@("SRMIS"_SRZ)),$G(SRX(SRZ))'="" W !,?5,SRX(SRZ)
 I SRMISS3,$O(^SRF(SRTN,1,0)) I $O(SRX(130.47,0)) S SRJ=0 F  S SRJ=$O(SRX(130.47,SRJ)) Q:'SRJ  S SRJJ=$P($G(^SRF(SRTN,1,SRJ,0)),"^") D
 .S SRPF=0 F  S SRPF=$O(SRX(130.47,SRJ,SRPF)) Q:'SRPF  S SRPF(SRPF)=""
 .I $O(SRPF(0)) W !!,?5,"PROSTHESIS INSTALLED item "_$P(^SRO(131.9,SRJJ,0),"^")_":"
 .F J=8:1:13 I $D(SRPF(J)) W !,?7,$S(J=8:"IMPLANT STERILITY CHECKED",J=9:"STERILITY EXPIRATION DATE",J=10:"RN VERIFIER",J=11:"LOT NUMBER",J=12:"SERIAL NUMBER",1:"PROVIDER READ BACK PERFORMED")
 .K SRPF
 I SRMISS3,'$O(^SRF(SRTN,1,0)) W !!,?5,"PROSTHESIS INSTALLED Multiple"
 I SRMISSAT W !,?5,"ANESTHESIA TECHNIQUE Multiple"
 W ! I SRMISSD,SRDONR1 D
 .F SRZ=648:1:658,660,663,665,747,749:1:753 I $G(SRX(SRZ))'="" W !,?5,SRX(SRZ)
 .I '$O(^SRF(SRTN,57,0)) W !,?5,"DONOR VESSEL UNOS ID Multiple"
 .I '$O(^SRF(SRTN,63,0)) W !,?5,"ORGAN TO BE TRANSPLANTED Multiple"
 I SRMISSD,SRDONR2 I $G(SRX(659))'="" W !,?5,SRX(659)
 W ! K DIR S DIR("A")="Do you want to enter this information",DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR,SRX I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I Y S SREDIT=1
 Q
CODE ; entry point from coding menu
 N SRAGE,SRDIV,SRDIVNM,SRDO,SRFUNCT,SRHDR,SRINUSE,SRLEAVE,SRLOC,SRNOEDIT,SRPARAM,SRPRINT,SRSEL,SRSINED,SRDTITL,SRTIU,SRSTAT,SRXX
 S SRNOEDIT=1,SRDTITL="Nurse Intraoperative Report"
 S (SRFUNCT,SRLEAVE,SRSINED)=0,SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",2)
 I SRTIU,$$STATUS^SROESUTL(SRTIU)=7 S SRSINED=1
 D DISPLY,END
 Q
LIST S SRZ=0 F  S SRZ=$O(SRY(130,SRTN,SRZ)) Q:'SRZ  I SRY(130,SRTN,SRZ,"I")="" D TR S X=$T(@SRP),SRFLD=$P(X,";;",2),SRX(SRZ)=$P(SRFLD,"^",2)
 S SRZ=0,SROO="" F  S SROO=$O(SRY(130.47,SRTN,SROO)) Q:'SROO  I SRY(130.47,SRTN,SROO,"I")="" D
 .S SRX(130.47,$P(SROO,";"),$P(SROO,";",2))=""
 M SRX(130.06,SRTN,6)=SRY(130.06,SRTN)
 I SRDONR1 F II=130.0664,130.0647 I $D(SRY(II)) M SRX(II,SRTN,.01)=SRY(II,SRTN)
 Q
TR S SRP=SRZ,SRP=$TR(SRP,"1234567890.","ABCDEFGHIJP")
 Q
PBJE ;;.205^TIME PAT IN OR
PBCB ;;.232^TIME PAT OUT OR
DD ;;44^SPONGE FINAL COUNT CORRECT
DE ;;45^SHARPS FINAL COUNT CORRECT
DF ;;46^INSTRUMENT FINAL COUNT CORRECT
DG ;;47^SPONGE, SHARPS, & INST COUNTER
DH ;;48^COUNT VERIFIER
FJJ ;;600^CORRECT PATIENT IDENTITY
FJA ;;601^PROCEDURE TO BE PERFORMED
FJB ;;602^SITE OF PROCEDURE
FJC ;;603^CONFIRM VALID CONSENT
FJD ;;604^CONFIRM PATIENT POSITION
FJE ;;605^MARKED SITE CONFIRMED
FJF ;;606^PREOPERATIVE IMAGING CONFIRMED
FJG ;;607^CORRECT MEDICAL IMPLANTS
FJH ;;608^ANTIBIOTIC PROPHYLAXIS
FJI ;;609^APPROPRIATE DVT PROPHYLAXIS
FAJ ;;610^BLOOD AVAILABILITY
FAA ;;611^AVAILABILITY OF SPECIAL EQUIP
HE ;;85^CHECKLIST COMMENT
PFI ;;.69^TIME-OUT DOCUMENT COMPLETED BY
GD ;;74^TIME-OUT COMPLETED
EJF ;;506^HAIR REMOVAL METHOD
EJH ;;508^HAIR REMOVAL COMMENTS
APAC ;;1.13^ASA CLASS
FCC ;;633^WOUND SWEEP
FCF ;;636^INTRAOPERATIVE X-RAY
FDH ;;648^UNOS NUMBER
FDI ;;649^DONOR SEROLOGY HCV
FEJ ;;650^DONOR SEROLOGY HBV
FEA ;;651^DONOR SEROLOGY CMV
FEB ;;652^DONOR SEROLOGY HIV
FEC ;;653^DONOR ABO TYPE
FED ;;654^RECIPIENT ABO TYPE
FEE ;;655^BLOOD BANK ABO VERIFICATION
FEF ;;656^OR ABO VERIFICATION
FEG ;;657^SURGEON VERIFYING UNET
FEH ;;658^ORGAN VER PRE-ANESTHESIA
FEI ;;659^SURGEON VER DONOR ORG PRE-ANES
FFJ ;;660^ORGAN VER PRE-TRANSPLANT
FFC ;;663^DONOR VESSEL USAGE
FFE ;;665^DONOR VESSEL DISPOSITION
GDG ;;747^D/T BLOOD BANK ABO VERIF
GDI ;;749^D/T OR ABO VERIF
GEJ ;;750^UNET VERIF BY SURGEON
GEA ;;751^SURGEON VER ORGAN PRE-ANES
GEB ;;752^DONOR ORG VER PRE-ANES
GEC ;;753^SURGEON VER ORG PRE-TRANSPLANT
BJJF ;;2006^ROBOTIC ASSISTANCE (Y/N)
